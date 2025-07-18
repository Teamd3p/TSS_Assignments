package com.tictactoe;

import com.tictactoe.logic.GameBoard;
import com.tictactoe.logic.GameLogic;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class GameLogicTest {
    private GameBoard board;
    private GameLogic logic;

    @BeforeEach
    void setUp() {
        board = new GameBoard();
        logic = new GameLogic(board);
    }

    @Test
    void testCheckWinnerRow() {
        board.placeMark(0, 0, 'X');
        board.placeMark(0, 1, 'X');
        board.placeMark(0, 2, 'X');
        assertTrue(logic.checkWinner('X'));
    }

    @Test
    void testCheckWinnerDiagonal() {
        board.placeMark(0, 0, 'O');
        board.placeMark(1, 1, 'O');
        board.placeMark(2, 2, 'O');
        assertTrue(logic.checkWinner('O'));
    }

    @Test
    void testNoWinner() {
        board.placeMark(0, 0, 'X');
        board.placeMark(0, 1, 'O');
        board.placeMark(0, 2, 'X');
        assertFalse(logic.checkWinner('X'));
    }

    @Test
    void testIsDraw() {
        char[][] filledBoard = {
            {'X', 'X', 'X'},
            {'X', 'X', 'O'},
            {'X', 'X', 'O'}
        };
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 3; j++)
                board.placeMark(i, j, filledBoard[i][j]);

        assertTrue(logic.isDraw());
    }

    @Test
    void testNotDrawIfEmpty() {
        assertFalse(logic.isDraw());
    }
}
