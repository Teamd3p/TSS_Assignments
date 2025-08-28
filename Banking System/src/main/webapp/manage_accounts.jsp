<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Accounts - VaultCore</title>
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
    .table { color: #e2e8f0; }
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
<body>
	<%@ include file="includes/header.jsp"%>
	<div class="d-flex">
		<%@ include file="includes/admin_sidebar.jsp"%>

		<main class="flex-grow-1 p-4">
			<div class="container-fluid">

				<h3 class="mb-4 text-primary">
					<i class="fas fa-wallet me-2"></i>Manage Accounts
				</h3>

				<c:if test="${param.updated == '1'}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle me-2"></i>Account status updated
						successfully.
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<div class="card shadow-sm mb-4">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-edit me-2 text-primary"></i>Update Account Status
						</h5>
					</div>
					<div class="card-body">
						<form class="row g-3" method="post"
							action="${pageContext.request.contextPath}/admin/account/update-status">
							<div class="col-md-4">
								<label class="form-label">Account ID</label> 
								<div class="custom-select-wrapper">
									<select class="form-select" name="accountId" id="accountSelect" required>
										<option value="" disabled selected>Select Account</option>
										<c:forEach var="account" items="${accounts}">
											<c:if test="${account.status != 'CLOSED'}">
												<option value="${account.accountId}"
													data-status="${account.status}">
													#${account.accountId} - ${account.accountType}
													(${account.status})</option>
											</c:if>
										</c:forEach>
									</select>
									<i class="fas fa-chevron-down select-arrow"></i>
								</div>
							</div>

							<div class="col-md-4">
								<label class="form-label">New Status</label>
								<div class="custom-select-wrapper">
									<select class="form-select" name="status" id="statusSelect" disabled required>
										<option value="" selected>Select Status</option>
									</select>
									<i class="fas fa-chevron-down select-arrow"></i>
								</div>
							</div>

							<div class="col-md-4 d-flex align-items-end">
								<button class="btn btn-success w-100" type="submit"
									id="submitBtn" disabled>
									<i class="fas fa-check me-2"></i>Update
								</button>
							</div>
						</form>
					</div>
				</div>

				<div class="card shadow-sm">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-list me-2 text-primary"></i>Account List
						</h5>
					</div>
					<div class="card-body">
						<table class="table table-hover align-middle">
							<thead>
								<tr>
									<th>Account ID</th>
									<th>Customer ID</th>
									<th>Account Type</th>
									<th>Balance</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="account" items="${accounts}">
									<tr>
										<td><strong>#${account.accountId}</strong></td>
										<td>${account.customerId}</td>
										<td>${account.accountType}</td>
										<td>₹${account.balance}</td>
										<td><c:choose>
												<c:when test="${account.status == 'ACTIVE'}">
													<span class="badge text-bg-success">Active</span>
												</c:when>
												<c:when test="${account.status == 'BLOCKED'}">
													<span class="badge text-bg-danger">Blocked</span>
												</c:when>
												<c:when test="${account.status == 'CLOSED'}">
													<span class="badge text-bg-secondary">Closed</span>
												</c:when>
											</c:choose></td>
										<td>
											<button type="button" class="btn btn-sm btn-outline-primary"
												data-bs-toggle="modal" data-bs-target="#accountModal"
												data-id="${account.accountId}"
												data-customer="${account.customerId}"
												data-name="${account.customerName}"
												data-number="${account.accountNumber}"
												data-type="${account.accountType}"
												data-balance="${account.balance}"
												data-status="${account.status}"
												data-date="${account.createdAt}">
												<i class="fas fa-eye"></i> View
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<c:if test="${empty accounts}">
							<div class="alert alert-info text-center">
								<i class="fas fa-info-circle me-2"></i>No accounts found.
							</div>
						</c:if>
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

	<script>
		const accountSelect = document.getElementById("accountSelect");
		const statusSelect = document.getElementById("statusSelect");
		const submitBtn = document.getElementById("submitBtn");

		function resetStatusDropdown() {
			statusSelect.innerHTML = "<option value='' disabled selected>Select Status</option>";
			statusSelect.disabled = true;
			submitBtn.disabled = true;
		}

		resetStatusDropdown();

		accountSelect.addEventListener("change", function() {
			resetStatusDropdown();
			const selected = this.options[this.selectedIndex];
			if (!selected)
				return;

			const currentStatus = selected.getAttribute("data-status");
			if (currentStatus === "ACTIVE") {
				addOption("BLOCKED", "Blocked");
				addOption("CLOSED", "Closed");
			} else if (currentStatus === "BLOCKED") {
				addOption("ACTIVE", "Active");
				addOption("CLOSED", "Closed");
			}

			if (statusSelect.options.length > 1) {
				statusSelect.disabled = false;
			}
		});

		statusSelect.addEventListener("change", function() {
			submitBtn.disabled = !this.value;
		});

		function addOption(value, text) {
			const option = document.createElement("option");
			option.value = value;
			option.textContent = text;
			statusSelect.appendChild(option);
		}
	</script>

	<div class="modal fade" id="accountModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-white">Account Details</h5>
					<button type="button" class="btn-close"
						data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<p>
						<strong>Account ID:</strong> <span id="modal-id"></span>
					</p>
					<p>
						<strong>Customer ID:</strong> <span id="modal-customer"></span>
					</p>
					<p>
						<strong>Customer Name:</strong> <span id="modal-name"></span>
					</p>
					<p>
						<strong>Account Number:</strong> <span id="modal-number"></span>
					</p>
					<p>
						<strong>Account Type:</strong> <span id="modal-type"></span>
					</p>
					<p>
						<strong>Status:</strong> <span id="modal-status"></span>
					</p>
					<p>
						<strong>Balance:</strong> ₹<span id="modal-balance"></span>
					</p>
					<p>
						<strong>Opening Date:</strong> <span id="modal-date"></span>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		const accountModal = document.getElementById('accountModal');
		accountModal.addEventListener('show.bs.modal', function(event) {
			const button = event.relatedTarget;
			document.getElementById('modal-id').textContent = button
					.getAttribute('data-id');
			document.getElementById('modal-customer').textContent = button
					.getAttribute('data-customer');
			document.getElementById('modal-name').textContent = button
					.getAttribute('data-name');
			document.getElementById('modal-number').textContent = button
					.getAttribute('data-number');
			document.getElementById('modal-type').textContent = button
					.getAttribute('data-type');
			document.getElementById('modal-status').textContent = button
					.getAttribute('data-status');
			document.getElementById('modal-balance').textContent = button
					.getAttribute('data-balance');
			document.getElementById('modal-date').textContent = button
					.getAttribute('data-date');
		});
	</script>
</body>
</html>