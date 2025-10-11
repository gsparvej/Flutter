package com.gsparvej.angularWithSpringBoot.dto;

public class BomResponseDTO {



    private int id;
    private int serial;
    private String material;
    private String unit;
    private double quantity;
    private double unitPrice;
    private double totalCost;

    private UomResponseDTO uom;
    private BomStyleResponseDTO bomStyle;

    public BomResponseDTO() {
    }

    public BomResponseDTO(int id, int serial, String material, String unit, double quantity, double unitPrice,
                          double totalCost, UomResponseDTO uom, BomStyleResponseDTO bomStyle) {
        this.id = id;
        this.serial = serial;
        this.material = material;
        this.unit = unit;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalCost = totalCost;
        this.uom = uom;
        this.bomStyle = bomStyle;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSerial() { return serial; }
    public void setSerial(int serial) { this.serial = serial; }

    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }

    public UomResponseDTO getUom() { return uom; }
    public void setUom(UomResponseDTO uom) { this.uom = uom; }

    public BomStyleResponseDTO getBomStyle() { return bomStyle; }
    public void setBomStyle(BomStyleResponseDTO bomStyle) { this.bomStyle = bomStyle; }
}
