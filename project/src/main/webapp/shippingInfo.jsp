<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>배송 정보</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
                let addr = ''; 
                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("addressDetail").focus();
            }
        }).open();
    }
</script>
</head>
<body>

<div class="container py-4">

    <%@ include file="menu.jsp" %>

    <div class="admin-box p-5 mb-4 shadow-soft">
        <h2 class="fw-bold">배송 정보</h2>
        <p class="text-muted">Shipping Info</p>
    </div>

<%
    userId = (String)session.getAttribute("sessionId");

    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int total = 0;

    String sql =
        "SELECT c.c_price, ct.quantity " +
        "FROM cart ct " +
        "JOIN cloth c ON ct.c_id = c.c_id " +
        "WHERE ct.m_id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userId);

    rs = pstmt.executeQuery();

    while(rs.next()){
        total += rs.getInt("c_price") * rs.getInt("quantity");
    }

    int shipping = 3000;
    int finalTotal = total + shipping;
%>

    <form action="processOrder.jsp" method="post">

        <!-- 배송지 입력 -->
        <div class="card p-4 mb-4 shadow-sm">

            <h5 class="fw-bold mb-4">배송지 입력</h5>

            <div class="mb-3">
                <label class="form-label">받으실 분</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">전화번호</label>
                <input type="text" name="phone" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">배송 주소</label>
                <div class="input-group mb-2">
                    <input type="text" name="zipcode" id="zipcode" class="form-control" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-outline-dark" onclick="execDaumPostcode()">우편번호 검색</button>
                </div>
                <input type="text" name="address" id="address" class="form-control mb-2" placeholder="기본 주소" readonly>
                <input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="상세 주소 입력" required>
            </div>

            <div class="mb-3">
                <label class="form-label">배송 요청사항</label>
                <textarea name="message" class="form-control" rows="3"></textarea>
            </div>
        </div>

        <!-- 결제 정보 -->
        <div class="card p-4 shadow-sm">

            <h5 class="fw-bold mb-4">결제 정보</h5>

            <table class="table">
                <tr>
                    <th>상품 금액</th>
                    <td class="text-end"><%=total%>원</td>
                </tr>

                <tr>
                    <th>배송비</th>
                    <td class="text-end"><%=shipping%>원</td>
                </tr>

                <tr class="table-light">
                    <th>최종 결제 금액</th>
                    <td class="text-end fw-bold text-primary">
                        <%=finalTotal%>원
                    </td>
                </tr>
            </table>

            <div class="text-end mt-4">

                <a href="cart.jsp" class="btn btn-warning">
                    이전으로
                </a>

                <button type="submit" class="btn btn-primary">
                    결제하기
                </button>

            </div>

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