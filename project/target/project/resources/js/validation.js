function CheckJoin(){

    var id = document.getElementById("id");
    var name = document.getElementById("name");
    var password = document.getElementById("password");
    var passwordCheck = document.getElementById("passwordCheck");
    var email = document.getElementById("email");

    // 아이디 체크
    if (!check(/^[a-zA-Z0-9]{4,15}$/, id, "[아이디] 4~15자 영문/숫자만 입력해주세요"))
        return false;

    // 비밀번호 체크
    if (!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/,
        password,
        "[비밀번호] 영문, 숫자, 특수문자(!@#$%^&*)를 포함하여 8~20자로 입력해주세요."
    )) {
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

function CheckAddCloth(){

    var bookId = document.getElementById("c_id");
    var name = document.getElementById("c_name");
    var unitPrice = document.getElementById("c_price");
    var unitsInStock = document.getElementById("c_stock");
    var description = document.getElementById("c_description");
    var manufacturer = document.getElementById("c_manufacturer");
    var brand = document.getElementById("c_brand");
    var country = document.getElementById("c_country");
    var topLength = document.getElementById("c_topLength");
    var pattern = document.getElementById("c_pattern");
    var pantsLength = document.getElementById("c_pantsLength");
    var season = document.getElementById("c_season");
    
    //도서아이디 체크
    if (!check(/^P[0-9]{3,6}$/, bookId, "[상품 이름]\nP와 숫자를 조합하여 4-7자까지 입력하세요\n첫 글자는 반드시 ISBN으로 시작하세요"))
        return false;


    //상품명 체크
    if (name.value.length < 4 || name.value.length > 50){
        alert("[상품명]\n최소 4자에서 최대 50자까지 입력하세요");
        name.focus();
        return false;
    }
    
    //가격 체크
    if (unitPrice.value.length == 0 || isNaN(unitPrice.value)){
        alert("[가격]\n숫자만 입력하세요");
        unitPrice.focus();
        return false;
    }

    if (unitPrice.value<0){
        alert("[가격]\n음수를 입력할 수 없습니다");
        unitPrice.focus();
        return false;
    }

    //재고 수 체크
    if (isNaN(unitsInStock.value)){
        alert("[재고 수]\n숫자만 입력하세요");
        unitsInStock.focus();
        return false;
    }
    
    if (unitsInStock.value < 0){
        alert("[재고 수]\n음수를 입력할 수 없습니다");
        unitsInStock.focus();
        return false;
    }

    //상세정보 조건 체크
    if (description.value.length < 50){
        alert("[상세정보]\n최소 50자 이상 입력하세요");
        description.focus();
        return false;
    }
    
    //제조사 체크
    if (manufacturer.value.trim() == ""){
        alert("[제조사]\n제조사를 작성해주세요");
        manufacturer.focus();
        return false;
    }

    //브랜드 체크
    if (brand.value.trim() == ""){
        alert("[브랜드]\n브랜드를 작성해주세요");
        brand.focus();
        return false;
    }

    //원산지 체크
    if (country.value.trim() == ""){
        alert("[원산지]\n원산지를 작성해주세요");
        country.focus();
        return false;
    }
    
    //상의 길이 체크
    if (topLength.value.trim() == ""){
        alert("[상의 길이]\n상의 길이를 작성해주세요");
        topLength.focus();
        return false;
    }

    //패턴 체크
    if (pattern.value.trim() == ""){
        alert("[패턴]\n패턴를 작성해주세요");
        pattern.focus();
        return false;
    }

    //하의 길이 체크
    if (pantsLength.value.trim() == ""){
        alert("[하의 길이]\n하의 길이를 작성해주세요");
        pantsLength.focus();
        return false;
    }

    //계절 체크
    if (season.value.trim() == ""){
        alert("[계절]\n계절를 작성해주세요");
        season.focus();
        return false;
    }

    document.addCloth.submit();
}