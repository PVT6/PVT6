package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.Set;

import org.junit.jupiter.api.Test;

public class UserControllerTest {

    @Test
    public void addNewUser() {
        UserController usrcon = new UserController();
        String result = usrcon.addNewUser("uid", "email", "phone", "name");
        assertEquals("Saved", result);
    }

    @Test
    public void getAllUsers() {
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        Iterable<User> users = usrcon.getAll();
        assertNotNull(users);
    }

    @Test
    public void addNewDog() {
        UserController usrcon = new UserController();

        usrcon.addNewUser("uid", "email", "phone", "name");
        String result = usrcon.addNewDog("uid", "dogname", "breed", "age", "weight", "", "", "");

        assertEquals("added new dog", result);
    }

    @Test
    public void findDogs() {
        UserController usrcon = new UserController();

        usrcon.addNewUser("uid", "email", "phone", "name");
        usrcon.addNewDog("uid", "dogname", "breed", "age", "weight", "", "", "");

        Dog dog = new Dog("dogname", "breed", "age", "weight", "", "", "");

        List<Dog> dogs = usrcon.findDogs("uid");
        assertTrue(dogs.contains(dog));
    }

    @Test
    public void findUser() {
        UserController usrcon = new UserController();
        User user = new User("uid", "email", "phone", "name", new ContactList());
        
        usrcon.addNewUser("uid", "email", "phone", "name");

        User usrconUser = usrcon.findUser("uid");

        assertEquals(user, usrconUser);
    }

    @Test
    public void updateFail() {
        UserController usrcon = new UserController();
        String status = usrcon.update("uid", "name", "email", "phone");

        assertEquals("no user found", status);
    }

    @Test
    public void update() {
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        String status = usrcon.update("uid", "name", "email", "phone");

        assertEquals("Updated", status);
    }

    @Test
    public void newNameForUserFail() {
        UserController usrcon = new UserController();
        boolean status = usrcon.newNameForUser("uid", "newName");

        assertFalse(status);
    }

    @Test
    public void newNameForUser() {
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        boolean status = usrcon.newNameForUser("uid", "newName");

        assertTrue(status);
    }

    @Test
    public void newPhoneNumberForUserFail(){
        UserController usrcon = new UserController();
        boolean status = usrcon.newPhoneNumberForUser("uid", "newPhone");

        assertFalse(status);
    }

    @Test
    public void newPhoneNumberForUser(){
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        boolean status = usrcon.newPhoneNumberForUser("uid", "newPhone");

        assertTrue(status);
    }

    @Test
    public void newEmailForUserFail() {
        UserController usrcon = new UserController();
        boolean status = usrcon.newEmailForUser("uid", "newEmail");

        assertFalse(status);
    }

    @Test
    public void newEmailForUser() {
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        boolean status = usrcon.newEmailForUser("uid", "newEmail");

        assertTrue(status);
    }

    @Test
    public void deleteUserFail() {
        UserController usrcon = new UserController();
        boolean status = usrcon.deleteUser("uid");

        assertFalse(status);
    }

    @Test
    public void deleteUser() {
        UserController usrcon = new UserController();
        usrcon.addNewUser("uid", "email", "phone", "name");
        boolean status = usrcon.deleteUser("uid");

        assertTrue(status);
    }
}