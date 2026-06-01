<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문현황</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <%@ include file="dbconn.jsp" %>
    <%
        // 세션 로그인 체크
        userId = (String)session.getAttribute("sessionId");

        if(userId == null){
            response.sendRedirect("login.jsp");
            return;
        }

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT oi.order_id, oi.order_date, oi.order_status, " +
                     "it.c_id, it.c_name, it.c_price, it.quantity, it.subtotal, " +
                     "c.c_fileName " +
                     "FROM orderinfo oi " +
                     "JOIN orderitem it ON oi.order_id = it.order_id " +
                     "JOIN cloth c ON it.c_id = c.c_id " +
                     "WHERE oi.m_id = ? AND oi.order_status <> '배송완료'" +
                     "ORDER BY oi.order_date DESC";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();
    %>

    <div class="container mt-5" style="min-height: 600px;">
        <h3 class="fw-bold mb-4">마이페이지 - 주문현황</h3>
        
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link active fw-bold text-dark" href="orderStatus.jsp">주문현황</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-muted" href="purchaseHistory.jsp">구매내역</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-muted" href="wishlist.jsp">관심등록</a>
            </li>
        </ul>

        <%
            // 주문 데이터가 존재하는지 먼저 확인
            if (!rs.next()) {
        %>
            <div class="text-center py-5 my-5 border rounded bg-light">
                <p class="text-muted mb-0 fs-5">현재 진행 중인 주문 내역이 없습니다.</p>
                <a href="./main.jsp" class="btn btn-dark mt-3">쇼핑하러 가기</a>
            </div>
        <%
            } else {
                // 데이터가 있을 경우 반복문 실행
                do {
        %>
            <div class="card shadow-sm mb-4">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center mb-3 mb-md-0">
                            <img src="./resources/images/<%=rs.getString("c_fileName")%>"
                                 class="img-fluid rounded border"
                                 style="max-height:120px; object-fit: cover;"
                                 alt="<%=rs.getString("c_name")%>">
                        </div>
                        
                        <div class="col-md-7">
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <%
                                    String color = null;
                                    String a = rs.getString("order_status");
                                    if(a.equals("결제완료")){
                                        color = "bg-primary";
                                    } else if(a.equals("배송완료")){
                                        color = "bg-success";
                                    } else if(a.equals("배송중")){
                                        color = "bg-warning";
                                    } else{
                                        color = "bg-secondary";
                                    }
                                %>
                                <span class="badge <%=color%>">
                                    <%=rs.getString("order_status")%>
                                </span>
                                <span class="text-muted small">|</span>
                                <span class="text-muted small">주문일: <%=rs.getDate("order_date")%></span>
                            </div>
                            
                            <h5 class="fw-bold text-truncate mb-1">
                                <%=rs.getString("c_name")%>
                            </h5>
                            
                            <div class="text-muted small mb-2">
                                주문번호 : <%=rs.getLong("order_id")%> · 수량 : <%=rs.getInt("quantity")%>개
                            </div>
                            
                            <div class="fs-5 fw-bold text-dark">
                                <%=String.format("%,d", rs.getInt("subtotal"))%>원
                            </div>
                        </div>
                        
                        <div class="col-md-3 text-end mt-3 mt-md-0">
                            <a href="./cloth.jsp?id=<%=rs.getString("c_id")%>"
                               class="btn btn-outline-dark mb-2 w-100 btn-sm">
                                상세보기
                            </a>
                            <button class="btn btn-dark w-100 btn-sm" onclick="alert('배송 조회 기능 준비 중입니다.');">
                                배송확인
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        <%
                } while(rs.next());
            }
        %>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
<%
    // 자원 해제 (dbconn.jsp에서 conn을 닫지 않는 구조라면 여기서 함께 해제)
    if(rs != null) try { rs.close(); } catch(SQLException e) {}
    if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
    if(conn != null) try { conn.close(); } catch(SQLException e) {}
%>