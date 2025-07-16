package com.strategy;

public class FlatDiscount implements Discount {

	@Override
	public double applyDiscount(double amount) {
		return amount > 500 ? 50 : 0;
	}

}
