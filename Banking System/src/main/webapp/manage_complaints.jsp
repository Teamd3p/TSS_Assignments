<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Complaints - VaultCore</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <%@ include file="includes/header.jsp" %>

    <div class="d-flex">
        <!-- Admin Sidebar -->
        <%@ include file="includes/admin_sidebar.jsp" %>

        <!-- Main Content -->
        <main class="flex-grow-1 p-4">
            <div class="container-fluid">

                <!-- Page Title -->
                <h3 class="mb-4 text-primary">
                    <i class="fas fa-exclamation-circle me-2"></i>Manage Complaints
                </h3>

                <!-- Success Alert -->
                <c:if test="${param.updated == '1'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Complaint status updated successfully.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Update Status Form -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-edit me-2"></i>Update Complaint Status
                        </h5>
                    </div>
                    <div class="card-body">
                        <form class="row g-3" method="post"
                              action="${pageContext.request.contextPath}/complaint/update-status">
                            <div class="col-md-3">
                                <label class="form-label">Complaint ID</label>
                                <select class="form-select" name="complaintId" id="complaintSelect" required>
                                    <option value="" disabled selected>Select Complaint</option>
                                    <c:forEach var="complaint" items="${complaints}">
                                        <c:if test="${complaint.status != 'RESOLVED'}">
                                            <option value="${complaint.complaintId}"
                                                    data-status="${complaint.status}">
                                                #${complaint.complaintId} - ${complaint.subject}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label">New Status</label>
                                <select class="form-select" name="status" id="statusSelect" disabled required>
                                    <option value="" selected>Select Status</option>
                                </select>
                            </div>

                            <div class="col-md-2 d-flex align-items-end">
                                <button class="btn btn-success w-100" type="submit" id="submitBtn" disabled>
                                    <i class="fas fa-check me-2"></i>Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Complaint List -->
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Complaint List
                        </h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Complaint ID</th>
                                    <th>Customer ID</th>
                                    <th>Subject</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <td><strong>#${complaint.complaintId}</strong></td>
                                        <td>${complaint.customerId}</td>
                                        <td class="text-truncate" style="max-width: 200px;" 
                                            title="${complaint.subject}">
                                            ${complaint.subject}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${complaint.status == 'OPEN'}">
                                                    <span class="badge text-bg-warning">Open</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                    <span class="badge text-bg-info">In Progress</span>
                                                </c:when>
                                                <c:when test="${complaint.status == 'RESOLVED'}">
                                                    <span class="badge text-bg-success">Resolved</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>${complaint.createdAt}</td>
                                        <td>
                                            <button type="button"
                                                    class="btn btn-sm btn-outline-primary"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#complaintModal"
                                                    data-id="${complaint.complaintId}"
                                                    data-customer="${complaint.customerId}"
                                                    data-subject="${complaint.subject}"
                                                    data-message="${complaint.message}"
                                                    data-status="${complaint.status}"
                                                    data-date="${complaint.createdAt}">
                                                <i class="fas fa-eye"></i> View
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Empty State -->
                        <c:if test="${empty complaints}">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle me-2"></i>No complaints found.
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Back to Dashboard -->
                <a class="btn btn-outline-secondary mt-4"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>

            </div>
        </main>
    </div>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <!-- Bootstrap JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script for Dynamic Status Dropdown -->
    <script>
        // Map complaint ID to current status
        const complaintStatusMap = {};
        <c:forEach var="complaint" items="${complaints}">
        <c:if test="${complaint.status != 'RESOLVED'}">
            complaintStatusMap[${complaint.complaintId}] = "${complaint.status}";
        </c:if>
        </c:forEach>

        const complaintSelect = document.getElementById("complaintSelect");
        const statusSelect = document.getElementById("statusSelect");
        const submitBtn = document.getElementById("submitBtn");

        // Reset status dropdown with placeholder
        function resetStatusDropdown() {
            statusSelect.innerHTML = "";
            const placeholder = document.createElement("option");
            placeholder.value = "";
            placeholder.textContent = "Select Status";
            placeholder.disabled = true;
            placeholder.selected = true;
            statusSelect.appendChild(placeholder);
            statusSelect.disabled = true;
            submitBtn.disabled = true;
        }

        // Initialize
        resetStatusDropdown();

        // Update status options based on selected complaint
        complaintSelect.addEventListener("change", function () {
            const selectedId = this.value;
            resetStatusDropdown();

            if (!selectedId) return;

            const currentStatus = complaintStatusMap[selectedId];

            if (currentStatus === "OPEN") {
                addOption("IN_PROGRESS", "In Progress");
                addOption("RESOLVED", "Resolved");
            } else if (currentStatus === "IN_PROGRESS") {
                addOption("RESOLVED", "Resolved");
            }

            if (statusSelect.children.length > 1) {
                statusSelect.disabled = false;
            }
        });

        // Enable submit only when a valid status is selected
        statusSelect.addEventListener("change", function () {
            submitBtn.disabled = !this.value || this.value === "";
        });

        function addOption(value, text) {
            const option = document.createElement("option");
            option.value = value;
            option.textContent = text;
            statusSelect.appendChild(option);
        }
    </script>

    <!-- Complaint Detail Modal -->
    <div class="modal fade" id="complaintModal" tabindex="-1" aria-labelledby="complaintModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="complaintModalLabel">Complaint Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Complaint ID:</strong> <span id="modal-id"></span></p>
                    <p><strong>Customer ID:</strong> <span id="modal-customer"></span></p>
                    <p><strong>Subject:</strong> <span id="modal-subject"></span></p>
                    <p><strong>Status:</strong> <span id="modal-status"></span></p>
                    <p><strong>Date:</strong> <span id="modal-date"></span></p>
                    <p><strong>Message:</strong></p>
                    <div class="alert bg-light p-3 rounded">
                        <pre id="modal-message" style="white-space: pre-wrap; margin: 0; font-family: inherit; font-size: 0.95rem;"></pre>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript to Populate Modal -->
    <script>
        const complaintModal = document.getElementById('complaintModal');
        complaintModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            document.getElementById('modal-id').textContent = button.getAttribute('data-id');
            document.getElementById('modal-customer').textContent = button.getAttribute('data-customer');
            document.getElementById('modal-subject').textContent = button.getAttribute('data-subject');
            document.getElementById('modal-status').textContent = button.getAttribute('data-status');
            document.getElementById('modal-date').textContent = button.getAttribute('data-date');
            document.getElementById('modal-message').textContent = button.getAttribute('data-message');
        });
    </script>
</body>
</html>