package com.gsparvej.angularWithSpringBoot.dto;

public class InventoryResponseDTO {
    private int id;
    private int quantity;
    private String itemName;
    private String categoryName;

    public InventoryResponseDTO() {
    }

    public InventoryResponseDTO(int id, int quantity, String itemName, String categoryName) {
        this.id = id;
        this.quantity = quantity;
        this.itemName = itemName;
        this.categoryName = categoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
