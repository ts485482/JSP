<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/style.css">
<title>로그인</title>

<script src="https://accounts.google.com/gsi/client" async defer></script>

<script>
// 구글 인증 성공 시 호출되는 콜백 함수
function handleCredentialResponse(response) {
    // response.credential 안에 구글이 검증한 유저 정보 토큰(JWT)이 들어있습니다.
    // 이 토큰을 백엔드 처리 페이지로 전송하기 위해 가상 폼을 생성합니다.
    let form = document.createElement("form");
    form.method = "POST";
    form.action = "processGoogleLogin.jsp"; // 구글 로그인 전용 처리 페이지

    let credentialInput = document.createElement("input");
    credentialInput.type = "hidden";
    credentialInput.name = "credential";
    credentialInput.value = response.credential;

    form.appendChild(credentialInput);
    document.body.appendChild(form);
    form.submit();
}
</script>
</head>

<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="text-center my-5">
        <h1 class="fw-bold">Mood Closet</h1>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-soft p-4 border-0">
                <h3 class="text-center mb-4">Please sign in</h3>

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

                <form action="processLogin.jsp" method="post" class="mb-3">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required>
                        <label for="id">ID</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" required>
                        <label for="password">Password</label>
                    </div>

                    <button class="btn btn-dark w-100 py-2" type="submit">
                        로그인
                    </button>
                </form>

                <div class="text-center my-2 text-muted small">또는</div>
                
                <div class="d-flex justify-content-center">
                    <div id="g_id_onload"
                         data-client_id="201888846688-akjocpg1d00o1tr9m546j779lglf1tun.apps.googleusercontent.com"
                         data-callback="handleCredentialResponse"
                         data-context="signin"
                         data-ux_mode="popup"
                         data-auto_prompt="false">
                    </div>

                    <div class="g_id_signin"
                         data-type="standard"
                         data-shape="rectangular"
                         data-theme="outline"
                         data-text="signin_with"
                         data-size="large"
                         data-logo_alignment="left"
                         data-width="380"> </div>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</div>
</body>
</html>