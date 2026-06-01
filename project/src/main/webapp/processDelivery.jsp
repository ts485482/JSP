<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 안전장치: 관리자 세션 유효성 검증
    String userId = (String) session.getAttribute("sessionId");
    if(userId == null || !userId.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }

    String orderIdStr = request.getParameter("orderId");
    String deliveryStatus = request.getParameter("deliveryStatus");

    if (orderIdStr != null && deliveryStatus != null) {
        PreparedStatement pstmt = null;
        
        // ★ 파자마 스크마 맞춤: orderinfo 테이블의 order_status 컬럼을 갱신합니다.
        String sql = "UPDATE orderinfo SET order_status = ? WHERE order_id = ?";
        
        try {
            int orderId = Integer.parseInt(orderIdStr); // order_id가 NUMBER 타입이므로 인티저 파싱
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, deliveryStatus);
            pstmt.setInt(2, orderId);
            
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        }
    }
    
    // 상태 변경 작업을 끝마치고 대시보드로 복귀 리다이렉션
    response.sendRedirect("adminDelivery.jsp");
%>