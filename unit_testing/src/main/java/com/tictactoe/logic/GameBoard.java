package com.tictactoe.logic;

public class GameBoard {
    private char[][] board;

    public GameBoard() {
        board = new char[3][3];
        resetBoard();
    }

    public void resetBoard() {
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 3; j++)
                board[i][j] = '-';
    }

    public boolean placeMark(int row, int col, char symbol) {
        if (row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == '-') {
            board[row][col] = symbol;
            return true;
        }
        return false;
    }

    public char[][] getBoard() {
        return board;
    }

    public void printBoard() {
        for (char[] row : board) {
            for (char cell : row) System.out.print(cell + " ");
            System.out.println();
        }
    }
}
