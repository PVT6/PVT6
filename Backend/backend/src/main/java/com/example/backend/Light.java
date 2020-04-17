package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity // This tells Hibernate to make a table out of this class
public class Light {
  @Id
  @GeneratedValue(strategy=GenerationType.AUTO)

  private Integer id; // Auto generated ID
  private String name;
  private String address;
  private String type; 

  public Light(){
      
  }

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

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }
  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }
}