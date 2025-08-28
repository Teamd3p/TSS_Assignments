<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Statements - VaultCore</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet">
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
    
    .btn-outline-secondary {
        color: #94a3b8;
        border-color: #94a3b8;
    }

    .btn-outline-secondary:hover {
        background-color: #94a3b8;
        color: #1a202c;
    }

    /* Alerts */
    .alert {
        border-radius: 10px;
    }
    .alert-success {
        background-color: #10b981;
        color: #fff;
        border-color: #059669;
    }
    .alert-danger {
        background-color: #dc2626;
        color: #fff;
        border-color: #b91c1c;
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
        border-color: #a78bfa; /* purple focus ring */
        box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
        background: #1e2b3b;
        color: #f1f5f9;
    }

    .form-select {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23a78bfa' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 0.75rem center;
        background-size: 16px 12px;
    }

    /* Tables */
    .table {
        background-color: #1e2b3b;
        border-radius: 8px;
        overflow: hidden;
        color: #e2e8f0;
    }

    .table thead {
        background: #334155;
        color: #f1f5f9;
    }

    .table-hover tbody tr:hover {
        background: rgba(148, 163, 184, 0.1);
    }
    
    .table td, .table th {
        border-top: 1px solid #334155;
    }

    /* Badges */
    .badge {
        font-size: 0.8rem;
        padding: 0.4em 0.8em;
        font-weight: 600;
        border-radius: 9999px;
    }
    
    /* Custom Badge Styles for Theme */
    .badge.text-bg-success {
        background-color: rgba(22, 163, 74, 0.3);
        color: #a7f3d0;
    }
    .badge.text-bg-warning {
        background-color: rgba(202, 138, 4, 0.3);
        color: #fef08a;
    }
    .badge.text-bg-danger {
        background-color: rgba(220, 38, 38, 0.3);
        color: #fecaca;
    }
    .badge.text-bg-secondary {
        background-color: rgba(100, 116, 139, 0.3);
        color: #e2e8f0;
    }
    .badge.text-bg-info {
        background-color: rgba(14, 165, 233, 0.3);
        color: #bae6fd;
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="includes/header.jsp"%>

	<div class="d-flex flex-grow-1">
		<%@ include file="includes/sidebar.jsp"%>

		<main class="flex-grow-1 p-4">
			<div class="container-fluid">
				<h3 class="mb-4 text-primary">
					<i class="fas fa-file-alt me-2"></i>Statements
				</h3>

				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<div class="card shadow-sm">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-list me-2 text-primary"></i>Transaction History
						</h5>
					</div>

					<div class="card-body">

						<form class="row g-3 mb-4" method="get"
							action="${pageContext.request.contextPath}/customer/statements">
							<div class="col-md-4">
								<label class="form-label">Select Account</label>

								<c:set var="selId"
									value="${not empty selectedAccountId ? selectedAccountId : param.accountId}" />

								<select class="form-select" name="accountId" required>
									<option value="" disabled
										<c:if test="${empty selId}">selected</c:if>>-- Select
										Account --</option>

									<c:forEach var="acc" items="${accounts}">
										<option value="${acc.accountId}"
											<c:if test="${selId == acc.accountId}">selected</c:if>>
											${acc.accountNumber} (ID: ${acc.accountId})</option>
									</c:forEach>
								</select>

							</div>

							<div class="col-md-4 d-flex align-items-end">
								<button class="btn btn-primary w-100" type="submit">
									<i class="fas fa-search me-2"></i>View Statements
								</button>
							</div>
						</form>

						<c:if test="${showTable}">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th scope="col">Transaction ID</th>
											<th scope="col">Date</th>
											<th scope="col">Type</th>
											<th scope="col">Amount</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="transaction" items="${transactions}">
											<tr>
												<td>${transaction.transactionId}</td>
												<td>${transaction.transactionDate}</td>
												<td>${transaction.type}</td>
												<td>${transaction.amount}</td>
											</tr>
										</c:forEach>

										<c:if test="${empty transactions}">
											<tr>
												<td colspan="4" class="text-center text-muted">No
													transactions found for this account.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</c:if>
					</div>
				</div>

				<a class="btn btn-outline-secondary mt-4"
					href="${pageContext.request.contextPath}/customer/dashboard"> <i
					class="fas fa-arrow-left me-2"></i>Back to Dashboard
				</a>
			</div>
		</main>
	</div>

	<%@ include file="includes/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>