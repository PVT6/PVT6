package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Set;

import org.junit.jupiter.api.Test;

public class ContactListTest {

    @Test
    public void getIdNoSet() {
        ContactList cl = new ContactList();
        long id = cl.getId();

        assertNotNull(id);
    }

    @Test
    public void getIdAfterSet() {
        ContactList cl = new ContactList();
        long setId = 1;
        cl.setId(setId);
        long getId = cl.getId();

        assertEquals(setId, getId);
    }

    @Test
    public void getUserNoSet() {
        ContactList cl = new ContactList();
        Set<User> users = cl.getUser();
        
        assertTrue(users.isEmpty());
    }

    @Test
    public void getUserAfterSet() {
        ContactList cl = new ContactList();
        User user = new User("uid");
        cl.addUser(user);
        Set<User> users = cl.getUser();

        assertFalse(users.isEmpty());
    }
}