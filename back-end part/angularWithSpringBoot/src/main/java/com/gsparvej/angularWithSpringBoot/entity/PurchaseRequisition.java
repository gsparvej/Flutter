package com.gsparvej.angularWithSpringBoot.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "requisitions")
public class PurchaseRequisition {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private Date prDate;
    private String requestedBy;
    private float quantity;
    private float approxUnitPrice;
    private float totalEstPrice;
    private String prStatus;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id")
    private Item item;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;


    public PurchaseRequisition() {
    }

    public PurchaseRequisition(int id, Date prDate, String requestedBy, float quantity, float approxUnitPrice, float totalEstPrice, String prStatus, Department department, Item item, Order order) {
        this.id = id;
        this.prDate = prDate;
        this.requestedBy = requestedBy;
        this.quantity = quantity;
        this.approxUnitPrice = approxUnitPrice;
        this.totalEstPrice = totalEstPrice;
        this.prStatus = prStatus;
        this.department = department;
        this.item = item;
        this.order = order;
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

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}
