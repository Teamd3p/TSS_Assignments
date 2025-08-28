package com.tss.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.dao.TransactionDAO;
import com.tss.model.User;
import com.tss.model.Customer;
import com.tss.service.AccountService;
import com.tss.service.CustomerService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/customer/statements" })
public class StatementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final TransactionDAO transactionDAO = new TransactionDAO();
    private final AccountService accountService = new AccountService();
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute(Constants.SESSION_USER);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // --- Resolve customerId for the logged-in user ---
            Customer sessionCustomer = (Customer) req.getSession().getAttribute(Constants.SESSION_CUSTOMER);
            Customer customer = sessionCustomer != null ? sessionCustomer : customerService.getByUserId(user.getUserId());
            if (customer == null) {
                req.setAttribute("error", "Customer not found for current user.");
                req.getRequestDispatcher("/statements.jsp").forward(req, resp);
                return;
            }

            int customerId = customer.getCustomerId();

            // --- Always load accounts for dropdown (by customerId) ---
            req.setAttribute("accounts", accountService.getAccountsByCustomer(customerId));

            // --- Show transactions only if user clicked "View Statements" ---
            String accountIdStr = req.getParameter("accountId");
            if (accountIdStr != null && !accountIdStr.isEmpty()) {
                int accountId = Integer.parseInt(accountIdStr);

                // Ownership check (throws if not owned)
                accountService.getAccount(accountId, user.getUserId());

                // Fetch latest 50 transactions
                req.setAttribute("transactions", transactionDAO.findByAccountId(accountId, 50));

                // Flags/values for JSP
                req.setAttribute("showTable", true);
                req.setAttribute("selectedAccountId", accountId);
            }

            req.getRequestDispatcher("/statements.jsp").forward(req, resp);

        } catch (NumberFormatException nfe) {
            req.setAttribute("error", "Invalid Account ID.");
            req.getRequestDispatcher("/statements.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Failed to load statements: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
