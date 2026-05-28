<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 선택된 상품들
    String[] productIds = request.getParameterValues("productId");

    PreparedStatement pstmt = null;

    // 체크된 상품이 있을 경우
    if(productIds != null){

        String sql = "DELETE FROM cloth WHERE c_id = ?";

        pstmt = conn.prepareStatement(sql);

        for(int i=0; i<productIds.length; i++){

            pstmt.setString(1, productIds[i]);

            pstmt.executeUpdate();
        }
    }

    // 자원 해제
    if(pstmt != null)
        pstmt.close();

    if(conn != null)
        conn.close();

    // 다시 관리자 페이지로 이동
    response.sendRedirect("adminDelete.jsp");
%>