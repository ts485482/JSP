package dto;

public class ClothDTO {
    private String id;
    private String name;
    private int price;
    private String manufacturer;
    private String brand;
    private String country;
    private String topLength;
    private String pattern;
    private String pantsLength;
    private String season;
    private String category;
    private int stock;
    private String description;
    private String fileName;
    private java.sql.Timestamp viewedAt;

    // 기본 생성자
    public ClothDTO() {}

    // Getter
    public String getId() { return id; }
    public String getName() { return name; }
    public int getPrice() { return price; }
    public String getManufacturer() { return manufacturer; }
    public String getBrand() { return brand; }
    public String getCountry() { return country; }
    public String getTopLength() { return topLength; }
    public String getPattern() { return pattern; }
    public String getPantsLength() { return pantsLength; }
    public String getSeason() { return season; }
    public String getCategory() { return category; }
    public int getStock() { return stock; }
    public String getDescription() { return description; }
    public String getFileName() { return fileName; }
    public java.sql.Timestamp getViewedAt() { return viewedAt; }
    
    // Setter
    public void setId(String id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setPrice(int price) { this.price = price; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
    public void setBrand(String brand) { this.brand = brand; }
    public void setCountry(String country){ this.country = country; };
    public void setTopLength(String topLength) { this.topLength = topLength; }
    public void setPattern(String pattern) { this.pattern = pattern; }
    public void setPantsLength(String pantsLength) { this.pantsLength = pantsLength; }
    public void setSeason(String season) { this.season = season; }
    public void setCategory(String category) { this.category = category; }
    public void setStock(int stock) { this.stock = stock; }
    public void setDescription(String description) { this.description = description; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public void setViewedAt(java.sql.Timestamp viewedAt) { this.viewedAt = viewedAt; }
}