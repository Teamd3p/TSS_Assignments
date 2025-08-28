<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - VaultCore</title>
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

        .text-primary {
            color: #a78bfa !important;
        }

        h2, h3, h4, h5 {
            font-weight: 600;
            color: #f9fafb;
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 16px;
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            color: #e2e8f0;
        }

        /* Form Styling */
        .form-control {
            border-radius: 8px;
            background: #0f172a;
            border: 1px solid #334155;
            color: #e2e8f0;
            box-shadow: none;
            padding: 0.75rem 1rem;
        }
        
        .form-control::placeholder {
            color: #64748b;
        }

        .form-control:focus {
            border-color: #a78bfa;
            box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
            background: #1e2b3b;
        }

        /* Button Styling */
        .btn {
            border-radius: 8px;
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
            font-weight: 500;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #a78bfa, #6d28d9);
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
            border: none;
            color: white;
        }
        .alert-danger {
            background-color: #ef4444;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <main class="flex-grow-1 d-flex align-items-center py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-md-8">
                    <div class="card p-4 p-lg-5">
                        <div class="text-center mb-4">
                            <h2 class="text-primary mb-1"><i class="fas fa-user-plus me-2"></i>VaultCore</h2>
                            <p class="text-secondary small">Create Your Secure Banking Account</p>
                        </div>

                        <!-- Show Error Only If It Exists -->
                        <c:if test="${not empty errors}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>${errors}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Registration Form -->
                        <form method="post" action="${pageContext.request.contextPath}/register">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Username</label>
                                    <input type="text" name="username" class="form-control" required value="${param.username}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Password</label>
                                    <input type="password" name="password" class="form-control" required minlength="6">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" name="fullName" class="form-control" required value="${param.fullName}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" required value="${param.email}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone</label>
                                    <input type="text" name="phone" class="form-control" required pattern="^[0-9\-+()\s]{8,15}$" value="${param.phone}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Address</label>
                                    <input type="text" name="address" class="form-control" value="${param.address}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Aadhar No</label>
                                    <input type="text" name="aadhar" class="form-control" pattern="^[0-9]{12}$" placeholder="12 digits" value="${param.aadhar}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">PAN No</label>
                                    <input type="text" name="pan" class="form-control" pattern="^[A-Z]{5}[0-9]{4}[A-Z]{1}$" placeholder="e.g., ABCDE1234F" value="${param.pan}">
                                </div>
                            </div>
                            <div class="d-flex mt-4 gap-2">
                                <button class="btn btn-primary px-4" type="submit">
                                    <i class="fas fa-user-plus me-2"></i>Register
                                </button>
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/login.jsp">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Login
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>