<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Overview - VaultCore</title>

    <!-- Google Fonts: Inter (Modern & Premium) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        :root {
            --bg-primary: #f9fafb;
            --text-primary: #111827;
            --text-secondary: #4b5563;
            --card-bg: #ffffff;
            --border-light: #e5e7eb;
            --accent-primary: #4f46e5;
            --accent-success: #10b981;
            --accent-warning: #f59e0b;
            --accent-danger: #ef4444;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.08);
            --shadow-hover: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        body {
            background-color: var(--bg-primary);
            color: var(--text-secondary);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        h3 {
            color: var(--text-primary);
            font-weight: 600;
        }

        /* Account Card */
        .account-card {
            background: var(--card-bg);
            border: 1px solid var(--border-light);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .account-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-hover);
        }

        .account-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--accent-primary);
            border-radius: 4px 0 0 4px;
        }

        .account-icon {
            font-size: 2rem;
            color: var(--accent-primary);
        }

        .account-number {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .account-meta {
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .account-balance {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        /* Status Badge */
        .status-badge {
            font-size: 0.85rem;
            font-weight: 600;
            padding: 0.4em 0.8em;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--accent-success);
        }

        .status-closed {
            background-color: rgba(100, 116, 139, 0.15);
            color: #64748b;
        }

        .status-blocked {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--accent-danger);
        }

        .status-pending {
            background-color: rgba(245, 158, 11, 0.15);
            color: var(--accent-warning);
        }

        /* Back Button */
        .btn-back {
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-back:hover {
            background-color: #4b5563;
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .account-card {
                padding: 1.2rem;
            }
            .account-number {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="includes/header.jsp" %>

    <div class="d-flex flex-grow-1">
        <%@ include file="includes/sidebar.jsp" %>

        <main class="flex-grow-1 p-4">
            <div class="container-fluid">

                <!-- Page Header -->
                <h3 class="mb-4">
                    <i class="fas fa-university me-2 text-primary"></i>Account Overview
                </h3>

                <!-- No Accounts Message -->
                <c:if test="${empty accounts}">
                    <div class="alert alert-info d-flex align-items-center" role="alert">
                        <i class="fas fa-info-circle me-3 fs-4"></i>
                        <div>
                            <strong>No accounts found.</strong> Please open an account to get started.
                        </div>
                    </div>
                </c:if>

                <!-- Accounts Grid -->
                <c:if test="${not empty accounts}">
                    <div class="row g-4">
                        <c:forEach var="acc" items="${accounts}">
                            <div class="col-md-4">
                                <div class="account-card shadow-sm">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="account-icon fas fa-building-columns"></i>
                                        <h5 class="ms-3 mb-0 account-number">${acc.accountNumber}</h5>
                                    </div>
                                    <p class="account-meta mb-2">
                                        <i class="fas fa-id-badge me-1"></i> ID: ${acc.accountId}
                                    </p>
                                    <p class="account-balance mb-2">
                                        <i class="fas fa-rupee-sign me-1"></i> ₹${acc.balance}
                                    </p>
                                    <p class="mb-2">
                                        <strong>Type:</strong> 
                                        <span class="text-capitalize">${acc.accountType.toLowerCase()}</span>
                                    </p>
                                    <p class="mb-0">
                                        <strong>Status:</strong>
                                        <span class="status-badge 
                                            ${acc.status == 'ACTIVE' ? 'status-active' : 
                                              acc.status == 'CLOSED' ? 'status-closed' : 
                                              acc.status == 'BLOCKED' ? 'status-blocked' : 
                                              'status-pending'}">
                                            ${acc.status}
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Back Button -->
                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/accounts" class="btn btn-outline-secondary btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back to Accounts
                    </a>
                </div>
            </div>
        </main>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>