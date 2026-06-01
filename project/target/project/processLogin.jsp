<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "SELECT * FROM member WHERE m_id=? AND m_password=?";

    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, id);
    pstmt.setString(2, password);

    rs = pstmt.executeQuery();

    // 로그인 성공
    if(rs.next()){

        // 세션 저장
        session.setAttribute("sessionId", rs.getString("m_id"));
        session.setAttribute("userName", rs.getString("m_name"));

        // 메인 페이지 이동
        response.sendRedirect("main.jsp");

    }else{

        // 로그인 실패
        response.sendRedirect("login.jsp?error=1");

    }

    // 자원 정리
    if(rs != null)
        rs.close();

    if(pstmt != null)
        pstmt.close();

    if(conn != null)
        conn.close();
%>