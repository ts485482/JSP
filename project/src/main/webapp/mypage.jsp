<%@ page contentType="text/html; charset=utf-8" %>

<%@ include file="menu.jsp" %>

<%
    if(userId == null || userId.equals("")){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
<div class="container mt-5">
    <div class="mypage-box shadow-soft p-5">
        <div class="text-muted mb-2">
            메뉴 > 마이페이지
        </div>
        <h2 class="fw-bold mb-5">
            마이페이지
        </h2>
        <div class="row g-4">
            <!-- 상품 추가 -->
            <div class="col-md-6">
                <div class="mypage-card p-5 text-center">
                    <h3 class="mb-3">
                        주문 현황
                    </h3>
                    <p class="text-muted">
                        배송이 완료되지 않은 상품을 확인할 수 있습니다.
                    </p>
                    <a href="orderStatus.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mypage-card p-5 text-center">
                    <h3 class="mb-3">
                        구매 내역
                    </h3>
                    <p class="text-muted">
                        지금까지 구매한 상품을 확인할 수 있습니다(최대 3개월)
                    </p>
                    <a href="purchaseHistory.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <!-- 상품 제거 -->
            <div class="col-md-6">
                <div class="mypage-card p-5 text-center">
                    <h3 class="mb-3">
                        관심등록
                    </h3>
                    <p class="text-muted">
                        관심 등록한 상품 목록을 확인할 수 있습니다.
                    </p>
                    <a href="wishlist.jsp"
                       class="btn btn-dark mt-3">
                        이동하기
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mypage-card p-5 text-center">
                    <h3 class="mb-3">
                        회원탈퇴
                    </h3>
                    <p class="text-muted">
                        회원탈퇴 시, 기존에 존재하던 정보 전체가 삭제됩니다.
                    </p>
                    <a href="deleteMember.jsp"
                       class="btn btn-danger mt-3" onclick="return confirm('정말로 회원탈퇴를 진행하시겠습니까?')">
                        탈퇴하기
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>