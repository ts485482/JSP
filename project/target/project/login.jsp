<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/style.css">
<title>로그인</title>
</head>

<body>

<div class="container py-4">

    <%@ include file="menu.jsp" %>

    <!-- 타이틀 -->
    <div class="text-center my-5">
        <h1 class="fw-bold">Mood Closet</h1>
    </div>

    <!-- 로그인 박스 -->
    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow-soft p-4 border-0">

                <h3 class="text-center mb-4">
                    Please sign in
                </h3>

                <%
                    String error = request.getParameter("error");

                    if(error != null){
                %>

                <div class="alert alert-danger text-center">
                    아이디와 비밀번호를 확인해주세요.
                </div>

                <%
                    }
                %>

                <form action="processLogin.jsp" method="post">

                    <!-- 아이디 -->
                    <div class="form-floating mb-3">

                        <input type="text"
                               class="form-control"
                               name="id"
                               id="id"
                               placeholder="아이디"
                               required>

                        <label for="id">ID</label>

                    </div>

                    <!-- 비밀번호 -->
                    <div class="form-floating mb-4">

                        <input type="password"
                               class="form-control"
                               name="password"
                               id="password"
                               placeholder="비밀번호"
                               required>

                        <label for="password">Password</label>

                    </div>

                    <!-- 버튼 -->
                    <button class="btn btn-dark w-100 py-2" type="submit">
                        로그인
                    </button>

                </form>

            </div>

        </div>

    </div>

    <%@ include file="footer.jsp" %>

</div>

</body>
</html>