<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        /* --- VaultCore Premium Purple Theme --- */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #0f172a, #1e2b3b);
            min-height: 100vh;
            color: #e2e8f0;
        }
        .text-primary { color: #a78bfa !important; }
        h3, h4, h5 { font-weight: 600; color: #f9fafb; }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 16px;
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            color: #e2e8f0;
        }
        .card-header {
            border-radius: 16px 16px 0 0;
            background: rgba(15, 23, 42, 0.8);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        /* Forms */
        .form-control, .form-select {
            border-radius: 8px;
            background: #0f172a;
            border: 1px solid #334155;
            color: #e2e8f0;
            box-shadow: none;
        }
        .form-control:focus, .form-select:focus {
            border-color: #a78bfa;
            box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
            background: #1e2b3b;
        }
        .was-validated .form-control:invalid, .form-control.is-invalid {
            border-color: #ef4444;
        }
        .invalid-feedback {
            display: none;
            color: #fecaca;
        }
        .was-validated .form-control:invalid ~ .invalid-feedback,
        .was-validated .form-select:invalid ~ .invalid-feedback {
            display: block;
        }
        
        /* Custom Dropdown Arrow */
        .form-select { -webkit-appearance: none; appearance: none; background-image: none; }
        .custom-select-wrapper { position: relative; }
        .custom-select-wrapper .select-arrow {
            position: absolute; top: 50%; right: 15px;
            transform: translateY(-50%); pointer-events: none; color: #a78bfa;
        }
        
        /* Buttons */
        .btn { border-radius: 8px; transition: transform 0.2s; border: none; }
        .btn:hover { transform: translateY(-2px); }
        .btn-primary { background: linear-gradient(135deg, #a78bfa, #6d28d9); color: #fff; }
        .btn-success { background-color: #10b981; color: #fff; }
        .btn-outline-secondary { color: #94a3b8; border-color: #94a3b8; }
        .btn-outline-secondary:hover { background-color: #94a3b8; color: #1a202c; }

        /* Chart & Loading Spinner */
        .chart-container { max-width: 600px; margin: 20px auto; }
        .loading {
            display: none; position: fixed; top: 50%; left: 50%;
            transform: translate(-50%, -50%); z-index: 1000;
            background: rgba(30, 41, 59, 0.9);
            padding: 20px; border-radius: 10px; color: #e2e8f0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<%@ include file="includes/header.jsp" %>
<div class="d-flex">
    <%@ include file="includes/admin_sidebar.jsp" %>
    <main class="flex-grow-1 p-4">
        <div class="container-fluid">
            <h3 class="mb-4 text-primary"><i class="fas fa-chart-bar me-2"></i>Reports</h3>

            <div class="card shadow-sm">
                <div class="card-header text-white">
                    <h5 class="mb-0"><i class="fas fa-file-alt me-2 text-primary"></i>Generate Report</h5>
                </div>
                <div class="card-body">
                    <form class="row g-3" id="reportForm" method="post" action="${pageContext.request.contextPath}/admin/reports" novalidate>
                        <div class="col-md-4">
                            <label class="form-label">Report Type</label>
                            <div class="custom-select-wrapper">
                                <select class="form-select" name="reportType" required>
                                    <option value="" disabled selected>Select Type</option>
                                    <option value="MONTHLY">Monthly</option>
                                    <option value="ANNUAL">Annual</option>
                                </select>
                                <i class="fas fa-chevron-down select-arrow"></i>
                            </div>
                            <div class="invalid-feedback">Please select a report type.</div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Date</label>
                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" var="today"/>
                            <input class="form-control" type="date" name="date" id="reportDate" required max="${today}">
                            <div class="invalid-feedback">Please select a valid date.</div>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button class="btn btn-primary w-100" type="submit" id="generateBtn">
                                <i class="fas fa-download me-2"></i>Generate
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <c:if test="${not empty report}">
                <div class="card shadow-sm mt-4">
                    <div class="card-header text-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Generated Report</h5>
                        <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/admin/reports/download?date=${param.date}&reportType=${param.reportType}">
                            <i class="fas fa-file-pdf me-2"></i>Download PDF
                        </a>
                    </div>
                    <div class="card-body">
                        <p><strong>Total Transactions:</strong> ${report.totalTransactions}</p>
                        <p><strong>Total Amount:</strong> <fmt:formatNumber value="${report.totalAmount}" type="currency" currencySymbol="₹" /></p>
                        <p><strong>Date Range:</strong> ${report.dateRange}</p>
                        <p><strong>Deposits:</strong> ${report.deposits} (<fmt:formatNumber value="${report.depositAmount}" type="currency" currencySymbol="₹" />)</p>
                        <p><strong>Withdrawals:</strong> ${report.withdrawals} (<fmt:formatNumber value="${report.withdrawalAmount}" type="currency" currencySymbol="₹" />)</p>
                        <p><strong>Transfers:</strong> ${report.transfers} (<fmt:formatNumber value="${report.transferAmount}" type="currency" currencySymbol="₹" />)</p>
                        <div class="chart-container">
                            <canvas id="transactionChart"></canvas>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-4">${error}</div>
            </c:if>

            <a class="btn btn-outline-secondary mt-4" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </main>
</div>

<%@ include file="includes/footer.jsp" %>

<div class="loading text-center" id="loading">
    <i class="fas fa-spinner fa-spin fa-3x"></i><br>Generating Report...
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Form validation
    (function() {
        'use strict';
        const form = document.getElementById('reportForm');
        form.addEventListener('submit', function(event) {
            const loading = document.getElementById('loading');
            const generateBtn = document.getElementById('generateBtn');
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                loading.style.display = 'block';
                generateBtn.disabled = true;
            }
            form.classList.add('was-validated');
        }, false);
    })();

    // Chart initialization
    <c:if test="${not empty report}">
    const chartTextColor = '#f1f5f9';
    const chartGridColor = 'rgba(255, 255, 255, 0.1)';

    new Chart(document.getElementById('transactionChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: ['Deposits', 'Withdrawals', 'Transfers'],
            datasets: [{
                label: 'Transaction Amount (₹)',
                data: [
                    ${report.depositAmount},
                    ${report.withdrawalAmount},
                    ${report.transferAmount}
                ],
                backgroundColor: ['#10b981', '#ef4444', '#a78bfa'],
                borderWidth: 1,
                borderColor: '#1e2b3b',
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { 
                legend: { 
                    position: 'top',
                    labels: { color: chartTextColor }
                }, 
                tooltip: { 
                    enabled: true,
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    titleColor: '#fff',
                    bodyColor: '#fff'
                } 
            },
            scales: { 
                y: { 
                    beginAtZero: true, 
                    title: { display: true, text: 'Amount (₹)', color: chartTextColor },
                    ticks: { color: chartTextColor },
                    grid: { color: chartGridColor }
                },
                x: {
                    ticks: { color: chartTextColor },
                    grid: { display: false }
                }
            }
        }
    });
    </c:if>
</script>
</body>
</html>