package com.user;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.Scanner;

import com.model.Customer;

public class Login {
    private static final Scanner sc = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        System.out.println("### Welcome to Desi Dhaba ###");

        List<Customer> customers = FileUtil.loadCustomers();

        while (true) {
            System.out.println("\n--- Main Menu ---");
            System.out.println("1. Login as Admin");
            System.out.println("2. Login as Customer");
            System.out.println("3. Exit");
            System.out.print("Choose option: ");
            int option = sc.nextInt();
            sc.nextLine();

            switch (option) {
                case 1 -> handleAdminLogin();
                case 2 -> handleCustomerLogin(customers);
                case 3 -> {
                    System.out.println("Thank you for visiting Desi Dhaba!");
                    FileUtil.saveCustomers(customers);
                    return;
                }
                default -> System.out.println("Invalid option. Try again.");
            }
        }
    }

    private static void handleAdminLogin() {
        System.out.print("Enter Admin ID: ");
        String id = sc.nextLine();
        System.out.print("Enter Admin Password: ");
        String password = sc.nextLine();

        Authentication.authentication(id, password);
    }

    private static void handleCustomerLogin(List<Customer> customers) throws FileNotFoundException, IOException {
        System.out.print("Enter Customer ID: ");
        String id = sc.nextLine();
        System.out.print("Enter Password: ");
        String password = sc.nextLine();

        Optional<Customer> customer = customers.stream()
                .filter(c -> c.getId().equals(id) && c.getPassword().equals(password))
                .findFirst();

        if (customer.isPresent()) {
            CustomerUI.start(customer.get());
        } else {
            System.out.print("No user found. Would you like to register? (yes/no): ");
            String ans = sc.nextLine();

            if (ans.equalsIgnoreCase("yes")) {
                System.out.print("Enter your name: ");
                String name = sc.nextLine();
                Customer newCustomer = new Customer(id, name, password);
                customers.add(newCustomer);
                FileUtil.saveCustomers(customers);
                System.out.println("Registration successful!");
                CustomerUI.start(newCustomer);
            } else {
                System.out.println("Returning to main menu...");
            }
        }
    }
}