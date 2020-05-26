package com.example.backend;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Set;

import org.junit.jupiter.api.Test;

public class SearchHistoryTest {

    @Test
    public void getIdNoSet() {
        SearchHistory sh = new SearchHistory();
        long id = sh.getId();
        assertNotNull(id);
    }

    @Test
    public void getIdAfterSet() {
        SearchHistory sh = new SearchHistory();
        long setId = 1;
        sh.setId(setId);
        long getId = sh.getId();
        assertEquals(setId, getId);
    }

    @Test
    public void getPosNoSet() {
        SearchHistory sh = new SearchHistory();
        Set<Position> poss = sh.getPos();
        assertTrue(poss.isEmpty());
    }

    @Test
    public void getPosAfterSet() {
        SearchHistory sh = new SearchHistory();
        Position pos = new Position(1.0, 2.0);
        sh.setPosd(pos);
        Set<Position> poss = sh.getPos();
        assertTrue(poss.contains(pos));
    }
}