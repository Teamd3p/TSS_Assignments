package com.tss.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.User;
import com.tss.service.LoanService;
import com.tss.util.Constants;

@WebServlet("/admin/loan/update-status")
public class AdminLoanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final LoanService loanService = new LoanService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int loanId = Integer.parseInt(req.getParameter("loanId"));
			String status = req.getParameter("status");
			User u = (User) req.getSession().getAttribute(Constants.SESSION_USER);

			loanService.updateStatus(u.getUserId(), loanId, status);

			resp.sendRedirect(req.getContextPath() + "/admin/loans?updated=1");
		} catch (Exception e) {
			req.setAttribute("errors", "Error: " + e.getMessage());
			req.getRequestDispatcher("/loan_approval.jsp").forward(req, resp);
		}
	}
}
