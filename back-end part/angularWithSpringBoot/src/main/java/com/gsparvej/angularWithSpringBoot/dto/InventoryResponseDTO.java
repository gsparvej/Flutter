package com.gsparvej.angularWithSpringBoot.dto;

public class InventoryResponseDTO {
    private int id;
    private int quantity;
    private String categoryName;

    public InventoryResponseDTO() {
    }

    public InventoryResponseDTO(int id, int quantity, String categoryName) {
        this.id = id;
        this.quantity = quantity;
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
