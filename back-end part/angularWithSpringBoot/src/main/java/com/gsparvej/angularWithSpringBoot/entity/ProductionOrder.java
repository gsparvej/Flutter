package com.gsparvej.angularWithSpringBoot.entity;

import jakarta.persistence.*;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "productionOrders")
public class ProductionOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int planQty;
    private Date startDate;
    private Date endDate;
    private String priority;
    private String status;
    private String description;
    private String size;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bomstyle_id")
    private BomStyle bomStyle;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @OneToMany(mappedBy = "productionOrder", cascade = CascadeType.ALL)
    private List<CuttingPlan> cuttingPlans;

    @OneToMany(mappedBy = "productionOrder", cascade = CascadeType.ALL)
    private List<DayWiseProduction> dayWiseProductions;


    public ProductionOrder() {
    }

    public ProductionOrder(int id, int planQty, Date startDate, Date endDate, String priority, String status, String description, String size, BomStyle bomStyle, Order order, List<CuttingPlan> cuttingPlans) {
        this.id = id;
        this.planQty = planQty;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.status = status;
        this.description = description;
        this.size = size;
        this.bomStyle = bomStyle;
        this.order = order;
        this.cuttingPlans = cuttingPlans;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPlanQty() {
        return planQty;
    }

    public void setPlanQty(int planQty) {
        this.planQty = planQty;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BomStyle getBomStyle() {
        return bomStyle;
    }

    public void setBomStyle(BomStyle bomStyle) {
        this.bomStyle = bomStyle;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<CuttingPlan> getCuttingPlans() {
        return cuttingPlans;
    }

    public void setCuttingPlans(List<CuttingPlan> cuttingPlans) {
        this.cuttingPlans = cuttingPlans;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }
}
