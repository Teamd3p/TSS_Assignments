package com.tss.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.Account;
import com.tss.model.Customer;
import com.tss.model.User;
import com.tss.service.AccountService;
import com.tss.service.CustomerService;
import com.tss.util.Constants;

@WebServlet("/accounts")
public class AccountListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AccountService accountService = new AccountService();
	private final CustomerService customerService = new CustomerService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		try {
			Customer customer = customerService.getByUserId(user.getUserId());
			if (customer == null) {
				req.setAttribute(Constants.ATTR_ERRORS, "No customer profile found.");
				req.getRequestDispatcher("/error.jsp").forward(req, resp);
				return;
			}
			System.out.println("AccountListServlet: Fetching accounts for customerId: " + customer.getCustomerId());
			List<Account> accounts = accountService.getAccountsByCustomer(customer.getCustomerId());
			req.setAttribute("accounts", accounts);
			req.setAttribute("customer", customer); // Ensure customer is set
			req.getRequestDispatcher("/accounts.jsp").forward(req, resp);
		} catch (SQLException e) {
			throw new ServletException("Database error: " + e.getMessage(), e);
		}
	}
}