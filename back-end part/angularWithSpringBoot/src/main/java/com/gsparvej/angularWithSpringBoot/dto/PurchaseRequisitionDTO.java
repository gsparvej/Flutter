package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class PurchaseRequisitionDTO {

    private int id;
    private Date prDate;
    private String requestedBy;
    private String prStatus;

    public PurchaseRequisitionDTO() {
    }

    public PurchaseRequisitionDTO(int id, Date prDate, String requestedBy, String prStatus) {
        this.id = id;
        this.prDate = prDate;
        this.requestedBy = requestedBy;
        this.prStatus = prStatus;
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

    public String getPrStatus() {
        return prStatus;
    }

    public void setPrStatus(String prStatus) {
        this.prStatus = prStatus;
    }
}
