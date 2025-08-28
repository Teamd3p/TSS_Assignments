package com.tss.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tss.exception.InvalidCredentialsException;
import com.tss.model.Customer;
import com.tss.model.User;
import com.tss.service.AuthService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/login", "/logout", "/register", "/change-password" })
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AuthService authService = new AuthService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		if ("/logout".equals(path)) {
			HttpSession session = req.getSession(false);
			if (session != null)
				session.invalidate();
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}
		resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		try {
			switch (path) {
			case "/login":
				handleLogin(req, resp);
				break;
			case "/register":
				handleRegister(req, resp);
				break;
			case "/change-password":
				handleChangePassword(req, resp);
				break;
			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLException e) {
			throw new ServletException(e);
		} catch (InvalidCredentialsException | IllegalArgumentException ex) {
			req.setAttribute(Constants.ATTR_ERRORS, ex.getMessage());
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
	}

	private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		try {
			User user = authService.login(username, password);
			HttpSession session = req.getSession(true);
			session.setAttribute(Constants.SESSION_USER, user);
			session.setAttribute(Constants.ATTR_MESSAGE, "Login successful");

			if (Constants.ROLE_ADMIN.equals(user.getRole())) {
				resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
			} else {
				resp.sendRedirect(req.getContextPath() + "/customer/dashboard");
			}
		} catch (Exception e) {
			HttpSession session = req.getSession(true);
			session.setAttribute(Constants.ATTR_ERRORS, e.getMessage());
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
		}
	}

	private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String fullName = req.getParameter("fullName");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");
		String aadhar = req.getParameter("aadhar");
		String pan = req.getParameter("pan");

		try {
			@SuppressWarnings("unused")
			Customer c = authService.registerCustomer(username, password, fullName, email, phone, address, aadhar, pan);
			// Registration successful → redirect to login with success param
			resp.sendRedirect(req.getContextPath() + "/login.jsp?registered=1");
		} catch (Exception e) {
			// Forward back to register page with error
			req.setAttribute(Constants.ATTR_ERRORS, e.getMessage());
			try {
				req.getRequestDispatcher("/register.jsp").forward(req, resp);
			} catch (ServletException ex) {
				throw new IOException(ex);
			}
		}
	}

	private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		User current = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (current == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		String oldPass = req.getParameter("oldPassword");
		String newPass = req.getParameter("newPassword");

		try {
			authService.changePassword(current.getUserId(), oldPass, newPass);
			req.setAttribute(Constants.ATTR_MESSAGE, "Password changed successfully");
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
		} catch (Exception e) {
			req.setAttribute(Constants.ATTR_ERRORS, e.getMessage());
			try {
				req.getRequestDispatcher("/profile.jsp").forward(req, resp);
			} catch (ServletException ex) {
				throw new IOException(ex);
			}
		}
	}
}