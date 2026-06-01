<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    // 1. 세션 로그인 체크 (비로그인 유저인 경우 로그인 페이지로 안내)
    String m_id = (String) session.getAttribute("sessionId");
    if (m_id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. cloth.jsp에서 보낸 상품 아이디(c_id) 받기
    String c_id = request.getParameter("c_id");

    // 상품 아이디가 정상적으로 넘어왔을 때만 진행
    if (c_id != null && !c_id.trim().equals("")) {
        PreparedStatement pstmt = null;
        
        try {
            // 3. 관심 상품 등록 SQL 실행
            // 테이블 설계 시 늘어나는 시퀀스(GENERATED ALWAYS AS IDENTITY)가 있으므로 m_id와 c_id만 넣어줍니다.
            String sql = "INSERT INTO wishlist (m_id, c_id) VALUES (?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, m_id);
            pstmt.setString(2, c_id);
            
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 4. 자원 해제
            if (pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
            if (conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    }

    // 5. 등록 처리가 끝나면 사용자가 원래 보고 있던 상품 상세 페이지로 다시 리다이렉트
    response.sendRedirect("cloth.jsp?id=" + c_id);
%>