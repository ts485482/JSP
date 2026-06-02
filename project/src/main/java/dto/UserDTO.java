package dto;

public class UserDTO {
    private String id;
    private String password;
    private String name; // 필요시 추가 (회원가입 등 확장용)

    // 기본 생성자
    public UserDTO() {}

    // Getter and Setter
    public String getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }
    
    public String getName() {
        return name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public void setName(String name) {
        this.name = name;
    }
}
