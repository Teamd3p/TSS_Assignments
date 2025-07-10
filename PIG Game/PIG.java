package com.Assignment;

import java.util.Random;
import java.util.Scanner;

public class PIG {

    public static int randomNumber() {
        Random random = new Random();
        int min = 1, max = 6;
        return random.nextInt(max - min + 1) + min;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int score = 0;

        System.out.println("--> Welcome to PIG Game");

        for (int turn = 1; turn < 6; turn++) {
            System.out.println("Turn " + turn);
            while (true) {
                System.out.print("Roll or Hold? (r/h): ");
                String choose = sc.nextLine();

                if (choose.equalsIgnoreCase("r")) {
                    int die = randomNumber();
                    System.out.println("Die: " + die);

                    if (die == 1) {
                        score = 0;
                        System.out.println("Rolled a 1! You lose all points this turn.");
                        break;
                    } else {
                        score += die;
                        System.out.println("Current Score: " + score);
                        if (score >= 20) {
                            System.out.println("You reached 20 points!");
                            System.out.println("You finish the Game in " + turn + " turns!!!");
                            System.out.println("Game Over..!");
                            return;
                        }
                    }
                } else if (choose.equalsIgnoreCase("h")) {
                    System.out.println("You chose to hold.");
                    System.out.println("Your score is: " + score);
                    break;
                } else {
                    System.out.println("Invalid input. Please type 'r' or 'h'.");
                }
            }
        }

        System.out.println("Game ended. Final Score: " + score);
    }
}
