<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>상품 상세</title>

<script>

function increase(){
    let qty = document.getElementById("qty");
    qty.value = parseInt(qty.value) + 1;
}

function decrease(){
    let qty = document.getElementById("qty");

    if(parseInt(qty.value) > 1){
        qty.value = parseInt(qty.value) - 1;
    }
}

function addToCart(){
    let qty = document.getElementById("qty").value;
    document.getElementById("hiddenQty").value = qty;

    alert("장바구니에 추가되었습니다.");

    document.addForm.submit();
}

function shippingWithCart(){
    let qty = document.getElementById("qty").value;
    document.getElementById("hiddenQty").value = qty;

    document.addForm.submit();
}

</script>

</head>

<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <%@ include file="dbconn.jsp" %>
    <%
        String id = request.getParameter("id");

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        /* =========================
           최근 본 상품 저장 시작
           ========================= */

        userId = (String)session.getAttribute("sessionId");

        if(userId != null && id != null){

            PreparedStatement recentPstmt = null;
            ResultSet recentRs = null;

            // 이미 최근 본 상품에 존재하는지 확인
            String recentCheckSql =
                "SELECT * FROM recent_view " +
                "WHERE m_id=? AND c_id=?";

            recentPstmt = conn.prepareStatement(recentCheckSql);

            recentPstmt.setString(1, userId);
            recentPstmt.setString(2, id);

            recentRs = recentPstmt.executeQuery();

            if(recentRs.next()){

                // 이미 존재하면 viewed_at 갱신
                String updateSql =
                    "UPDATE recent_view " +
                    "SET viewed_at = SYSDATE " +
                    "WHERE m_id=? AND c_id=?";

                recentPstmt = conn.prepareStatement(updateSql);

                recentPstmt.setString(1, userId);
                recentPstmt.setString(2, id);

                recentPstmt.executeUpdate();

            }else{

                // 없으면 INSERT
                String insertSql =
                    "INSERT INTO recent_view(m_id, c_id, viewed_at) " +
                    "VALUES(?, ?, SYSDATE)";

                recentPstmt = conn.prepareStatement(insertSql);

                recentPstmt.setString(1, userId);
                recentPstmt.setString(2, id);

                recentPstmt.executeUpdate();
            }

            /* 최근 본 상품 최대 3개 유지 */

            String deleteOldSql =
                "DELETE FROM recent_view " +
                "WHERE m_id=? " +
                "AND c_id NOT IN ( " +
                "    SELECT c_id FROM ( " +
                "        SELECT c_id " +
                "        FROM recent_view " +
                "        WHERE m_id=? " +
                "        ORDER BY viewed_at DESC " +
                "        FETCH FIRST 3 ROWS ONLY " +
                "    ) " +
                ")";

            recentPstmt = conn.prepareStatement(deleteOldSql);

            recentPstmt.setString(1, userId);
            recentPstmt.setString(2, userId);

            recentPstmt.executeUpdate();

            if(recentRs != null) recentRs.close();
            if(recentPstmt != null) recentPstmt.close();
        }

        String sql = "SELECT * FROM cloth WHERE c_id=?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);

        rs = pstmt.executeQuery();

        if(rs.next()){
    %>

    <!-- 뒤로가기 -->
    <div class="mb-4">
        <a href="./main.jsp"
           class="text-decoration-none text-dark">
           << 검색 결과로 돌아가기
        </a>
    </div>

    <div class="row bg-white p-4 rounded shadow-sm">

        <!-- 상품 이미지 -->
        <div class="col-md-5 text-center">

            <img src="./resources/images/<%=rs.getString("c_fileName")%>"
                 style="width:90%;height:100%;object-fit:cover;border-radius:3%;"
                 class="product-img">

        </div>

        <!-- 상품 정보 -->
        <div class="col-md-7">

            <h2 class="fw-bold mb-3">
                <%=rs.getString("c_name")%>
            </h2>

            <p class="text-muted mb-4">
                <%=rs.getString("c_description")%>
            </p>

            <!-- 가격 -->
            <div class="price mb-4">
                <%=rs.getString("c_price")%>원
            </div>

            <!-- 재고 -->
            <p class="text-muted mb-4">
                남은 수량 : <%=rs.getString("c_stock")%>
            </p>

            <!-- 수량 -->
            <div class="d-flex align-items-center mb-4">

                <button class="btn btn-outline-secondary"
                        onclick="decrease()">
                    -
                </button>

                <input type="text"
                       id="qty"
                       value="1"
                       class="form-control text-center quantity-box mx-2">

                <button class="btn btn-outline-secondary"
                        onclick="increase()">
                    +
                </button>

            </div>

            <!-- 버튼 -->
            <form name="addForm" action="./addCart.jsp" method="post">
                <input type="hidden" name="c_id" value="<%=rs.getString("c_id")%>">
                <input type="hidden" name="quantity" id="hiddenQty" value="1">
                <button type="button" class="btn btn-dark me-2" onclick="addToCart()">
                    장바구니 추가
                </button>
                <button type="button" class="btn btn-dark me-2" onclick="shippingWithCart()">
                    바로 구매하기
                </button>
            </form>
        </div>
    </div>
    <!-- 상품 정보 테이블 -->
    <div class="bg-white p-4 mt-4 rounded shadow-sm">
        <table class="table info-table">
            <tr>
                <td width="20%">상품번호</td>
                <td><%=rs.getString("c_id")%></td>
            </tr>
            <tr>
                <td>제조사</td>
                <td><%=rs.getString("c_manufacturer")%></td>
            </tr>
            <tr>
                <td>브랜드</td>
                <td><%=rs.getString("c_brand")%></td>
            </tr>
            <tr>
                <td>원산지</td>
                <td><%=rs.getString("c_country")%></td>
            </tr>
            <tr>
                <td>소매기장</td>
                <td><%=rs.getString("c_topLength")%></td>
            </tr>
            <tr>
                <td>패턴</td>
                <td><%=rs.getString("c_pattern")%></td>
            </tr>
            <tr>
                <td>하의기장</td>
                <td><%=rs.getString("c_pantsLength")%></td>
            </tr>
            <tr>
                <td>착용계절</td>
                <td><%=rs.getString("c_season")%></td>
            </tr>
            <tr>
                <td>구분</td>
                <td><%=rs.getString("c_category")%></td>
            </tr>
        </table>
    </div>
    <%
        }
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    %>

    <%@ include file="footer.jsp" %>

</div>

</body>
</html>