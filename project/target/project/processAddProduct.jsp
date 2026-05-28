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
    String c_id = request.getParameter("c_id");
    String c_name = request.getParameter("c_name");

    String c_price = request.getParameter("c_price");

    String c_manufacturer = request.getParameter("c_manufacturer");
    String c_brand = request.getParameter("c_brand");

    String c_country = request.getParameter("c_country");

    String c_topLength = request.getParameter("c_topLength");
    String c_pattern = request.getParameter("c_pattern");

    String c_pantsLength = request.getParameter("c_pantsLength");
    String c_season = request.getParameter("c_season");

    String c_category = request.getParameter("c_category");

    String c_stock = request.getParameter("c_stock");

    String c_description = request.getParameter("c_description");

    // 4. 숫자형 데이터 변환 (Exception 방지 로직 포함)
    int price = (c_price != null && !c_price.isEmpty()) ? Integer.parseInt(c_price) : 0;
    int stock = (c_stock != null && !c_stock.isEmpty()) ? Integer.parseInt(c_stock) : 0;

    // 5. 파일 업로드 처리 (Part 인터페이스 사용)
    String fileName = "";
    Part part = request.getPart("productImage");
    
    if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
        fileName = part.getSubmittedFileName();
        // 파일 중복 방지를 위한 간단한 처리 (필요시 날짜나 UUID 추가)
        part.write(realFolder + File.separator + fileName);
    }
    
    // 6. 데이터베이스(Repository) 저장
    PreparedStatement pstmt=null;

    String sql = "INSERT INTO cloth VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    pstmt=conn.prepareStatement(sql);
    pstmt.setString(1, c_id);
    pstmt.setString(2, c_name);
    pstmt.setInt(3, price);
    pstmt.setString(4, c_manufacturer);
    pstmt.setString(5, c_brand);
    pstmt.setString(6, c_country);
    pstmt.setString(7, c_topLength);
    pstmt.setString(8, c_pattern);
    pstmt.setString(9, c_pantsLength);
    pstmt.setString(10, c_season);
    pstmt.setString(11, c_category);
    pstmt.setInt(12,stock);
    pstmt.setString(13,c_description);
    pstmt.setString(14,fileName);
    pstmt.executeUpdate();

    if(pstmt != null)
        pstmt.close();
    if(conn!=null)
        conn.close();

    // 7. 성공 후 리다이렉트
    response.sendRedirect("adminAdd.jsp");
%>