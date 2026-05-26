<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ado.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page errorPage="exceptionNoBookId.jsp" %>

<jsp:useBean id="bookDAO" class="dao.BookRepository" scope="session" />
<html>
<head>
<link href = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>도서 정보</title>
<script type="text/javascript">
    function addToCart() {
        if (confirm("도서를 장바구니에 추가하시겠습니까?")){
            document.addForm.submit();
        } else{
            document.addForm.reset();
        }
    }
</script>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">도서정보</h1>
            <p class="col-md-8 fs-4">BookInfo</p>
        </div>
    </div>

    <% 
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql="SELECT * FROM book";
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
    %>
    <div class="row align-items-md-stretch">
        <div class="col-md-5">
            <img src="resources/images/<%=rs.getString("b_filename") %>" style=
            "width : 70%;">
        </div>
        <div class="col-md-6">
            <h3><b><%=rs.getString("b_name") %></b></h3>
            <p> <%=rs.getString("b_description") %>
            <p> <b>도서코드 : </b><span class="badge text-bg-danger">
            <%=rs.getString("b_id") %></span>
            <p> <b>저자</b> : <%=rs.getString("b_author") %>
            <p> <b>출판사</b> : <%=rs.getString("b_publisher") %>
            <p> <b>출판일</b> : <%=rs.getString("b_releaseDate") %>
            <p> <b>분류</b> : <%=rs.getString("b_category") %>
            <p> <b>재고수</b> : <%=rs.getString("b_unitsInStock") %>
            <h4><%=rs.getString("b_unitPrice") %>원</h4>
            <p> <form name="addForm" action="./addCart.jsp?id=<%=rs.getString("b_id") %>" method = "post">
                    <a href="#" class="btn btn-info" onclick="addToCart()">도서 주문&raquo;</a>
                    <a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
                    <a href="./books.jsp" class="btn btn-secondary">도서 목록 &raquo;</a>
                </form>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
