package com.example.backend;

import java.beans.Transient;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "User")
public class User {
  @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
  @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
  private Long id;

  @Column(name = "UID", unique = true, nullable = false)
  private String uid;


  private String name;

  private String email;

  @OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.ALL})
  private Set<Route> savedRoutes;

  private String phoneNumber;

  @OneToOne(fetch = FetchType.LAZY)
  private Position position;

  //fingerprint

  //password

  @OneToOne(fetch = FetchType.LAZY)
  private ContactList contactList;

  //route

  @OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.ALL})
  private Set<Dog> ownedDog;


  @OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.ALL})
  private Set<ContactRequest> contactRequests;

  @OneToOne(fetch = FetchType.LAZY)
  private SearchHistory searchHistory; //unsure

  //instagram

  //facebook

  //google

  private Long createdAt;
  //YYYYMMDDHHMM (temporary)                           
  private Long updatedAt;
 
  public User(String uid){
    this.uid = uid;
  }
  public User(String uid,  String email, String phone, String name){
    this.uid = uid;
    this.email = email;
    this.phoneNumber = phone;
    this.name = name;
  }
  public User(){
  
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

  @JsonIgnore
  public ContactList getContactList() {
    return contactList;
  }

  @JsonIgnore
  public Set<ContactRequest> getContactRequest() {
    return contactRequests;
  }

  public void setContactList(ContactList contactList) {
    this.contactList = contactList;
  }

  @JsonIgnore
  public Set<Dog> getOwnedDog() {
    return ownedDog;
  }

  
  public void setContactRequest(ContactRequest r) {
    this.contactRequests.add(r);
  }


  public void setOwnedDog(Dog ownedDog) {
    this.ownedDog.add(ownedDog);
  }

  @JsonIgnore
  public String getUid() {
    return this.uid;
  }

  @JsonIgnore
  public SearchHistory getSearchHistory() {
    return searchHistory;
  }

  public void setSearchHistory(SearchHistory searchHistory) {
    this.searchHistory = searchHistory;
  }

  @JsonIgnore
  public Long getCreatedAt() {
    return createdAt;
  }

  public Set<Route> getSavedRoutes(){
    return savedRoutes;
  }
  public void addRoutes(Route r){
    this.savedRoutes.add(r);
  }

  public void setCreatedAt(Long createdAt) {
    this.createdAt = createdAt;
  }

  public void cleanRoutes(){
    this.savedRoutes.clear();
  }

  @JsonIgnore
  public Long getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Long updatedAt) {
    this.updatedAt = updatedAt;
  }
}