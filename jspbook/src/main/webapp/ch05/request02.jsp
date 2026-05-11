<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
    <p>클라이언트 IP : <%=request.getRemoteAddr() %></p>
    <p>요청 정보 길이 : <%=request.getContentLength() %></p>
    <p>요청 정보 인코딩 : <%=request.getCharacterEncoding() %></p>
    <p>요청 정보 컨텐츠 유형 : <%=request.getContentType() %></p>

    <p>요청 정보 프로토콜 : <%=request.getProtocol() %></p>
    <p>요청 정보 전송방식 : <%=request.getMethod() %></p>
    <p>요청 URI : <%=request.getRequestURI() %></p>                <!--꼭 외우기-->
    <p>콘텍스트 경로 : <%=request.getContextPath() %></p>           <!--꼭 외우기-->
    <p>서버 이름 : <%=request.getContentLength() %></p>
    <p>서버 포트 : <%=request.getContentLength() %></p>
    <p>쿼리문 : <%=request.getQueryString() %></p>
</body>
</html>