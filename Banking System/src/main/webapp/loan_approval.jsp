<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Loan Approvals - VaultCore</title>
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
    
    /* Custom Dropdown Arrow Fix */
    .form-select {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: none;
        padding-right: 2.5rem; /* Space for custom arrow */
    }
    .custom-select-wrapper {
        position: relative;
    }
    .custom-select-wrapper .select-arrow {
        position: absolute;
        top: 50%;
        right: 15px;
        transform: translateY(-50%);
        pointer-events: none;
        color: #a78bfa;
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
    .btn-outline-secondary { color: #94a3b8; border-color: #94a3b8; }
    .btn-outline-secondary:hover { background-color: #94a3b8; color: #1a202c; }

    /* Alerts */
    .alert { border-radius: 10px; border: none; color: white; }
    .alert-success { background-color: #10b981; }
    .alert-danger { background-color: #ef4444; }
    .alert-info { background-color: #22d3ee; }

    /* Table */
    .table { color: #e2e8f0; }
    .table thead { background: #334155; color: #f1f5f9; }
    .table-hover tbody tr:hover { background: rgba(148, 163, 184, 0.1); }
    .table td, .table th { border-top: 1px solid #334155; vertical-align: middle; }
    .table-striped > tbody > tr:nth-of-type(odd) > * {
        background-color: rgba(255, 255, 255, 0.03);
        color: #e2e8f0;
    }

    /* Badges */
    .badge {
        font-size: 0.8rem;
        padding: 0.4em 0.8em;
        font-weight: 600;
        border-radius: 9999px;
    }
    .badge.text-bg-success { background-color: rgba(22, 163, 74, 0.3); color: #a7f3d0; }
    .badge.text-bg-warning { background-color: rgba(202, 138, 4, 0.3); color: #fef08a; }
    .badge.text-bg-danger { background-color: rgba(220, 38, 38, 0.3); color: #fecaca; }
    .badge.text-bg-secondary { background-color: rgba(100, 116, 139, 0.3); color: #e2e8f0; }
</style>
</head>
<body>
	<%@ include file="includes/header.jsp"%>
	<div class="d-flex">
		<%@ include file="includes/admin_sidebar.jsp"%>
		<main class="flex-grow-1 p-4">
			<div class="container-fluid">
				<h3 class="mb-4 text-primary">
					<i class="fas fa-hand-holding-usd me-2"></i>Loan Approvals
				</h3>

				<c:if test="${param.updated == '1'}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle me-2"></i>Loan status updated
						successfully.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<c:if test="${not empty errors}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<i class="fas fa-exclamation-circle me-2"></i>${errors}
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<div class="card shadow-sm mb-4">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-list me-2 text-primary"></i>Loan List
						</h5>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-striped table-hover align-middle">
								<thead>
									<tr>
										<th scope="col">Loan ID</th>
										<th scope="col">Customer ID</th>
										<th scope="col">Account Number</th>
										<th scope="col">Loan Type</th>
										<th scope="col">Amount</th>
										<th scope="col">Interest Rate</th>
										<th scope="col">Tenure</th>
										<th scope="col">Status</th>
										<th scope="col">Applied Date</th>
										<th scope="col">Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="loan" items="${loans}">
										<tr>
											<td><strong>#${loan.loanId}</strong></td>
											<td>${loan.customerId}</td>
											<td><c:choose>
													<c:when test="${not empty loan.accountNumber}">
                                                        ${loan.accountNumber}
                                                    </c:when>
													<c:otherwise>
														<em class="text-muted">Not assigned</em>
													</c:otherwise>
												</c:choose></td>
											<td>${loan.loanType}</td>
											<td>₹${loan.amount}</td>
											<td>${loan.interestRate}%</td>
											<td>${loan.tenureMonths} months</td>
											<td><c:choose>
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
												</c:choose></td>
											<td>${loan.appliedDate}</td>
											<td><c:choose>
													<c:when test="${loan.status == 'PENDING'}">
														<form method="post"
															action="${pageContext.request.contextPath}/admin/loan/update-status"
															class="d-inline">
															<input type="hidden" name="loanId" value="${loan.loanId}">
															<div class="custom-select-wrapper">
																<select class="form-select form-select-sm" name="status"
																	required>
																	<option value="" disabled selected>Select</option>
																	<option value="APPROVED">Approve</option>
																	<option value="REJECTED">Reject</option>
																</select>
																<i class="fas fa-chevron-down select-arrow"></i>
															</div>
															<button type="submit"
																class="btn btn-sm btn-primary mt-1 w-100">Update</button>
														</form>
													</c:when>
													<c:otherwise>
														<span class="text-muted"><i
															class="fas fa-lock me-1"></i>No further actions</span>
													</c:otherwise>
												</c:choose></td>

										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="text-center text-muted">Total
											Loans: ${loans != null ? loans.size() : 0}</td>
									</tr>
								</tfoot>
							</table>

							<c:if test="${empty loans}">
								<div class="alert alert-info text-center">
									<i class="fas fa-info-circle me-2"></i>No loans to approve at
									this time.
								</div>
							</c:if>
						</div>
					</div>
				</div>

				<a class="btn btn-outline-secondary mt-4"
					href="${pageContext.request.contextPath}/admin/dashboard"> <i
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