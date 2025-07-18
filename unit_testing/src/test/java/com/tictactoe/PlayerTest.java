package com.tictactoe;

import com.tictactoe.logic.Player;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PlayerTest {

    @Test
    void testPlayerSymbol() {
        Player p = new Player('X');
        assertEquals('X', p.getSymbol());
    }
}
