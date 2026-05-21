<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>Database SQL</title>
</head>
<body>
    <%
        Connection conn = null;
        try {
          
            String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
            String user = "system";      
            String password = "1234";   // 오라클 비밀번호

            // 2. 오라클 드라이버 로드 (Modern 방식)
            Class.forName("oracle.jdbc.OracleDriver");
            
            // 3. 커넥션 객체 생성
            conn = DriverManager.getConnection(url, user, password);
            out.println("오라클 데이터베이스 연결이 성공했습니다.");
            
        } catch (ClassNotFoundException ex) {
            out.println("드라이버 로드 실패! ojdbc 라이브러리를 확인하세요.<br>");
            out.println("ClassNotFoundException: " + ex.getMessage());
        } catch (SQLException ex) {
            out.println("오라클 데이터베이스 연결이 실패했습니다.<br>");
            out.println("SQLException: " + ex.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>