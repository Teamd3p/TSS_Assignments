package com.tss.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.dao.TransactionDAO;
import com.tss.model.User;
import com.tss.service.AccountService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/transactions" })
public class TransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final TransactionDAO transactionDAO = new TransactionDAO();
    private final AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute(Constants.SESSION_USER);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String accountIdStr = req.getParameter("accountId");

        try {
            if (Constants.ROLE_ADMIN.equals(user.getRole())) {
                // ADMIN: all transactions OR filtered
                if (accountIdStr != null && !accountIdStr.isEmpty()) {
                    int accountId = Integer.parseInt(accountIdStr);
                    req.setAttribute("transactions", transactionDAO.findByAccountId(accountId, 100));
                } else {
                    req.setAttribute("transactions", transactionDAO.findAll());
                }
            } else {
                // CUSTOMER: must pass their own account
                if (accountIdStr != null && !accountIdStr.isEmpty()) {
                    int accountId = Integer.parseInt(accountIdStr);
                    accountService.getAccount(accountId, user.getUserId()); // ownership check
                    req.setAttribute("transactions", transactionDAO.findByAccountId(accountId, 50));
                }
            }

            req.getRequestDispatcher("/transactions.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Failed to load transactions: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
