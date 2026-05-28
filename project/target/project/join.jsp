<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>회원가입</title>
</head>

<body>

<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm p-4">
                <h2 class="text-center mb-4 fw-bold">회원가입</h2>
                <form name="joinForm" action="processJoin.jsp" method="post">
                    <!-- 아이디 -->
                    <div class="mb-3">
                        <label class="form-label">아이디</label>
                        <input type="text" name="id" id="id" class="form-control" placeholder="아이디 입력">
                    </div>
                    <!-- 비밀번호 -->
                    <div class="mb-3">
                        <label class="form-label">
                            비밀번호
                        </label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호 입력">
                    </div>
                    <!-- 비밀번호 확인 -->
                    <div class="mb-3">
                        <label class="form-label">
                            비밀번호 확인
                        </label>
                        <input type="password" name="passwordCheck" id="passwordCheck" class="form-control" placeholder="비밀번호 재입력">
                    </div>
                    <!-- 이름 -->
                    <div class="mb-3">
                        <label class="form-label">
                            이름
                        </label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="이름 입력">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">생년월일</label>
                        <input type="date" name="birth" class="form-control">
                    </div>
                    <!-- 이메일 -->
                    <div class="mb-3">
                        <label class="form-label">
                            이메일
                        </label>
                        <input type="email" name="email" id="email" class="form-control" placeholder="example@email.com">
                    </div>
                    <!-- 전화번호 -->
                    <div class="mb-3">
                        <label class="form-label">
                            전화번호
                        </label>
                        <input type="text" maxlength="3" size="3" name="phone1" value="010"> 
                        - <input type="text" maxlength="4" size="4" name="phone2"> 
                        - <input type="text" maxlength="4" size="4" name="phone3">
                    </div>
                    <!-- 주소 -->
                    <div class="mb-3">
                        <label class="form-label">
                            주소
                        </label>
                        <input type="text" name="address" class="form-control" placeholder="주소 입력">
                    </div>
                    <!-- 성별 -->
                    <div class="mb-4">
                        <label class="form-label d-block">
                            성별
                        </label>
                        <input type="radio" name="gender" value="남성" checked> 남성
                        <input type="radio" name="gender" value="여성" class="ms-3"> 여성
                    </div>
                    <!-- 버튼 -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-dark btn-lg">
                            가입하기
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</div>

</body>
</html>