<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.role != 'USER'}">
    <c:redirect url="login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Leave Balance</title>
    <link rel="stylesheet" href="css/dashboard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container narrow">
    <header class="page-header">
        <div>
            <h1>Leave Balance</h1>
            <p class="muted">Welcome, ${sessionScope.name != null ? sessionScope.name : 'User'}</p>
        </div>
    </header>
    <main>
        <section class="panel">
            <h2>Your Leave Balance</h2>
            <c:choose>
                <c:when test="${not empty leaveBalance}">
                    <div class="panel small">
                        <p><strong>Employee:</strong> ${leaveBalance.empId}</p>
                        <p><strong>Total Leaves:</strong> ${leaveBalance.totalLeaves}</p>
                        <p><strong>Leaves Taken:</strong> ${leaveBalance.leavesTaken}</p>
                        <p><strong>Remaining:</strong> ${leaveBalance.remainingLeaves}</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="muted">No leave balance found for this employee.</p>
                </c:otherwise>
            </c:choose>
        </section>
    </main>
</div>
</body>
</html>