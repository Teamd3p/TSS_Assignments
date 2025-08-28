<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - VaultCore</title>

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

        /* General styles for text and icons */
        .text-primary, .text-purple { color: #a78bfa !important; }
        .text-warning { color: #f97316 !important; }
        .text-info { color: #22d3ee !important; }
        .text-success { color: #10b981 !important; }
        .text-danger { color: #ef4444 !important; }
        
        /* Headings & Section Title */
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
            background: linear-gradient(145deg, #2d3340, #1f232d);
            border: 1px solid #3a3f4f;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 8px 15px rgba(0,0,0,0.4);
        }
        .summary-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.55);
        }
        .summary-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .bg-gradient-primary .summary-icon { color: #a78bfa; }
        .bg-gradient-success .summary-icon { color: #34d399; }

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

        /* Accordion */
        .accordion {
            --bs-accordion-bg: #1f242d;
            --bs-accordion-color: #e2e8f0;
            --bs-accordion-border-color: #3a3f4f;
            --bs-accordion-border-radius: 12px;
            --bs-accordion-btn-color: #d1d5db;
            --bs-accordion-btn-focus-box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.4);
            --bs-accordion-active-bg: linear-gradient(135deg, #a78bfa, #6d28d9);
            --bs-accordion-active-color: #ffffff;
        }
        .accordion-button { font-weight: 500; }
        .accordion-body { background-color: #1a202c; font-size: 0.95rem; }

        /* Timeline */
        .timeline { list-style: none; padding-left: 1.5rem; }
        .timeline li { position: relative; padding-bottom: 1rem; }
        .timeline li::before {
            content: '';
            position: absolute;
            left: -1.2rem;
            top: 0.4rem;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #a78bfa;
        }
        .timeline li:not(:last-child)::after {
            content: '';
            position: absolute;
            left: -0.95rem;
            top: 1rem;
            bottom: 0;
            width: 2px;
            background-color: #3a3f4f;
        }

        /* Achievements */
        .achievement-item {
            background: #1f232d;
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #3a3f4f;
            box-shadow: 0 5px 12px rgba(0,0,0,0.35);
        }
        .achievement-item i { font-size: 1.7rem; color: #34d399; margin-bottom: 0.5rem; }
        .achievement-item span { font-weight: 500; }
        .achievement-item small { color: #9ca3af; margin-top: 0.25rem; display: block; }

        /* Bank Stats */
        .bank-stats { list-style: none; padding: 0; }
        .bank-stats li { display: flex; align-items: center; padding: 0.6rem 0; }
        .bank-stats i { color: #a78bfa; margin-right: 0.75rem; width: 20px; text-align: center; }

        /* Logout Button */
        .btn-outline-danger {
            color: #ef4444;
            border-color: #ef4444;
        }
        .btn-outline-danger:hover {
            background-color: #ef4444;
            color: white;
        }
    </style>
</head>
<body>

<%@ include file="includes/header.jsp" %>

<div class="d-flex">
    <%@ include file="includes/sidebar.jsp" %>

    <main class="flex-grow-1 p-4">
        <div class="container-fluid">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3>
                    <i class="fas fa-chart-pie me-2" style="color: #a78bfa;"></i>
                    VaultCore Dashboard
                </h3>
                <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-power-off me-2"></i>Logout
                </a>
            </div>

            <h4 class="section-title">Account Summary</h4>
            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <div class="card bg-gradient-primary summary-card text-center">
                        <div class="card-body">
                            <i class="fas fa-wallet summary-icon"></i>
                            <h5 class="card-title">Number of Accounts</h5>
                            <h2 class="mb-0"><c:out value="${accountCount}" default="0"/></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card bg-gradient-success summary-card text-center">
                        <div class="card-body">
                            <i class="fas fa-sack-dollar summary-icon"></i>
                            <h5 class="card-title">Total Balance</h5>
                            <h2 class="mb-0">
                                <fmt:formatNumber value="${totalBalance}" type="currency" currencySymbol="₹" maxFractionDigits="2" />
                            </h2>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>

</body>
</html>