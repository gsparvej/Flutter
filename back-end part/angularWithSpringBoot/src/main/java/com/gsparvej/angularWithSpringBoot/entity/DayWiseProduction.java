package com.gsparvej.angularWithSpringBoot.entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "dayWiseproduction")
public class DayWiseProduction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private Date updatedDate;
    private int shortSQty;
    private int shortMQty;
    private int shortLQty;
    private int shortXLQty;
    private int fullSQty;
    private int fullMQty;
    private int fullLQty;
    private int fullXLQty;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productionOrder_id")
    private ProductionOrder productionOrder;

    public DayWiseProduction() {
    }

    public DayWiseProduction(int id, Date updatedDate, int shortSQty, int shortMQty, int shortLQty, int shortXLQty, int fullSQty, int fullMQty, int fullLQty, int fullXLQty, Order order, ProductionOrder productionOrder) {
        this.id = id;
        this.updatedDate = updatedDate;
        this.shortSQty = shortSQty;
        this.shortMQty = shortMQty;
        this.shortLQty = shortLQty;
        this.shortXLQty = shortXLQty;
        this.fullSQty = fullSQty;
        this.fullMQty = fullMQty;
        this.fullLQty = fullLQty;
        this.fullXLQty = fullXLQty;
        this.order = order;
        this.productionOrder = productionOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public int getShortSQty() {
        return shortSQty;
    }

    public void setShortSQty(int shortSQty) {
        this.shortSQty = shortSQty;
    }

    public int getShortMQty() {
        return shortMQty;
    }

    public void setShortMQty(int shortMQty) {
        this.shortMQty = shortMQty;
    }

    public int getShortLQty() {
        return shortLQty;
    }

    public void setShortLQty(int shortLQty) {
        this.shortLQty = shortLQty;
    }

    public int getShortXLQty() {
        return shortXLQty;
    }

    public void setShortXLQty(int shortXLQty) {
        this.shortXLQty = shortXLQty;
    }

    public int getFullSQty() {
        return fullSQty;
    }

    public void setFullSQty(int fullSQty) {
        this.fullSQty = fullSQty;
    }

    public int getFullMQty() {
        return fullMQty;
    }

    public void setFullMQty(int fullMQty) {
        this.fullMQty = fullMQty;
    }

    public int getFullLQty() {
        return fullLQty;
    }

    public void setFullLQty(int fullLQty) {
        this.fullLQty = fullLQty;
    }

    public int getFullXLQty() {
        return fullXLQty;
    }

    public void setFullXLQty(int fullXLQty) {
        this.fullXLQty = fullXLQty;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public ProductionOrder getProductionOrder() {
        return productionOrder;
    }

    public void setProductionOrder(ProductionOrder productionOrder) {
        this.productionOrder = productionOrder;
    }
}
