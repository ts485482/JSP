<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*, java.util.*, jakarta.servlet.http.*" %>
<%
    //저장 경로 설정
    String savePath = "C:\\upload";
    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    //일반 파라미터 읽기
    String title = request.getParameter("title");
    out.println("제목 : " + title + "<br>");

    Collection<Part> parts = request.getParts();
    for (Part part : parts) {
        if(part.getContentType() != null) { //파일인 경우
            String fileName = part.getSubmittedFileName();
            if (fileName != null && !fileName.isEmpty()){
                part.write(savePath + File.separator + fileName);
                out.println("파라미터명 : " + part.getName() + "<br>");
                out.println("파일명 : " + fileName + "<br>");
                out.println("크기 : " + part.getSize() + "<br>");
            }
        }
    }
%>