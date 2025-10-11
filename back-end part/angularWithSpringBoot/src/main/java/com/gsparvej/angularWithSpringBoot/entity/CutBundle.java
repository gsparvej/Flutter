package com.gsparvej.angularWithSpringBoot.entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "cutBundles")
public class CutBundle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String bundleNo;
    private String size;
    private String color;
    private int plannedQty;
    private Date cutBundleDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cuttingPlan_id")
    private CuttingPlan cuttingPlan;

    public CutBundle() {
    }

    public CutBundle(int id, String bundleNo, String size, String color, int plannedQty, Date cutBundleDate, CuttingPlan cuttingPlan) {
        this.id = id;
        this.bundleNo = bundleNo;
        this.size = size;
        this.color = color;
        this.plannedQty = plannedQty;
        this.cutBundleDate = cutBundleDate;
        this.cuttingPlan = cuttingPlan;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBundleNo() {
        return bundleNo;
    }

    public void setBundleNo(String bundleNo) {
        this.bundleNo = bundleNo;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getPlannedQty() {
        return plannedQty;
    }

    public void setPlannedQty(int plannedQty) {
        this.plannedQty = plannedQty;
    }

    public CuttingPlan getCuttingPlan() {
        return cuttingPlan;
    }

    public void setCuttingPlan(CuttingPlan cuttingPlan) {
        this.cuttingPlan = cuttingPlan;
    }

    public Date getCutBundleDate() {
        return cutBundleDate;
    }

    public void setCutBundleDate(Date cutBundleDate) {
        this.cutBundleDate = cutBundleDate;
    }
}
