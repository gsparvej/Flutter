package com.gsparvej.angularWithSpringBoot.dto;

public class ItemResponseDTO {

    private int id;

    private String categoryName;
    private String unit;

    public ItemResponseDTO() {
    }

    public ItemResponseDTO(int id, String categoryName, String unit) {
        this.id = id;
        this.categoryName = categoryName;
        this.unit = unit;
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
}
