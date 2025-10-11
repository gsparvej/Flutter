package com.gsparvej.angularWithSpringBoot.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;


@Entity
@Table(name = "BOM")
public class BOM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int serial;
    private String material;
    private String unit;
    private float quantity;
    private float unitPrice;
    private float totalCost;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "uom_id")
    private UOM uom;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bomstyle_id")
    private BomStyle bomStyle;

    public BOM() {
    }

    public BOM(int id, int serial, String material, String unit, float quantity, float unitPrice, float totalCost, UOM uom, BomStyle bomStyle) {
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSerial() {
        return serial;
    }

    public void setSerial(int serial) {
        this.serial = serial;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(float totalCost) {
        this.totalCost = totalCost;
    }

    public UOM getUom() {
        return uom;
    }

    public void setUom(UOM uom) {
        this.uom = uom;
    }

    public BomStyle getBomStyle() {
        return bomStyle;
    }

    public void setBomStyle(BomStyle bomStyle) {
        this.bomStyle = bomStyle;
    }
}
