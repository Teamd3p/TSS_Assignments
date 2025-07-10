package com;
import java.util.Random;
import java.util.Scanner;

public class Account {
	int accId;
	String name, accNumber;
	AccountType accType;
	float balance;

	public Account(int accId, String accNumber, String name, AccountType accType, float balance) {
		this.accId = accId;
		this.name = name;
		this.accNumber = accNumber;
		this.accType = accType;
		this.balance = balance;
	}
	public void setName(String name) {
		this.name = name;
	}

	public AccountType getAccType() {
		return accType;
	}

	public void setAccType(AccountType accType) {
		this.accType = accType;
	}

	public float getBalance() {
		return balance;
	}

	public void setBalance(float balance) {
		this.balance = balance;
	}

	public int getAccId() {
		return accId;
	}

	public String getAccNumber() {
		return accNumber;
	}

	public String getName() {
		return name;
	}

	public void setAccId(int accId) {
		this.accId = accId;
	}

	public void setAccNumber(String accNumber) {
		this.accNumber = accNumber;
	}

	public float deposit(int amount) {
		balance = balance + amount;
		return balance;
	}

	public float withdraw(int amount) {
		if (balance - amount >= 500) {
			balance = balance - amount;
			return balance;
		} else {
			System.out.println("Your Account under valued..!!");
			System.out.println("-->You need to have atleast 500 Rupess in Account");
			return balance;
		}

	}
	public void display() {
		System.out.println("Your Account User name: "+ name);
		System.out.println("Your Account Id: "+ accId);
		System.out.println("Your Account Current Balance: "+ balance);
		System.out.println("Your Account Type: "+ accType);
		System.out.println("Your Account Number: "+ accNumber);
	}
}
