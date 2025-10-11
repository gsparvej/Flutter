package com.gsparvej.angularWithSpringBoot.entity;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "bomStyle")
public class BomStyle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String styleCode;
    private String styleType;
    private String description;

    @OneToMany(mappedBy = "bomStyle" , cascade = CascadeType.ALL)
    private List<Order> orders;


    @OneToMany(mappedBy = "bomStyle" , cascade = CascadeType.ALL)
    private List<BOM> boms;


    @OneToMany(mappedBy = "bomStyle", cascade = CascadeType.ALL)
    private List<ProductionOrder> productionOrders;

    public BomStyle() {
    }

    public BomStyle(int id, String styleCode, String styleType, String description, List<Order> orders, List<BOM> boms, List<ProductionOrder> productionOrders) {
        this.id = id;
        this.styleCode = styleCode;
        this.styleType = styleType;
        this.description = description;
        this.orders = orders;
        this.boms = boms;
        this.productionOrders = productionOrders;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStyleCode() {
        return styleCode;
    }

    public void setStyleCode(String styleCode) {
        this.styleCode = styleCode;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<BOM> getBoms() {
        return boms;
    }

    public void setBoms(List<BOM> boms) {
        this.boms = boms;
    }

    public List<ProductionOrder> getProductionOrders() {
        return productionOrders;
    }

    public void setProductionOrders(List<ProductionOrder> productionOrders) {
        this.productionOrders = productionOrders;
    }
}
