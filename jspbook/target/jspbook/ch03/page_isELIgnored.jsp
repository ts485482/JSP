<%@ page language = "java" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page isELIgnored = "false" %>
<html>
    <head>
        <title>Directives Tag</title>
    </head>
    <body>
        <% 
            request.setAttribute("RequestAttribute", "request 내장 객체");
        %>
        ${requestScope.RequestAttribute}
    </body>
</html>
