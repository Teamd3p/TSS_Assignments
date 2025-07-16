package com.payment;

import java.util.Scanner;

public class UPIPayment implements IPaymentMethod {
    @Override
    public void pay(double amount) {
    	Scanner sc = new Scanner(System.in);
    	System.out.println("Enter the UPI pin: ");
    	int upiPin = sc.nextInt();
    	if(upiPin > 0000 && upiPin <= 9999) {
        System.out.println("Payment of ₹" + amount + " done via UPI.");}
    }

    @Override
    public String getMode() {
        return "UPI";
    }
}

