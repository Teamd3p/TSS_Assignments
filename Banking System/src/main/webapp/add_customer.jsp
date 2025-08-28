<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer - VaultCore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <div class="d-flex">
        <%@ include file="includes/admin_sidebar.jsp" %>
        <main class="flex-grow-1 p-4">
            <div class="container-fluid">
                <h3 class="mb-4 text-primary"><i class="fas fa-user-plus me-2"></i>Add Customer</h3>
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>New Customer Details</h5>
                    </div>
                    <div class="card-body">
                        <form class="row g-3" method="post" action="${pageContext.request.contextPath}/admin/customer/create">
                            <div class="col-md-3">
                                <label class="form-label">User ID</label>
                                <input class="form-control" name="userId" placeholder="Enter User ID" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input class="form-control" name="fullName" placeholder="Enter Full Name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="Enter Email" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone</label>
                                <input class="form-control" name="phone" placeholder="Enter Phone" required pattern="^[0-9\-+()\s]{8,15}$" title="Enter a valid phone number">
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Address</label>
                                <input class="form-control" name="address" placeholder="Enter Address (Optional)">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Aadhar No</label>
                                <input class="form-control" name="aadhar" placeholder="Enter Aadhar No (Optional)" pattern="^[0-9]{12}$" title="Aadhar must be 12 digits">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">PAN No</label>
                                <input class="form-control" name="pan" placeholder="Enter PAN No (Optional)" pattern="^[A-Z]{5}[0-9]{4}[A-Z]{1}$" title="PAN must be 10 characters (5 letters, 4 digits, 1 letter)">
                            </div>
                            <div class="col-12 d-flex gap-2 mt-3">
                                <button class="btn btn-primary" type="submit"><i class="fas fa-save me-2"></i>Create Customer</button>
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-arrow-left me-2"></i>Back</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>