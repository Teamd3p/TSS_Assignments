package com.tss.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.exception.InsufficientBalanceException;
import com.tss.model.Account;
import com.tss.model.Customer;
import com.tss.model.User;
import com.tss.service.AccountService;
import com.tss.service.AdminService;
import com.tss.service.ComplaintService;
import com.tss.service.CustomerService;
import com.tss.service.LoanService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/customer/dashboard", "/customer/deposit", "/customer/withdraw", "/customer/transfer",
		"/customer/open_account", "/customer/complaints", "/customer/loan_status", "/customer/apply_loan",
		"/customer/repay_loan", "/account-overview", "/customer/profile" }) // Added /customer/profile
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AccountService accountService = new AccountService();
	@SuppressWarnings("unused")
	private final AdminService adminService = new AdminService();
	private final ComplaintService complaintService = new ComplaintService();
	private final CustomerService customerService = new CustomerService();
	private final LoanService loanService = new LoanService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		User u = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (u == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		try {
			int customerId = getCustomerId(u.getUserId(), req);
			Customer customer = customerService.get(customerId);
			if (customer == null) {
				req.setAttribute(Constants.ATTR_ERRORS, "Customer not found.");
				req.getRequestDispatcher("/error.jsp").forward(req, resp);
				return;
			}

			switch (path) {
			case "/customer/dashboard":
				List<Account> accounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", accounts);
				req.setAttribute("accountCount", accounts != null ? accounts.size() : 0);
				BigDecimal totalBalance = BigDecimal.ZERO;
				if (accounts != null) {
					for (Account acc : accounts) {
						totalBalance = totalBalance.add(acc.getBalance() != null ? acc.getBalance() : BigDecimal.ZERO);
					}
				}
				req.setAttribute("totalBalance", totalBalance);
				req.getRequestDispatcher("/customer_dashboard.jsp").forward(req, resp);
				break;

			case "/customer/deposit":
				List<Account> depositAccounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", depositAccounts);
				req.getRequestDispatcher("/deposit.jsp").forward(req, resp);
				break;

			case "/customer/withdraw":
				List<Account> withdrawAccounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", withdrawAccounts);
				req.getRequestDispatcher("/withdraw.jsp").forward(req, resp);
				break;

			case "/customer/transfer":
				List<Account> transferAccounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", transferAccounts);
				req.getRequestDispatcher("/transfer.jsp").forward(req, resp);
				break;

			case "/customer/open_account":
				req.setAttribute("customerId", customerId);
				req.getRequestDispatcher("/open_account.jsp").forward(req, resp);
				break;

			case "/customer/apply_loan":
				List<Account> loanAccounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", loanAccounts);
				req.setAttribute("customerId", customerId);
				req.getRequestDispatcher("/apply_loan.jsp").forward(req, resp);
				break;

			case "/customer/loan_status":
				req.setAttribute("loans", loanService.getLoansByCustomer(customerId));
				req.getRequestDispatcher("/loan_status.jsp").forward(req, resp);
				break;

			case "/customer/complaints":
				req.setAttribute("complaints", complaintService.findByCustomer(customerId));
				req.getRequestDispatcher("/complaints.jsp").forward(req, resp);
				break;

			case "/customer/repay_loan":
				req.setAttribute("customerId", customerId);
				req.setAttribute("loans", loanService.getLoansByCustomer(customerId));
				req.getRequestDispatcher("/repay_loan.jsp").forward(req, resp);
				break;

			case "/account-overview":
				List<Account> overviewAccounts = accountService.getAccountsByCustomer(customerId);
				req.setAttribute("accounts", overviewAccounts);
				req.getRequestDispatcher("/account-overview.jsp").forward(req, resp);
				break;

			case "/customer/profile":
				req.setAttribute("customer", customer);
				req.getRequestDispatcher("/profile.jsp").forward(req, resp);
				break;

			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLException e) {
			throw new ServletException("Database error", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (u == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		try {
			int userId = u.getUserId();
			int customerId = getCustomerId(userId, req);

			switch (req.getServletPath()) {
			case "/customer/deposit":
				int accIdD = Integer.parseInt(req.getParameter("accountId"));
				BigDecimal amtD = new BigDecimal(req.getParameter("amount"));
				accountService.deposit(userId, accIdD, amtD);
				resp.sendRedirect(req.getContextPath() + "/accounts?success=1");
				break;
			case "/customer/withdraw":
				int accIdW = Integer.parseInt(req.getParameter("accountId"));
				BigDecimal amtW = new BigDecimal(req.getParameter("amount"));
				try {
					accountService.withdraw(userId, accIdW, amtW);
					resp.sendRedirect(req.getContextPath() + "/accounts?success=1");
				} catch (InsufficientBalanceException e) {
					req.setAttribute("error", "Insufficient balance for withdrawal.");
					req.getRequestDispatcher("/error.jsp").forward(req, resp);
				}
				break;
			case "/customer/transfer":
				int fromId = Integer.parseInt(req.getParameter("fromAccountId"));
				String toAcc = req.getParameter("toAccountNumber");
				BigDecimal amtT = new BigDecimal(req.getParameter("amount"));
				try {
					accountService.transfer(userId, fromId, toAcc, amtT);
					resp.sendRedirect(req.getContextPath() + "/accounts?success=1");
				} catch (InsufficientBalanceException e) {
					req.setAttribute("error", "Insufficient balance for transfer.");
					req.getRequestDispatcher("/error.jsp").forward(req, resp);
				}
				break;
			case "/customer/open_account":
				String type = req.getParameter("accountType");
				accountService.openAccount(customerId, type);
				resp.sendRedirect(req.getContextPath() + "/accounts?opened=1");
				break;
			case "/customer/complaints":
				String subject = req.getParameter("subject");
				String message = req.getParameter("message");
				if (subject == null || message == null || subject.trim().isEmpty() || message.trim().isEmpty()) {
					req.setAttribute("error", "Subject and message are required.");
					req.getRequestDispatcher("/complaints.jsp").forward(req, resp);
					return;
				}
				complaintService.createComplaint(userId, subject, message);
				resp.sendRedirect(req.getContextPath() + "/customer/complaints?created=1");
				break;
			case "/customer/apply_loan":
				int accountId = Integer.parseInt(req.getParameter("accountId"));
				String loanType = req.getParameter("loanType");
				BigDecimal amount = new BigDecimal(req.getParameter("amount"));
				BigDecimal interestRate = new BigDecimal(req.getParameter("interestRate"));
				int tenureMonths = Integer.parseInt(req.getParameter("tenureMonths"));

				if (amount.compareTo(BigDecimal.ZERO) <= 0) {
					req.setAttribute("errors", java.util.List.of("Amount must be greater than 0"));
					doGet(req, resp);
					return;
				}
				if (tenureMonths <= 0) {
					req.setAttribute("errors", java.util.List.of("Tenure must be at least 1 month"));
					doGet(req, resp);
					return;
				}

				loanService.applyLoan(userId, customerId, accountId, loanType, amount, interestRate, tenureMonths);
				resp.sendRedirect(req.getContextPath() + "/customer/apply_loan?applied=1");
				break;
			case "/customer/repay_loan":
				int loanId = Integer.parseInt(req.getParameter("loanId"));
				BigDecimal repayAmount = new BigDecimal(req.getParameter("amount"));
				loanService.repay(userId, loanId, repayAmount);
				resp.sendRedirect(req.getContextPath() + "/customer/repay_loan?repaid=1");
				break;
			case "/customer/profile":
				String action = req.getParameter("action");
				if ("changePassword".equals(action)) {
					String oldPassword = req.getParameter("oldPassword");
					String newPassword = req.getParameter("newPassword");
					String confirmPassword = req.getParameter("confirmPassword");

					if (!newPassword.equals(confirmPassword)) {
						req.setAttribute("error", "New passwords do not match.");
						req.setAttribute("customer", customerService.get(customerId));
						req.getRequestDispatcher("/profile.jsp").forward(req, resp);
						return;
					}
					if (customerService.changePassword(u.getUserId(), oldPassword, newPassword)) {
						req.setAttribute("message", "Password updated successfully.");
					} else {
						req.setAttribute("error", "Old password is incorrect.");
					}
					req.setAttribute("customer", customerService.get(customerId));
					req.getRequestDispatcher("/profile.jsp").forward(req, resp);
				}
				break;
			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLException e) {
			throw new ServletException("Database error: " + e.getMessage(), e);
		} catch (NumberFormatException e) {
			req.setAttribute("error", "Invalid numeric input.");
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
	}

	private int getCustomerId(int userId, HttpServletRequest req) throws SQLException {
		Customer customer = customerService.getByUserId(userId);
		if (customer == null) {
			throw new IllegalArgumentException("No customer linked to this user");
		}
		return customer.getCustomerId();
	}
}