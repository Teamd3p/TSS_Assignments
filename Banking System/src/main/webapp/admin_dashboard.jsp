<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <style>
        /* --- VaultCore Premium Purple Theme --- */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #0f172a, #1e2b3b);
            min-height: 100vh;
            color: #e2e8f0;
        }

        /* General styles for text and icons */
        .text-primary, .text-purple { color: #a78bfa !important; }
        .text-warning { color: #f97316 !important; }
        .text-info { color: #22d3ee !important; }
        .text-success { color: #10b981 !important; }
        .text-danger { color: #ef4444 !important; }
        
        h3, h4 {
            font-weight: 600;
            color: #f9fafb;
        }
        .section-title {
            font-size: 1.25rem;
            color: #a1a1aa;
            border-bottom: 2px solid #3a3f4f;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        /* Summary Cards */
        .summary-card {
            border-radius: 20px;
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            color: #e2e8f0;
            min-height: 150px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .summary-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.55);
        }

        /* Quick Action Buttons */
        .quick-action-btn {
            border-radius: 14px;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 0.85rem;
            min-height: 95px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: linear-gradient(145deg, #2c313d, #1f242d);
            color: #f1f1f1;
            box-shadow: 0 6px 12px rgba(0,0,0,0.35);
            transition: all 0.3s ease;
        }
        .quick-action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(167,139,250,0.4);
        }

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
        
        .chart-container {
            position: relative;
            height: 250px; /* Made charts slightly shorter to fit the new layout */
            width: 100%;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex flex-grow-1">
        <%@ include file="includes/admin_sidebar.jsp" %>
        <main class="flex-grow-1 p-4 bg-dark">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-tachometer-alt me-2 text-primary"></i>Admin Dashboard</h3>
                    <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/logout" aria-label="Logout">
                        <i class="fas fa-power-off me-2"></i>Logout
                    </a>
                </div>

                <h4 class="mb-3 text-white">Admin Summary</h4>
                <div class="row g-4 mb-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="card summary-card text-white">
                            <div class="card-body text-center">
                                <h6 class="card-title"><i class="fas fa-users me-2 text-primary"></i>Customers</h6>
                                <h3 class="card-text"><c:out value="${summary.customers != null ? summary.customers : 0}" /></h3>
                                <p class="text-white-50 mb-0">Active Users</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card summary-card text-white">
                            <div class="card-body text-center">
                                <h6 class="card-title"><i class="fas fa-wallet me-2 text-success"></i>Accounts</h6>
                                <h3 class="card-text"><c:out value="${summary.accounts != null ? summary.accounts : 0}" /></h3>
                                <p class="text-white-50 mb-0">Total Accounts</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card summary-card text-white">
                            <div class="card-body text-center">
                                <h6 class="card-title"><i class="fas fa-exchange-alt me-2 text-warning"></i>Transactions</h6>
                                <h3 class="card-text"><c:out value="${summary.transactions != null ? summary.transactions : 0}" /></h3>
                                <p class="text-white-50 mb-0">Recent Transactions</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card summary-card text-white">
                            <div class="card-body text-center">
                                <h6 class="card-title"><i class="fas fa-hand-holding-usd me-2 text-danger"></i>Loans</h6>
                                <h3 class="card-text"><c:out value="${summary.loans != null ? summary.loans : 0}" /></h3>
                                <p class="text-white-50 mb-0"><c:out value="${summary.pendingLoans != null ? summary.pendingLoans : 0}" /> Pending</p>
                            </div>
                        </div>
                    </div>
                </div>

                <h4 class="mt-5 mb-3 text-white">Analytics Overview</h4>
                <div class="card shadow-sm">
                    <div class="card-header text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i>Visual Insights</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-4">
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Customer Status</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="customerStatusChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Account Status</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="accountStatusChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Transaction Types</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="transactionTypeChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Loan Status</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="loanStatusChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Complaint Status</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="complaintStatusChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100">
                                    <div class="card-header text-white"><h6 class="mb-0">Daily Activity</h6></div>
                                    <div class="card-body chart-container">
                                        <canvas id="activityLogChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const chartTextColor = '#f1f5f9';
        const chartGridColor = 'rgba(255, 255, 255, 0.1)';

        const barChartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    enabled: true,
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: '#a78bfa',
                    borderWidth: 1
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { color: chartTextColor },
                    grid: { color: chartGridColor }
                },
                x: {
                    ticks: { color: chartTextColor },
                    grid: { display: false }
                }
            }
        };

        // Customer Status Chart
        new Chart(document.getElementById('customerStatusChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Active', 'Blocked'],
                datasets: [{
                    label: 'Customers',
                    data: [
                        ${summary.customers != null ? summary.customers : 0} - ${summary.blockedCustomers != null ? summary.blockedCustomers : 0},
                        ${summary.blockedCustomers != null ? summary.blockedCustomers : 0}
                    ],
                    backgroundColor: ['#a78bfa', '#ef4444'],
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });

        // Account Status Chart
        new Chart(document.getElementById('accountStatusChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Active', 'Closed', 'Blocked'],
                datasets: [{
                    label: 'Accounts',
                    data: [
                        ${summary.accounts != null ? summary.accounts : 0} - ${summary.closedAccounts != null ? summary.closedAccounts : 0} - ${summary.blockedAccounts != null ? summary.blockedAccounts : 0},
                        ${summary.closedAccounts != null ? summary.closedAccounts : 0},
                        ${summary.blockedAccounts != null ? summary.blockedAccounts : 0}
                    ],
                    backgroundColor: ['#a78bfa', '#64748b', '#ef4444'],
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });

        // Transaction Type Chart
        new Chart(document.getElementById('transactionTypeChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Deposit', 'Withdraw', 'Transfer'],
                datasets: [{
                    label: 'Transactions',
                    data: [
                        ${summary.deposits != null ? summary.deposits : 0},
                        ${summary.withdrawals != null ? summary.withdrawals : 0},
                        ${summary.transfers != null ? summary.transfers : 0}
                    ],
                    backgroundColor: ['#10b981', '#ef4444', '#a78bfa'],
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });

        // Loan Status Chart
        new Chart(document.getElementById('loanStatusChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Pending', 'Approved', 'Rejected', 'Closed'],
                datasets: [{
                    label: 'Loans',
                    data: [
                        ${summary.pendingLoans != null ? summary.pendingLoans : 0},
                        ${summary.approvedLoans != null ? summary.approvedLoans : 0},
                        ${summary.rejectedLoans != null ? summary.rejectedLoans : 0},
                        ${summary.closedLoans != null ? summary.closedLoans : 0}
                    ],
                    backgroundColor: ['#f97316', '#10b981', '#ef4444', '#64748b'],
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });

        // Complaint Status Chart
        new Chart(document.getElementById('complaintStatusChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Open', 'In Progress', 'Resolved'],
                datasets: [{
                    label: 'Complaints',
                    data: [
                        ${summary.openComplaints != null ? summary.openComplaints : 0},
                        ${summary.inProgressComplaints != null ? summary.inProgressComplaints : 0},
                        ${summary.resolvedComplaints != null ? summary.resolvedComplaints : 0}
                    ],
                    backgroundColor: ['#f97316', '#22d3ee', '#10b981'],
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });

        // Daily Activity Bar Chart
        new Chart(document.getElementById('activityLogChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['Today', 'Yesterday', 'Last 7 Days'],
                datasets: [{
                    label: 'Activities',
                    data: [
                        ${summary.todayActivities != null ? summary.todayActivities : 0},
                        ${summary.yesterdayActivities != null ? summary.yesterdayActivities : 0},
                        ${summary.weekActivities != null ? summary.weekActivities : 0}
                    ],
                    backgroundColor: '#a78bfa',
                    borderRadius: 5
                }]
            },
            options: barChartOptions
        });
    </script>
</body>
</html>