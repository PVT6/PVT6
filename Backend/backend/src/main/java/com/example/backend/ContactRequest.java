package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.GenericGenerator;
@Entity
public class ContactRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @GenericGenerator(name = "generator", strategy = "increment")
    private Long id;

    @Enumerated(EnumType.STRING)
    private Status status;

    @OneToOne(fetch = FetchType.LAZY)
    private User sender;

    @OneToOne(fetch = FetchType.LAZY)
    private User receiver;
    
    public ContactRequest(User sender, User receiver, Status s){
        this.sender = sender;
        this.receiver = receiver;
        this.status = s;
    } 
    public ContactRequest(){}
    
    public void setStatus(Status s) {
        this.status = s;
    }
    public Status getStatus() {
        return status;
    }
    public User getSender() {
        return sender;
      }
    public User getReceiver() {
        return receiver;
      }
}