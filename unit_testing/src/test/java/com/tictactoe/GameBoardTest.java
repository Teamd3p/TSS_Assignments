package com.tictactoe;

import com.tictactoe.logic.GameBoard;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class GameBoardTest {
    private GameBoard board;

    @BeforeEach
    void setUp() {
        board = new GameBoard();
    }

    @Test
    void testPlaceMarkSuccess() {
        assertTrue(board.placeMark(0, 0, 'X'));
        assertEquals('X', board.getBoard()[0][0]);
    }

    @Test
    void testPlaceMarkOccupiedCell() {
        board.placeMark(0, 0, 'X');
        assertFalse(board.placeMark(0, 0, 'O'));
    }

    @Test
    void testPlaceMarkOutOfBounds() {
        assertFalse(board.placeMark(3, 3, 'X'));
        assertFalse(board.placeMark(-1, 0, 'O'));
    }

    @Test
    void testResetBoard() {
        board.placeMark(1, 1, 'X');
        board.resetBoard();
        assertEquals('-', board.getBoard()[1][1]);
    }
}
