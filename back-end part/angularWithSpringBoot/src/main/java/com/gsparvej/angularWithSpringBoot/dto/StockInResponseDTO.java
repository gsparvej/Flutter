package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class StockInResponseDTO {

    private int id;

    private Date receivedTransactionDate;
    private int quantity;

    private ItemResponseDTO item;

    public StockInResponseDTO() {
    }

    public StockInResponseDTO(int id, Date receivedTransactionDate, int quantity, ItemResponseDTO item) {
        this.id = id;
        this.receivedTransactionDate = receivedTransactionDate;
        this.quantity = quantity;
        this.item = item;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getReceivedTransactionDate() {
        return receivedTransactionDate;
    }

    public void setReceivedTransactionDate(Date receivedTransactionDate) {
        this.receivedTransactionDate = receivedTransactionDate;
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
