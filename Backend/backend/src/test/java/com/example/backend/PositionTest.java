package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

public class PositionTest {

    @Test
    public void makePositionEmptyConstructor() {
        Position pos = new Position();

        assertNull(pos.getX());
        assertNull(pos.getY());
    }
    
    @Test
    public void makePositionConstructor() {
        Position pos = new Position(0.1, 0.2);

        assertEquals(0.1, pos.getX());
        assertEquals(0.2, pos.getY());
    }

    @Test
    public void makePositionSetters() {
        Position pos = new Position();

        pos.setX(0.1);
        pos.setY(0.2);

        assertEquals(0.1, pos.getX());
        assertEquals(0.2, pos.getY());
    }
}