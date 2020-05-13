package com.example.backend;

import org.junit.Test;
import static org.junit.Assert.*;

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