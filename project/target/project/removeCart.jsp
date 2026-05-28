<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String)session.getAttribute("sessionId");

    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String c_id = request.getParameter("c_id");

    PreparedStatement pstmt = null;

    String sql = "DELETE FROM cart WHERE m_id=? AND c_id=?";

    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, userId);
    pstmt.setString(2, c_id);

    pstmt.executeUpdate();

    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();

    response.sendRedirect("cart.jsp");
%>