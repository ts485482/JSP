<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.CartDTO" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="java.util.List" %>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<script>
window.onload = function () {
    document.getElementById("checkAll").addEventListener("change", function () {
        let checks = document.getElementsByName("cartCheck");
        for (let i = 0; i < checks.length; i++) {
            checks[i].checked = this.checked;
        }
    });
};
</script>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="admin-box p-5 mb-4 shadow-soft">
        <h2 class="fw-bold">장바구니</h2>
        <p class="text-muted">Cart</p>
    </div>
<%
    // userId 변수는 menu.jsp에서 공유되므로 그대로 사용 가능하며, 튕겨내기 예외 처리 작동
    userId = (String)session.getAttribute("sessionId");
    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // 데이터베이스 자원 해제 코드가 사라지므로 pstmt, rs, dbconn.jsp 모두 제거 대상!
    int sum = 0;

    CartDAO cartDAO = new CartDAO();
    List<CartDTO> cartList = cartDAO.getCartList(userId);
%>
    <form method="post" action="deleteSelectedCart.jsp">
        <table class="table table-hover align-middle">
            <thead>
            <tr>
                <th><input type="checkbox" id="checkAll"></th>
                <th>상품</th>
                <th>가격</th>
                <th>수량</th>
                <th>소계</th>
                <th>삭제</th>
            </tr>
            </thead>
            <tbody>
<%
    for(CartDTO cart : cartList) {
        int price = cart.getClothPrice();
        int qty = cart.getQuantity();
        int total = price * qty;
        sum += total;
%>
            <tr>
                <td>
                    <input type="checkbox" name="cartCheck" value="<%=cart.getClothId()%>">
                </td>
                <td>
                    <div class="d-flex align-items-center">
                        <img src="./resources/images/<%=cart.getClothFileName()%>" style="width:80px;height:80px;object-fit:cover;border-radius:10px;" class="me-3">
                        <div>
                            <div class="fw-bold"><%=cart.getClothName()%></div>
                            <small class="text-muted"><%=cart.getClothId()%></small>
                        </div>
                    </div>
                </td>
                <td><%=price%>원</td>
                <td><%=qty%></td>
                <td class="fw-bold"><%=total%>원</td>
                <td>
                    <a href="./removeCart.jsp?m_id=<%=userId%>&c_id=<%=cart.getClothId()%>" class="badge bg-danger">삭제</a>
                </td>
            </tr>
<%
    } // end of for
    
    if(cartList.isEmpty()) {
%>
            <tr>
                <td colspan="6" class="text-center py-5 text-muted">장바구니가 비어 있습니다.</td>
            </tr>
<%
    }
%>
            </tbody>
            <tfoot>
            <tr>
                <th colspan="3" class="text-end">총액</th>
                <th class="price" style="font-size:20px;"><%=sum%>원</th>
                <th></th>
                <th></th>
            </tr>
            </tfoot>
        </table>
        <div class="d-flex justify-content-between">
            <a href="main.jsp" class="btn btn-outline-secondary">&laquo; 쇼핑 계속하기</a>
            <button type="submit" class="btn btn-danger" onclick="return confirm('선택한 상품을 삭제하시겠습니까?')">선택한 목록 삭제</button>
            <a href="./deleteCart.jsp?m_id=<%=userId%>" class="btn btn-delete" onclick="return confirm('장바구니를 비우시겠습니까?')">장바구니 비우기</a>
            <a href="./shippingInfo.jsp?m_id=<%=userId%>" class="btn btn-dark">주문하기</a>
        </div>
    </form>
</div>
</body>
</html>