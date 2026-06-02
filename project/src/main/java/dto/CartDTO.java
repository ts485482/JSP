package dto;

public class CartDTO {
    private String clothId;
    private String clothName;
    private int clothPrice;
    private int clothStock;
    private String clothFileName;
    private int quantity;
    
    public String getClothFileName() {
        return clothFileName;
    }
    public String getClothId() {
        return clothId;
    }
    public String getClothName() {
        return clothName;
    }
    public int getClothPrice() {
        return clothPrice;
    }
    public int getClothStock() {
        return clothStock;
    }
    public int getQuantity() {
        return quantity;
    }

    public void setClothFileName(String clothFileName) {
        this.clothFileName = clothFileName;
    }
    public void setClothId(String clothId) {
        this.clothId = clothId;
    }
    public void setClothName(String clothName) {
        this.clothName = clothName;
    }
    public void setClothPrice(int clothPrice) {
        this.clothPrice = clothPrice;
    }
    public void setClothStock(int clothStock) {
        this.clothStock = clothStock;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
