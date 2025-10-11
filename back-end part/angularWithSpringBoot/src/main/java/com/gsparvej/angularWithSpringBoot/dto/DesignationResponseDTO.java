package com.gsparvej.angularWithSpringBoot.dto;

public class DesignationResponseDTO {

    private int id;
    private String designationTitle;
    private DepartmentResponseDTO department;


    public DesignationResponseDTO() {
    }

    public DesignationResponseDTO(int id, String designationTitle, DepartmentResponseDTO department) {
        this.id = id;
        this.designationTitle = designationTitle;
        this.department = department;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDesignationTitle() {
        return designationTitle;
    }

    public void setDesignationTitle(String designationTitle) {
        this.designationTitle = designationTitle;
    }

    public DepartmentResponseDTO getDepartment() {
        return department;
    }

    public void setDepartment(DepartmentResponseDTO department) {
        this.department = department;
    }
}
