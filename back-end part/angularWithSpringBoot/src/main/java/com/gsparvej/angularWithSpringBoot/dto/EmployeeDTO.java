package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class EmployeeDTO {

    private int id;
    private String name;
    private String phoneNumber;
    private String email;
    private Date joinDate;

    private DesignationResponseDTO designation;
    private DepartmentResponseDTO department;


    // Constructor


    public EmployeeDTO() {
    }

    public EmployeeDTO(int id, String name, String phoneNumber, String email, Date joinDate, DesignationResponseDTO designation, DepartmentResponseDTO department) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.joinDate = joinDate;
        this.designation = designation;
        this.department = department;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public DesignationResponseDTO getDesignation() {
        return designation;
    }

    public void setDesignation(DesignationResponseDTO designation) {
        this.designation = designation;
    }

    public DepartmentResponseDTO getDepartment() {
        return department;
    }

    public void setDepartment(DepartmentResponseDTO department) {
        this.department = department;
    }
}
