package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class ProductionOrderResponseDTO {

    private int id;

    private int planQty;
    private Date startDate;
    private Date endDate;
    private String priority;
    private String status;
    private String description;
    private String size;

    private BomStyleResponseDTO bomStyle;
    private OrderResponseDTO order;

    public ProductionOrderResponseDTO() {
    }

    public ProductionOrderResponseDTO(int id, int planQty, Date startDate, Date endDate, String priority, String status, String description, String size, BomStyleResponseDTO bomStyle, OrderResponseDTO order) {
        this.id = id;
        this.planQty = planQty;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.status = status;
        this.description = description;
        this.size = size;
        this.bomStyle = bomStyle;
        this.order = order;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPlanQty() {
        return planQty;
    }

    public void setPlanQty(int planQty) {
        this.planQty = planQty;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public BomStyleResponseDTO getBomStyle() {
        return bomStyle;
    }

    public void setBomStyle(BomStyleResponseDTO bomStyle) {
        this.bomStyle = bomStyle;
    }

    public OrderResponseDTO getOrder() {
        return order;
    }

    public void setOrder(OrderResponseDTO order) {
        this.order = order;
    }
}
