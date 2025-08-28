<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Loans - VaultCore</title>
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

/* Tables - Dark Theme */
.table {
    border-radius: 8px;
    overflow: hidden;
    background-color: rgba(30, 41, 59, 0.8); /* dark background */
    color: #e2e8f0; /* light text */
}

.table thead {
    background-color: #1e293b; /* darker header */
    color: #f1f5f9;
}

.table-hover tbody tr:hover {
    background-color: rgba(148, 163, 184, 0.15); /* subtle highlight */
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
					<i class="fas fa-hand-holding-usd me-2"></i>My Loans
				</h3>
				<div class="card shadow-sm">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-list me-2 text-primary"></i>Loan Details
						</h5>
					</div>
					<div class="card-body">
						<c:choose>
							<c:when test="${empty loans}">
								<p class="text-muted">No loans found.</p>
							</c:when>
							<c:otherwise>
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th scope="col">Loan ID</th>
												<th scope="col">Account Number</th>
												<th scope="col">Loan Type</th>
												<th scope="col">Sanctioned Amount</th>
												<th scope="col">Remaining Amount</th>
												<th scope="col">Interest Rate</th>
												<th scope="col">Tenure (Months)</th>
												<th scope="col">Applied Date</th>
												<th scope="col">Status</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="loan" items="${loans}">
												<tr>
													<td>${loan.loanId}</td>
													<td>
														<c:choose>
															<c:when test="${not empty loan.accountNumber}">
																${loan.accountNumber}
															</c:when>
															<c:otherwise>
																<em class="text-muted">Not assigned</em>
															</c:otherwise>
														</c:choose>
													</td>
													<td>${loan.loanType}</td>
													<td>
														<%-- This was the line with the error. Corrected below. --%>
														<fmt:formatNumber value="${loan.amount}"
															type="currency" currencySymbol="₹" maxFractionDigits="2" />
													</td>
													<td>
														<fmt:formatNumber value="${loan.outstandingAmount}"
															type="currency" currencySymbol="₹" maxFractionDigits="2" />
													</td>
													<td>
														<fmt:formatNumber value="${loan.interestRate}"
															maxFractionDigits="2" />%
													</td>
													<td>${loan.tenureMonths}</td>
													<td>
														<fmt:formatDate value="${loan.appliedDate}" pattern="dd-MM-yyyy" />
													</td>
													<td>
														<c:choose>
															<c:when test="${loan.status == 'PENDING'}">
																<span class="badge text-bg-warning">Pending</span>
															</c:when>
															<c:when test="${loan.status == 'APPROVED'}">
																<span class="badge text-bg-success">Approved</span>
															</c:when>
															<c:when test="${loan.status == 'REJECTED'}">
																<span class="badge text-bg-danger">Rejected</span>
															</c:when>
															<c:when test="${loan.status == 'CLOSED'}">
																<span class="badge text-bg-secondary">Closed</span>
															</c:when>
															<c:otherwise>
																<span class="badge text-bg-info">${loan.status}</span>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<a class="btn btn-outline-secondary mt-4"
					href="${pageContext.request.contextPath}/customer/dashboard"><i
					class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
			</div>
		</main>
	</div>
	<%@ include file="includes/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>