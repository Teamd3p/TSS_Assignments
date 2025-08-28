package com.tss.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.Complaint;
import com.tss.model.User;
import com.tss.service.ComplaintService;
import com.tss.util.Constants;

@WebServlet(urlPatterns = { "/complaint", "/complaint/create", "/complaint/update-status" })
public class ComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ComplaintService complaintService = new ComplaintService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute(Constants.SESSION_USER);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Admins should use /admin/complaints (handled by AdminServlet)
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/complaints");
                return;
            }

            // Customers: show only their complaints
            List<Complaint> complaints = complaintService.findByCustomerUserId(user.getUserId());
            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("/complaints.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Failed to load complaints: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        User user = (User) req.getSession().getAttribute(Constants.SESSION_USER);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            switch (path) {
                case "/complaint/create": {
                    String subject = req.getParameter("subject");
                    String message = req.getParameter("message");

                    complaintService.createComplaint(user.getUserId(), subject, message);
                    resp.sendRedirect(req.getContextPath() + "/complaint?created=1");
                    break;
                }
                case "/complaint/update-status": {
                    int complaintId = Integer.parseInt(req.getParameter("complaintId"));
                    String status = req.getParameter("status");

                    // Only admins can update
                    if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                        complaintService.updateStatus(user.getUserId(), complaintId, status);
                        // ✅ Redirect back to the admin list page
                        resp.sendRedirect(req.getContextPath() + "/admin/complaints?updated=1");
                    } else {
                        resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized to update complaints");
                    }
                    break;
                }
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
