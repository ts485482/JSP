<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>메인 화면</title>
</head>

<body class="bg-light">

<div class="container py-4">

    <%@ include file="menu.jsp" %>

    <%@ include file="dbconn.jsp" %>

    <!-- 상품 목록 -->
    <div class="row mt-5">

        <%
            PreparedStatement pstmt=null;
            ResultSet rs=null;

            String sql = "SELECT * FROM cloth WHERE 1=1";

            String keyword = request.getParameter("keyword");

            if(keyword == null){
                keyword = "";
            }

            /* 카테고리 조건 */
            if(category != null && !category.equals("")){
                sql += " AND c_category=?";
            }

            /* 검색 조건 */
            if(!keyword.equals("")){
                sql += " AND (UPPER(c_name) LIKE UPPER(?) OR UPPER(c_brand) LIKE UPPER(?))";
            }

            pstmt = conn.prepareStatement(sql);

            int index = 1;

            /* category 바인딩 */
            if(category != null && !category.equals("")){
                pstmt.setString(index++, category);
            }

            /* keyword 바인딩 */
            if(!keyword.equals("")){
                pstmt.setString(index++, "%" + keyword + "%");
                pstmt.setString(index++, "%" + keyword + "%");
            }

            rs = pstmt.executeQuery();

            while(rs.next()){
        %>

        <div class="col-md-3 mb-4">

            <div class="card h-100 shadow-sm product-card">

                <!-- 이미지 -->
                <img src="./resources/images/<%=rs.getString("c_fileName")%>"
                     class="card-img-top">

                <!-- 내용 -->
                <div class="card-body text-center">

                    <h5 class="card-title">
                        <%=rs.getString("c_name")%>
                    </h5>

                    <p class="text-muted">
                        <%=rs.getString("c_brand")%>
                    </p>

                    <h6 class="fw-bold">
                        <%=rs.getString("c_price")%>원
                    </h6>

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