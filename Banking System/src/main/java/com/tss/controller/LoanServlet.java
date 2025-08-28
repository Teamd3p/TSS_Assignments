package com.tss.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.User;
import com.tss.service.LoanService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/loan/apply", "/loan/approve", "/loan/reject", "/loan/repay" })
public class LoanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final LoanService loanService = new LoanService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		User u = (User) req.getSession().getAttribute(Constants.SESSION_USER);
		if (u == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}
		try {
			switch (path) {
			case "/loan/apply":
				int customerId = Integer.parseInt(req.getParameter("customerId"));
				int accountId = Integer.parseInt(req.getParameter("accountId")); // ✅ NEW
				String type = req.getParameter("loanType");
				BigDecimal amount = new BigDecimal(req.getParameter("amount"));
				BigDecimal rate = new BigDecimal(req.getParameter("interestRate"));
				int tenure = Integer.parseInt(req.getParameter("tenureMonths"));

				loanService.applyLoan(u.getUserId(), customerId, accountId, type, amount, rate, tenure);

				resp.sendRedirect(req.getContextPath() + "/loan_status.jsp?applied=1");
				break;
			case "/loan/approve":
				int loanIdA = Integer.parseInt(req.getParameter("loanId"));
				loanService.approveLoan(u.getUserId(), loanIdA);
				resp.sendRedirect(req.getContextPath() + "/loan_approval.jsp?approved=1");
				break;
			case "/loan/reject":
				int loanIdR = Integer.parseInt(req.getParameter("loanId"));
				loanService.rejectLoan(u.getUserId(), loanIdR);
				resp.sendRedirect(req.getContextPath() + "/loan_approval.jsp?rejected=1");
				break;
			case "/loan/repay":
				int loanIdP = Integer.parseInt(req.getParameter("loanId"));
				BigDecimal pay = new BigDecimal(req.getParameter("amount"));
				loanService.repay(u.getUserId(), loanIdP, pay);
				resp.sendRedirect(req.getContextPath() + "/repay_loan.jsp?success=1");
				break;
			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLException e) {
			throw new ServletException(e);
		}
	}
}
