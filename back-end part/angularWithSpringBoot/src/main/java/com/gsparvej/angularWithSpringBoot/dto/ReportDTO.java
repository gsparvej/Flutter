package com.gsparvej.angularWithSpringBoot.dto;

public class ReportDTO {
    private int shortSTotal;
    private int shortMTotal;
    private int shortLTotal;
    private int shortXLTotal;

    private int fullSTotal;
    private int fullMTotal;
    private int fullLTotal;
    private int fullXLTotal;

    private int remainingShortSQty;
    private int remainingShortMQty;
    private int remainingShortLQty;
    private int remainingShortXLQty;

    private int remainingFullSQty;
    private int remainingFullMQty;
    private int remainingFullLQty;
    private int remainingFullXLQty;

// Getter/Setter গুলোও লিখতে হবে




    public ReportDTO() {
    }

    public ReportDTO(int shortSTotal, int shortMTotal, int shortLTotal, int shortXLTotal, int fullSTotal, int fullMTotal, int fullLTotal, int fullXLTotal, int remainingShortSQty, int remainingShortMQty, int remainingShortLQty, int remainingShortXLQty, int remainingFullSQty, int remainingFullMQty, int remainingFullLQty, int remainingFullXLQty) {
        this.shortSTotal = shortSTotal;
        this.shortMTotal = shortMTotal;
        this.shortLTotal = shortLTotal;
        this.shortXLTotal = shortXLTotal;
        this.fullSTotal = fullSTotal;
        this.fullMTotal = fullMTotal;
        this.fullLTotal = fullLTotal;
        this.fullXLTotal = fullXLTotal;
        this.remainingShortSQty = remainingShortSQty;
        this.remainingShortMQty = remainingShortMQty;
        this.remainingShortLQty = remainingShortLQty;
        this.remainingShortXLQty = remainingShortXLQty;
        this.remainingFullSQty = remainingFullSQty;
        this.remainingFullMQty = remainingFullMQty;
        this.remainingFullLQty = remainingFullLQty;
        this.remainingFullXLQty = remainingFullXLQty;
    }

    public int getShortSTotal() {
        return shortSTotal;
    }

    public void setShortSTotal(int shortSTotal) {
        this.shortSTotal = shortSTotal;
    }

    public int getShortMTotal() {
        return shortMTotal;
    }

    public void setShortMTotal(int shortMTotal) {
        this.shortMTotal = shortMTotal;
    }

    public int getShortLTotal() {
        return shortLTotal;
    }

    public void setShortLTotal(int shortLTotal) {
        this.shortLTotal = shortLTotal;
    }

    public int getShortXLTotal() {
        return shortXLTotal;
    }

    public void setShortXLTotal(int shortXLTotal) {
        this.shortXLTotal = shortXLTotal;
    }

    public int getFullSTotal() {
        return fullSTotal;
    }

    public void setFullSTotal(int fullSTotal) {
        this.fullSTotal = fullSTotal;
    }

    public int getFullMTotal() {
        return fullMTotal;
    }

    public void setFullMTotal(int fullMTotal) {
        this.fullMTotal = fullMTotal;
    }

    public int getFullLTotal() {
        return fullLTotal;
    }

    public void setFullLTotal(int fullLTotal) {
        this.fullLTotal = fullLTotal;
    }

    public int getFullXLTotal() {
        return fullXLTotal;
    }

    public void setFullXLTotal(int fullXLTotal) {
        this.fullXLTotal = fullXLTotal;
    }

    public int getRemainingShortSQty() {
        return remainingShortSQty;
    }

    public void setRemainingShortSQty(int remainingShortSQty) {
        this.remainingShortSQty = remainingShortSQty;
    }

    public int getRemainingShortMQty() {
        return remainingShortMQty;
    }

    public void setRemainingShortMQty(int remainingShortMQty) {
        this.remainingShortMQty = remainingShortMQty;
    }

    public int getRemainingShortLQty() {
        return remainingShortLQty;
    }

    public void setRemainingShortLQty(int remainingShortLQty) {
        this.remainingShortLQty = remainingShortLQty;
    }

    public int getRemainingShortXLQty() {
        return remainingShortXLQty;
    }

    public void setRemainingShortXLQty(int remainingShortXLQty) {
        this.remainingShortXLQty = remainingShortXLQty;
    }

    public int getRemainingFullSQty() {
        return remainingFullSQty;
    }

    public void setRemainingFullSQty(int remainingFullSQty) {
        this.remainingFullSQty = remainingFullSQty;
    }

    public int getRemainingFullMQty() {
        return remainingFullMQty;
    }

    public void setRemainingFullMQty(int remainingFullMQty) {
        this.remainingFullMQty = remainingFullMQty;
    }

    public int getRemainingFullLQty() {
        return remainingFullLQty;
    }

    public void setRemainingFullLQty(int remainingFullLQty) {
        this.remainingFullLQty = remainingFullLQty;
    }

    public int getRemainingFullXLQty() {
        return remainingFullXLQty;
    }

    public void setRemainingFullXLQty(int remainingFullXLQty) {
        this.remainingFullXLQty = remainingFullXLQty;
    }
}
