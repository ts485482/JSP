package dao;

import java.sql.*;
import dto.ClothDTO;

public class ClothDAO {
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "1234");
    }

    // 1. 단일 상품 정보 조회
    public ClothDTO getClothById(String c_id) {
        ClothDTO cloth = null;
        String sql = "SELECT * FROM cloth WHERE c_id = ?";
        
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, c_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cloth = new ClothDTO();
                    cloth.setId(rs.getString("c_id"));
                    cloth.setName(rs.getString("c_name"));
                    cloth.setPrice(rs.getInt("c_price"));
                    cloth.setManufacturer(rs.getString("c_manufacturer"));
                    cloth.setBrand(rs.getString("c_brand"));
                    cloth.setCountry(rs.getString("c_country"));
                    cloth.setTopLength(rs.getString("c_topLength"));
                    cloth.setPattern(rs.getString("c_pattern"));
                    cloth.setPantsLength(rs.getString("c_pantsLength"));
                    cloth.setSeason(rs.getString("c_season"));
                    cloth.setCategory(rs.getString("c_category"));
                    cloth.setStock(rs.getInt("c_stock"));
                    cloth.setDescription(rs.getString("c_description"));
                    cloth.setFileName(rs.getString("c_fileName"));
                }
            }
        } catch (Exception e) {}
        return cloth;
    }

    // 2. 최근 본 상품 비즈니스 로직 처리
    public void manageRecentView(String m_id, String c_id) {
        if (m_id == null || c_id == null) return;

        try (Connection conn = getConnection()) {
            // 존재 확인
            String checkSql = "SELECT 1 FROM recent_view WHERE m_id=? AND c_id=?";
            boolean exists = false;
            try (PreparedStatement pstmt = conn.prepareStatement(checkSql)) {
                pstmt.setString(1, m_id);
                pstmt.setString(2, c_id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) exists = true;
                }
            }

            // UPDATE 또는 INSERT
            if (exists) {
                String updateSql = "UPDATE recent_view SET viewed_at = SYSDATE WHERE m_id=? AND c_id=?";
                try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                    pstmt.setString(1, m_id);
                    pstmt.setString(2, c_id);
                    pstmt.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO recent_view(m_id, c_id, viewed_at) VALUES(?, ?, SYSDATE)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                    pstmt.setString(1, m_id);
                    pstmt.setString(2, c_id);
                    pstmt.executeUpdate();
                }
            }

            // 오래된 내역 삭제 (최대 3개 유지)
            String deleteOldSql = "DELETE FROM recent_view WHERE m_id=? AND c_id NOT IN " +
                                  "(SELECT c_id FROM (SELECT c_id FROM recent_view WHERE m_id=? ORDER BY viewed_at DESC) WHERE ROWNUM <= 3)";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteOldSql)) {
                pstmt.setString(1, m_id);
                pstmt.setString(2, m_id);
                pstmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. 위시리스트 등록 여부 및 ID 확인 (배열로 반환 [0]: 등록여부 0/1, [1]: wishlist_id)
    public int[] checkWishlist(String m_id, String c_id) {
        int[] result = {0, 0}; // {isWish(0 또는 1), wishlistId}
        if (m_id == null || c_id == null) return result;

        String sql = "SELECT wishlist_id FROM wishlist WHERE m_id = ? AND c_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, m_id);
            pstmt.setString(2, c_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result[0] = 1; // true를 뜻함
                    result[1] = rs.getInt("wishlist_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public java.util.List<ClothDTO> getMainProductList(String userId, String category, String keyword) {
        java.util.List<ClothDTO> list = new java.util.ArrayList<>();
        
        // 1. 기본 SQL 뼈대 구성
        String sql = "";
        if (userId != null) {
            sql = "SELECT c.*, rv.viewed_at FROM cloth c " +
                "LEFT JOIN recent_view rv ON c.c_id = rv.c_id AND rv.m_id = ? " +
                "WHERE 1=1 ";
        } else {
            sql = "SELECT c.* FROM cloth c WHERE 1=1 ";
        }

        // 2. 카테고리 및 검색 조건 추가
        if (category != null && !category.equals("")) {
            sql += "AND c.c_category = ? ";
        }
        if (keyword != null && !keyword.equals("")) {
            sql += "AND (UPPER(c.c_name) LIKE UPPER(?) OR UPPER(c.c_brand) LIKE UPPER(?)) ";
        }

        // 3. 정렬 조건 추가
        if (userId != null) {
            sql += "ORDER BY CASE WHEN rv.viewed_at IS NULL THEN 1 ELSE 0 END, rv.viewed_at DESC";
        } else {
            sql += "ORDER BY c.c_id DESC";
        }

        // 4. PreparedStatement 세팅 및 실행
        try (Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int index = 1;
            if (userId != null) {
                pstmt.setString(index++, userId);
            }
            if (category != null && !category.equals("")) {
                pstmt.setString(index++, category);
            }
            if (keyword != null && !keyword.equals("")) {
                pstmt.setString(index++, "%" + keyword + "%");
                pstmt.setString(index++, "%" + keyword + "%");
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ClothDTO cloth = new ClothDTO();
                    cloth.setId(rs.getString("c_id"));
                    cloth.setName(rs.getString("c_name"));
                    cloth.setBrand(rs.getString("c_brand"));
                    cloth.setPrice(rs.getInt("c_price"));
                    cloth.setFileName(rs.getString("c_fileName"));
                    // 로그인 상태일 때만 최근 본 시간 추출
                    if (userId != null) {
                        cloth.setViewedAt(rs.getTimestamp("viewed_at"));
                    }
                    list.add(cloth);
                }
            }
        } catch (Exception e) {}
        return list;
    }
}