package com.gsparvej.angularWithSpringBoot.dto;

import java.util.Date;

public class LeaveResponseDTO {
    private Integer id;
    private String leaveType;
    private Date fromDate;
    private Date toDate;
    private String status;

    private EmployeeDTO employee;

    public LeaveResponseDTO() {
    }

    public LeaveResponseDTO(Integer id, String leaveType, Date fromDate, Date toDate, String status, EmployeeDTO employee) {
        this.id = id;
        this.leaveType = leaveType;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.status = status;
        this.employee = employee;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
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
