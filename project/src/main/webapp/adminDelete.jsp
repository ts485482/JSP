<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="menu.jsp" %>
<%@ include file="dbconn.jsp" %>
<%
    if(userId == null || !userId.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 관리</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <!-- CSS -->
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
<div class="container mt-5">
    <!-- 관리자 박스 -->
    <div class="admin-box shadow-soft p-5">
        <%@ include file="adminMenu.jsp" %>
        <!-- 제목 -->
        <h2 class="mb-4 fw-bold">
            물품 제거
        </h2>
        <!-- 테이블 -->
        <form action="deleteProduct.jsp" method="post">
            <table class="table admin-table align-middle">
                <thead>
                <tr>
                    <th width="60"></th>
                    <th>상품번호</th>
                    <th>상품이름</th>
                </tr>
                </thead>

                <tbody>
                <%
                    PreparedStatement pstmt=null;
                    ResultSet rs=null;

                    String sql = "SELECT * FROM cloth";

                    pstmt=conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while(rs.next()){
                %>
                <!-- 예시 데이터 -->
                <tr>
                    <td>
                        <input type="checkbox" name="productId" value="<%=rs.getString("c_id")%>">
                    </td>
                    <td><%=rs.getString("c_id")%></td>
                    <td><%=rs.getString("c_name")%></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <!-- 버튼 -->
            <div class="text-end mt-4">
                <button type="submit" class="btn btn-delete px-4 py-2" onclick="return confirm('선택한 상품을 삭제하시겠습니까?')">
                물품 삭제하기
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>