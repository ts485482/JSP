<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%> 
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
    } catch (SQLException ex) {
        out.println("오라클 데이터베이스 연결이 실패했습니다.<br>");
        out.println("SQLException: " + ex.getMessage());
    }
%>