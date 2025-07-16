package com.model;

import java.util.ArrayList;
import java.util.List;

public class Order {
	List<OrderItems> items = new ArrayList<>();
	private double discount;
	private double total;
	private String paymentMode;
	private String deliveryPartner;

	public void addItem(OrderItems item) {
		items.add(item);
	}

	public List<OrderItems> getItem(){return items;}
	
	public double getSubtotal() {
		return items.stream().mapToDouble(OrderItems::getTotalPrice).sum();
	}
	
	public void applyDiscount(double discount) {
		this.discount=discount;
	}
	
	public void setTotal(double total) {
		this.total=total;
	}

	public List<OrderItems> getItems() {
		return items;
	}

	public void setItems(List<OrderItems> items) {
		this.items = items;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public double getTotal() {
		return total;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getDeliveryPartner() {
		return deliveryPartner;
	}

	public void setDeliveryPartner(String deliveryPartner) {
		this.deliveryPartner = deliveryPartner;
	}
	
	
}
