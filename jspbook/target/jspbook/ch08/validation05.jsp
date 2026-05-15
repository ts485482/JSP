<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<title>Validation</title>
</head>
<script type="text/javascript">
    function checkMember(){


        var regExpId = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var regExpName = /^[가-힣]*$/;
		var regExpPasswd = /^[0-9]*$/;
		var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		var regExpEmail =
				 /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

        var form = document.Member;

        var id = form.id.value;
        var passwd = form.pw.value;
        var name = form.name.value;
        var phone = form.phone1.value + "-" + form.phone2.value + "-" + form.phone3.value;
        var email = form.email.value;

        if(!regExpId.test(id)){
            alert("아이디는 문자로 시작해주세요!");
            form.id.select();
            return;
        }
        if(!regExpName.test(name)){
            alert("이름을 한글로 입력해주세요!");
            form.name.select();
            return;
        }
        if(!regExpPasswd.test(passwd)){
            alert("비밀번호는 숫자만 입력해주세요!");
            form.pw.select();
            return;
        }
        if(!regExpPhone.test(phone)){
            alert("연락처 입력을 확인해주세요!");
            form.phone2.select();
            return;
        }
        if(!regExpEmail.test(email)){
            alert("이메일 입력을 확인해주세요!");
            form.id.select();
            return;
        }

        form.submit();
    }
</script>
<body>
    <h3>회원가입</h3>
    <form action="validation05_process.jsp" name="Member" method="post">
        <p> 아이디 : <input type="text" name="id">
        <p> 비밀번호 : <input type="password" name="pw">
        <p> 이름 : <input type="text" name="name">
        <p> 연락처 : <input type="text" maxlength="3" size="3" name="phone1" value="010"> 
        - <input type="text" maxlength="4" size="4" name="phone2"> 
        - <input type="text" maxlength="4" size="4" name="phone3">
        <p> 이메일 : <input type="text" name="email">
        <p> <input type="button" value="가입하기" onclick="checkMember()">
    </form>
</body>
</html>