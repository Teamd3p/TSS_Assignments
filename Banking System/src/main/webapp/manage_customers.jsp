<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Customers - VaultCore</title>
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
					<i class="fas fa-users me-2"></i> Manage Customers
				</h3>

				<c:if test="${param.created == '1'}">
					<div class="alert alert-success">Customer created
						successfully.</div>
				</c:if>
				<c:if test="${param.updated == '1'}">
					<div class="alert alert-success">Customer updated
						successfully.</div>
				</c:if>
				<c:if test="${param.deleted == '1'}">
					<div class="alert alert-warning">Customer deleted.</div>
				</c:if>
				<c:if test="${not empty errors}">
					<div class="alert alert-danger">${errors}</div>
				</c:if>

				<div class="card shadow-sm mb-4">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-plus-circle me-2 text-primary"></i>Create Customer
						</h5>
					</div>
					<div class="card-body">
						<form class="row g-3" method="post"
							action="${pageContext.request.contextPath}/admin/customer/create">
							<div class="col-md-3">
								<input class="form-control" name="username"
									placeholder="Username" required
									pattern="^[A-Za-z0-9_.-]{4,50}$"
									title="4-50 characters: letters, numbers, _, ., -">
							</div>
							<div class="col-md-3">
								<input class="form-control" type="password" name="password"
									placeholder="Password" required minlength="6"
									title="At least 6 characters">
							</div>
							<div class="col-md-3">
								<input class="form-control" name="fullName"
									placeholder="Full Name" required minlength="3">
							</div>
							<div class="col-md-3">
								<input class="form-control" type="email" name="email"
									placeholder="Email" required>
							</div>
							<div class="col-md-3">
								<input class="form-control" name="phone" placeholder="Phone"
									required pattern="^[0-9\\-+()\\s]{8,15}$"
									title="8-15 digits or +()-">
							</div>
							<div class="col-md-3">
								<input class="form-control" name="address" placeholder="Address">
							</div>
							<div class="col-md-3">
								<input class="form-control" name="aadhar" placeholder="Aadhar"
									pattern="^[0-9]{12}$" title="12 digits">
							</div>
							<div class="col-md-3">
								<input class="form-control" name="pan" placeholder="PAN"
									pattern="^[A-Z]{5}[0-9]{4}[A-Z]{1}$" title="Format: ABCDE1234F">
							</div>
							<div class="col-md-3 d-flex align-items-end">
								<button class="btn btn-primary w-100" type="submit">
									<i class="fas fa-plus"></i> Create
								</button>
							</div>
						</form>
					</div>
				</div>

				<div class="card shadow-sm">
					<div class="card-header text-white">
						<h5 class="mb-0">
							<i class="fas fa-list me-2 text-primary"></i>Customer List
						</h5>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-striped table-hover align-middle">
								<thead>
									<tr>
										<th>ID</th>
										<th>Full Name</th>
										<th>Email</th>
										<th>Phone</th>
										<th>Address</th>
										<th>Aadhar</th>
										<th>PAN</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${customers}">
										<tr>
											<td>${c.customerId}</td>
											<td>${c.fullName}</td>
											<td>${c.email}</td>
											<td>${c.phone}</td>
											<td>${c.address}</td>
											<td>${c.aadharNo}</td>
											<td>${c.panNo}</td>
											<td>
												<button class="btn btn-sm btn-warning"
													data-bs-toggle="modal"
													data-bs-target="#editModal${c.customerId}">
													<i class="fas fa-edit"></i>
												</button> <form method="post"
													action="${pageContext.request.contextPath}/admin/customer/delete"
													class="d-inline">
													<input type="hidden" name="customerId"
														value="${c.customerId}">
													<button class="btn btn-sm btn-danger" type="submit"
														onclick="return confirm('Delete this customer?');">
														<i class="fas fa-trash"></i>
													</button>
												</form>
											</td>
										</tr>

										<div class="modal fade" id="editModal${c.customerId}"
											tabindex="-1">
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
													<form method="post"
														action="${pageContext.request.contextPath}/admin/customer/update">
														<div class="modal-header">
															<h5 class="modal-title">Edit Customer</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal"></button>
														</div>

														<div class="modal-body row g-3">
															<input type="hidden" name="customerId"
																value="${c.customerId}">

															<div class="col-md-6">
																<label class="form-label">Full Name</label> <input
																	class="form-control" name="fullName"
																	value="${c.fullName}" required minlength="3">
															</div>

															<div class="col-md-6">
																<label class="form-label">Email</label> <input
																	class="form-control" type="email" name="email"
																	value="${c.email}" required>
															</div>

															<div class="col-md-6">
																<label class="form-label">Phone</label> <input
																	class="form-control" name="phone" value="${c.phone}"
																	required pattern="^[0-9\\-+()\\s]{8,15}$"
																	title="8-15 digits or +()-">
															</div>

															<div class="col-md-6">
																<label class="form-label">Address</label> <input
																	class="form-control" name="address"
																	value="${c.address}">
															</div>

															<div class="col-md-6">
																<label class="form-label">Aadhar No</label> <input
																	class="form-control" value="${c.aadharNo}" disabled>
																<input type="hidden" name="aadhar" value="${c.aadharNo}">
															</div>

															<div class="col-md-6">
																<label class="form-label">PAN No</label> <input
																	class="form-control" value="${c.panNo}" disabled>
																<input type="hidden" name="pan" value="${c.panNo}">
															</div>
														</div>

														<div class="modal-footer">
															<button class="btn btn-success" type="submit">Save
																Changes</button>
															<button type="button" class="btn btn-secondary"
																data-bs-dismiss="modal">Cancel</button>
														</div>
													</form>
												</div>
											</div>
										</div>

									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<a class="btn btn-outline-secondary mt-4"
					href="${pageContext.request.contextPath}/admin/dashboard"><i
					class="fas fa-arrow-left"></i> Back</a>
			</div>
		</main>
	</div>

	<%@ include file="includes/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>