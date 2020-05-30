package com.example.backend;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javassist.bytecode.ByteArray;

@Entity
@Table(name = "Dog")
public class Dog {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
    @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
    private Long id;

    private String name;
    private String breed;
    private String age;
    private String height;
    private String weight;
    private String description;
    private String gender;
    private Blob blobPicture;

    public Dog(String name, String breed, String age, String height, String weight,
            String description, String gender) {
        this.name = name;
        this.breed = breed;
        this.age = age;
        this.height = height;
        this.weight = weight;
        this.description = description;
        this.gender = gender;

    }

    public Dog() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRace() {
        return breed;
    }

    public void setRace(String race) {
        this.breed = race;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String newHeight) {
        this.height = newHeight;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String newDescription) {
        this.description = newDescription;
    }
    @JsonIgnore
    public String getImage() {
        try {
            byte[] pic = blobPicture.getBytes(1, (int) blobPicture.length());
            return new String(Base64.getEncoder().encode(pic));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Error";
    }

    @JsonIgnore
    public void setBlobImage(Blob blobImage) {
        this.blobPicture = blobImage;
    }



    public String getGender() {
        return gender;
    }

    public void setGender(String newGender) {
        this.gender = newGender;
    }

}