package com;

import java.util.*;

public class BookTest {
    static Scanner scanner = new Scanner(System.in);
    static List<Book> books = new ArrayList<>();

    public static void main(String[] args) {
        int choice;
        boolean loop =true;
        while(loop){
            System.out.println("\n------ Book Management System ------");
            System.out.println("1. Add a new book");
            System.out.println("2. Issue a book by ID");
            System.out.println("3. Display all available books");
            System.out.println("4. Display all issued books");
            System.out.println("5. Return a book");
            System.out.println("6. Sort books");
            System.out.println("0. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1 : addBook(); break;
                case 2 : issueBook(); break;
                case 3 : displayAvailableBooks(); break;
                case 4 : displayIssuedBooks(); break;
                case 5 : returnBook(); break;
                case 6 : 
                	Collections.sort(books, new AuthorComparator());
                    System.out.println("--- Sorted by author ---");
                    for (Book book : books) {
                        System.out.println(book);
                    }
                    
                    Collections.sort(books, new TitleComparator());
                    System.out.println("--- Sorted by title ---");
                    for (Book book : books) {
                        System.out.println(book);
                    }
                    
                    break;
                case 7 : System.out.println("Exiting..."); loop=false; break;
                default : System.out.println("Invalid choice. Try again.");
            }
        }
    }

    static void addBook() {
        System.out.print("Enter Book ID: ");
        int id = scanner.nextInt();
        scanner.nextLine(); 
        System.out.print("Enter Book Title: ");
        String title = scanner.nextLine();
        System.out.print("Enter Author: ");
        String author = scanner.nextLine();

        books.add(new Book(id, title, author));
        System.out.println("Book added successfully!");
    }

    static void issueBook() {
        System.out.print("Enter Book ID to issue: ");
        int id = scanner.nextInt();

        for (Book book : books) {
            if (book.getId() == id && !book.isIssued()) {
                book.issue();
                System.out.println("Book issued successfully.");
                return;
            }
        }
        System.out.println("Book not found or already issued.");
    }

    static void displayAvailableBooks() {
        System.out.println("\n--- Available Books ---");
        boolean found = false;
        for (Book book : books) {
            if (!book.isIssued()) {
                System.out.println(book);
                found = true;
            }
        }
        if (!found) System.out.println("No available books.");
    }

    static void displayIssuedBooks() {
        System.out.println("\n--- Issued Books ---");
        boolean found = false;
        for (Book book : books) {
            if (book.isIssued()) {
                System.out.println(book);
                found = true;
            }
        }
        if (!found) System.out.println("No books are currently issued.");
    }

    static void returnBook() {
        System.out.print("Enter Book ID to return: ");
        int id = scanner.nextInt();

        for (Book book : books) {
            if (book.getId() == id && book.isIssued()) {
                book.returnBook();
                System.out.println("Book returned successfully.");
                return;
            }
        }
        System.out.println("Book not found or not issued.");
    }
}
