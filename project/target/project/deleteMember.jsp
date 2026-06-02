<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String m_id = (String)session.getAttribute("sessionId");
    if(m_id == null){
        response.sendRedirect("login.jsp");
        return;
    }
    PreparedStatement pstmt = null;
    // [1단계] 위시리스트 삭제 (자식)
    String deleteWish = "DELETE FROM wishlist WHERE m_id = ?";
    pstmt = conn.prepareStatement(deleteWish);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
    pstmt.close();

    // [2단계] 최근 본 상품 삭제 (자식)
    String deleteRecent = "DELETE FROM recent_view WHERE m_id = ?";
    pstmt = conn.prepareStatement(deleteRecent);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
    pstmt.close();

    // [3단계] 장바구니 삭제 (자식)
    String deleteCart = "DELETE FROM cart WHERE m_id = ?";
    pstmt = conn.prepareStatement(deleteCart);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
    pstmt.close();

    // [4단계] 주문 아이템 삭제 (가장 하위 자식)
    // orderinfo 테이블의 m_id와 연동된 order_id를 찾아서 orderitem을 지웁니다.
    String deleteItems = "DELETE FROM orderitem WHERE order_id IN (SELECT order_id FROM orderinfo WHERE m_id = ?)";
    pstmt = conn.prepareStatement(deleteItems);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
    pstmt.close();

    // [5단계] 주문 정보 삭제 (부모 겸 자식)
    String deleteOrder = "DELETE FROM orderinfo WHERE m_id = ?";        
    pstmt = conn.prepareStatement(deleteOrder);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
    pstmt.close();

    // [6단계] 최종 회원 정보 삭제 (최상위 부모)
    String deleteMember = "DELETE FROM member WHERE m_id = ?";
    pstmt = conn.prepareStatement(deleteMember);
    pstmt.setString(1, m_id);
    pstmt.executeUpdate();
        
    session.invalidate();

    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();
%>
    <script>
        alert("탈퇴가 완료되었습니다. 그동안 Mood Closet을 이용해 주셔서 감사합니다.");
        location.href = "main.jsp";
    </script>