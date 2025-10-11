package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class FullRequisitionResponseDTO {

    private int id;
    private Date prDate;
    private String requestedBy;
    private float quantity;
    private float approxUnitPrice;
    private float totalEstPrice;
    private String prStatus;

    private OrderResponseDTO order;
    private ItemResponseDTO item;
    private DepartmentResponseDTO department;

    public FullRequisitionResponseDTO() {
    }

    public FullRequisitionResponseDTO(int id, Date prDate, String requestedBy, float quantity, float approxUnitPrice, float totalEstPrice, String prStatus, OrderResponseDTO order, ItemResponseDTO item, DepartmentResponseDTO department) {
        this.id = id;
        this.prDate = prDate;
        this.requestedBy = requestedBy;
        this.quantity = quantity;
        this.approxUnitPrice = approxUnitPrice;
        this.totalEstPrice = totalEstPrice;
        this.prStatus = prStatus;
        this.order = order;
        this.item = item;
        this.department = department;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPrDate() {
        return prDate;
    }

    public void setPrDate(Date prDate) {
        this.prDate = prDate;
    }

    public String getRequestedBy() {
        return requestedBy;
    }

    public void setRequestedBy(String requestedBy) {
        this.requestedBy = requestedBy;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getApproxUnitPrice() {
        return approxUnitPrice;
    }

    public void setApproxUnitPrice(float approxUnitPrice) {
        this.approxUnitPrice = approxUnitPrice;
    }

    public float getTotalEstPrice() {
        return totalEstPrice;
    }

    public void setTotalEstPrice(float totalEstPrice) {
        this.totalEstPrice = totalEstPrice;
    }

    public String getPrStatus() {
        return prStatus;
    }

    public void setPrStatus(String prStatus) {
        this.prStatus = prStatus;
    }

    public OrderResponseDTO getOrder() {
        return order;
    }

    public void setOrder(OrderResponseDTO order) {
        this.order = order;
    }

    public ItemResponseDTO getItem() {
        return item;
    }

    public void setItem(ItemResponseDTO item) {
        this.item = item;
    }

    public DepartmentResponseDTO getDepartment() {
        return department;
    }

    public void setDepartment(DepartmentResponseDTO department) {
        this.department = department;
    }
}
