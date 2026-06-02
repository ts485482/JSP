<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ClothDTO" %>
<%@ page import="dao.ClothDAO" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/style.css">
    <title>메인 화면</title>
</head>

<body>

<div class="container py-4">

    <%@ include file="menu.jsp" %>
    <%
        String category = request.getParameter("category");
        if(category == null) { category = ""; }

        String keyword = request.getParameter("keyword");
        if(keyword == null) { keyword = ""; }

        ClothDAO clothDAO = new ClothDAO();
        
        List<ClothDTO> productList = clothDAO.getMainProductList(userId, category, keyword);
    %>

    <div class="row text-center mt-4">
        <div class="col border p-3 category-box <%= category.equals("") ? "category-active" : "" %>">
            <a href="./main.jsp" class="text-decoration-none">신상품</a>
        </div>
        <div class="col border p-3 category-box <%= category.equals("남성잠옷") ? "category-active" : "" %>">
            <a href="./main.jsp?category=남성잠옷" class="text-decoration-none">남성잠옷</a>
        </div>
        <div class="col border p-3 category-box <%= category.equals("여성잠옷") ? "category-active" : "" %>">
            <a href="./main.jsp?category=여성잠옷" class="text-decoration-none">여성잠옷</a>
        </div>
        <div class="col border p-3 category-box <%= category.equals("커플세트") ? "category-active" : "" %>">
            <a href="./main.jsp?category=커플세트" class="text-decoration-none">커플세트</a>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-6 mx-auto">
            <form action="./main.jsp" method="get" class="d-flex">
                <input type="hidden" name="category" value="<%=category%>">
                <input type="text" name="keyword" class="form-control me-2" placeholder="상품명 또는 브랜드 검색" value="<%=keyword%>">
                <button type="submit" class="btn btn-dark">검색</button>
            </form>
        </div>
    </div>

    <div class="row mt-5">
        <%
            // 향상된 for문(for-each)으로 리스트 순회
            for(ClothDTO cloth : productList) {
        %>
        <div class="col-md-3 mb-4">
            <div class="card h-100 shadow-sm product-card">
                <img src="./resources/images/<%=cloth.getFileName()%>" class="card-img-top">

                <div class="card-body text-center">
                    <% if(cloth.getViewedAt() != null) { %>
                        <span class="badge bg-danger mb-2">최근 본 상품</span>
                    <% } %>

                    <h5 class="card-title"><%=cloth.getName()%></h5>
                    <p class="text-muted"><%=cloth.getBrand()%></p>
                    <h6 class="fw-bold"><%=cloth.getPrice()%>원</h6>

                    <a href="./cloth.jsp?id=<%=cloth.getId()%>" class="btn btn-dark mt-2">상세보기</a>
                </div>
            </div>
        </div>
        <%
            } // end of for
            
            if(productList.isEmpty()) {
        %>
            <div class="col-12 text-center py-5 text-muted">
                조회된 상품이 존재하지 않습니다.
            </div>
        <%
            }
        %>
    </div>

    <%@ include file="footer.jsp" %>

</div>

</body>
</html>