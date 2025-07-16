package com.service;

import java.util.ArrayList;
import java.util.List;

import com.model.FoodItems;

public class MenuManager {
	private static final List<FoodItems> menu = new ArrayList<>();

	static {
		menu.add(new FoodItems("Pizza", 250));
		menu.add(new FoodItems("Burger", 150));
		menu.add(new FoodItems("Pasta", 200));
		menu.add(new FoodItems("Fries", 100));
	}

	public static List<FoodItems> getMenu() {
		return menu;
	}

	public static void addItem(FoodItems item) {
		menu.add(item);
	}

	public static void removeItem(String i) {
        	menu.removeIf(item -> item.getName().equalsIgnoreCase(i));
        }

	public static void printMenu() {
	    System.out.println("\n--------------------- Menu ---------------------");
	    if (menu.isEmpty()) {
	        System.out.println("Menu is empty.");
	        return;
	    }

	    System.out.printf("%-5s %-25s %-10s\n", "S.No", "Item Name", "Price (₹)");
	    System.out.println("--------------------------------------------------");

	    for (int i = 0; i < menu.size(); i++) {
	        FoodItems item = menu.get(i);
	        System.out.printf("%-5d %-25s ₹%-10.2f\n", i + 1, item.getName(), item.getPrice());
	    }
	}

}
