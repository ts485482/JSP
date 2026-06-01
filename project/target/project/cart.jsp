<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/style.css">
<!-- AI 도움 -->
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
    userId = (String)session.getAttribute("sessionId");
    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String cartId = session.getId();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int sum = 0;
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
    String sql =
        "SELECT c.c_id, c.c_name, c.c_price, c.c_stock, c.c_fileName, ct.quantity " +
        "FROM cart ct " +
        "JOIN cloth c ON ct.c_id = c.c_id " +
        "WHERE ct.m_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userId);
    rs = pstmt.executeQuery();
    while(rs.next()){
        int price = rs.getInt("c_price");
        int qty = rs.getInt("quantity");
        int total = price * qty;
        sum += total;
%>
            <tr>
                <!-- 체크박스 -->
                <td>
                    <input type="checkbox" name="cartCheck" value="<%=rs.getString("c_id")%>">
                </td>
                <!-- 상품 -->
                <td>
                    <div class="d-flex align-items-center">
                        <img src="./resources/images/<%=rs.getString("c_fileName")%>" style="width:80px;height:80px;object-fit:cover;border-radius:10px;" class="me-3">
                        <div>
                            <div class="fw-bold">
                                <%=rs.getString("c_name")%>
                            </div>
                            <small class="text-muted">
                                <%=rs.getString("c_id")%>
                            </small>
                        </div>

                    </div>
                </td>
                <!-- 가격 -->
                <td>
                    <%=price%>원
                </td>
                <!-- 수량 -->
                <td>
                    <%=qty%>
                </td>
                <!-- 소계 -->
                <td class="fw-bold">
                    <%=total%>원
                </td>
                <!-- 삭제 -->
                <td>
                    <a href="./removeCart.jsp?m_id=<%=userId%>&c_id=<%=rs.getString("c_id")%>" class="badge bg-danger">
                        삭제
                    </a>
                </td>

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
            </tr>
            </tfoot>
        </table>
        <!-- 버튼 -->
        <div class="d-flex justify-content-between">
            <a href="main.jsp" class="btn btn-outline-secondary">
                &laquo; 쇼핑 계속하기
            </a>
            <button type="submit" class="btn btn-danger" onclick="return confirm('선택한 상품을 삭제하시겠습니까?')">
                선택한 목록 삭제
            </button>
            <a href="./deleteCart.jsp?m_id=<%=userId%>" class="btn btn-delete" onclick="return confirm('장바구니를 비우시겠습니까?')">
                장바구니 비우기
            </a>
            <a href="./shippingInfo.jsp?m_id=<%=userId%>" class="btn btn-dark">
                주문하기
            </a>
        </div>
    </form>
<%
    if(rs != null) rs.close();
    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();
%>
</div>
</body>
</html>
