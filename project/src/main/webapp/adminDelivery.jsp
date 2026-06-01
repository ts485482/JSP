<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="menu.jsp" %>
<%
    if(userId == null || !userId.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
<div class="container mt-5">
    <div class="shadow-sm p-4 bg-white rounded">
        <div class="text-muted mb-2">관리자 계정 > 배송 관리</div>
        <h2 class="fw-bold mb-4">고객 주문 및 배송 처리</h2>
        
        <table class="table table-hover align-middle border-top text-center">
            <thead class="table-light">
                <tr>
                    <th>주문번호</th>
                    <th>주문자ID</th>
                    <th>수령인</th>
                    <th>상품명</th>
                    <th>총 결제액</th>
                    <th>주문일자</th>
                    <th>현재 배송상태</th>
                    <th>상태 변경하기</th>
                </tr>
            </thead>
            <tbody>
            <%
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                // orderinfo 테이블을 베이스로 조회하며, 주문 상품명을 유연하게 가져오기 위해 서브쿼리를 조합합니다.
                String sql = "SELECT o.order_id, o.m_id, o.receiver_name, o.total_price, o.order_date, o.order_status, "
                           + "  (SELECT MIN(c_name) FROM orderitem WHERE order_id = o.order_id) as main_product, "
                           + "  (SELECT COUNT(*) FROM orderitem WHERE order_id = o.order_id) as product_count "
                           + "FROM orderinfo o "
                           + "ORDER BY o.order_date DESC";
                
                try {
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    
                    boolean hasOrders = false;
                    while(rs.next()) {
                        hasOrders = true;
                        int orderId = rs.getInt("order_id");
                        String memberId = rs.getString("m_id");
                        String receiverName = rs.getString("receiver_name");
                        int totalPrice = rs.getInt("total_price");
                        Timestamp orderDate = rs.getTimestamp("order_date");
                        String status = rs.getString("order_status");
                        
                        String mainProduct = rs.getString("main_product");
                        int productCount = rs.getInt("product_count");
                        
                        // 상품명 노출 가공
                        String displayProductName = "";
                        if (mainProduct != null) {
                            if (productCount > 1) {
                                displayProductName = mainProduct + " 외 " + (productCount - 1) + "개";
                            } else {
                                displayProductName = mainProduct;
                            }
                        } else {
                            displayProductName = "등록된 상품 정보 없음";
                        }
                        
                        if(status == null) status = "결제완료";
            %>
                <tr>
                    <td class="fw-bold"><%=orderId%></td>
                    <td><%=memberId != null ? memberId : "비회원"%></td>
                    <td><%=receiverName%></td>
                    <td class="text-start"><%=displayProductName%></td>
                    <td class="fw-bold text-end pr-3"><%=String.format("%,d", totalPrice)%>원</td>
                    <td class="small text-muted"><%=orderDate%></td>
                    <td>
                        <% if(status.equals("배송완료")) { %>
                            <span class="badge bg-success"><%=status%></span>
                        <% } else if(status.equals("배송중")) { %>
                            <span class="badge bg-warning text-dark"><%=status%></span>
                        <% } else if(status.equals("결제완료")) { %>
                            <span class="badge bg-primary"><%=status%></span>
                        <% } else { %>
                            <span class="badge bg-secondary"><%=status%></span>
                        <% } %>
                    </td>
                    <td>
                        <form action="processDelivery.jsp" method="post" class="d-flex gap-1 justify-content-center m-0">
                            <input type="hidden" name="orderId" value="<%=orderId%>">
                            <select name="deliveryStatus" class="form-select form-select-sm" style="width:120px;">
                                <option value="결제완료" <%=status.equals("결제완료")?"selected":""%>>결제완료</option>
                                <option value="배송준비중" <%=status.equals("배송준비중")?"selected":""%>>배송준비중</option>
                                <option value="배송중" <%=status.equals("배송중")?"selected":""%>>배송중</option>
                                <option value="배송완료" <%=status.equals("배송완료")?"selected":""%>>배송완료</option>
                            </select>
                            <button type="submit" class="btn btn-sm btn-dark">변경</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                    if(!hasOrders) {
            %>
                <tr>
                    <td colspan="8" class="text-center py-5 text-muted">현재 접수된 주문 내역이 없습니다.</td>
                </tr>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if(rs != null) rs.close();
                    if(pstmt != null) pstmt.close();
                    if(conn != null) conn.close();
                }
            %>
            </tbody>
        </table>
        
        <div class="text-end mt-4">
            <a href="admin.jsp" class="btn btn-outline-dark">관리자 홈으로</a>
        </div>
    </div>
</div>
</body>
</html>