package com.tss.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tss.model.Report;
import com.tss.service.AdminService;

@WebServlet(urlPatterns = { "/admin/dashboard", "/admin/customers", "/admin/accounts", "/admin/transactions",
		"/admin/loans", "/admin/complaints", "/admin/logs", "/admin/reports", "/admin/reports/download" })
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AdminService adminService = new AdminService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();

		try {
			switch (path) {
			case "/admin/dashboard":
				req.setAttribute("summary", adminService.getDashboardSummary());
				req.getRequestDispatcher("/admin_dashboard.jsp").forward(req, resp);
				break;
			case "/admin/customers":
				req.setAttribute("customers", adminService.getAllCustomers());
				req.getRequestDispatcher("/manage_customers.jsp").forward(req, resp);
				break;
			case "/admin/accounts":
				req.setAttribute("accounts", adminService.getAllAccounts());
				req.getRequestDispatcher("/manage_accounts.jsp").forward(req, resp);
				break;
			case "/admin/transactions":
				req.setAttribute("transactions", adminService.getAllTransactions());
				req.getRequestDispatcher("/transactions.jsp").forward(req, resp);
				break;
			case "/admin/loans":
				req.setAttribute("loans", adminService.getAllLoans());
				req.getRequestDispatcher("/loan_approval.jsp").forward(req, resp);
				break;
			case "/admin/complaints":
				req.setAttribute("complaints", adminService.getAllComplaints());
				req.getRequestDispatcher("/manage_complaints.jsp").forward(req, resp);
				break;
			case "/admin/logs":
				req.setAttribute("logs", adminService.getRecentActivityLogs(200));
				req.getRequestDispatcher("/logs.jsp").forward(req, resp);
				break;
			case "/admin/reports":
				// Just show the report page
				req.getRequestDispatcher("/reports.jsp").forward(req, resp);
				break;
			case "/admin/reports/download":
				handleReportDownload(req, resp);
				break;
			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (Exception e) {
			throw new ServletException("Error in AdminServlet [" + path + "]: " + e.getMessage(), e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();

		try {
			switch (path) {
			case "/admin/reports":
				String reportType = req.getParameter("reportType");
				String date = req.getParameter("date");

				if (reportType != null && date != null && !reportType.isEmpty()) {
					Report report = adminService.generateReport(reportType, date);
					req.setAttribute("report", report);
				} else {
					req.setAttribute("error", "Please select a report type and date.");
				}
				req.getRequestDispatcher("/reports.jsp").forward(req, resp);
				break;
			default:
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (Exception e) {
			req.setAttribute("error", "Error generating report: " + e.getMessage());
			req.getRequestDispatcher("/reports.jsp").forward(req, resp);
		}
	}

	private void handleReportDownload(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String reportType = req.getParameter("reportType");
		String date = req.getParameter("date");
		Report report = adminService.generateReport(reportType, date);

		// For now, return a simple text PDF (instead of LaTeX, which requires latexmk
		// installed)
		resp.setContentType("application/pdf");
		resp.setHeader("Content-Disposition", "attachment; filename=report_" + date + ".pdf");

		try (var out = resp.getOutputStream()) {
			// Minimal PDF content
			String pdfContent = "%PDF-1.4\n1 0 obj <<>> endobj\ntrailer <<>>\n%%EOF";
			out.write(pdfContent.getBytes());
			out.flush();
		}
	}
}
