<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Accounts - VaultCore</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

    <style>
        /* --- VaultCore Premium Purple Theme --- */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #0f172a, #1e2b3b); /* deep dark gradient */
            min-height: 100vh;
            color: #e2e8f0;
        }

        /* General styles for text and icons */
        .text-primary {
            color: #a78bfa !important;
        }
        .text-warning {
            color: #f97316 !important;
        }
        .text-info {
            color: #22d3ee !important;
        }
        .text-success {
            color: #10b981 !important;
        }
        
        /* Navbar */
        .navbar-brand {
            font-weight: 800;
            color: #a78bfa !important; /* light purple accent */
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #1e2b3b;
            border-right: 1px solid #334155;
            padding: 1rem;
            min-height: 100vh;
        }

        .sidebar .nav-link {
            color: #94a3b8;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background: linear-gradient(135deg, #a78bfa, #6d28d9); /* purple gradient */
            color: #ffffff;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 16px;
            background: rgba(30, 41, 59, 0.85); /* glass effect */
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            color: #e2e8f0;
        }

        .card-header {
            border-radius: 16px 16px 0 0;
            background: rgba(15, 23, 42, 0.8);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Buttons */
        .btn {
            border-radius: 8px;
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(167, 139, 250, 0.3); /* purple glow */
        }

        .btn-primary {
            background: linear-gradient(135deg, #a78bfa, #6d28d9); /* purple gradient */
            color: #fff;
        }
        
        .btn-outline-light {
            color: #e2e8f0;
            border-color: #e2e8f0;
        }
        .btn-outline-light:hover {
            background-color: #e2e8f0;
            color: #1a202c;
        }

        .btn-success {
            background-color: #10b981;
            color: #fff;
        }

        .btn-warning {
            background-color: #f97316;
            color: white;
        }

        .btn-info {
            background-color: #22d3ee;
            color: white;
        }

        /* Accordion */
        .accordion-button {
            border-radius: 8px !important;
            background: #1e2b3b;
            color: #e2e8f0;
        }

        .accordion-button:not(.collapsed) {
            background: linear-gradient(135deg, #a78bfa, #6d28d9);
            color: #ffffff;
        }
        
        .accordion-body {
            background: #1a202c;
            border: 1px solid #334155;
            border-radius: 0 0 12px 12px;
        }
        
        /* Alerts */
        .alert {
            border-radius: 12px;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(8px);
        }
        .alert-success {
            background-color: #10b981;
            color: #fff;
        }
        .alert-danger {
            background-color: #dc2626;
            color: #fff;
        }

        /* Forms */
        .form-control, .form-select {
            border-radius: 8px;
            background: #0f172a;
            border: 1px solid #334155;
            color: #e2e8f0;
            box-shadow: none;
            transition: border-color 0.2s;
        }
        .form-control::placeholder {
            color: #64748b;
        }

        .form-control:focus, .form-select:focus {
            border-color: #a78bfa;
            box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
            background: #1e2b3b;
            color: #f1f5f9;
        }
        .form-select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23a78bfa' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        }
        label {
            color: var(--text-secondary);
        }

        /* Badges */
        .badge {
            font-size: 0.8rem;
            padding: 0.4em 0.7em;
            border-radius: 6px;
        }
        .badge.bg-success { background-color: #10b981 !important; }
        .badge.bg-danger { background-color: #dc2626 !important; }
        .badge.bg-secondary { background-color: #64748b !important; }
        .badge.bg-warning { background-color: #f97316 !important; color: white !important; }
    </style>
</head>
<body class="bg-dark">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex">
        <%@ include file="includes/sidebar.jsp" %>

        <main class="flex-grow-1 p-4">
            <div class="container-fluid">

                <h3 class="mb-4 text-white">
                    <i class="fas fa-wallet me-2 text-primary"></i> My Accounts
                </h3>

                <c:if test="${param.opened == '1'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> Account opened successfully.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.success == '1'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> Transaction completed successfully.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card shadow-sm mb-5">
                    <div class="card-header text-white">
                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Your Accounts</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty accounts}">
                            <p class="text-center text-muted">You have no accounts yet. Open one below!</p>
                        </c:if>
                        <c:if test="${not empty accounts}">
                            <div class="row g-4">
                                <c:forEach var="acc" items="${accounts}">
                                    <div class="col-md-4">
                                        <div class="card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title mb-3">
                                                    <i class="fas fa-university me-2 text-primary"></i>Account #${acc.accountId}
                                                </h5>
                                                <p class="mb-1"><strong>Number:</strong> ${acc.accountNumber}</p>
                                                <p class="mb-1"><strong>Type:</strong> ${acc.accountType}</p>
                                                <p class="mb-1"><strong>Balance:</strong> ₹<span class="text-success">${acc.balance}</span></p>
                                                <p><strong>Status:</strong>
                                                    <c:choose>
                                                        <c:when test="${acc.status == 'ACTIVE'}">
                                                            <span class="badge bg-success">${acc.status}</span>
                                                        </c:when>
                                                        <c:when test="${acc.status == 'CLOSED'}">
                                                            <span class="badge bg-secondary">${acc.status}</span>
                                                        </c:when>
                                                        <c:when test="${acc.status == 'BLOCKED'}">
                                                            <span class="badge bg-danger">${acc.status}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning">${acc.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="accordion" id="accountActions">

                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#openAccountForm">
                                <i class="fas fa-plus-circle me-2 text-success"></i> Open New Account
                            </button>
                        </h2>
                        <div id="openAccountForm" class="accordion-collapse collapse" data-bs-parent="#accountActions">
                            <div class="accordion-body">
                                <form method="post" action="${pageContext.request.contextPath}/customer/open_account" class="row g-3">
                                    <div class="col-md-4">
                                        <label>Customer ID</label>
                                        <input type="text" class="form-control" name="customerId" value="${customer.customerId}" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Account Type</label>
                                        <select class="form-select" name="accountType" required>
                                            <option value="" selected disabled>-- Select Type --</option>
                                            <option value="SAVINGS">Savings</option>
                                            <option value="CURRENT">Current</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-plus me-2"></i>Open
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#depositForm">
                                <i class="fas fa-arrow-up me-2 text-success"></i> Deposit
                            </button>
                        </h2>
                        <div id="depositForm" class="accordion-collapse collapse" data-bs-parent="#accountActions">
                            <div class="accordion-body">
                                <form method="post" action="${pageContext.request.contextPath}/customer/deposit" class="row g-3">
                                    <div class="col-md-4">
                                        <label>Select Account</label>
                                        <select class="form-select" name="accountId" required>
                                            <option value="">-- Choose Account --</option>
                                            <c:forEach var="acc" items="${accounts}">
                                                <c:if test="${acc.status == 'ACTIVE'}">
                                                    <option value="${acc.accountId}">${acc.accountNumber} (₹${acc.balance})</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Amount</label>
                                        <input type="number" step="0.01" min="0.01" class="form-control" name="amount" placeholder="Enter amount" required>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-arrow-up me-2"></i>Deposit
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#withdrawForm">
                                <i class="fas fa-arrow-down me-2 text-warning"></i> Withdraw
                            </button>
                        </h2>
                        <div id="withdrawForm" class="accordion-collapse collapse" data-bs-parent="#accountActions">
                            <div class="accordion-body">
                                <form method="post" action="${pageContext.request.contextPath}/customer/withdraw" class="row g-3">
                                    <div class="col-md-4">
                                        <label>Select Account</label>
                                        <select class="form-select" name="accountId" required>
                                            <option value="">-- Choose Account --</option>
                                            <c:forEach var="acc" items="${accounts}">
                                                <c:if test="${acc.status == 'ACTIVE'}">
                                                    <option value="${acc.accountId}">${acc.accountNumber} (₹${acc.balance})</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Amount</label>
                                        <input type="number" step="0.01" min="0.01" class="form-control" name="amount" placeholder="Enter amount" required>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <button type="submit" class="btn btn-warning w-100 text-white">
                                            <i class="fas fa-arrow-down me-2"></i>Withdraw
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#transferForm">
                                <i class="fas fa-exchange-alt me-2 text-info"></i> Transfer
                            </button>
                        </h2>
                        <div id="transferForm" class="accordion-collapse collapse" data-bs-parent="#accountActions">
                            <div class="accordion-body">
                                <form method="post" action="${pageContext.request.contextPath}/customer/transfer" class="row g-3">
                                    <div class="col-md-3">
                                        <label>From Account</label>
                                        <select class="form-select" name="fromAccountId" required>
                                            <option value="">-- Select --</option>
                                            <c:forEach var="acc" items="${accounts}">
                                                <c:if test="${acc.status == 'ACTIVE'}">
                                                    <option value="${acc.accountId}">${acc.accountNumber}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label>To Account Number</label>
                                        <input type="text" class="form-control" name="toAccountNumber" placeholder="Recipient Number" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label>Amount</label>
                                        <input type="number" step="0.01" min="0.01" class="form-control" name="amount" placeholder="Enter amount" required>
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-info w-100 text-white">
                                            <i class="fas fa-paper-plane me-2"></i>Transfer
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-outline-light px-4">
                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>