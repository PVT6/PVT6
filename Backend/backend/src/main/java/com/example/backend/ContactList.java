package com.example.backend;

import java.util.HashSet;
import java.util.Set;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class ContactList {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
    @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
    private Long id;

    @ManyToMany(fetch = FetchType.LAZY, cascade = { CascadeType.ALL })
    @JoinTable(
        name = "ContactLists", 
        joinColumns = { @JoinColumn(name = "userId")
    },
    inverseJoinColumns = { @JoinColumn(name = "contactListId") }
    
    )
    private Set<User> users = new HashSet<>();;
    
    public ContactList(){

    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Set<User> getUser() {
        return users;
    }
   


    public void addUser(User user) {
        this.users.add(user);
    }
}