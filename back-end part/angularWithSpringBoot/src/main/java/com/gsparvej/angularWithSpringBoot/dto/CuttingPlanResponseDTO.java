package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class CuttingPlanResponseDTO {

    private int id;
    private String markerNo;
    private float fabricWidth;
    private int layCount;
    private float plannedPcs;
    private float fabricUsed;
    private String status;
    private Date cuttingDate;

    private float actualPcs;
    private float markerEfficiency;
    private float fabricLength;
    private int markerCount;
    private String remarks;
    private String createdBy;
    private String description;
    private int markerOutput;

    private UomResponseDTO uom;
    private ProductionOrderResponseDTO productionOrder;

    public CuttingPlanResponseDTO() {
    }

    public CuttingPlanResponseDTO(int id, String markerNo, float fabricWidth, int layCount, float plannedPcs, float fabricUsed, String status, Date cuttingDate, float actualPcs, float markerEfficiency, float fabricLength, int markerCount, String remarks, String createdBy, String description, int markerOutput, UomResponseDTO uom, ProductionOrderResponseDTO productionOrder) {
        this.id = id;
        this.markerNo = markerNo;
        this.fabricWidth = fabricWidth;
        this.layCount = layCount;
        this.plannedPcs = plannedPcs;
        this.fabricUsed = fabricUsed;
        this.status = status;
        this.cuttingDate = cuttingDate;
        this.actualPcs = actualPcs;
        this.markerEfficiency = markerEfficiency;
        this.fabricLength = fabricLength;
        this.markerCount = markerCount;
        this.remarks = remarks;
        this.createdBy = createdBy;
        this.description = description;
        this.markerOutput = markerOutput;
        this.uom = uom;
        this.productionOrder = productionOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMarkerNo() {
        return markerNo;
    }

    public void setMarkerNo(String markerNo) {
        this.markerNo = markerNo;
    }

    public float getFabricWidth() {
        return fabricWidth;
    }

    public void setFabricWidth(float fabricWidth) {
        this.fabricWidth = fabricWidth;
    }

    public int getLayCount() {
        return layCount;
    }

    public void setLayCount(int layCount) {
        this.layCount = layCount;
    }

    public float getPlannedPcs() {
        return plannedPcs;
    }

    public void setPlannedPcs(float plannedPcs) {
        this.plannedPcs = plannedPcs;
    }

    public float getFabricUsed() {
        return fabricUsed;
    }

    public void setFabricUsed(float fabricUsed) {
        this.fabricUsed = fabricUsed;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCuttingDate() {
        return cuttingDate;
    }

    public void setCuttingDate(Date cuttingDate) {
        this.cuttingDate = cuttingDate;
    }

    public float getActualPcs() {
        return actualPcs;
    }

    public void setActualPcs(float actualPcs) {
        this.actualPcs = actualPcs;
    }

    public float getMarkerEfficiency() {
        return markerEfficiency;
    }

    public void setMarkerEfficiency(float markerEfficiency) {
        this.markerEfficiency = markerEfficiency;
    }

    public float getFabricLength() {
        return fabricLength;
    }

    public void setFabricLength(float fabricLength) {
        this.fabricLength = fabricLength;
    }

    public int getMarkerCount() {
        return markerCount;
    }

    public void setMarkerCount(int markerCount) {
        this.markerCount = markerCount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public UomResponseDTO getUom() {
        return uom;
    }

    public void setUom(UomResponseDTO uom) {
        this.uom = uom;
    }

    public ProductionOrderResponseDTO getProductionOrder() {
        return productionOrder;
    }

    public void setProductionOrder(ProductionOrderResponseDTO productionOrder) {
        this.productionOrder = productionOrder;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getMarkerOutput() {
        return markerOutput;
    }

    public void setMarkerOutput(int markerOutput) {
        this.markerOutput = markerOutput;
    }
}
