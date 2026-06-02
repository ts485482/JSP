package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.CartDTO;

public class CartDAO {

    // 기존 프로젝트의 getConnection() 방식을 그대로 사용하시면 됩니다.
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "1234");
    }

    /**
     * 특정 사용자의 장바구니 리스트 가져오기 (JOIN)
     */
    public List<CartDTO> getCartList(String userId) {
        List<CartDTO> list = new ArrayList<>();
        
        // 기존 cart.jsp에 있던 정석 조인 쿼리문 그대로 반영
        String sql = "SELECT c.c_id, c.c_name, c.c_price, c.c_stock, c.c_fileName, ct.quantity " +
                     "FROM cart ct " +
                     "JOIN cloth c ON ct.c_id = c.c_id " +
                     "WHERE ct.m_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CartDTO cart = new CartDTO();
                    cart.setClothId(rs.getString("c_id"));
                    cart.setClothName(rs.getString("c_name"));
                    cart.setClothPrice(rs.getInt("c_price"));
                    cart.setClothStock(rs.getInt("c_stock"));
                    cart.setClothFileName(rs.getString("c_fileName"));
                    cart.setQuantity(rs.getInt("quantity"));
                    
                    list.add(cart);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}