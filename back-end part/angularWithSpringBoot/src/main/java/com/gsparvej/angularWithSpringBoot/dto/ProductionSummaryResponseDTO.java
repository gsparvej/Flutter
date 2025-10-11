package com.gsparvej.angularWithSpringBoot.dto;

public class ProductionSummaryResponseDTO {

    private int shortSQtySum;
    private int shortMQtySum;
    private int shortLQtySum;
    private int shortXLQtySum;
    private int fullSQtySum;
    private int fullMQtySum;
    private int fullLQtySum;
    private int fullXLQtySum;

    public ProductionSummaryResponseDTO() {
    }

    public ProductionSummaryResponseDTO(int shortSQtySum, int shortMQtySum, int shortLQtySum, int shortXLQtySum, int fullSQtySum, int fullMQtySum, int fullLQtySum, int fullXLQtySum) {
        this.shortSQtySum = shortSQtySum;
        this.shortMQtySum = shortMQtySum;
        this.shortLQtySum = shortLQtySum;
        this.shortXLQtySum = shortXLQtySum;
        this.fullSQtySum = fullSQtySum;
        this.fullMQtySum = fullMQtySum;
        this.fullLQtySum = fullLQtySum;
        this.fullXLQtySum = fullXLQtySum;
    }

    public int getShortSQtySum() {
        return shortSQtySum;
    }

    public void setShortSQtySum(int shortSQtySum) {
        this.shortSQtySum = shortSQtySum;
    }

    public int getShortMQtySum() {
        return shortMQtySum;
    }

    public void setShortMQtySum(int shortMQtySum) {
        this.shortMQtySum = shortMQtySum;
    }

    public int getShortLQtySum() {
        return shortLQtySum;
    }

    public void setShortLQtySum(int shortLQtySum) {
        this.shortLQtySum = shortLQtySum;
    }

    public int getShortXLQtySum() {
        return shortXLQtySum;
    }

    public void setShortXLQtySum(int shortXLQtySum) {
        this.shortXLQtySum = shortXLQtySum;
    }

    public int getFullSQtySum() {
        return fullSQtySum;
    }

    public void setFullSQtySum(int fullSQtySum) {
        this.fullSQtySum = fullSQtySum;
    }

    public int getFullMQtySum() {
        return fullMQtySum;
    }

    public void setFullMQtySum(int fullMQtySum) {
        this.fullMQtySum = fullMQtySum;
    }

    public int getFullLQtySum() {
        return fullLQtySum;
    }

    public void setFullLQtySum(int fullLQtySum) {
        this.fullLQtySum = fullLQtySum;
    }

    public int getFullXLQtySum() {
        return fullXLQtySum;
    }

    public void setFullXLQtySum(int fullXLQtySum) {
        this.fullXLQtySum = fullXLQtySum;
    }
}
