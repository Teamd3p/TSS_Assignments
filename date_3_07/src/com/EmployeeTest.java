package com;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class EmployeeTest {
	static Scanner scanner = new Scanner(System.in);
	static List<Employee> employees = new ArrayList<>();

	public static void readEmployee() {
		System.out.println("Enter ID: ");
		int id = scanner.nextInt();
		System.out.println("Enter name: ");
		String name = scanner.next();
		System.out.println("Enter Salary: ");
		double salary = scanner.nextDouble();
		
		employees.add(new Employee(id, name,salary));
	}

	public static void main(String args[]) {

		

		System.out.println("How many employees you want to add: ");
		int number = scanner.nextInt();

		for (int i = 0; i < number; i++) {
			System.out.println("Details of employee "+ (i+1));
			System.out.println("------------------------------------------------");
			readEmployee();
		}

		for(Employee emp : employees) {
			System.out.println(emp);
		}
		
		Collections.sort(employees, new NameComparator());
        System.out.println("--- Sorted by Name ---");
        for (Employee e : employees) {
            System.out.println(e);
        }


        Collections.sort(employees, new SalaryComparator());
        System.out.println("--- Sorted by Salary ---");
        for (Employee e : employees) {
            System.out.println(e);
        }

	}

}
