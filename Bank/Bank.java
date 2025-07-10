package com;

import java.util.Random;
import java.util.Scanner;

public class Bank {
	
	public static String generateAccNumber() {
		String forntAccNumber = "21DMPD10100";
		int min = 10000, max = 99999;
		Random random = new Random();
		int endAccNumber = random.nextInt(max - min + 1) + min;
		String accountNumber = forntAccNumber + endAccNumber;
		return accountNumber;
	}
	public static void transfer(int fromAccount, int toAccount, Account[] account, int transferAmount) {
		float sums = account[toAccount].getBalance() + transferAmount ; 
		account[toAccount].setBalance(sums);
		float subtraction = account[fromAccount].getBalance() - transferAmount;
		account[fromAccount].setBalance(subtraction);
	}
	

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);

		Boolean loop = true;
		System.out.println("--> Welcome too!!! 21 Din Ma Paisa Double Bank!!!!");
		System.out.println("");
		System.out.println("--> How many account You want In Bank");
		int i = sc.nextInt();
		Account[] account = new Account[i+1];
		int n = 1,count=1;
		while (loop) {
			System.out.println("---------------------------------------------------------------------------------------");
			System.out.println("1. Create Account\r\n" + "2. Display Balance\r\n" + "3. Deposit\r\n" + "4. Withdraw\r\n"
					+ "5. Display Account Details\r\n" +  "6. Transfer Amount\r\n" +  "7. Delete Amount\r\n" +  "8. Exit");
			System.out.println("---------------------------------------------------------------------------------------");
			int choose = sc.nextInt();
			switch (choose) {
			case 1:
				try {
				if(n <= i) {
				sc.nextLine();
				System.out.println("Enter your name:");
				String name = sc.nextLine();
				System.out.println("Enter your Account Type:");
				System.out.println("1: Savings 2:Current 3:FD");
				int number = sc.nextInt();
				AccountType accType = null;
				if (number == 1) {
					accType = AccountType.SAVINGS;
				} else if (number == 2) {
					accType = AccountType.CURRENT;
				} else if (number == 3) {
					accType = AccountType.FD;
				} else {
					System.out.println("Enter from Range 1-3 only..");
				}
				int accId = count;
				count++;
				System.out.println("Enter your Account Balance:");
				int balance = sc.nextInt();
				
				String accNumber = generateAccNumber();
				for(int j = n-1; j > 0; j--) {
					if(  accNumber == account[j].getAccNumber()) {
						System.out.println("Your Account Number Match With Other User.. \nHere is your other Account Number: ");
						accNumber = generateAccNumber();
					}
				}
				account[n] = new Account(accId, accNumber, name, accType, balance);
				System.out.println("Account Created Successfully...");
				n++;
			}else {
					System.out.println("--> You already created "+ i +" accounts in Bank");
					System.out.println("--> You can't create more Account in 21 Din Ma Paisa Double Bank...");
				}
				}catch(Exception e) {

				}break;
			case 2:
				System.out.println("Which account balance You want to view(1,2,3)...");
				int m = sc.nextInt();
				try {
					System.out.println("Your Current Balance is: " + account[m].getBalance());	
				}catch(Exception e) {
					System.out.println("There aren't any Account with this Account Id..!! ");
				}
				
				break;
			case 3:
				System.out.println("Which account balance You want to deposit(1,2,3)...");
				int m1 = sc.nextInt();
				System.out.print("Enter your Deposit Amount:");
				int amountDe = sc.nextInt();
				try {account[m1].deposit(amountDe);}catch(Exception e) {
					System.out.println("There aren't any Account with this Account Id..!! ");
				}
				
				break;
			case 4:
				System.out.println("Which account balance You want to withdraw(1,2,3)...");
				int m2 = sc.nextInt();
				System.out.println("Enter your WithDrawal Amount");
				int amountWi = sc.nextInt();
				try {
				account[m2].withdraw(amountWi);}catch(Exception e) {
					System.out.println("There aren't any Account with this Account Id..!! ");
				}
				break;
			case 5:
				System.out.println("Which account Details You want to View(0,1,2)...");
				int m3 = sc.nextInt();
				try {
				account[m3].display();}catch(Exception e) {
					System.out.println("There aren't any Account with this Account Id..!! ");
				}
				break;
			case 6:
				try {
				System.out.print("From which account you want to transfer(0,1,2)... ");
				int fromAccount = sc.nextInt();
				System.out.print("To which account you want to transfer(0,1,2)...   ");
				int toAccount = sc.nextInt();
				System.out.print("Enter the Amount you want to transfer: ");
				int transferAmount = sc.nextInt();
				transfer(fromAccount, toAccount, account, transferAmount);}catch(Exception e) {
					System.out.println("There aren't any Account with this Account Id..!! ");
				}
				break;
			case 7:
			    System.out.println("Enter account number to delete (e.g., 1, 2, 3): ");
			    int delIndex = sc.nextInt();
			    if (delIndex >= 1 && delIndex <= i && account[delIndex] != null) {
			        account[delIndex] = null;
			        System.out.println("Account deleted successfully.");
			    } else {
			        System.out.println("Invalid account number or account already deleted.");
			    }
			    break;
			case 8:
				loop = false;
				sc.close();
				break;
			default:
				System.out.println("Enter between 1-6.");
			}
		}

	}

}
