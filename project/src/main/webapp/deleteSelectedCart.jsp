<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

String userId = (String)session.getAttribute("sessionId");
String[] c_ids = request.getParameterValues("cartCheck");

if (userId == null || c_ids == null) {
    response.sendRedirect("cart.jsp");
    return;
}

PreparedStatement pstmt = null;

String sql = "DELETE FROM cart WHERE m_id=? AND c_id=?";

pstmt = conn.prepareStatement(sql);

for (String c_id : c_ids) {
    pstmt.setString(1, userId);
    pstmt.setString(2, c_id);
    pstmt.executeUpdate();
}

if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("cart.jsp");
%>