package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "Dog")
public class Dog {
    private Integer id;
    private String name;
    private String race;
    private Float weight;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRace() {
        return race;
    }

    public void setRace(String race) {
        this.race = race;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

}