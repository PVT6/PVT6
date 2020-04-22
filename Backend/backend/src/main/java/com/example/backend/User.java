package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "User")
public class User {
  @Id
  @GeneratedValue(strategy=GenerationType.AUTO)
  private Integer id;

  private String name;

  private String email;

  private String phoneNumber;

  private Position position;

  //(fingerprint)

  //(password)

  private Integer contactsId;

  //route

  private Integer ownedDogsId;

  private Integer searchHistoryId;

  //instagram

  //facebook

  //google

  private Integer createdAt;
  //YYYYMMDDHHMM (temporary)                           
  private Integer updatedAt;


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

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhoneNumber() {
    return phoneNumber;
  }

  public void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  public Position getPosition() {
    return position;
  }

  public void setPosition(Position position) {
    this.position = position;
  }

  public Integer getContactsId() {
    return contactsId;
  }

  public void setContactsId(Integer contactsId) {
    this.contactsId = contactsId;
  }

  public Integer getOwnedDogsId() {
    return ownedDogsId;
  }

  public void setOwnedDogsId(Integer ownedDogsId) {
    this.ownedDogsId = ownedDogsId;
  }

  public Integer getSearchHistoryId() {
    return searchHistoryId;
  }

  public void setSearchHistoryId(Integer searchHistoryId) {
    this.searchHistoryId = searchHistoryId;
  }

  public Integer getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Integer createdAt) {
    this.createdAt = createdAt;
  }

  public Integer getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Integer updatedAt) {
    this.updatedAt = updatedAt;
  }
}