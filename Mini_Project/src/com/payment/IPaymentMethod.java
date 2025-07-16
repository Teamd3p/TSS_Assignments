package com.payment;

public interface IPaymentMethod {

	public void pay(double amount);
	public String getMode();
}
