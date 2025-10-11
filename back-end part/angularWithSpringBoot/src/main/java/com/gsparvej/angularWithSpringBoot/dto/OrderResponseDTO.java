package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class OrderResponseDTO {

    private int id;
    private Date deliveryDate;

    private BomStyleResponseDTO bomStyle;
    private BuyerResponseDTO buyer;


    public OrderResponseDTO() {
    }

    public OrderResponseDTO(int id, Date deliveryDate, BomStyleResponseDTO bomStyle, BuyerResponseDTO buyer) {
        this.id = id;
        this.deliveryDate = deliveryDate;
        this.bomStyle = bomStyle;
        this.buyer = buyer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public BomStyleResponseDTO getBomStyle() {
        return bomStyle;
    }

    public void setBomStyle(BomStyleResponseDTO bomStyle) {
        this.bomStyle = bomStyle;
    }

    public BuyerResponseDTO getBuyer() {
        return buyer;
    }

    public void setBuyer(BuyerResponseDTO buyer) {
        this.buyer = buyer;
    }

}
