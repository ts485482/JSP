<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
    <h2>이 파일은 first_param.jsp입니다.</h2>
    <jsp:include page="second_param.jsp">
        <jsp:param name="date" value="<%= new java.util.Date() %>" />
    </jsp:include>
</body>
</html>
