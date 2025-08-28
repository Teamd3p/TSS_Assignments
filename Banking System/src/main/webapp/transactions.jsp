<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions - VaultCore</title>
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
        
        h3, h4, h5 {
            font-weight: 600;
            color: #f9fafb;
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
        
        /* Forms */
        .form-control, .form-select {
            border-radius: 8px;
            background: #0f172a;
            border: 1px solid #334155;
            color: #e2e8f0;
            box-shadow: none;
        }
        .form-control::placeholder { color: #64748b; }
        .form-control:focus, .form-select:focus {
            border-color: #a78bfa;
            box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
            background: #1e2b3b;
            color: #f1f5f9;
        }
        
        /* Buttons */
        .btn {
            border-radius: 8px;
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-primary { background: linear-gradient(135deg, #a78bfa, #6d28d9); color: #fff; }
        .btn-success { background-color: #10b981; border-color: #10b981; color: #fff;}
        .btn-warning { background-color: #f97316; border-color: #f97316; color: #fff;}
        .btn-danger { background-color: #ef4444; border-color: #ef4444; color: #fff;}
        .btn-secondary { background-color: #64748b; border-color: #64748b; color: #fff;}
        .btn-outline-primary { color: #a78bfa; border-color: #a78bfa; }
        .btn-outline-primary:hover { background-color: #a78bfa; color: #1a202c; }
        .btn-outline-secondary { color: #94a3b8; border-color: #94a3b8; }
        .btn-outline-secondary:hover { background-color: #94a3b8; color: #1a202c; }

        /* Alerts */
        .alert { border-radius: 10px; border: none; color: white; }
        .alert-success { background-color: #10b981; }
        .alert-danger { background-color: #ef4444; }
        .alert-warning { background-color: #f97316; }

        /* Table */
        .table { background-color: #1e2b3b; color: #e2e8f0; }
        .table thead { background: #334155; color: #f1f5f9; }
        .table-hover tbody tr:hover { background: rgba(148, 163, 184, 0.1); }
        .table td, .table th { border-top: 1px solid #334155; }
        .table-striped > tbody > tr:nth-of-type(odd) > * {
            background-color: rgba(255, 255, 255, 0.03);
            color: #e2e8f0;
        }

        /* Modal Styling */
        .modal-content {
            background: #1e2b3b;
            border: 1px solid #334155;
            color: #e2e8f0;
            border-radius: 16px;
        }
        .modal-header {
            background: rgba(15, 23, 42, 0.8);
            border-bottom: 1px solid #334155;
            color: #f9fafb;
        }
        .modal-header .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        .modal-footer {
            border-top: 1px solid #334155;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex flex-grow-1">
        <c:choose>
            <c:when test="${sessionScope.currentUser.role eq 'ADMIN'}">
                <%@ include file="includes/admin_sidebar.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="includes/sidebar.jsp" %>
            </c:otherwise>
        </c:choose>

        <main class="flex-grow-1 p-4">
            <div class="container-fluid">
                <h3 class="mb-4 text-primary"><i class="fas fa-list me-2"></i>Transactions</h3>
                <div class="card shadow-sm">
                    <div class="card-header text-white">
                        <h5 class="mb-0"><i class="fas fa-history me-2 text-primary"></i>Transaction History</h5>
                    </div>
                    <div class="card-body">
                        <form class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/transactions">
                            <div class="col-md-4">
                                <label class="form-label">Account ID</label>
                                <input class="form-control" name="accountId"
                                       placeholder="Enter Account ID (optional)"
                                       pattern="^[0-9]+$" title="Numbers only">
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button class="btn btn-primary w-100" type="submit">
                                    <i class="fas fa-search me-2"></i>Filter
                                </button>
                            </div>
                        </form>

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <th>Account ID</th>
                                    <th>Date</th>
                                    <th>Type</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="transaction" items="${transactions}">
                                    <tr>
                                        <td>${transaction.transactionId}</td>
                                        <td>${transaction.accountId}</td>
                                        <td>${transaction.transactionDate}</td>
                                        <td>${transaction.type}</td>
                                        <td>${transaction.amount}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.currentUser.role eq 'ADMIN'}">
                        <a class="btn btn-outline-secondary mt-4" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-outline-secondary mt-4" href="${pageContext.request.contextPath}/customer/dashboard">
                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>