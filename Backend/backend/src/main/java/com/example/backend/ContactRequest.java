package com.example.backend;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

public class ContactRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
    @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
    private Long id;

    @Enumerated(EnumType.STRING)
    private Status status;

    @OneToOne(fetch = FetchType.LAZY)
    private User sender;

    @OneToOne(fetch = FetchType.LAZY)
    private User receiver;
    
    public ContactRequest(User sender, User receiver){
        this.sender = sender;
        this.receiver = receiver;
    } 
    public ContactRequest(){}
    
    public Status getStatus() {
        return status;
    }
    public User getSender() {
        return sender;
      }
    public User getReceiver() {
        return sender;
      }
}