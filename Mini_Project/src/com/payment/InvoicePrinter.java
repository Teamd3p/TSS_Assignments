package com.payment;

import com.model.Order;
import com.model.OrderItems;

public class InvoicePrinter {
	public static void printInvoice(Order order) {
		System.out.println("### Invoice ###");
		for (OrderItems item : order.getItem()) {
			System.out.println(item.getItem().getName() + " x " + item.getQuantity() + " = " + item.getTotalPrice());
		}
		System.out.println("Subtotal: ₹" + order.getSubtotal());
		System.out.println("Discount: ₹" + order.getDiscount());
		System.out.println("Total: ₹" + order.getTotal());
		System.out.println("Payment Mode: " + order.getPaymentMode());
		System.out.println("Delivery Partner: " + order.getDeliveryPartner());
		System.out.println("---------------------\n");
	}

}
