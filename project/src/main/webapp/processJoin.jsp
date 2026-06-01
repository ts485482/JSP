<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 회원가입 폼 데이터 받기
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String birth = request.getParameter("birth");
    String email = request.getParameter("email");
    
    // 전화번호 결합 처리 (join.jsp에서 phone1, phone2, phone3로 나누어 보냈기 때문)
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String phone = phone1 + "-" + phone2 + "-" + phone3;

    // ★ [주소 API 연동 핵심 추가 영역] ★
    // join.jsp에서 보낸 우편번호, 기본주소, 상세주소를 각각 수령합니다.
    String zipcode = request.getParameter("zipcode");
    String baseAddress = request.getParameter("address");
    String addressDetail = request.getParameter("addressDetail");

    // 수령한 주소 조각들을 기존 DB의 단일 address 컬럼 구조에 맞게 하나로 결합합니다.
    String fullAddress = "[" + zipcode + "] " + baseAddress + " " + addressDetail;

    // 가입 날짜 생성
    String regist_day = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            .format(new java.util.Date());

    // DB 저장 프로세스
    PreparedStatement pstmt = null;

    String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,?)";

    try {
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, name);
        pstmt.setString(4, gender);
        pstmt.setString(5, birth);
        pstmt.setString(6, email);
        pstmt.setString(7, phone);
        pstmt.setString(8, fullAddress); // 결합된 전체 주소 문자열을 8번째 위치에 바인딩
        pstmt.setString(9, regist_day);

        pstmt.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // 자원 해제 안전하게 처리
        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }

    // 회원가입 완료 후 메인페이지로 리다이렉트 이동
    response.sendRedirect("main.jsp");
%>