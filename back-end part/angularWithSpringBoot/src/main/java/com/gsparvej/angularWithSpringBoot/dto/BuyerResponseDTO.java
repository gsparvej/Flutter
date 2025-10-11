package com.gsparvej.angularWithSpringBoot.dto;

public class BuyerResponseDTO {

    private int id;
    private String name;
    private String country;
    private String contactPerson;
    private String phone;
    private String email;
    private String address;
    private String website;

    public BuyerResponseDTO() {
    }

    public BuyerResponseDTO(int id, String name) {
    }

    public BuyerResponseDTO(int id, String name, String country, String contactPerson, String phone, String email, String address, String website) {
        this.id = id;
        this.name = name;
        this.country = country;
        this.contactPerson = contactPerson;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.website = website;
    }

    public BuyerResponseDTO(int id, String name, String contactPerson, String email) {
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

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}
