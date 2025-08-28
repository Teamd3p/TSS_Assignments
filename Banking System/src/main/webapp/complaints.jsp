<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

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

        .btn-danger {
            background: linear-gradient(135deg, #dc2626, #ef4444);
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
        .alert, .card.text-bg-danger {
            border-radius: 10px;
        }
        .alert-success {
            background-color: #10b981;
            color: #fff;
            border-color: #059669;
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
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex flex-grow-1">
        <%@ include file="includes/sidebar.jsp" %>
        <main class="flex-grow-1 p-4">
            <div class="container-fluid">
                <h3 class="mb-4"><i class="fas fa-exclamation-circle me-2 text-primary"></i>My Complaints</h3>
                <c:if test="${param.created == '1'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Complaint created successfully.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <div class="card shadow-sm mb-4">
                    <div class="card-header text-white">
                        <h5 class="mb-0"><i class="fas fa-plus-circle me-2 text-primary"></i>Raise Complaint</h5>
                    </div>
                    <div class="card-body">
                        <form class="row g-3" method="post" action="${pageContext.request.contextPath}/complaint/create">
                            <div class="col-md-12">
                                <label class="form-label">Subject</label>
                                <input class="form-control" name="subject" placeholder="Enter Subject" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Message</label>
                                <textarea class="form-control" name="message" placeholder="Enter Message" rows="3" required></textarea>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button class="btn btn-primary w-100" type="submit"><i class="fas fa-paper-plane me-2"></i>Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card shadow-sm">
                    <div class="card-header text-white">
                        <h5 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>Complaint History</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Complaint ID</th>
                                    <th scope="col">Subject</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="complaint" items="${complaints}">
                                    <tr>
                                        <td>${complaint.complaintId}</td>
                                        <td>${complaint.subject}</td>
                                        <td>${complaint.status}</td>
                                        <td>${complaint.createdAt}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <a class="btn btn-outline-secondary mt-4" href="${pageContext.request.contextPath}/customer/dashboard">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>