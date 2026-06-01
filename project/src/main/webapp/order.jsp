<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>

<div class="container py-4">

    <%@ include file="menu.jsp" %>

    <div class="admin-box p-5 mb-4 shadow-soft">
        <h2 class="fw-bold">주문 완료</h2>
        <p class="text-muted">Order Complete</p>
    </div>

<%
    String orderId = request.getParameter("order_id");

    if(orderId == null){
        response.sendRedirect("main.jsp");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // =========================
    // 주문 정보 조회
    // =========================

    String orderSql =
        "SELECT * FROM orderinfo WHERE order_id=?";

    pstmt = conn.prepareStatement(orderSql);
    pstmt.setString(1, orderId);

    rs = pstmt.executeQuery();

    String receiverName = "";
    String receiverPhone = "";
    String receiverAddress = "";
    String message = "";
    int totalPrice = 0;
    String orderDate = "";

    if(rs.next()){

        receiverName = rs.getString("receiver_name");
        receiverPhone = rs.getString("receiver_phone");
        receiverAddress = rs.getString("receiver_address");
        message = rs.getString("message");

        totalPrice = rs.getInt("total_price");

        orderDate = rs.getString("order_date");
    }

    rs.close();
    pstmt.close();
%>

    <!-- 주문 정보 -->
    <div class="order-box mb-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="order-title">주문 정보</h3>

            <span class="badge-order">
                주문번호 #<%=orderId%>
            </span>
        </div>
        <table class="table table-bordered info-table">
            <tr>
                <th>주문일</th>
                <td><%=orderDate%></td>
            </tr>
            <tr>
                <th>받는 사람</th>
                <td><%=receiverName%></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><%=receiverPhone%></td>
            </tr>
            <tr>
                <th>배송 주소</th>
                <td><%=receiverAddress%></td>
            </tr>
            <tr>
                <th>배송 요청사항</th>
                <td>
                    <%=message == null ? "" : message%>
                </td>
            </tr>
        </table>
    </div>
    <!-- 주문 상품 -->
    <div class="order-box mb-4">
        <h3 class="order-title">주문 상품</h3>
        <table class="table table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th>상품명</th>
                <th>가격</th>
                <th>수량</th>
                <th>소계</th>
            </tr>
            </thead>
            <tbody>
<%
    // =========================
    // 주문 상품 조회
    // =========================

    String itemSql =
        "SELECT * FROM orderitem WHERE order_id=?";

    pstmt = conn.prepareStatement(itemSql);

    pstmt.setString(1, orderId);

    rs = pstmt.executeQuery();

    int productTotal = 0;

    while(rs.next()){

        String productName = rs.getString("c_name");

        int price = rs.getInt("c_price");

        int quantity = rs.getInt("quantity");

        int subtotal = rs.getInt("subtotal");

        productTotal += subtotal;
%>
            <tr>
                <td class="fw-bold">
                    <%=productName%>
                </td>
                <td>
                    <%=price%>원
                </td>
                <td>
                    <%=quantity%>
                </td>
                <td class="fw-bold text-primary">
                    <%=subtotal%>원
                </td>
            </tr>
<%
    }

    rs.close();
    pstmt.close();

    int shippingPrice = 3000;
%>
            </tbody>
        </table>
        <!-- 결제 금액 -->
        <div class="mt-4">
            <table class="table">
                <tr>
                    <th>상품 금액</th>
                    <td class="text-end">
                        <%=productTotal%>원
                    </td>
                </tr>
                <tr>
                    <th>배송비</th>
                    <td class="text-end">
                        <%=shippingPrice%>원
                    </td>
                </tr>
                <tr class="table-light">
                    <th>최종 결제 금액</th>
                    <td class="text-end total-price">
                        <%=totalPrice%>원
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!-- 버튼 -->
    <div class="d-flex justify-content-end gap-2">
        <a href="main.jsp" class="btn btn-outline-secondary">
            쇼핑 계속하기
        </a>
        <a href="myOrder.jsp" class="btn btn-primary">
            주문 내역 보기
        </a>
    </div>
<%
    if(conn != null){
        conn.close();
    }
%>

</div>

</body>
</html>