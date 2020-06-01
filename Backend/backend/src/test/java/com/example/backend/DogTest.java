package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

public class DogTest {
    @Test
    public void makeDogEmptyConstructor() {
        Dog dog = new Dog();

        assertNotNull(dog.getId());

        assertNull(dog.getName());
        assertNull(dog.getRace());
        assertNull(dog.getAge());
        assertNull(dog.getWeight());
    }

    @Test
    public void makeDogConstructor() {
        Dog dog = new Dog("name", "breed", "1", "2", null, null, null);

        assertNotNull(dog.getId());

        assertEquals("name", dog.getName());
        assertEquals("breed", dog.getRace());
        assertEquals("1", dog.getAge());
        assertEquals("2", dog.getWeight());
    }

    @Test
    public void makeDogSetters() {
        Dog dog = new Dog();

        dog.setName("name");
        dog.setRace("breed");
        dog.setAge("1");
        dog.setWeight("2");

        assertNotNull(dog.getId());

        assertEquals("name", dog.getName());
        assertEquals("breed", dog.getRace());
        assertEquals("1", dog.getAge());
        assertEquals("2", dog.getWeight());
    }

}