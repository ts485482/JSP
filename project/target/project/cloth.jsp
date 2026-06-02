<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ClothDTO" %>
<%@ page import="dao.ClothDAO" %>

<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/style.css">
    <title>상품 상세</title>
    <script>
        function increase(){
            let qty = document.getElementById("qty");
            qty.value = parseInt(qty.value) + 1;
        }
        function decrease(){
            let qty = document.getElementById("qty");
            if(parseInt(qty.value) > 1){ qty.value = parseInt(qty.value) - 1; }
        }
        function addToCart(){
            let qty = document.getElementById("qty").value;
            document.getElementById("hiddenQty1").value = qty;
            alert("장바구니에 추가되었습니다.");
            document.addForm.submit();
        }
        function shippingWithCart(){
            let qty = document.getElementById("qty").value;
            document.getElementById("hiddenQty2").value = qty;
            document.buyForm.submit();
        }
    </script>
</head>

<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <%
        String id = request.getParameter("id");
        userId = (String)session.getAttribute("sessionId");

        ClothDAO clothDAO = new ClothDAO();

        // 최근 본 상품 가져오기(비로그인 시, 작동안되게 함)
        if(userId != null){
        clothDAO.manageRecentView(userId, id);
        }

        // 상품 데이터 가져오기
        ClothDTO cloth = clothDAO.getClothById(id);

        if(cloth != null){
            // 위시리스트 확인
            int[] wishResult = clothDAO.checkWishlist(userId, id);
            boolean isWish = (wishResult[0] == 1);
            int currentWishlistId = wishResult[1];
    %>

    <div class="mb-4">
        <a href="./main.jsp" class="text-decoration-none text-dark"><< 검색 결과로 돌아가기</a>
    </div>

    <div class="row bg-white p-4 rounded shadow-sm">
        <div class="col-md-5 text-center">
            <img src="./resources/images/<%=cloth.getFileName()%>" style="width:90%;height:100%;object-fit:cover;border-radius:3%;" class="product-img">
        </div>

        <div class="col-md-7">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h2 class="fw-bold mb-0"><%=cloth.getName()%></h2>
                <%
                if(userId != null){ 
                %>
                <div>
                    <% if (isWish) { %>
                        <a href="./removeWishlist.jsp?wishlistId=<%=currentWishlistId%>&c_id=<%=cloth.getId()%>" class="text-danger fs-3 text-decoration-none">
                            <i class="bi bi-heart-fill" onclick="return confirm('관심 상품에서 삭제하시겠습니까?');"></i>
                        </a>
                    <% } else { %>
                        <a href="./addWishlist.jsp?c_id=<%=cloth.getId()%>" class="text-dark fs-3 text-decoration-none">
                            <i class="bi bi-heart" onclick="return confirm('관심 상품으로 등록하시겠습니까?');"></i>
                        </a>
                    <% } %>
                </div>
                <%
                }
                %>
            </div>
            <p class="text-muted mb-4"><%=cloth.getDescription()%></p>

            <div class="price mb-4"><%=cloth.getPrice()%>원</div>
            <p class="text-muted mb-4">남은 수량 : <%=cloth.getStock()%></p>

            <div class="d-flex align-items-center mb-4">
                <button class="btn btn-outline-secondary" onclick="decrease()">-</button>
                <input type="text" id="qty" value="1" class="form-control text-center quantity-box mx-2">
                <button class="btn btn-outline-secondary" onclick="increase()">+</button>
            </div>

            <form name="addForm" action="./addCart.jsp" method="post">
                <input type="hidden" name="c_id" value="<%=cloth.getId()%>">
                <input type="hidden" name="quantity" id="hiddenQty1" value="1">
                <button type="button" class="btn btn-dark me-2" onclick="addToCart()">장바구니 추가</button>
            </form>
            <form name="buyForm" action="./buyCart.jsp" method="post">
                <input type="hidden" name="c_id" value="<%=cloth.getId()%>">
                <input type="hidden" name="quantity" id="hiddenQty2" value="1">
                <button type="button" class="btn btn-dark me-2" onclick="shippingWithCart()">바로 구매하기</button>
            </form>
        </div>
    </div>

    <div class="bg-white p-4 mt-4 rounded shadow-sm">
        <table class="table info-table">
            <tr><td width="20%">상품번호</td><td><%=cloth.getId()%></td></tr>
            <tr><td>제조사</td><td><%=cloth.getManufacturer()%></td></tr>
            <tr><td>브랜드</td><td><%=cloth.getBrand()%></td></tr>
            <tr><td>원산지</td><td><%=cloth.getCountry()%></td></tr>
            <tr><td>소매기장</td><td><%=cloth.getTopLength()%></td></tr>
            <tr><td>패턴</td><td><%=cloth.getPattern()%></td></tr>
            <tr><td>하의기장</td><td><%=cloth.getPantsLength()%></td></tr>
            <tr><td>착용계절</td><td><%=cloth.getSeason()%></td></tr>
            <tr><td>구분</td><td><%=cloth.getCategory()%></td></tr>
        </table>
    </div>
    <%
        } // end of if(cloth != null)
    %>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>