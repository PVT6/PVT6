package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "User")
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
  @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
  private Long id;

  private String name;

  private String email;

  private String phoneNumber;

  @OneToOne(fetch = FetchType.LAZY)
  private Position position;

  //(fingerprint)

  //(password)

  @OneToMany(fetch = FetchType.LAZY)
  private Long contactId;

  //route

  @OneToMany(fetch = FetchType.LAZY)
  private Dog ownedDog;

  @OneToMany(fetch = FetchType.LAZY)
  private Integer searchHistoryId; //unsure

  //instagram

  //facebook

  //google

  private Long createdAt;
  //YYYYMMDDHHMM (temporary)                           
  private Long updatedAt;


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

  public Long getContactId() {
    return contactId;
  }

  public void setContactId(Long contactId) {
    this.contactId = contactId;
  }

  public Dog getOwnedDog() {
    return ownedDog;
  }

  public void setOwnedDog(Dog ownedDog) {
    this.ownedDog = ownedDog;
  }

  public Integer getSearchHistoryId() {
    return searchHistoryId;
  }

  public void setSearchHistoryId(Integer searchHistoryId) {
    this.searchHistoryId = searchHistoryId;
  }

  public Long getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Long createdAt) {
    this.createdAt = createdAt;
  }

  public Long getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Long updatedAt) {
    this.updatedAt = updatedAt;
  }
}