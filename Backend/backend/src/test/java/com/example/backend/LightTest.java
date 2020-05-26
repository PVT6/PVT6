package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

public class LightTest {

    @Test
    public void makeLightEmptyConstructor() {
        Light light = new Light();

        assertNotNull(light.getId());

        assertNull(light.getName());
        assertNull(light.getAddress());
        assertNull(light.getType());
    }

    @Test
    public void makeLightConstructor() {
        Light light = new Light("name", "address", "type", "updatedAt", "createdAt", 1.0, 2.0);

        assertNotNull(light.getId());

        assertEquals("name", light.getName());
        assertEquals("address", light.getAddress());
        assertEquals("type", light.getType());
        assertEquals("X: "+ 1.0+ "Y: "+2.0, light.getPos());
    }

    @Test
    public void makeLightSetters() {
        Light light = new Light();

        light.setName("name");
        light.setAddress("address");
        light.setType("type");

        assertNotNull(light.getId());

        assertEquals("name", light.getName());
        assertEquals("address", light.getAddress());
        assertEquals("type", light.getType());
    }
}