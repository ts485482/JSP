<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/style.css">
<title>메인 화면</title>
</head>

<body>

<div class="container py-4">

    <%@ include file="menu.jsp" %>
    <%@ include file="dbconn.jsp" %>

    <%
        // 로그인 사용자
        userId = (String)session.getAttribute("sessionId");

        // 카테고리
        category = request.getParameter("category");

        if(category == null){
            category = "";
        }

        // 검색어
        String keyword = request.getParameter("keyword");

        if(keyword == null){
            keyword = "";
        }
    %>

    <!-- 카테고리 -->
    <div class="row text-center mt-4">

        <!-- 전체 -->
        <div class="col border p-3 category-box <%= category.equals("") ? "category-active" : "" %>">
            <a href="./main.jsp" class="text-decoration-none">
                신상품
            </a>
        </div>

        <!-- 남성잠옷 -->
        <div class="col border p-3 category-box <%= category.equals("남성잠옷") ? "category-active" : "" %>">
            <a href="./main.jsp?category=남성잠옷" class="text-decoration-none">
                남성잠옷
            </a>
        </div>

        <!-- 여성잠옷 -->
        <div class="col border p-3 category-box <%= category.equals("여성잠옷") ? "category-active" : "" %>">
            <a href="./main.jsp?category=여성잠옷" class="text-decoration-none">
                여성잠옷
            </a>
        </div>

        <!-- 커플세트 -->
        <div class="col border p-3 category-box <%= category.equals("커플세트") ? "category-active" : "" %>">
            <a href="./main.jsp?category=커플세트" class="text-decoration-none">
                커플세트
            </a>
        </div>
    </div>
    <!-- 검색창 -->
    <div class="row mt-4">
        <div class="col-md-6 mx-auto">

            <form action="./main.jsp" method="get" class="d-flex">

                <!-- 현재 카테고리 유지 -->
                <input type="hidden" name="category" value="<%=category%>">

                <!-- 검색어 입력 -->
                <input type="text"
                    name="keyword"
                    class="form-control me-2"
                    placeholder="상품명 또는 브랜드 검색"
                    value="<%=keyword%>">

                <!-- 검색 버튼 -->
                <button type="submit" class="btn btn-dark">
                    검색
                </button>

            </form>

        </div>
    </div>
    <!-- 상품 목록 -->
    <div class="row mt-5">
        <%
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            /* =========================
            최근 본 상품 우선 출력 SQL
            ========================= */

            String sql = "";

            /* 로그인 상태 */
            if(userId != null){

                sql =
                    "SELECT c.*, rv.viewed_at " +
                    "FROM cloth c " +
                    "LEFT JOIN recent_view rv " +
                    "ON c.c_id = rv.c_id " +
                    "AND rv.m_id=? " +
                    "WHERE 1=1 ";

            }else{

                /* 비로그인 상태 */
                sql =
                    "SELECT c.* " +
                    "FROM cloth c " +
                    "WHERE 1=1 ";
            }

            /* 카테고리 조건 */
            if(!category.equals("")){
                sql += "AND c.c_category=? ";
            }

            /* 검색 조건 */
            if(!keyword.equals("")){
                sql +=
                    "AND (UPPER(c.c_name) LIKE UPPER(?) " +
                    "OR UPPER(c.c_brand) LIKE UPPER(?)) ";
            }

            /* 정렬 */
            if(userId != null){

                // 최근 본 상품 우선
                sql +=
                    "ORDER BY " +
                    "CASE WHEN rv.viewed_at IS NULL THEN 1 ELSE 0 END, " +
                    "rv.viewed_at DESC";

            }else{

                // 비로그인 시 기본 정렬
                sql += "ORDER BY c.c_id DESC";
            }

            pstmt = conn.prepareStatement(sql);

            int index = 1;

            /* 로그인 사용자 */
            if(userId != null){
                pstmt.setString(index++, userId);
            }

            /* category */
            if(!category.equals("")){
                pstmt.setString(index++, category);
            }

            /* keyword */
            if(!keyword.equals("")){
                pstmt.setString(index++, "%" + keyword + "%");
                pstmt.setString(index++, "%" + keyword + "%");
            }

            rs = pstmt.executeQuery();

            while(rs.next()){
        %>

        <div class="col-md-3 mb-4">

            <div class="card h-100 shadow-sm product-card">

                <!-- 상품 이미지 -->
                <img src="./resources/images/<%=rs.getString("c_fileName")%>"
                    class="card-img-top">

                <!-- 내용 -->
                <div class="card-body text-center">

                    <!-- 최근 본 상품 표시 -->
                    <%
                        Timestamp viewedAt = null;

                        if(userId != null){
                            viewedAt = rs.getTimestamp("viewed_at");
                        }

                        if(viewedAt != null){
                    %>

                        <span class="badge bg-danger mb-2">
                            최근 본 상품
                        </span>

                    <%
                        }
                    %>

                    <!-- 상품명 -->
                    <h5 class="card-title">
                        <%=rs.getString("c_name")%>
                    </h5>

                    <!-- 브랜드 -->
                    <p class="text-muted">
                        <%=rs.getString("c_brand")%>
                    </p>

                    <!-- 가격 -->
                    <h6 class="fw-bold">
                        <%=rs.getString("c_price")%>원
                    </h6>

                    <!-- 상세보기 -->
                    <a href="./cloth.jsp?id=<%=rs.getString("c_id")%>"
                    class="btn btn-dark mt-2">
                        상세보기
                    </a>

                </div>

            </div>

        </div>

        <%
            }

            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        %>

    </div>
    <%@ include file="footer.jsp" %>

</div>

</body>
</html>