package com.tictactoe;

import java.util.Scanner;

import com.tictactoe.logic.GameBoard;
import com.tictactoe.logic.GameLogic;
import com.tictactoe.logic.Player;

public class GameFacade {
    private GameBoard board;
    private GameLogic logic;
    private Player player1;
    private Player player2;
    private Scanner scanner;

    public GameFacade() {
        board = new GameBoard();
        logic = new GameLogic(board);
        player1 = new Player('X');
        player2 = new Player('O');
        scanner = new Scanner(System.in);
    }

    public void startGame() {
        Player currentPlayer = player1;
        board.printBoard();

        while (true) {
            System.out.println("Player " + currentPlayer.getSymbol() + "'s turn. Enter row and column (0-2): ");
            int row = scanner.nextInt();
            int col = scanner.nextInt();

            if (board.placeMark(row, col, currentPlayer.getSymbol())) {
                board.printBoard();

                if (logic.checkWinner(currentPlayer.getSymbol())) {
                    System.out.println("Player " + currentPlayer.getSymbol() + " wins!");
                    break;
                } else if (logic.isDraw()) {
                    System.out.println("It's a draw!");
                    break;
                }

                currentPlayer = (currentPlayer == player1) ? player2 : player1;
            } else {
                System.out.println("Invalid move. Try again.");
            }
        }
    }
}
