package com.gsparvej.angularWithSpringBoot.dto;

public class StockRequestDTO {
    private int itemId;
    private int quantity;

    public StockRequestDTO() {
    }

    public StockRequestDTO(int itemId, int quantity) {
        this.itemId = itemId;
        this.quantity = quantity;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
