<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Apply for a Loan - VaultCore</title>
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
        background: linear-gradient(135deg, #0f172a, #1e293b); /* deep dark gradient */
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
        background: #1e293b;
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

    /* Danger card */
    .card.text-bg-danger {
        background: linear-gradient(135deg, #dc2626, #ef4444) !important;
        color: #ffffff !important;
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
        background: #1e293b;
        color: #f1f5f9;
    }

    .form-select {
        /* This is the key change: a high-contrast SVG arrow */
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23a78bfa' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 0.75rem center;
        background-size: 16px 12px;
    }

    /* Tables */
    .table {
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

    /* Badges */
    .badge {
        font-size: 0.9rem;
        padding: 0.5em 1em;
        border-radius: 9999px;
    }
</style>
</head>
<body>
	<%@ include file="includes/header.jsp"%>
	<div class="d-flex">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="flex-grow-1 p-4">
			<div class="container-fluid">
				<h3 class="mb-4 text-primary">
					<i class="fas fa-hand-holding-usd me-2"></i>Apply for a Loan
				</h3>

				<c:if test="${param.applied == '1'}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle me-2"></i>Loan application submitted
						successfully.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<c:if test="${not empty errors}">
					<div class="alert alert-danger">
						<ul>
							<c:forEach var="err" items="${errors}">
								<li>${err}</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>

				<div class="card shadow-sm">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-plus-circle me-2 text-primary"></i>Loan Application
						</h5>
					</div>
					<div class="card-body">
						<form class="row g-3" method="post"
							action="${pageContext.request.contextPath}/customer/apply_loan">
							<div class="col-md-2">
								<label class="form-label">Customer ID</label> <input
									class="form-control" name="customerId" value="${customerId}"
									readonly>
							</div>

							<div class="col-md-4">
								<label class="form-label">Select Account</label> <select
									class="form-select" name="accountId" id="accountId" required>
									<option value="" disabled
										<c:if test="${empty selId}">selected</c:if>>-- Select
										Account --</option>
									<c:choose>
										<c:when test="${not empty accounts}">
											<c:forEach var="acc" items="${accounts}">
												<option value="${acc.accountId}">
													${acc.accountNumber} - ${acc.accountType}</option>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<option value="">No accounts found</option>
										</c:otherwise>
									</c:choose>
								</select>
							</div>

							<div class="col-md-2">
								<label class="form-label">Loan Type</label> <select
									class="form-select" name="loanType" id="loanType" required>
									<option value="" disabled
										<c:if test="${empty selId}">selected</c:if>>-- Select
										Type --</option>
									<option value="PERSONAL">Personal</option>
									<option value="HOME">Home</option>
									<option value="CAR">Car</option>
									<option value="EDUCATION">Education</option>
								</select>
							</div>

							<div class="col-md-2">
								<label class="form-label">Amount</label> <input
									class="form-control" type="number" step="0.01" min="1000"
									name="amount" placeholder="Enter Amount" required>
							</div>

							<div class="col-md-2">
								<label class="form-label">Interest Rate (%)</label> <input
									id="interestRate" class="form-control" type="number"
									step="0.01" name="interestRate" readonly required>
							</div>

							<div class="col-md-2">
								<label class="form-label">Tenure (Months)</label> <input
									class="form-control" type="number" min="1" step="1"
									name="tenureMonths" placeholder="Enter Months" required>
							</div>

							<div class="col-12">
								<div class="d-flex gap-2">
									<button class="btn btn-primary" type="submit">
										<i class="fas fa-paper-plane me-2"></i>Apply
									</button>
									<a class="btn btn-outline-secondary"
										href="${pageContext.request.contextPath}/customer/dashboard">Back
										to Dashboard</a>
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>
		</main>
	</div>

	<%@ include file="includes/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>

	<script>
		// interest rates can be tuned here; we use conservative example rates.
		const LOAN_RATES = {
			PERSONAL : 14.0,
			HOME : 9.0,
			CAR : 11.0,
			EDUCATION : 8.0
		};

		function setInterestRate() {
			const loanTypeEl = document.getElementById("loanType");
			const rateEl = document.getElementById("interestRate");
			const rate = LOAN_RATES[loanTypeEl.value] || 0;
			rateEl.value = rate;
		}

		document.getElementById("loanType").addEventListener("change",
				setInterestRate);

		// Initialize on load
		window.addEventListener("load", setInterestRate);
	</script>
</body>
</html>