package com.tss.model;

public class Report {
	private int totalTransactions;
	private double totalAmount;
	private String dateRange;
	private int deposits;
	private int withdrawals;
	private int transfers;
	private double depositAmount;
	private double withdrawalAmount;
	private double transferAmount;

	// Getters and Setters
	public int getTotalTransactions() {
		return totalTransactions;
	}

	public void setTotalTransactions(int totalTransactions) {
		this.totalTransactions = totalTransactions;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getDateRange() {
		return dateRange;
	}

	public void setDateRange(String dateRange) {
		this.dateRange = dateRange;
	}

	public int getDeposits() {
		return deposits;
	}

	public void setDeposits(int deposits) {
		this.deposits = deposits;
	}

	public int getWithdrawals() {
		return withdrawals;
	}

	public void setWithdrawals(int withdrawals) {
		this.withdrawals = withdrawals;
	}

	public int getTransfers() {
		return transfers;
	}

	public void setTransfers(int transfers) {
		this.transfers = transfers;
	}

	public double getDepositAmount() {
		return depositAmount;
	}

	public void setDepositAmount(double depositAmount) {
		this.depositAmount = depositAmount;
	}

	public double getWithdrawalAmount() {
		return withdrawalAmount;
	}

	public void setWithdrawalAmount(double withdrawalAmount) {
		this.withdrawalAmount = withdrawalAmount;
	}

	public double getTransferAmount() {
		return transferAmount;
	}

	public void setTransferAmount(double transferAmount) {
		this.transferAmount = transferAmount;
	}
}