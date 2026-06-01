<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/style.css">
<title>회원가입</title>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    // 2. 주소 검색 팝업창을 띄우는 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분입니다.

                // 도로명 주소와 지번 주소 중 선택한 주소 타입을 가져옵니다.
                let addr = ''; 
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 에 넣습니다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                
                // 커서를 상세주소 필드로 이동하여 바로 입력할 수 있도록 합니다.
                document.getElementById("addressDetail").focus();
            }
        }).open();
    }
</script>
</head>

<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm p-4">
                <h2 class="text-center mb-4 fw-bold">회원가입</h2>
                <form name="joinForm" action="processJoin.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label">아이디</label>
                        <input type="text" name="id" id="id" class="form-control" placeholder="아이디 입력">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">비밀번호</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호 입력">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">비밀번호 확인</label>
                        <input type="password" name="passwordCheck" id="passwordCheck" class="form-control" placeholder="비밀번호 재입력">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="이름 입력">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">생년월일</label>
                        <input type="date" name="birth" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" id="email" class="form-control" placeholder="example@email.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label d-block">전화번호</label>
                        <div class="d-flex align-items-center gap-2">
                            <input type="text" maxlength="3" name="phone1" value="010" class="form-control text-center" style="width: 80px;"> 
                            <span>-</span>
                            <input type="text" maxlength="4" name="phone2" class="form-control text-center" style="width: 100px;"> 
                            <span>-</span>
                            <input type="text" maxlength="4" name="phone3" class="form-control text-center" style="width: 100px;">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">주소</label>
                        <div class="input-group mb-2">
                            <input type="text" name="zipcode" id="zipcode" class="form-control" placeholder="우편번호" readonly>
                            <button type="button" class="btn btn-outline-dark" onclick="execDaumPostcode()">우편번호 검색</button>
                        </div>
                        <input type="text" name="address" id="address" class="form-control mb-2" placeholder="기본 주소" readonly>
                        <input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="상세 주소 입력">
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label d-block">성별</label>
                        <input type="radio" name="gender" value="남성" checked> 남성
                        <input type="radio" name="gender" value="여성" class="ms-3"> 여성
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-dark btn-lg">가입하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>