<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="menu.jsp" %>
<%
    userId = (String)session.getAttribute("sessionId");

    if(userId == null || !userId.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>상품 수정 목록</title>
</head>

<body>

<div class="container mt-5">
    

    <div class="admin-box shadow-soft p-5">
        <%@ include file="adminMenu.jsp" %>
        <h3 class="fw-bold">상품 수정</h3>
<%
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "SELECT * FROM cloth ORDER BY c_id";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
%>
        <table class="table table-hover bg-white shadow-sm">
            <thead>
                <tr>
                    <th>상품코드</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>브랜드</th>
                    <th>수정</th>
                </tr>
            </thead>
            <tbody>
<%
    while(rs.next()){
%>
            <tr>
                <td><%=rs.getString("c_id")%></td>
                <td><%=rs.getString("c_name")%></td>
                <td><%=rs.getInt("c_price")%>원</td>
                <td><%=rs.getString("c_brand")%></td>
                <td>
                    <a href="adminUpdateForm.jsp?c_id=<%=rs.getString("c_id")%>"
                    class="btn btn-sm btn-dark">
                        수정
                    </a>
                </td>
            </tr>
<%
    }
%>
            </tbody>
        </table>
    </div>
<%
    if(rs != null) rs.close();
    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();
%>
</div>
</body>
</html>