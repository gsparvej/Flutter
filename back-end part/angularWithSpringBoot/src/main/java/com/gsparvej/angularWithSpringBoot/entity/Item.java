package com.gsparvej.angularWithSpringBoot.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "items")
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String categoryName;
    private String unit;

    @OneToMany(mappedBy = "item" , cascade = CascadeType.ALL)
    private List<PurchaseOrder> purchaseOrders;

    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<PurchaseRequisition> purchaseRequisitions;

    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<InventoryModel> inventoryModels;

    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<StockInModel> stockInModels;
    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<StockOutModel> stockOutModels;

    public Item() {
    }

    public Item(int id, String categoryName, String unit, List<PurchaseOrder> purchaseOrders, List<PurchaseRequisition> purchaseRequisitions) {
        this.id = id;
        this.categoryName = categoryName;
        this.unit = unit;
        this.purchaseOrders = purchaseOrders;
        this.purchaseRequisitions = purchaseRequisitions;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public List<PurchaseOrder> getPurchaseOrders() {
        return purchaseOrders;
    }

    public void setPurchaseOrders(List<PurchaseOrder> purchaseOrders) {
        this.purchaseOrders = purchaseOrders;
    }

    public List<PurchaseRequisition> getPurchaseRequisitions() {
        return purchaseRequisitions;
    }

    public void setPurchaseRequisitions(List<PurchaseRequisition> purchaseRequisitions) {
        this.purchaseRequisitions = purchaseRequisitions;
    }
}
