package com.tss.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.Customer;
import com.tss.model.User;
import com.tss.service.AuthService;
import com.tss.service.CustomerService;
import com.tss.util.Constants;
import com.tss.util.ValidationUtil;

@WebServlet(urlPatterns = { "/admin/customer/create", "/admin/customer/update", "/admin/customer/delete" })
public class CustomerAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CustomerService customerService = new CustomerService();
	private final AuthService authService = new AuthService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		User admin = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (admin == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}
		try {
			switch (path) {
			case "/admin/customer/create":
				String username = req.getParameter("username");
				String password = req.getParameter("password");
				String fullName = req.getParameter("fullName");
				String email = req.getParameter("email");
				String phone = req.getParameter("phone");
				String address = req.getParameter("address");
				String aadhar = req.getParameter("aadhar");
				String pan = req.getParameter("pan");

				// Validate inputs
				java.util.List<String> errors = ValidationUtil.validateRegistration(username, password, fullName, email,
						phone);
				if (!errors.isEmpty()) {
					req.setAttribute(Constants.ATTR_ERRORS, String.join("; ", errors));
					req.getRequestDispatcher("/manage_customers.jsp").forward(req, resp);
					return;
				}

				// Create customer account
				authService.registerCustomer(username, password, fullName, email, phone, address, aadhar, pan);
				resp.sendRedirect(req.getContextPath() + "/admin/customers?created=1");
				break;

			case "/admin/customer/update":
				Customer u = new Customer();
				u.setCustomerId(Integer.parseInt(req.getParameter("customerId")));
				u.setFullName(req.getParameter("fullName"));
				u.setEmail(req.getParameter("email"));
				u.setPhone(req.getParameter("phone"));
				u.setAddress(req.getParameter("address"));
				u.setAadharNo(req.getParameter("aadhar"));
				u.setPanNo(req.getParameter("pan"));
				customerService.update(admin.getUserId(), u);
				resp.sendRedirect(req.getContextPath() + "/admin/customers?updated=1");
				break;

			case "/admin/customer/delete":
				int customerId = Integer.parseInt(req.getParameter("customerId"));
				customerService.delete(admin.getUserId(), customerId);
				resp.sendRedirect(req.getContextPath() + "/admin/customers?deleted=1");
				break;

			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLIntegrityConstraintViolationException e) {
			String errorMessage = "Duplicate entry detected. Please ensure username, email, phone, Aadhar, or PAN is unique.";
			if (e.getMessage().contains("username")) {
				errorMessage = "Username already exists.";
			} else if (e.getMessage().contains("email")) {
				errorMessage = "Email already exists.";
			} else if (e.getMessage().contains("phone")) {
				errorMessage = "Phone number already exists.";
			} else if (e.getMessage().contains("aadhar_no")) {
				errorMessage = "Aadhar number already exists.";
			} else if (e.getMessage().contains("pan_no")) {
				errorMessage = "PAN number already exists.";
			}
			req.setAttribute(Constants.ATTR_ERRORS, errorMessage);
			req.getRequestDispatcher("/manage_customers.jsp").forward(req, resp);
		} catch (SQLException e) {
			throw new ServletException("Database error while processing request", e);
		} catch (NumberFormatException e) {
			req.setAttribute(Constants.ATTR_ERRORS, "Invalid customer ID format");
			req.getRequestDispatcher("/manage_customers.jsp").forward(req, resp);
		} catch (IllegalArgumentException e) {
			req.setAttribute(Constants.ATTR_ERRORS, e.getMessage());
			req.getRequestDispatcher("/manage_customers.jsp").forward(req, resp);
		}
	}
}