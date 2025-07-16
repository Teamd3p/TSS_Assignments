package com.model;

public class OrderItems {
	private FoodItems item;
	private int quantity;

	public OrderItems(FoodItems item, int quantity) {
		super();
		this.item = item;
		this.quantity = quantity;
	}

	public FoodItems getItem() {
		return item;
	}

	public int getQuantity() {
		return quantity;
	}
	
	public double getTotalPrice() {
		return item.getPrice() * quantity;
	}
}
