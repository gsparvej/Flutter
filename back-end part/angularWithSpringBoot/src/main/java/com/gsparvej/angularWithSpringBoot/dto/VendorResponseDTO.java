package com.gsparvej.angularWithSpringBoot.dto;

public class VendorResponseDTO {

    private int id;
    private String companyName;
    private String phone;
    private String address;
    private String contactPerson;


    public VendorResponseDTO() {
    }

    public VendorResponseDTO(int id, String companyName, String phone) {
        this.id = id;
        this.companyName = companyName;
        this.phone = phone;
    }

    public VendorResponseDTO(int id, String companyName, String phone, String address, String contactPerson) {
        this.id = id;
        this.companyName = companyName;
        this.phone = phone;
        this.address = address;
        this.contactPerson = contactPerson;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }
}
