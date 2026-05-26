function CheckJoin(){

    var id = document.getElementById("id");
    var name = document.getElementById("name");
    var password = document.getElementById("password");
    var passwordCheck = document.getElementById("passwordCheck");
    var email = document.getElementById("email");

    // 아이디 체크
    if (!check(/^[a-zA-Z0-9]$/, id, "[아이디] 아이디는 영문, 숫자만 사용하여 입력해주세요"))
        return false;

    if (id.value.length < 4 || id.value.length > 15){
        alert("[아이디] 아이디 길이는 4~15자 사이로 입력하세요.");
        id.focus();
        return false;
    }

    // 비밀번호 체크
    if (!check(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$/,
        password,
        "[비밀번호] 비밀번호는 영문과 숫자를 최소 1개 이상 포함해주세요."))

        return false;

    if (password.value.length < 8 || password.value.length > 20){
        alert("[비밀번호] 비밀번호는 8~20자 사이로 입력하세요.");
        password.focus();
        return false;
    }

    // 비밀번호 확인
    if (password.value != passwordCheck.value){
        alert("[비밀번호 확인] 입력한 비밀번호가 일치하지 않습니다.");
        passwordCheck.focus();
        return false;
    }

    // 이메일 체크
    if (!check(
        /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/,
        email,
        "[이메일] 이메일 형식이 올바르지 않습니다."
    )){
        email.focus();
        return false;
    }

    // 이름 체크
    if (!check(/^[가-힣]{,10}$/,
        name,
        "[이름] 이름은 한글로 최소 2글자 이상 입력해주세요.")){

        name.focus();
        return false;
    }

    // 최종 제출
    document.joinForm.submit();
}


// 정규식 검사 함수
function check(regExp, e, msg){

    if(regExp.test(e.value)){
        return true;
    }

    alert(msg);

    e.focus();

    return false;
}