<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>관심등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>

<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <%@ include file="dbconn.jsp" %>

    <%
        // 세션 로그인 체크
        String m_id = (String)session.getAttribute("sessionId");

        if(m_id == null){
            response.sendRedirect("login.jsp");
            return;
        }

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // [관심상품 조회 SQL] wishlist 테이블과 cloth 테이블을 조인하여 로그인한 사용자의 찜 목록을 가져옵니다.
        String sql = "SELECT w.wishlist_id, c.c_id, c.c_name, c.c_brand, c.c_price, c.c_fileName " +
                     "FROM wishlist w " +
                     "JOIN cloth c ON w.c_id = c.c_id " +
                     "WHERE w.m_id = ? " +
                     "ORDER BY w.wishlist_id DESC";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, m_id);
        rs = pstmt.executeQuery();
    %>

    <div class="container mt-5" style="min-height: 600px;">
        <h3 class="fw-bold mb-4">마이페이지 - 관심등록</h3>
        
        <% request.setAttribute("currentTab", "wishlist"); %>

        <div class="row mt-4">
        <%
            // 관심등록한 상품이 존재하는지 확인
            if (!rs.next()) {
        %>
            <div class="col-12 text-center py-5 my-5 border rounded bg-light">
                <p class="text-muted mb-0 fs-5">관심등록한 상품이 없습니다.</p>
                <p class="text-muted small mt-1">마음에 드는 상품을 관심등록해 보세요!</p>
                <a href="./main.jsp" class="btn btn-dark mt-3">상품 보러가기</a>
            </div>
        <%
            } else {
                // 데이터가 있을 경우 반복문 실행 (main.jsp의 카드 스타일 레이아웃 차용)
                do {
        %>
            <div class="col-md-3 mb-4">
                <div class="card h-100 shadow-sm product-card">
                    <img src="./resources/images/<%=rs.getString("c_fileName")%>" 
                         class="card-img-top" 
                         alt="<%=rs.getString("c_name")%>"
                         style="height: 250px; object-fit: cover;">
                    
                    <div class="card-body text-center d-flex flex-column justify-content-between">
                        <div>
                            <p class="text-muted small mb-1">
                                <%=rs.getString("c_brand")%>
                            </p>
                            <h5 class="card-title fs-6 fw-bold text-truncate">
                                <%=rs.getString("c_name")%>
                            </h5>
                            <h6 class="fw-bold text-danger mb-3">
                                <%=String.format("%,d", rs.getInt("c_price"))%>원
                            </h6>
                        </div>

                        <div class="d-grid gap-2">
                            <a href="./cloth.jsp?id=<%=rs.getString("c_id")%>" class="btn btn-dark btn-sm">
                                상세보기
                            </a>
                            <a href="./removeWishlist.jsp?wishlistId=<%=rs.getInt("wishlist_id")%>" 
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('관심 상품에서 삭제하시겠습니까?');">
                                삭제
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <%
                } while(rs.next());
            }
        %>
        </div>
    </div>

    <%-- 하단 공통 푸터 포함 --%>
    <%@ include file="footer.jsp" %>

</div>

</body>
</html>

<%
    // 자원 해제
    if(rs != null) try { rs.close(); } catch(SQLException e) {}
    if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
    if(conn != null) try { conn.close(); } catch(SQLException e) {}
%>