package com.tss.service;

import java.sql.SQLException;
import java.util.List;

import com.tss.dao.ActivityLogDAO;
import com.tss.dao.ComplaintDAO;
import com.tss.dao.CustomerDAO;
import com.tss.exception.ComplaintNotFoundException;
import com.tss.model.ActivityLog;
import com.tss.model.Complaint;
import com.tss.model.Customer;

public class ComplaintService {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();
    private final ActivityLogDAO logDAO = new ActivityLogDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    /**
     * Create complaint for the logged-in user. We must resolve the customer's
     * primary key (customer_id) from the user's id to satisfy the FK:
     * complaints.customer_id -> customers.customer_id
     */
    public int createComplaint(int userId, String subject, String message) throws SQLException {
        // Resolve the customer by user id
        Customer customer = customerDAO.findByUserId(userId);
        if (customer == null) {
            throw new SQLException("Customer record not found for userId=" + userId);
        }

        Complaint c = new Complaint();
        c.setCustomerId(customer.getCustomerId());
        c.setSubject(subject);
        c.setMessage(message);
        c.setStatus("OPEN");

        int id = complaintDAO.create(c);
        log(userId, "Complaint raised #" + id + ": " + subject);
        return id;
    }

    public void updateStatus(int userId, int complaintId, String status) throws SQLException {
        ensureExists(complaintId);
        complaintDAO.updateStatus(complaintId, status);
        log(userId, "Complaint #" + complaintId + " status updated to " + status);
    }

    public Complaint get(int complaintId) throws SQLException {
        Complaint c = complaintDAO.findById(complaintId);
        if (c == null) throw new ComplaintNotFoundException("Complaint not found");
        return c;
    }

    public List<Complaint> findByCustomer(int customerId) throws SQLException {
        return complaintDAO.findByCustomerId(customerId);
    }

    /**
     * Convenience for controllers that only have userId available.
     */
    public List<Complaint> findByCustomerUserId(int userId) throws SQLException {
        Customer customer = customerDAO.findByUserId(userId);
        if (customer == null) {
            // Return empty list instead of throwing to keep page stable
            return java.util.Collections.emptyList();
        }
        return complaintDAO.findByCustomerId(customer.getCustomerId());
    }

    public List<Complaint> findAll() throws SQLException {
        return complaintDAO.findAll();
    }

    private void ensureExists(int id) throws SQLException {
        if (complaintDAO.findById(id) == null) {
            throw new ComplaintNotFoundException("Complaint not found");
        }
    }

    private void log(int userId, String action) {
        try {
            ActivityLog l = new ActivityLog();
            l.setUserId(userId);
            l.setAction(action);
            logDAO.create(l);
        } catch (SQLException ignored) { }
    }
}
