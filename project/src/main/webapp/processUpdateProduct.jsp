<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String c_id = request.getParameter("c_id");
    String c_name = request.getParameter("c_name");
    int c_price = Integer.parseInt(request.getParameter("c_price"));
    String c_brand = request.getParameter("c_brand");
    int c_stock = Integer.parseInt(request.getParameter("c_stock"));
    String c_description = request.getParameter("c_description");

    PreparedStatement pstmt = null;

    String sql = "UPDATE cloth SET c_name=?, c_price=?, c_brand=?, c_stock=?, c_description=? WHERE c_id=?";

    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, c_name);
    pstmt.setInt(2, c_price);
    pstmt.setString(3, c_brand);
    pstmt.setInt(4, c_stock);
    pstmt.setString(5, c_description);
    pstmt.setString(6, c_id);

    pstmt.executeUpdate();

    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();

    response.sendRedirect("adminUpdate.jsp");
%>