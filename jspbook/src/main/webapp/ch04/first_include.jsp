<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
    <h3>이 파일은 first_include.jsp입니다.</h3>
    <jsp:include page="second_include.jsp" flush="false"/>
    <p>Jakarta Server Page</p>
</body>
</html>
