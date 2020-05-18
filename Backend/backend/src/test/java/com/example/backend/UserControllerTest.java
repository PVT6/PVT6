package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
    public void getAllUsers() { //WIP
        UserController usrcon = new UserController();
        User user = new User("uid", "email", "phone", "name");
        //Iterable<User> usersTest = new Iterable<User>();
        usrcon.addNewUser("uid", "email", "phone", "name");
        //create user and make Iterable<User> and add it to that
        //use the created users data in usrcon.addNewUser()
        Iterable<User> users = usrcon.getAll();
        assertTrue(users.equals(user)); //will not work
        //compare both Iterable<User> for equality
        //or do like findDogs()

    }

    @Test
    public void addNewDog() {
        UserController usrcon = new UserController();

        usrcon.addNewUser("uid", "email", "phone", "name");
        String result = usrcon.addNewDog("uid", "dogname", "breed", "age", "weight");

        assertEquals("added new dog", result);
    }

    @Test
    public void findDogs() {
        UserController usrcon = new UserController();

        usrcon.addNewUser("uid", "email", "phone", "name");
        usrcon.addNewDog("uid", "dogname", "breed", "age", "weight");

        Dog dog = new Dog("dogname", "breed", "age", "weight");

        Set<Dog> dogs = usrcon.findDogs("uid");
        assertTrue(dogs.contains(dog));
    }
}