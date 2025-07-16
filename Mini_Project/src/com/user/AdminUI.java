package com.user;

import java.util.List;
import java.util.Scanner;

import com.delivery.RandomDeliveryPartner;
import com.model.FoodItems;
import com.service.MenuManager;

public class AdminUI {
	private static Scanner sc = new Scanner(System.in);

	public static void showAdminMenu() {
		
		boolean loop = true;

		while(loop) {
			System.out.println("-----------------------------------------");
			System.out.println("### Admin Panel ###");
			System.out.println("-----------------------------------------");
			System.out.println(
					"1. Edit Menu \n2. View Menu \n3. Edit Deilvery Partner \n4. View Delivery Partner\n5. Go back to Main Menu");
			int choose = sc.nextInt();
		switch (choose) {
		case 1:
			System.out.println("1. Add Item \n2.Remove Item \n3. Exit ");
			int ch = sc.nextInt();
			if (ch == 1) {
				System.out.print("Enter item name: ");
				String name = sc.next();
				System.out.print("Enter price: ");
				double price = sc.nextDouble();
				MenuManager.addItem(new FoodItems(name, price));
			}
			if (ch == 2) {
				List<FoodItems> menu = MenuManager.getMenu();
				for (int i = 0; i < menu.size(); i++) {
					System.out.println((i + 1) + ". " + menu.get(i).getName());
				}
				System.out.println("Enter the name to remove: ");
				String rm = sc.next();
				MenuManager.removeItem(rm);
			}
			if (ch == 3) {
				break;
			}
			break;
		case 2:
			System.out.println("-----------------------------------------");
			System.out.println("### Current Menu ###");
			System.out.println("-----------------------------------------");
			List<FoodItems> menu = MenuManager.getMenu();
			for (int i = 0; i < menu.size(); i++) {
				FoodItems item = menu.get(i);
				System.out.println((i + 1) + ". " + item.getName() + " - ₹" + item.getPrice());
			}
			break;
		case 3:
			System.out.println("1. Add Partner\n2. Remove Partner");
			int dch = sc.nextInt();
			sc.nextLine();
			if (dch == 1) {
				System.out.print("Enter partner name: ");
				String dname = sc.nextLine();
				RandomDeliveryPartner.addDeliveryPartner(dname);
			} if (dch ==2){
				List<String> partners = RandomDeliveryPartner.getPartners();
				for (int i = 0; i < partners.size(); i++) {
					System.out.println((i + 1) + ". " + partners.get(i));
				}
				System.out.print("Enter index to remove: ");
				int rm = sc.nextInt();
				RandomDeliveryPartner.removeDeliveryPartner(rm - 1);
			}
			if (dch == 3) {
				break;
			}

			break;
		case 4:
			System.out.println("### Current Delivery Partners ###");
			List<String> partners = RandomDeliveryPartner.getPartners();
			for (int i = 0; i < partners.size(); i++) {
				String item = partners.get(i);
				System.out.println((i + 1) + ". " + item);
			}

			break;
		case 5:
			loop = false;
			System.out.println("Exciting");
			break;
		}
		}
	}

}
