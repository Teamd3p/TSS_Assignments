<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - VaultCore</title>
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

.text-primary {
	color: #a78bfa !important;
}

h2, h3, h4, h5 {
	font-weight: 600;
	color: #f9fafb;
}

/* Main Login Container */
.login-container .card {
	border: none;
	border-radius: 16px;
	background: rgba(30, 41, 59, 0.85);
	backdrop-filter: blur(12px);
	border: 1px solid rgba(255, 255, 255, 0.05);
	box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
	color: #e2e8f0;
    overflow: hidden; /* Important for the split layout */
}

/* Left Promotional Panel */
.login-promo {
    background: linear-gradient(145deg, #a78bfa, #6d28d9);
    color: white;
    padding: 2.5rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.login-promo h3 {
    color: white;
}

.feature-list {
    list-style: none;
    padding-left: 0;
}

.feature-list li {
    display: flex;
    align-items: center;
    margin-bottom: 1rem;
    font-size: 0.95rem;
}

.feature-list i {
    font-size: 1.1rem;
    margin-right: 0.75rem;
    width: 24px;
    text-align: center;
}


/* Right Login Form Panel */
.login-form-panel {
    padding: 2.5rem;
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

.form-control:focus {
	border-color: #a78bfa;
	box-shadow: 0 0 0 0.25rem rgba(167, 139, 250, 0.25);
	background: #1e2b3b;
}

/* Button Styling */
.btn-primary {
	background: linear-gradient(135deg, #a78bfa, #6d28d9);
	color: #fff;
	border-radius: 8px;
	transition: transform 0.2s, box-shadow 0.2s;
	border: none;
	font-weight: 600;
	padding: 0.75rem;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 16px rgba(167, 139, 250, 0.3);
}

/* Alerts */
.alert {
	border-radius: 10px;
	border: none;
	color: white;
}

.alert-success {
	background-color: #10b981;
}

.alert-danger {
	background-color: #ef4444;
}
</style>
</head>
<body>
	<main class="d-flex align-items-center justify-content-center min-vh-100 p-3 login-container">
        <div class="card shadow-lg" style="max-width: 900px; width: 100%;">
            <div class="row g-0">
                <div class="col-lg-6 d-none d-lg-flex login-promo">
                    <div>
                        <h3 class="mb-4">
                            <i class="fas fa-vault me-2"></i>Welcome to VaultCore
                        </h3>
                        <p class="mb-4">Your trusted partner in modern, secure, and digital-first banking.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-shield-alt"></i> Secure Transactions</li>
                            <li><i class="fas fa-headset"></i> 24/7 Customer Support</li>
                            <li><i class="fas fa-mobile-alt"></i> Seamless Mobile Banking</li>
                            <li><i class="fas fa-bolt"></i> Instant Loan Approvals</li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-6 login-form-panel">
                    <div class="text-center mb-4">
                        <h4 class="mb-1">Secure Portal Login</h4>
                        <p class="text-secondary small">Enter your credentials to access your account.</p>
                    </div>

                    <c:if test="${param.registered == '1'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>Registration successful! Please log in.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty errors}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${errors}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${param.error == '1' && empty errors}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>Invalid credentials.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/login">
                        <div class="mb-3">
                            <label class="form-label">Username</label> 
                            <input class="form-control" name="username" placeholder="Enter Username" required autofocus>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Password</label> 
                            <input class="form-control" type="password" name="password" placeholder="Enter Password" required>
                        </div>
                        <button class="btn btn-primary w-100 py-2 mb-3" type="submit">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <p class="small text-secondary mb-0">Don't have an account? 
                            <a href="${pageContext.request.contextPath}/register.jsp" class="text-primary fw-medium text-decoration-none">Register here</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>