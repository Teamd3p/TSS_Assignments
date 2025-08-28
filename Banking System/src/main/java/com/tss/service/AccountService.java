package com.tss.service;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.tss.dao.AccountDAO;
import com.tss.dao.ActivityLogDAO;
import com.tss.dao.TransactionDAO;
import com.tss.database.DBConnection;
import com.tss.exception.AccountNotFoundException;
import com.tss.exception.InsufficientBalanceException;
import com.tss.model.Account;
import com.tss.model.ActivityLog;
import com.tss.model.Customer;
import com.tss.model.Transaction;

public class AccountService {
    private final CustomerService customerService = new CustomerService();
    private final AccountDAO accountDAO = new AccountDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();
    private final ActivityLogDAO logDAO = new ActivityLogDAO();

    public int openAccount(int customerId, String accountType) throws SQLException { // Removed accountNumber parameter
        Account a = new Account();
        a.setCustomerId(customerId);
        a.setAccountType(accountType);
        a.setBalance(BigDecimal.ZERO);
        a.setStatus("ACTIVE");
        // Generate unique account number (e.g., customerId + timestamp)
        String generatedAccountNumber = generateAccountNumber(customerId);
        a.setAccountNumber(generatedAccountNumber);
        int accountId = accountDAO.create(a);
        if (accountId == 0) throw new SQLException("Failed to create account");
        log(customerId, "Opened account " + generatedAccountNumber);
        return accountId;
    }

    private String generateAccountNumber(int customerId) {
        // Example: customerId + current timestamp (YYYYMMDDHHMMSS)
        String timestamp = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", new Date());
        return timestamp;
    }

    public void deposit(int userId, int accountId, BigDecimal amount) throws SQLException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Account acc = accountDAO.findByIdForUpdate(conn, accountId);
                if (acc == null) throw new AccountNotFoundException("Account not found");
                BigDecimal newBalance = acc.getBalance().add(amount);
                accountDAO.updateBalance(conn, accountId, newBalance);
                Transaction t = new Transaction();
                t.setAccountId(accountId);
                t.setType("DEPOSIT");
                t.setAmount(amount);
                t.setStatus("SUCCESS");
                transactionDAO.create(conn, t);
                conn.commit();
                log(userId, "Deposit into account " + acc.getAccountNumber() + ": " + amount);
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public void withdraw(int userId, int accountId, BigDecimal amount) throws SQLException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Account acc = accountDAO.findByIdForUpdate(conn, accountId);
                if (acc == null) throw new AccountNotFoundException("Account not found");
                if (acc.getBalance().compareTo(amount) < 0) {
                    throw new InsufficientBalanceException("Insufficient balance");
                }
                BigDecimal newBalance = acc.getBalance().subtract(amount);
                accountDAO.updateBalance(conn, accountId, newBalance);
                Transaction t = new Transaction();
                t.setAccountId(accountId);
                t.setType("WITHDRAW");
                t.setAmount(amount);
                t.setStatus("SUCCESS");
                transactionDAO.create(conn, t);
                conn.commit();
                log(userId, "Withdraw from account " + acc.getAccountNumber() + ": " + amount);
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public void transfer(int userId, int fromAccountId, String toAccountNumber, BigDecimal amount) throws SQLException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Account from = accountDAO.findByIdForUpdate(conn, fromAccountId);
                if (from == null) throw new AccountNotFoundException("Source account not found");
                Account to = accountDAO.findByAccountNumberForUpdate(conn, toAccountNumber);
                if (to == null) throw new AccountNotFoundException("Destination account not found");
                if (from.getBalance().compareTo(amount) < 0) {
                    throw new InsufficientBalanceException("Insufficient balance");
                }
                accountDAO.updateBalance(conn, from.getAccountId(), from.getBalance().subtract(amount));
                accountDAO.updateBalance(conn, to.getAccountId(), to.getBalance().add(amount));
                Transaction t1 = new Transaction();
                t1.setAccountId(from.getAccountId());
                t1.setType("TRANSFER");
                t1.setAmount(amount);
                t1.setStatus("SUCCESS");
                t1.setReferenceAccount(to.getAccountNumber());
                transactionDAO.create(conn, t1);

                Transaction t2 = new Transaction();
                t2.setAccountId(to.getAccountId());
                t2.setType("DEPOSIT");
                t2.setAmount(amount);
                t2.setStatus("SUCCESS");
                t2.setReferenceAccount(from.getAccountNumber());
                transactionDAO.create(conn, t2);

                conn.commit();
                log(userId, "Transfer from " + from.getAccountNumber() + " to " + to.getAccountNumber() + ": " + amount);
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public Account getAccount(int accountId, int userId) throws SQLException {
        Account acc = accountDAO.findById(accountId);
        if (acc == null) throw new AccountNotFoundException("Account not found");
        Customer customer = customerService.getByUserId(userId);
        if (customer == null || customer.getCustomerId() != acc.getCustomerId()) {
            throw new IllegalArgumentException("Access denied: Account does not belong to you");
        }
        return acc;
    }

    public List<Account> getAccountsByCustomer(int customerId) throws SQLException {
        List<Account> accounts = accountDAO.findByCustomerId(customerId);
        System.out.println("AccountService: Fetched " + accounts.size() + " accounts for customerId: " + customerId);
        return accounts;
    }

    public void log(int userId, String action) {
        try {
            ActivityLog l = new ActivityLog();
            l.setUserId(userId);
            l.setAction(action);
            logDAO.create(l);
        } catch (SQLException ignored) {
        }
    }
}