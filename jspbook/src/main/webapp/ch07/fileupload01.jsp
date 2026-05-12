<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>File Upload Standard API</title>
</head>
<body>
    <form name="filename" enctype="multipart/form-data" action="fileupload01_process.jsp" method="post">
        <p> 이 름 : <input type="text" name="name">
        <p> 제 목 : <input type="text" name="title">
        <p> 파 일 : <input type="file" name="fileName">
        <p> <input type="submit" value="파일 업로드하기">
    </form>
</body>
</html>
