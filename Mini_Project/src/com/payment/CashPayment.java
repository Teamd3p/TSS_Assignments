package com.payment;

public class CashPayment implements IPaymentMethod{

	@Override
	public void pay(double amount) {
		System.out.println("Payment of "+amount+" rupees received in Cash..!!");
		
	}

	@Override
	public String getMode() {
		return "Cash";
	}
	

}
