<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    // 1. 세션 로그인 체크 (비로그인 유저 차단)
    String m_id = (String) session.getAttribute("sessionId");
    if (m_id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. 파라미터 받기 (c_id: 상세페이지 복귀용, wishlistId: 삭제 대상)
    String c_id = request.getParameter("c_id");
    String wishlistIdParam = request.getParameter("wishlistId");

    // 파라미터가 비어있다면 비정상적인 접근이므로 목록으로 리다이렉트
    if (wishlistIdParam == null || wishlistIdParam.trim().equals("")) {
        response.sendRedirect("wishlist.jsp");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        int wishlistId = Integer.parseInt(wishlistIdParam);

        // 3. 삭제 SQL 실행 (본인 것만 삭제 가능하도록 m_id 검증)
        String sql = "DELETE FROM wishlist WHERE wishlist_id = ? AND m_id = ?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, wishlistId);
        pstmt.setString(2, m_id);
        
        pstmt.executeUpdate();

    } catch (NumberFormatException e) {
        e.printStackTrace();
    } finally {
        // 4. 자원 해제
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }

    // 5. 페이지 이동 분기 처리
    // c_id가 넘어왔다는 것은 '상품 상세페이지(cloth.jsp)'에서 하트를 눌러 해제했다는 뜻입니다.
    if (c_id != null && !c_id.trim().equals("")) {
        response.sendRedirect("cloth.jsp?id=" + c_id);
    } else {
        // c_id가 없다면 '관심등록 목록페이지(wishlist.jsp)'에서 삭제를 누른 것이므로 목록에 남겨둡니다.
        response.sendRedirect("wishlist.jsp");
    }
%>