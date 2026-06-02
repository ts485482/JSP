package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dto.UserDTO;

public class UserDAO {
    private Connection getConnection() throws Exception {
        String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbID = "system";
        String dbPassword = "1234";
        
        Class.forName("oracle.jdbc.OracleDriver");
        return DriverManager.getConnection(dbURL, dbID, dbPassword);
    }

    public int login(UserDTO user) {
        String sql = "SELECT m_password, m_name FROM member WHERE m_id = ?";
        
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getId());
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    if (rs.getString("m_password").equals(user.getPassword())) {
                        user.setName(rs.getString("m_name"));
                        return 1; // 로그인 성공
                    } else {
                        return 0; // 비밀번호 불일치
                    }
                }
                return -1; // 존재하지 않는 아이디
            }
            
        } catch (Exception e) {}
        return -2; // 데이터베이스 내부 오류
    }
}