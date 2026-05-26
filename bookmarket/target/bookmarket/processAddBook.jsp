<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    // 1. 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 2. 파일 저장 경로 설정 (프로젝트 내 resources/images 폴더)
    String realFolder = request.getServletContext().getRealPath("./resources/images");
    
    // 폴더가 없으면 생성
    File dir = new File(realFolder);

    if (!dir.exists()) {
        dir.mkdirs();
    }

    // 3. 파라미터 수집 (Standard API에서는 request.getParameter로 바로 가능)
    String bookId = request.getParameter("bookId");
    String name = request.getParameter("name");
    String unitPrice = request.getParameter("unitPrice");
    String author = request.getParameter("author");
    String publisher = request.getParameter("publisher");
    String releaseDate = request.getParameter("releaseDate"); 
    String description = request.getParameter("description"); 
    String category = request.getParameter("category");
    String unitsInStock = request.getParameter("unitsInStock");
    String condition = request.getParameter("condition");

    // 4. 숫자형 데이터 변환 (Exception 방지 로직 포함)
    int price = (unitPrice != null && !unitPrice.isEmpty()) ? Integer.parseInt(unitPrice) : 0;
    long stock = (unitsInStock != null && !unitsInStock.isEmpty()) ? Long.parseLong(unitsInStock) : 0;

    // 5. 파일 업로드 처리 (Part 인터페이스 사용)
    String fileName = "";
    Part part = request.getPart("BookImage"); // HTML <input type="file" name="bookImage"> 와 일치해야 함
    
    if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
        fileName = part.getSubmittedFileName();
        // 파일 중복 방지를 위한 간단한 처리 (필요시 날짜나 UUID 추가)
        part.write(realFolder + File.separator + fileName);
    }
    
    // 6. 데이터베이스(Repository) 저장
    PreparedStatement pstmt=null;

    String sql = "INSERT INTO book VALUES(?,?,?,?,?,?,?,?,?,?,?)";

    pstmt=conn.prepareStatement(sql);
    pstmt.setString(1, bookId);
    pstmt.setString(2, name);
    pstmt.setInt(3, price);
    pstmt.setString(4, author);
    pstmt.setString(5, description);
    pstmt.setString(6, publisher);
    pstmt.setString(7, category);
    pstmt.setLong(8, stock);
    pstmt.setString(9, releaseDate);
    pstmt.setString(10, condition);
    pstmt.setString(11, fileName);
    pstmt.executeUpdate();

    if(pstmt != null)
        pstmt.close();
    if(conn!=null)
        conn.close();

    // 7. 성공 후 리다이렉트
    response.sendRedirect("books.jsp");
%>