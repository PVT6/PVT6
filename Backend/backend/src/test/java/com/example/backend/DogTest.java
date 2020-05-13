package com.example.backend;


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
        assertNull(dog.getWeight());
        assertNull(dog.getAge());
    }
}