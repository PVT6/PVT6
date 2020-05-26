package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

public class UserTest {
    
    @Test
    public void makeUserEmptyConstructor() {
        User user = new User();

        assertNotNull(user.getId());

        assertNull(user.getEmail());
        assertNull(user.getPhoneNumber());
        assertNull(user.getName());
    }

    @Test
    public void makeUserConstructor() {
        User user = new User("uid", "email@email.com", "0700000000", "name" );

        assertNotNull(user.getId());

        assertEquals("email@email.com" ,user.getEmail());
        assertEquals("0700000000", user.getPhoneNumber());
        assertEquals("name", user.getName());
    }

    @Test
    public void makeUserSetters() {
        User user = new User();

        assertNotNull(user.getId());

       user.setEmail("email@email.com");
       user.setPhoneNumber("0700000000");
       user.setName("name");

        assertEquals("email@email.com" ,user.getEmail());
        assertEquals("0700000000", user.getPhoneNumber());
        assertEquals("name", user.getName());
    }
}