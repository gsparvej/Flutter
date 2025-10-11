package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class FullOrderViewResponseDTO {

    private int id;

    private Date orderDate;
    private Date deliveryDate;

    // Short sleeve sizes & prices
    private int shortSmallSize;
    private double shortSPrice;

    private int shortMediumSize;
    private double shortMPrice;

    private int shortLargeSize;
    private double shortLPrice;

    private int shortXLSize;
    private double shortXLPrice;

    // Full sleeve sizes & prices
    private int fullSmallSize;
    private double fullSPrice;

    private int fullMediumSize;
    private double fullMPrice;

    private int fullLargeSize;
    private double fullLPrice;

    private int fullXLSize;
    private double fullXLPrice;

    // Financial
    private double subTotal;
    private double vat;
    private double paidAmount;
    private double dueAmount;
    private double total;

    private String remarks;
    private String orderStatus;

    private BomStyleResponseDTO bomStyle;
    private BuyerResponseDTO buyer;


    public FullOrderViewResponseDTO() {
    }

    public FullOrderViewResponseDTO(int id, Date orderDate, Date deliveryDate, int shortSmallSize, double shortSPrice, int shortMediumSize, double shortMPrice, int shortLargeSize, double shortLPrice, int shortXLSize, double shortXLPrice, int fullSmallSize, double fullSPrice, int fullMediumSize, double fullMPrice, int fullLargeSize, double fullLPrice, int fullXLSize, double fullXLPrice, double subTotal, double vat, double paidAmount, double dueAmount, double total, String remarks, String orderStatus, BomStyleResponseDTO bomStyle, BuyerResponseDTO buyer) {
        this.id = id;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
        this.shortSmallSize = shortSmallSize;
        this.shortSPrice = shortSPrice;
        this.shortMediumSize = shortMediumSize;
        this.shortMPrice = shortMPrice;
        this.shortLargeSize = shortLargeSize;
        this.shortLPrice = shortLPrice;
        this.shortXLSize = shortXLSize;
        this.shortXLPrice = shortXLPrice;
        this.fullSmallSize = fullSmallSize;
        this.fullSPrice = fullSPrice;
        this.fullMediumSize = fullMediumSize;
        this.fullMPrice = fullMPrice;
        this.fullLargeSize = fullLargeSize;
        this.fullLPrice = fullLPrice;
        this.fullXLSize = fullXLSize;
        this.fullXLPrice = fullXLPrice;
        this.subTotal = subTotal;
        this.vat = vat;
        this.paidAmount = paidAmount;
        this.dueAmount = dueAmount;
        this.total = total;
        this.remarks = remarks;
        this.orderStatus = orderStatus;
        this.bomStyle = bomStyle;
        this.buyer = buyer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public int getShortSmallSize() {
        return shortSmallSize;
    }

    public void setShortSmallSize(int shortSmallSize) {
        this.shortSmallSize = shortSmallSize;
    }

    public double getShortSPrice() {
        return shortSPrice;
    }

    public void setShortSPrice(double shortSPrice) {
        this.shortSPrice = shortSPrice;
    }

    public int getShortMediumSize() {
        return shortMediumSize;
    }

    public void setShortMediumSize(int shortMediumSize) {
        this.shortMediumSize = shortMediumSize;
    }

    public double getShortMPrice() {
        return shortMPrice;
    }

    public void setShortMPrice(double shortMPrice) {
        this.shortMPrice = shortMPrice;
    }

    public int getShortLargeSize() {
        return shortLargeSize;
    }

    public void setShortLargeSize(int shortLargeSize) {
        this.shortLargeSize = shortLargeSize;
    }

    public double getShortLPrice() {
        return shortLPrice;
    }

    public void setShortLPrice(double shortLPrice) {
        this.shortLPrice = shortLPrice;
    }

    public int getShortXLSize() {
        return shortXLSize;
    }

    public void setShortXLSize(int shortXLSize) {
        this.shortXLSize = shortXLSize;
    }

    public double getShortXLPrice() {
        return shortXLPrice;
    }

    public void setShortXLPrice(double shortXLPrice) {
        this.shortXLPrice = shortXLPrice;
    }

    public int getFullSmallSize() {
        return fullSmallSize;
    }

    public void setFullSmallSize(int fullSmallSize) {
        this.fullSmallSize = fullSmallSize;
    }

    public double getFullSPrice() {
        return fullSPrice;
    }

    public void setFullSPrice(double fullSPrice) {
        this.fullSPrice = fullSPrice;
    }

    public int getFullMediumSize() {
        return fullMediumSize;
    }

    public void setFullMediumSize(int fullMediumSize) {
        this.fullMediumSize = fullMediumSize;
    }

    public double getFullMPrice() {
        return fullMPrice;
    }

    public void setFullMPrice(double fullMPrice) {
        this.fullMPrice = fullMPrice;
    }

    public int getFullLargeSize() {
        return fullLargeSize;
    }

    public void setFullLargeSize(int fullLargeSize) {
        this.fullLargeSize = fullLargeSize;
    }

    public double getFullLPrice() {
        return fullLPrice;
    }

    public void setFullLPrice(double fullLPrice) {
        this.fullLPrice = fullLPrice;
    }

    public int getFullXLSize() {
        return fullXLSize;
    }

    public void setFullXLSize(int fullXLSize) {
        this.fullXLSize = fullXLSize;
    }

    public double getFullXLPrice() {
        return fullXLPrice;
    }

    public void setFullXLPrice(double fullXLPrice) {
        this.fullXLPrice = fullXLPrice;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public double getVat() {
        return vat;
    }

    public void setVat(double vat) {
        this.vat = vat;
    }

    public double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public double getDueAmount() {
        return dueAmount;
    }

    public void setDueAmount(double dueAmount) {
        this.dueAmount = dueAmount;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
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
