package com.example.backend;

import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MapsId;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "Light")
public class Light {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
  @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")

  private Long id;
  private String name;
  private String address;
  private String type; 
  private String updatedAt;
  private String createdAt;

  @OneToOne(fetch = FetchType.LAZY)
  @MapsId
  private Position pos;
  public Light(){}

  public Light(String name, String address, String type, String updatedAt, String createdAt, Double x, Double y){
      this.name = name;
      this.address = address;
      this.type = type;
      this.updatedAt = updatedAt;
      this.createdAt = createdAt;
      this.pos = new Position(x,y);
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
   public void setName(String name) {
    this.name = name;
  }

  public String getType() {
    return type;
  }
  public String getPos() {
    return "X: "+ this.pos.getX()+ "Y: "+this.pos.getY();
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