package com.tss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tss.dao.AccountDAO;
import com.tss.dao.ActivityLogDAO;
import com.tss.dao.ComplaintDAO;
import com.tss.dao.CustomerDAO;
import com.tss.dao.LoanDAO;
import com.tss.dao.TransactionDAO;
import com.tss.database.DBConnection;
import com.tss.model.Account;
import com.tss.model.ActivityLog;
import com.tss.model.Complaint;
import com.tss.model.Customer;
import com.tss.model.Loan;
import com.tss.model.Report;
import com.tss.model.Transaction;

public class AdminService {
	private final CustomerDAO customerDAO = new CustomerDAO();
	private final AccountDAO accountDAO = new AccountDAO();
	private final TransactionDAO transactionDAO = new TransactionDAO();
	private final LoanDAO loanDAO = new LoanDAO();
	private final ComplaintDAO complaintDAO = new ComplaintDAO();
	private final ActivityLogDAO logDAO = new ActivityLogDAO();

	public Map<String, Integer> getDashboardSummary() throws SQLException {
		Map<String, Integer> summary = new HashMap<>();
		List<Customer> customers = customerDAO.findAll();
		summary.put("customers", customers.size());
		summary.put("blockedCustomers", 0); // Placeholder

		List<Account> accounts = accountDAO.findAll();
		summary.put("accounts", accounts.size());
		summary.put("closedAccounts", (int) accounts.stream().filter(a -> "CLOSED".equals(a.getStatus())).count());
		summary.put("blockedAccounts", (int) accounts.stream().filter(a -> "BLOCKED".equals(a.getStatus())).count());

		List<Transaction> transactions = transactionDAO.findAll();
		summary.put("transactions", transactions.size());
		summary.put("deposits", (int) transactions.stream().filter(t -> "DEPOSIT".equals(t.getType())).count());
		summary.put("withdrawals", (int) transactions.stream().filter(t -> "WITHDRAW".equals(t.getType())).count());
		summary.put("transfers", (int) transactions.stream().filter(t -> "TRANSFER".equals(t.getType())).count());

		List<Loan> loans = loanDAO.findAll();
		summary.put("loans", loans.size());
		summary.put("pendingLoans", (int) loans.stream().filter(l -> "PENDING".equals(l.getStatus())).count());
		summary.put("approvedLoans", (int) loans.stream().filter(l -> "APPROVED".equals(l.getStatus())).count());
		summary.put("rejectedLoans", (int) loans.stream().filter(l -> "REJECTED".equals(l.getStatus())).count());
		summary.put("closedLoans", (int) loans.stream().filter(l -> "CLOSED".equals(l.getStatus())).count());

		List<Complaint> complaints = complaintDAO.findAll();
		summary.put("complaints", complaints.size());
		summary.put("openComplaints", (int) complaints.stream().filter(c -> "OPEN".equals(c.getStatus())).count());
		summary.put("inProgressComplaints",
				(int) complaints.stream().filter(c -> "IN_PROGRESS".equals(c.getStatus())).count());
		summary.put("resolvedComplaints",
				(int) complaints.stream().filter(c -> "RESOLVED".equals(c.getStatus())).count());

		try (Connection conn = DBConnection.getConnection()) {
			java.util.Date today = new java.util.Date();
			java.sql.Date sqlToday = new java.sql.Date(today.getTime());
			java.sql.Date yesterday = new java.sql.Date(today.getTime() - 24 * 60 * 60 * 1000);
			java.sql.Date weekAgo = new java.sql.Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);

			String sql = "SELECT " + "SUM(CASE WHEN log_date >= ? THEN 1 ELSE 0 END) as today, "
					+ "SUM(CASE WHEN log_date >= ? AND log_date < ? THEN 1 ELSE 0 END) as yesterday, "
					+ "SUM(CASE WHEN log_date >= ? THEN 1 ELSE 0 END) as week " + "FROM activity_logs";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setDate(1, sqlToday);
				ps.setDate(2, yesterday);
				ps.setDate(3, sqlToday);
				ps.setDate(4, weekAgo);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						summary.put("todayActivities", rs.getInt("today"));
						summary.put("yesterdayActivities", rs.getInt("yesterday"));
						summary.put("weekActivities", rs.getInt("week"));
					}
				}
			}
		}

		return summary;
	}

	public Report generateReport(String reportType, String dateStr) throws SQLException {
		Report report = new Report();

		try {
			LocalDate inputDate = LocalDate.parse(dateStr); // expects yyyy-MM-dd
			LocalDate start;
			LocalDate end;

			switch (reportType) {
			case "DAILY" -> {
				start = inputDate;
				end = inputDate;
			}
			case "MONTHLY" -> {
				start = inputDate.withDayOfMonth(1);
				end = inputDate.withDayOfMonth(inputDate.lengthOfMonth());
			}
			case "ANNUAL" -> {
				start = inputDate.withDayOfYear(1);
				end = inputDate.withDayOfYear(inputDate.lengthOfYear());
			}
			default -> throw new SQLException("Invalid report type: " + reportType);
			}

			try (Connection conn = DBConnection.getConnection()) {
				String sql = """
						SELECT
						  COUNT(*) as totalTransactions,
						  COALESCE(SUM(amount),0) as totalAmount,
						  COALESCE(SUM(CASE WHEN type = 'DEPOSIT' THEN amount ELSE 0 END),0) as depositAmount,
						  COALESCE(SUM(CASE WHEN type = 'WITHDRAW' THEN amount ELSE 0 END),0) as withdrawalAmount,
						  COALESCE(SUM(CASE WHEN type = 'TRANSFER' THEN amount ELSE 0 END),0) as transferAmount,
						  COALESCE(SUM(CASE WHEN type = 'DEPOSIT' THEN 1 ELSE 0 END),0) as deposits,
						  COALESCE(SUM(CASE WHEN type = 'WITHDRAW' THEN 1 ELSE 0 END),0) as withdrawals,
						  COALESCE(SUM(CASE WHEN type = 'TRANSFER' THEN 1 ELSE 0 END),0) as transfers
						FROM transactions
						WHERE transaction_date BETWEEN ? AND ?
						""";

				try (PreparedStatement ps = conn.prepareStatement(sql)) {
					ps.setDate(1, java.sql.Date.valueOf(start));
					ps.setDate(2, java.sql.Date.valueOf(end));
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							report.setTotalTransactions(rs.getInt("totalTransactions"));
							report.setTotalAmount(rs.getDouble("totalAmount"));
							report.setDeposits(rs.getInt("deposits"));
							report.setWithdrawals(rs.getInt("withdrawals"));
							report.setTransfers(rs.getInt("transfers"));
							report.setDepositAmount(rs.getDouble("depositAmount"));
							report.setWithdrawalAmount(rs.getDouble("withdrawalAmount"));
							report.setTransferAmount(rs.getDouble("transferAmount"));
						}
					}
				}
			}

			report.setDateRange(start + " to " + end);
			return report;

		} catch (Exception e) {
			throw new SQLException("Error generating report: " + e.getMessage(), e);
		}
	}

	public List<Customer> getAllCustomers() throws SQLException {
		return customerDAO.findAll();
	}

	public List<Account> getAllAccounts() throws SQLException {
		return accountDAO.findAll();
	}

	public List<Transaction> getAllTransactions() throws SQLException {
		return transactionDAO.findAll();
	}

	public List<Loan> getAllLoans() throws SQLException {
		return loanDAO.findAll();
	}

	public List<Complaint> getAllComplaints() throws SQLException {
		return complaintDAO.findAll();
	}

	public List<ActivityLog> getRecentActivityLogs(int limit) throws SQLException {
		return logDAO.findAll(limit);
	}
}