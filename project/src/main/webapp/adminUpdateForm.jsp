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

    String c_id = request.getParameter("c_id");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "SELECT * FROM cloth WHERE c_id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, c_id);

    rs = pstmt.executeQuery();

    if(!rs.next()){
        out.println("상품이 존재하지 않습니다.");
        return;
    }
%>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>상품 수정</title>
</head>

<body>

<div class="container py-4">
    <%@ include file="adminMenu.jsp" %>

    <div class="bg-white p-4 shadow-sm rounded">

        <h3 class="mb-4">상품 수정</h3>

        <form action="processUpdateProduct.jsp" method="post" enctype="multipart/form-data">

            <input type="hidden" name="c_id" value="<%=rs.getString("c_id")%>">

            <div class="mb-3">
                <label>상품명</label>
                <input type="text" name="c_name" class="form-control"
                       value="<%=rs.getString("c_name")%>">
            </div>

            <div class="mb-3">
                <label>가격</label>
                <input type="number" name="c_price" class="form-control"
                       value="<%=rs.getInt("c_price")%>">
            </div>

            <div class="mb-3">
                <label>브랜드</label>
                <input type="text" name="c_brand" class="form-control"
                       value="<%=rs.getString("c_brand")%>">
            </div>

            <div class="mb-3">
                <label>재고</label>
                <input type="number" name="c_stock" class="form-control"
                       value="<%=rs.getInt("c_stock")%>">
            </div>

            <div class="mb-3">
                <label>상품 설명</label>
                <textarea name="c_description" class="form-control"><%=rs.getString("c_description")%></textarea>
            </div>

            <button type="submit" class="btn btn-dark">
                수정 완료
            </button>

        </form>

    </div>

</div>

</body>
</html>