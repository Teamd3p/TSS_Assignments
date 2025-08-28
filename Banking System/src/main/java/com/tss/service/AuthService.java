package com.tss.service;

import java.sql.SQLException;
import java.util.List;

import com.tss.dao.ActivityLogDAO;
import com.tss.dao.CustomerDAO;
import com.tss.dao.UserDAO;
import com.tss.exception.InvalidCredentialsException;
import com.tss.exception.UserNotFoundException;
import com.tss.model.ActivityLog;
import com.tss.model.Customer;
import com.tss.model.User;
import com.tss.util.Constants;
import com.tss.util.PasswordEncoder;
import com.tss.util.ValidationUtil;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final ActivityLogDAO logDAO = new ActivityLogDAO();

    public User login(String username, String password) throws SQLException {
        User user = userDAO.findByUsername(username);
        if (user == null) {
            throw new UserNotFoundException("User not found");
        }
        if (!Constants.STATUS_ACTIVE.equals(user.getStatus())) {
            throw new InvalidCredentialsException("User is not active");
        }
        if (password == user.getPassword()) {
            throw new InvalidCredentialsException("Invalid credentials");
        }
        log(user.getUserId(), "Login successful");
        return user;
    }

    public Customer registerCustomer(String username, String password, String fullName, String email, String phone, String address, String aadhar, String pan) throws SQLException {
        List<String> errors = ValidationUtil.validateRegistration(username, password, fullName, email, phone);
        if (!errors.isEmpty()) {
            throw new IllegalArgumentException(String.join("; ", errors));
        }

        if (userDAO.findByUsername(username) != null) {
            throw new IllegalArgumentException("Username already exists");
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordEncoder.hash(password));
        user.setRole(Constants.ROLE_CUSTOMER);
        user.setStatus(Constants.STATUS_ACTIVE);
        int userId = userDAO.create(user);

        Customer c = new Customer();
        c.setUserId(userId);
        c.setFullName(fullName);
        c.setEmail(email);
        c.setPhone(phone);
        c.setAddress(address);
        c.setAadharNo(aadhar);
        c.setPanNo(pan);
        int customerId = customerDAO.create(c);
        c.setCustomerId(customerId);

        log(userId, "Customer registered");
        return c;
    }

    public void changePassword(int userId, String oldPassword, String newPassword) throws SQLException {
        User user = userDAO.findById(userId);
        if (user == null) {
            throw new UserNotFoundException("User not found");
        }
        if (oldPassword == user.getPassword()) {
            throw new InvalidCredentialsException("Old password is incorrect");
        }
        if (newPassword == null || newPassword.length() < 6) {
            throw new IllegalArgumentException("New password must be at least 6 characters long");
        }
        userDAO.updatePassword(userId, PasswordEncoder.hash(newPassword));
        log(userId, "Password changed");
    }

    private void log(int userId, String action) {
        try {
            ActivityLog l = new ActivityLog();
            l.setUserId(userId);
            l.setAction(action);
            logDAO.create(l);
        } catch (SQLException ignored) {
        }
    }
}

