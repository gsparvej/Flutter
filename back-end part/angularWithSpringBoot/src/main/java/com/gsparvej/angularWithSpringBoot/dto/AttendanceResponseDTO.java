package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class AttendanceResponseDTO {

    private int id;
    private Date attDate;
    private String status;

    private EmployeeDTO employee;

    public AttendanceResponseDTO() {
    }

    public AttendanceResponseDTO(int id, Date attDate, String status, EmployeeDTO employee) {
        this.id = id;
        this.attDate = attDate;
        this.status = status;
        this.employee = employee;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getAttDate() {
        return attDate;
    }

    public void setAttDate(Date attDate) {
        this.attDate = attDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public EmployeeDTO getEmployee() {
        return employee;
    }

    public void setEmployee(EmployeeDTO employee) {
        this.employee = employee;
    }
}
