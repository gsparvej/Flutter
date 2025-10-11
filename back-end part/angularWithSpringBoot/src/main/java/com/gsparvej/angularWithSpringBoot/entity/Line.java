package com.gsparvej.angularWithSpringBoot.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "line")
public class Line {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String lineCode;
    private String floor;
    private int capacityPerHour;



    public Line() {
    }

    public Line(int id, String lineCode, String floor, int capacityPerHour) {
        this.id = id;
        this.lineCode = lineCode;
        this.floor = floor;
        this.capacityPerHour = capacityPerHour;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLineCode() {
        return lineCode;
    }

    public void setLineCode(String lineCode) {
        this.lineCode = lineCode;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public int getCapacityPerHour() {
        return capacityPerHour;
    }

    public void setCapacityPerHour(int capacityPerHour) {
        this.capacityPerHour = capacityPerHour;
    }


}
