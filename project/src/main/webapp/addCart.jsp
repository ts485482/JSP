<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 로그인 확인
    String userId = (String)session.getAttribute("sessionId");
    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // 상품 정보
    String c_id = request.getParameter("c_id");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 이미 장바구니에 있는 상품인지 확인
    String sql = "SELECT * FROM cart WHERE m_id=? AND c_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userId);
    pstmt.setString(2, c_id);
    rs = pstmt.executeQuery();

    // 이미 있으면 수량 증가
    if(rs.next()){
        int currentQty = rs.getInt("quantity");
        pstmt.close();
        sql =
            "UPDATE cart SET quantity=? WHERE m_id=? AND c_id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, currentQty + quantity);
        pstmt.setString(2, userId);
        pstmt.setString(3, c_id);
        pstmt.executeUpdate();
    } else{      // 없으면 새로 추가
        pstmt.close();
        sql =
            "INSERT INTO cart(m_id, c_id, quantity) VALUES(?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, c_id);
        pstmt.setInt(3, quantity);
        pstmt.executeUpdate();
    }
    if(rs != null) rs.close();
    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();
    // 장바구니 이동
    response.sendRedirect("cloth.jsp?id=" + c_id);
%>