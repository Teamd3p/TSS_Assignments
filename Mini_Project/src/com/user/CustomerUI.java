package com.user;

import java.util.List;
import java.util.Scanner;

import com.delivery.IDelivery;
import com.delivery.RandomDeliveryPartner;
import com.model.Customer;
import com.model.FoodItems;
import com.model.Order;
import com.model.OrderItems;
import com.payment.CashPayment;
import com.payment.IPaymentMethod;
import com.payment.InvoicePrinter;
import com.payment.UPIPayment;
import com.service.MenuManager;
import com.strategy.Discount;
import com.strategy.FlatDiscount;

public class CustomerUI {
	public static void start(Customer customer) {
		Scanner sc = new Scanner(System.in);
		Order order = new Order();
		
		System.out.println("Welcome, "+customer.getName());
		while(true) {
			MenuManager.printMenu();
			System.out.println("--------------------------------------------------------------------------------");
			System.out.println("Enter item number to order (0 ot finish)");
			int choise = sc.nextInt();
			
			if(choise == 0) {
				break;
			}
			List<FoodItems> menu = MenuManager.getMenu();
			if(choise > 0 && choise <= menu.size()) {
				FoodItems item = menu.get(choise - 1);
				System.out.println("Enter quantity: ");
				int qty = sc.nextInt();
				order.addItem(new OrderItems(item, qty));
			}
			else {
				System.out.println("Invalid Item Number");
			}
		}
		double subtotal = order.getSubtotal();
		Discount discountStrategy = new FlatDiscount();
        double discount = discountStrategy.applyDiscount(subtotal);
        double total = subtotal - discount;
        
        order.applyDiscount(discount);
        order.setTotal(total);
        
        System.out.println("Choose Payment method: ");
        System.out.println("1. Cash\n2. UPI");
        
        int pay = sc.nextInt();
        IPaymentMethod payment = (pay == 1) ? new CashPayment() : new UPIPayment();
        payment.pay(total);
        order.setPaymentMode(payment.getMode());
        IDelivery delivery = new RandomDeliveryPartner();
        order.setDeliveryPartner(delivery.assignDeliveryPartner());
        
        InvoicePrinter.printInvoice(order);
	}

}
