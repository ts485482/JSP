<%@ page contentType="text/html; charset=utf-8" %>

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
    <title>관리자 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
<div class="container mt-5">
    <div class="admin-box shadow-soft p-5">
        <div class="text-muted mb-2">
            관리자 계정 > 물품 관리
        </div>
        <h2 class="fw-bold mb-5">
            물품 관리
        </h2>
        <div class="row g-4">
            <!-- 상품 추가 -->
            <div class="col-md-6">
                <div class="admin-menu-card p-5 text-center">
                    <h3 class="mb-3">
                        물품 추가
                    </h3>
                    <p class="text-muted">
                        새로운 상품 등록
                    </p>
                    <a href="adminAdd.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="admin-menu-card p-5 text-center">
                    <h3 class="mb-3">
                        물품 수정
                    </h3>
                    <p class="text-muted">
                        기존 상품 정보 수정
                    </p>
                    <a href="adminUpdate.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <!-- 상품 제거 -->
            <div class="col-md-6">
                <div class="admin-menu-card p-5 text-center">
                    <h3 class="mb-3">
                        물품 제거
                    </h3>
                    <p class="text-muted">
                        등록 상품 삭제
                    </p>
                    <a href="adminDelete.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="admin-menu-card p-5 text-center">
                    <h3 class="mb-3">
                        배송 관리
                    </h3>
                    <p class="text-muted">
                        주문 물품 배송 상태 변경
                    </p>
                    <a href="adminDelivery.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>