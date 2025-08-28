<%-- src/main/webapp/WEB-INF/jsp/includes/admin_sidebar.jsp --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav class="sidebar p-3">
    <ul class="nav flex-column">
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:endsWith(pageContext.request.requestURI, '/admin/dashboard') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-home me-3 opacity-75"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/customers') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/customers">
                <i class="fas fa-users me-3 opacity-75"></i>
                <span>Manage Customers</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/accounts') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/accounts">
                <i class="fas fa-wallet me-3 opacity-75"></i>
                <span>Manage Accounts</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/transactions') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/transactions">
                <i class="fas fa-exchange-alt me-3 opacity-75"></i>
                <span>View Transactions</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/loans') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/loans">
                <i class="fas fa-hand-holding-usd me-3 opacity-75"></i>
                <span>Loan Approvals</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/complaints') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/complaints">
                <i class="fas fa-exclamation-circle me-3 opacity-75"></i>
                <span>Complaints</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/logs') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/logs">
                <i class="fas fa-file-alt me-3 opacity-75"></i>
                <span>Activity Logs</span>
            </a>
        </li>
        <li class="nav-item mb-2">
            <a class="nav-link rounded-3 d-flex align-items-center ${fn:contains(pageContext.request.requestURI, '/admin/reports') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar me-3 opacity-75"></i>
                <span>Reports</span>
            </a>
        </li>
    </ul>
</nav>

<style>
    .sidebar {
        width: 250px;
        min-height: 100vh;
        background: #1e2b3b;
        border-right: 1px solid #334155;
    }

    .sidebar .nav-link {
        color: #94a3b8;
        font-size: 1rem;
        font-weight: 500;
        padding: 0.75rem 1rem;
        transition: all 0.2s ease;
    }

    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
        background: linear-gradient(135deg, #a78bfa, #6d28d9);
        color: #ffffff;
        box-shadow: 0 4px 15px rgba(167, 139, 250, 0.25);
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
            border-bottom: 1px solid #334155;
        }
        .sidebar .nav-link {
            justify-content: center;
            padding: 0.6rem;
            font-size: 0.95rem;
        }
        .sidebar .nav-link span {
            display: none;
        }
    }
</style>