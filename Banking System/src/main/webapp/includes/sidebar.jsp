<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<nav class="sidebar p-3"
     style="width: 250px; min-height: 100vh; background: #1e1e2f; border-right: 1px solid #2d2d3a;">
    <ul class="nav flex-column">

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center ${fn:endsWith(pageContext.request.requestURI, '/dashboard') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/customer/dashboard">
                <i class="fas fa-chart-pie me-3"></i> <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/accounts') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/accounts">
                <i class="fas fa-building-columns me-3"></i> <span>My Accounts</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center"
               href="${pageContext.request.contextPath}/customer/statements">
                <i class="fas fa-file-invoice-dollar me-3"></i> <span>Statements</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center"
               href="${pageContext.request.contextPath}/customer/loan_status">
                <i class="fas fa-landmark me-3"></i> <span>My Loans</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center"
               href="${pageContext.request.contextPath}/customer/apply_loan">
                <i class="fas fa-file-signature me-3"></i> <span>Apply Loan</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center"
               href="${pageContext.request.contextPath}/customer/repay_loan">
                <i class="fas fa-money-bill-wave me-3"></i> <span>Repay Loan</span>
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link d-flex align-items-center"
               href="${pageContext.request.contextPath}/customer/complaints">
                <i class="fas fa-headset me-3"></i> <span>My Complaints</span>
            </a>
        </li>

    </ul>
</nav>

<style>
.sidebar .nav-link {
    color: #a1a1aa;
    font-size: 1rem;
    font-weight: 500;
    padding: 0.75rem 1rem;
    transition: all 0.3s ease;
    border-left: 3px solid transparent;
    border-radius: 8px;
}
.sidebar .nav-link:hover, .sidebar .nav-link.active {
    background: rgba(139, 92, 246, 0.15); /* violet glow */
    color: #8b5cf6;
    border-left: 3px solid #8b5cf6;
    transform: translateX(3px);
}
.sidebar .nav-link.active {
    font-weight: 600;
}
.sidebar .nav-link i {
    width: 24px;
    text-align: center;
}
@media (max-width: 768px) {
    .sidebar {
        width: 100%;
        min-height: auto;
        border-right: none;
        border-bottom: 1px solid #2d2d3a;
    }
    .sidebar .nav-link {
        justify-content: center;
        padding: 0.6rem;
        font-size: 0.95rem;
    }
    .sidebar .nav-link span {
        display: none;
    }
    .sidebar .nav-link:hover span {
        display: inline;
    }
}
</style>
