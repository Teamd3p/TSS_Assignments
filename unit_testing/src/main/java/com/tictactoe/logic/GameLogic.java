package com.tictactoe.logic;

public class GameLogic {
    private GameBoard board;

    public GameLogic(GameBoard board) {
        this.board = board;
    }

    public boolean checkWinner(char symbol) {
        char[][] b = board.getBoard();
        for (int i = 0; i < 3; i++)
            if ((b[i][0] == symbol && b[i][1] == symbol && b[i][2] == symbol) ||
                (b[0][i] == symbol && b[1][i] == symbol && b[2][i] == symbol))
                return true;

        return (b[0][0] == symbol && b[1][1] == symbol && b[2][2] == symbol) ||
               (b[0][2] == symbol && b[1][1] == symbol && b[2][0] == symbol);
    }

    public boolean isDraw() {
        for (char[] row : board.getBoard())
            for (char cell : row)
                if (cell == '-') return false;
        return true;
    }
}
