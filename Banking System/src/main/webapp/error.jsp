<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .error-card {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            border-radius: 14px;
            padding: 25px;
            max-width: 600px;
            margin: 0 auto;
            color: #ffffff;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .error-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(220, 53, 69, 0.3);
        }
        .error-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .error-title {
            font-weight: 600;
            margin-bottom: 10px;
        }
        .error-message {
            font-size: 1.1rem;
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .error-card {
                margin-bottom: 15px;
                padding: 15px;
            }
            .error-icon {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex flex-grow-1">
        <%@ include file="includes/sidebar.jsp" %>
        <main class="flex-grow-1 p-4 bg-light">
            <div class="container-fluid d-flex justify-content-center align-items-center min-vh-75">
                <div class="error-card shadow-sm text-center">
                    <i class="error-icon fas fa-exclamation-triangle"></i>
                    <h4 class="error-title">Oops! Something Went Wrong</h4>
                    <c:choose>
                        <c:when test="${not empty errors}">
                            <p class="error-message">${errors}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="error-message">An unexpected error has occurred. We apologize for the inconvenience. Please try again later or contact support if the issue persists.</p>
                        </c:otherwise>
                    </c:choose>
                    <c:set var="user" value="${sessionScope[Constants.SESSION_USER]}" />
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light">
                                <i class="fas fa-arrow-left me-2"></i>Back to Admin Dashboard
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-outline-light">
                                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>