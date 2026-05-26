<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>

<%
    // 인코딩
    request.setCharacterEncoding("UTF-8");

    // 회원가입 폼 데이터 받기
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String birth = request.getParameter("birth");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // 가입 날짜
    String regist_day = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            .format(new java.util.Date());

    // DB 저장
    PreparedStatement pstmt = null;

    String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,?)";

    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, id);
    pstmt.setString(2, password);
    pstmt.setString(3, name);
    pstmt.setString(4, gender);
    pstmt.setString(5, birth);
    pstmt.setString(6, email);
    pstmt.setString(7, phone);
    pstmt.setString(8, address);
    pstmt.setString(9, regist_day);

    pstmt.executeUpdate();

    // 자원 정리
    if(pstmt != null)
        pstmt.close();

    if(conn != null)
        conn.close();

    // 메인페이지 이동
    response.sendRedirect("main.jsp");
%>