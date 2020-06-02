package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;


public class DogTest {
    @Test
    public void makeDogEmptyConstructor() {
        Dog dog = new Dog();

        assertNull(dog.getName());
        assertNull(dog.getRace());
        assertNull(dog.getAge());
        assertNull(dog.getHeight());
        assertNull(dog.getWeight());
        //assertNull(dog.getDogpicture());
        assertNull(dog.getDescription());
        assertNull(dog.getGender());
    }

    @Test
    public void makeDogConstructor() {
        Dog dog = new Dog("name", "breed", "1", "2", "3", "dogpicture", "description", "gender");

        assertEquals("name", dog.getName());
        assertEquals("breed", dog.getRace());
        assertEquals("1", dog.getAge());
        assertEquals("2", dog.getHeight());
        assertEquals("3", dog.getWeight());
        //assertEquals("dogpicture", dog.getDogpicture());
        assertEquals("description", dog.getDescription());
        assertEquals("gender", dog.getGender());
    }

    @Test
    public void makeDogSetters() {
        Dog dog = new Dog();

        dog.setName("name");
        dog.setRace("breed");
        dog.setAge("1");
        dog.setHeight("2");
        dog.setWeight("3");
        //dog.setDogpicture("dogpicture");
        dog.setDescription("description");
        dog.setGender("gender");

        assertEquals("name", dog.getName());
        assertEquals("breed", dog.getRace());
        assertEquals("1", dog.getAge());
        assertEquals("2", dog.getHeight());
        assertEquals("3", dog.getWeight());
        //assertEquals("dogpicture", dog.getDogpicture());
        assertEquals("description", dog.getDescription());
        assertEquals("gender", dog.getGender());
    }

}