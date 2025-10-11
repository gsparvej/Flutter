package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class StockOutResponseDTO {

    private int id;

    private Date transactionDate;
    private int quantity;

    private ItemResponseDTO item;

    public StockOutResponseDTO() {
    }

    public StockOutResponseDTO(int id, Date transactionDate, int quantity, ItemResponseDTO item) {
        this.id = id;
        this.transactionDate = transactionDate;
        this.quantity = quantity;
        this.item = item;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ItemResponseDTO getItem() {
        return item;
    }

    public void setItem(ItemResponseDTO item) {
        this.item = item;
    }
}
