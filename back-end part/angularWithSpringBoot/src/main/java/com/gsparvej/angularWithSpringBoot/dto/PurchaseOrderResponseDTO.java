package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class PurchaseOrderResponseDTO {

    private int id;
    private String poNumber;
    private Date poDate;
    private float quantity;
    private float rate;
    private float subTotal;
    private float totalAmount;
    private float tax;
    private Date deliveryDate;
    private String termsAndCondition;

    private VendorResponseDTO vendor;
    private ItemResponseDTO item;

    public PurchaseOrderResponseDTO() {
    }

    public PurchaseOrderResponseDTO(int id, String poNumber, Date poDate, float quantity, float rate, float subTotal, float totalAmount, float tax, Date deliveryDate, String termsAndCondition, VendorResponseDTO vendor, ItemResponseDTO item) {
        this.id = id;
        this.poNumber = poNumber;
        this.poDate = poDate;
        this.quantity = quantity;
        this.rate = rate;
        this.subTotal = subTotal;
        this.totalAmount = totalAmount;
        this.tax = tax;
        this.deliveryDate = deliveryDate;
        this.termsAndCondition = termsAndCondition;
        this.vendor = vendor;
        this.item = item;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPoNumber() {
        return poNumber;
    }

    public void setPoNumber(String poNumber) {
        this.poNumber = poNumber;
    }

    public Date getPoDate() {
        return poDate;
    }

    public void setPoDate(Date poDate) {
        this.poDate = poDate;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public float getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(float subTotal) {
        this.subTotal = subTotal;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public float getTax() {
        return tax;
    }

    public void setTax(float tax) {
        this.tax = tax;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public VendorResponseDTO getVendor() {
        return vendor;
    }

    public void setVendor(VendorResponseDTO vendor) {
        this.vendor = vendor;
    }

    public ItemResponseDTO getItem() {
        return item;
    }

    public void setItem(ItemResponseDTO item) {
        this.item = item;
    }

    public String getTermsAndCondition() {
        return termsAndCondition;
    }

    public void setTermsAndCondition(String termsAndCondition) {
        this.termsAndCondition = termsAndCondition;
    }
}
