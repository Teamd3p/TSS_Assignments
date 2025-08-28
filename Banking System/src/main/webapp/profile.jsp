<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .profile-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }
        .info-label {
            font-weight: 500;
            color: #374151;
        }
        .info-value {
            color: #1f2937;
        }
        .form-section {
            margin-top: 20px;
        }
        .coming-soon {
            opacity: 0.7;
            cursor: not-allowed;
        }
        @media (max-width: 768px) {
            .profile-card {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex flex-grow-1">
        <%@ include file="includes/sidebar.jsp" %>
        <main class="flex-grow-1 p-4">
            <div class="container-fluid">
                <h3 class="mb-4 text-primary"><i class="fas fa-user me-2"></i>Profile</h3>

                <!-- Customer Details -->
                <div class="profile-card shadow-sm">
                    <h5 class="mb-4"><i class="fas fa-info-circle me-2 text-primary"></i>Personal Information</h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <p><span class="info-label">Full Name:</span> <span class="info-value"><c:out value="${customer.fullName}" /></span></p>
                            <p><span class="info-label">Email:</span> <span class="info-value"><c:out value="${customer.email}" /></span></p>
                            <p><span class="info-label">Phone:</span> <span class="info-value"><c:out value="${customer.phone}" /></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><span class="info-label">Address:</span> <span class="info-value"><c:out value="${customer.address}" default="Not provided" /></span></p>
                            <p><span class="info-label">Aadhar No:</span> <span class="info-value"><c:out value="${customer.aadharNo}" default="Not provided" /></span></p>
                            <p><span class="info-label">PAN No:</span> <span class="info-value"><c:out value="${customer.panNo}" default="Not provided" /></span></p>
                        </div>
                        <div class="col-12">
                            <p><span class="info-label">Account Status:</span> <span class="info-value"><c:out value="${customer.status}" /></span></p>
                            <p><span class="info-label">Joined Since:</span> <span class="info-value"><fmt:formatDate value="${customer.createdAt}" pattern="dd-MM-yyyy" /></span></p>
                        </div>
                    </div>
                </div>

                <!-- Manage Password Form -->
                <div class="form-section">
                    <div class="profile-card shadow-sm">
                        <h5 class="mb-4"><i class="fas fa-lock me-2 text-primary"></i>Manage Password</h5>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <form class="row g-3" method="post" action="${pageContext.request.contextPath}/customer/profile">
                            <input type="hidden" name="action" value="changePassword">
                            <div class="col-md-4">
                                <label for="oldPassword" class="form-label">Current Password</label>
                                <input id="oldPassword" class="form-control" type="password" name="oldPassword" placeholder="Enter current password" required>
                            </div>
                            <div class="col-md-4">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input id="newPassword" class="form-control" type="password" name="newPassword" placeholder="Enter new password" required>
                            </div>
                            <div class="col-md-4">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input id="confirmPassword" class="form-control" type="password" name="confirmPassword" placeholder="Confirm new password" required>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button class="btn btn-primary w-100" type="submit" aria-label="Update password">
                                    <i class="fas fa-save me-2"></i>Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Reset Password Section -->
                <div class="form-section">
                    <div class="profile-card shadow-sm coming-soon">
                        <h5 class="mb-4"><i class="fas fa-key me-2 text-primary"></i>Reset Password</h5>
                        <p class="text-muted">Forgot your password? Reset it by entering your registered email below. A verification link will be sent to you (feature coming soon).</p>
                        <form class="row g-3" method="post" action="${pageContext.request.contextPath}/customer/profile" disabled>
                            <input type="hidden" name="action" value="resetPassword">
                            <div class="col-md-6">
                                <label for="resetEmail" class="form-label">Email Address</label>
                                <input id="resetEmail" class="form-control" type="email" name="resetEmail" placeholder="Enter your email" disabled>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button class="btn btn-outline-primary w-100" type="submit" disabled aria-label="Reset password (coming soon)">
                                    <i class="fas fa-redo me-2"></i>Reset
                                </button>
                            </div>
                        </form>
                        <p class="text-muted mt-2">This feature is under development. Check back later!</p>
                    </div>
                </div>

                <a class="btn btn-outline-secondary mt-4" href="${pageContext.request.contextPath}/customer/dashboard" aria-label="Back to dashboard">
                    <i class="fas fa-arrow-left me-2"></i>Back
                </a>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>