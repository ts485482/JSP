<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>File Upload Standard API</title>
</head>
<body>
    <form name="file" enctype="multipart/form-data" action="fileupload02_process.jsp" method="post">
        <p> 이 름 : <input type="text" name="name1">
        제 목 : <input type="text" name="subject1">
        파 일 : <input type="file" name="file1">

        <p> 이 름 : <input type="text" name="name2">
        제 목 : <input type="text" name="subject2">
        파 일 : <input type="file" name="file2">

        <p> 이 름 : <input type="text" name="name3">
        제 목 : <input type="text" name="subject3">
        파 일 : <input type="file" name="file3">
        
        <p> <input type="submit" value="파일 업로드하기">
    </form>
</body>
</html>
