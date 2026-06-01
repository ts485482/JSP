<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String userId = (String)session.getAttribute("sessionId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

String name = request.getParameter("name");
String phone = request.getParameter("phone");
String zipcode = request.getParameter("zipcode");
String address = request.getParameter("address");
String addressDetail = request.getParameter("addressDetail");
String message = request.getParameter("message");

PreparedStatement pstmt = null;
ResultSet rs = null;

int totalPrice = 0;
int orderId = 0;

// 장바구니 조회
String cartSql =
    "SELECT c.c_id, " +
    "       c.c_name, " +
    "       c.c_price, " +
    "       c.c_stock, " +
    "       ct.quantity " +
    "FROM cart ct " +
    "JOIN cloth c " +
    "ON ct.c_id = c.c_id " +
    "WHERE ct.m_id=?";

pstmt = conn.prepareStatement(cartSql);

pstmt.setString(1, userId);

rs = pstmt.executeQuery();

totalPrice += 3000;
while(rs.next()){

    totalPrice += rs.getInt("c_price")
                * rs.getInt("quantity");
}

rs.close();
pstmt.close();


// =========================
// 재고 검사
// =========================

pstmt = conn.prepareStatement(cartSql);

pstmt.setString(1, userId);

rs = pstmt.executeQuery();

while(rs.next()){

    int stock = rs.getInt("c_stock");

    int qty = rs.getInt("quantity");

    String productName = rs.getString("c_name");

    // 재고 부족
    if(stock < qty){

        rs.close();
        pstmt.close();
        conn.close();

        out.println("<script>");
        out.println("alert('" + productName + " 상품의 재고가 부족합니다.');");
        out.println("location.href='cart.jsp';");
        out.println("</script>");

        return;
    }
}

rs.close();
pstmt.close();


// =========================
// 1. 주문 저장
// =========================

String orderSql =
    "INSERT INTO orderinfo " +
    "(order_id, m_id, receiver_name, receiver_phone, receiver_address, message, total_price, order_status) " +
    "VALUES (order_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

pstmt = conn.prepareStatement(orderSql);

pstmt.setString(1, userId);
pstmt.setString(2, name);
pstmt.setString(3, phone);
pstmt.setString(4, "["+ zipcode + "] " + address + addressDetail);
pstmt.setString(5, message);
pstmt.setInt(6, totalPrice);
pstmt.setString(7,"배송준비중");

pstmt.executeUpdate();

pstmt.close();


// =========================
// 2. 생성된 order_id 조회
// =========================

String seqSql = "SELECT order_seq.CURRVAL FROM dual";

pstmt = conn.prepareStatement(seqSql);

rs = pstmt.executeQuery();

if(rs.next()){
    orderId = rs.getInt(1);
}

rs.close();
pstmt.close();


// =========================
// 3. 주문 상품 저장
// =========================

pstmt = conn.prepareStatement(cartSql);
pstmt.setString(1, userId);

rs = pstmt.executeQuery();

while(rs.next()){

    String c_id = rs.getString("c_id");
    int price = rs.getInt("c_price");
    int qty = rs.getInt("quantity");

    String itemSql =
        "INSERT INTO orderitem " +
        "(item_id, order_id, c_id, c_name, c_price, quantity, subtotal) " +
        "VALUES (orderitem_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";

    PreparedStatement itemPstmt = conn.prepareStatement(itemSql);

    itemPstmt.setInt(1, orderId);
    itemPstmt.setString(2, rs.getString("c_id"));
    itemPstmt.setString(3, rs.getString("c_name"));
    itemPstmt.setInt(4, price);
    itemPstmt.setInt(5, qty);
    itemPstmt.setInt(6, price * qty);

    itemPstmt.executeUpdate();

    itemPstmt.close();

    String stockSql = "UPDATE cloth " +
                    "SET c_stock = c_stock - ? " +
                    "WHERE c_id = ?";

    PreparedStatement stockPstmt = conn.prepareStatement(stockSql);

    stockPstmt.setInt(1,qty);
    stockPstmt.setString(2, c_id);
    stockPstmt.executeUpdate();
    stockPstmt.close();
}

rs.close();
pstmt.close();


// =========================
// 4. 장바구니 비우기
// =========================

String deleteSql = "DELETE FROM cart WHERE m_id=?";

pstmt = conn.prepareStatement(deleteSql);

pstmt.setString(1, userId);

pstmt.executeUpdate();

pstmt.close();
conn.close();

// =========================
// 5. 주문완료 페이지 이동
// =========================

response.sendRedirect("order.jsp?order_id=" + orderId);
%>