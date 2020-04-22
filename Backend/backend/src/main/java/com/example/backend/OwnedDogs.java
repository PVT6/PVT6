package com.example.backend;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "OwnedDogs")
public class OwnedDogs {
    private Integer id;
    private List<Integer> dogList;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<Integer> getDogList(){
        return dogList;
    }

    public void addDog(Integer dogId) {
        this.dogList.add(dogId);
    }

    public void removeDog(Integer dogId) {
        this.dogList.remove(dogId);
    }
}