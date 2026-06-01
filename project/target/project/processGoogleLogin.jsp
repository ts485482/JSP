<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ include file="dbconn.jsp" %>

<%
    String credential = request.getParameter("credential");

    if (credential != null && !credential.trim().equals("")) {
        String googleId = "";
        String googleName = "";

        try {
            String[] parts = credential.split("\\.");
            String payload = new String(Base64.getUrlDecoder().decode(parts[1]), "UTF-8");

            if (payload.contains("\"sub\":\"")) {
                int start = payload.indexOf("\"sub\":\"") + 7;
                int end = payload.indexOf("\"", start);
                String sub = payload.substring(start, end);
                if (sub.length() > 8) {
                    googleId = "G_" + sub.substring(sub.length() - 8);
                } else {
                    googleId = "G_" + sub;
                }
            }

            try {
                if (payload.contains("\"name\":\"")) {
                    int start = payload.indexOf("\"name\":\"") + 8;
                    int end = payload.indexOf("\"", start);
                    googleName = payload.substring(start, end);
                    String regex = "\\\\" + "u([0-9a-fA-F]{4})";
                    googleName = googleName.replaceAll(regex, "");
                }
            } catch (Exception e) {}

            if(googleName == null || googleName.trim().equals("") || googleName.contains("{")) {
                googleName = "구글회원";
            }

            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String selectSql = "SELECT m_id, m_name FROM member WHERE m_id = ?";
            pstmt = conn.prepareStatement(selectSql);
            pstmt.setString(1, googleId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 이미 가입된 회원이면 DB에 등록된 실제 이름을 가져옵니다.
                session.setAttribute("sessionId", googleId);
                session.setAttribute("userName", rs.getString("m_name")); 
            } else {
                if (pstmt != null) pstmt.close();
                
                String insertSql = "INSERT INTO member (m_id, m_password, m_name, regist_day) VALUES (?, 'GOOGLE_SOCIAL_LOGIN', ?, SYSDATE)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, googleId);
                pstmt.setString(2, googleName);
                pstmt.executeUpdate();

                // 신규 회원이면 추출한 구글 이름을 세션에 넣습니다.
                session.setAttribute("sessionId", googleId);
                session.setAttribute("userName", googleName); 
            }

            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();

            response.sendRedirect("main.jsp");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=google_parse_error");
            return;
        }
    } else {
        response.sendRedirect("login.jsp?error=invalid_token");
    }
%>