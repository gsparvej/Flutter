package com.gsparvej.angularWithSpringBoot.dto;

public class RawMaterialsResponseDTO {

    private int id;

    private int shortSTotalQuantity;
    private int shortMTotalQuantity;
    private int shortLTotalQuantity;
    private int shortXLTotalQuantity;
    private int fullSTotalQuantity;
    private int fullMTotalQuantity;
    private int fullLTotalQuantity;
    private int fullXLTotalQuantity;
    private double totalFabric;

    private OrderResponseDTO order;
    private BomStyleResponseDTO bomStyle;

    public RawMaterialsResponseDTO() {
    }

    public RawMaterialsResponseDTO(int id, int shortSTotalQuantity, int shortMTotalQuantity, int shortLTotalQuantity, int shortXLTotalQuantity, int fullSTotalQuantity, int fullMTotalQuantity, int fullLTotalQuantity, int fullXLTotalQuantity, double totalFabric, OrderResponseDTO order, BomStyleResponseDTO bomStyle) {
        this.id = id;
        this.shortSTotalQuantity = shortSTotalQuantity;
        this.shortMTotalQuantity = shortMTotalQuantity;
        this.shortLTotalQuantity = shortLTotalQuantity;
        this.shortXLTotalQuantity = shortXLTotalQuantity;
        this.fullSTotalQuantity = fullSTotalQuantity;
        this.fullMTotalQuantity = fullMTotalQuantity;
        this.fullLTotalQuantity = fullLTotalQuantity;
        this.fullXLTotalQuantity = fullXLTotalQuantity;
        this.totalFabric = totalFabric;
        this.order = order;
        this.bomStyle = bomStyle;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getShortSTotalQuantity() {
        return shortSTotalQuantity;
    }

    public void setShortSTotalQuantity(int shortSTotalQuantity) {
        this.shortSTotalQuantity = shortSTotalQuantity;
    }

    public int getShortMTotalQuantity() {
        return shortMTotalQuantity;
    }

    public void setShortMTotalQuantity(int shortMTotalQuantity) {
        this.shortMTotalQuantity = shortMTotalQuantity;
    }

    public int getShortLTotalQuantity() {
        return shortLTotalQuantity;
    }

    public void setShortLTotalQuantity(int shortLTotalQuantity) {
        this.shortLTotalQuantity = shortLTotalQuantity;
    }

    public int getShortXLTotalQuantity() {
        return shortXLTotalQuantity;
    }

    public void setShortXLTotalQuantity(int shortXLTotalQuantity) {
        this.shortXLTotalQuantity = shortXLTotalQuantity;
    }

    public int getFullSTotalQuantity() {
        return fullSTotalQuantity;
    }

    public void setFullSTotalQuantity(int fullSTotalQuantity) {
        this.fullSTotalQuantity = fullSTotalQuantity;
    }

    public int getFullMTotalQuantity() {
        return fullMTotalQuantity;
    }

    public void setFullMTotalQuantity(int fullMTotalQuantity) {
        this.fullMTotalQuantity = fullMTotalQuantity;
    }

    public int getFullLTotalQuantity() {
        return fullLTotalQuantity;
    }

    public void setFullLTotalQuantity(int fullLTotalQuantity) {
        this.fullLTotalQuantity = fullLTotalQuantity;
    }

    public int getFullXLTotalQuantity() {
        return fullXLTotalQuantity;
    }

    public void setFullXLTotalQuantity(int fullXLTotalQuantity) {
        this.fullXLTotalQuantity = fullXLTotalQuantity;
    }

    public double getTotalFabric() {
        return totalFabric;
    }

    public void setTotalFabric(double totalFabric) {
        this.totalFabric = totalFabric;
    }

    public OrderResponseDTO getOrder() {
        return order;
    }

    public void setOrder(OrderResponseDTO order) {
        this.order = order;
    }

    public BomStyleResponseDTO getBomStyle() {
        return bomStyle;
    }

    public void setBomStyle(BomStyleResponseDTO bomStyle) {
        this.bomStyle = bomStyle;
    }
}
