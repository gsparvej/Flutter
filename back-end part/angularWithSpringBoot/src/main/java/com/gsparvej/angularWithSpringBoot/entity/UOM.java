package com.gsparvej.angularWithSpringBoot.entity;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "uom")
public class UOM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;



    private String productName;
    private String size;
    private float body;
    private float sleeve;
    private float pocket;
    private float wastage;
    private float shrinkage;
    private float baseFabric;

    @OneToMany(mappedBy = "uom" , cascade = CascadeType.ALL)
    private List<BOM> boms;

    @OneToMany(mappedBy = "uom" , cascade = CascadeType.ALL)
    private List<CuttingPlan> cuttingPlans;




    public UOM() {
    }

    public UOM(int id, String productName, String size, float body, float sleeve, float pocket, float wastage, float shrinkage, float baseFabric, List<BOM> boms, List<CuttingPlan> cuttingPlans) {
        this.id = id;
        this.productName = productName;
        this.size = size;
        this.body = body;
        this.sleeve = sleeve;
        this.pocket = pocket;
        this.wastage = wastage;
        this.shrinkage = shrinkage;
        this.baseFabric = baseFabric;
        this.boms = boms;
        this.cuttingPlans = cuttingPlans;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public float getBody() {
        return body;
    }

    public void setBody(float body) {
        this.body = body;
    }

    public float getSleeve() {
        return sleeve;
    }

    public void setSleeve(float sleeve) {
        this.sleeve = sleeve;
    }

    public float getPocket() {
        return pocket;
    }

    public void setPocket(float pocket) {
        this.pocket = pocket;
    }

    public float getWastage() {
        return wastage;
    }

    public void setWastage(float wastage) {
        this.wastage = wastage;
    }

    public float getShrinkage() {
        return shrinkage;
    }

    public void setShrinkage(float shrinkage) {
        this.shrinkage = shrinkage;
    }

    public float getBaseFabric() {
        return baseFabric;
    }

    public void setBaseFabric(float baseFabric) {
        this.baseFabric = baseFabric;
    }

    public List<BOM> getBoms() {
        return boms;
    }

    public void setBoms(List<BOM> boms) {
        this.boms = boms;
    }

    public List<CuttingPlan> getCuttingPlans() {
        return cuttingPlans;
    }

    public void setCuttingPlans(List<CuttingPlan> cuttingPlans) {
        this.cuttingPlans = cuttingPlans;
    }
}
