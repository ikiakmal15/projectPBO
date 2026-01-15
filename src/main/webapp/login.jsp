<%-- 
    Document   : login
    Created on : 15 Jan 2026, 10.36.58
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container">
            <div class="row justify-content-center align-items-center min-vh-100">
                <div class="col-md-5">
                    <div class="card shadow-lg border-0 rounded-4">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-shop text-primary" style="font-size: 3rem;"></i>
                                <h2 class="fw-bold mt-3">Sistem Toko</h2>
                                <p class="text-muted">Silakan login untuk melanjutkan</p>
                            </div>

                            <% if (request.getAttribute("error") != null) {%>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error")%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <% if (request.getAttribute("success") != null) {%>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>
                                <%= request.getAttribute("success")%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% }%>

                            <form action="auth" method="post">
                                <input type="hidden" name="action" value="login">

                                <div class="mb-3">
                                    <label for="username" class="form-label fw-semibold">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="bi bi-person"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" id="username" 
                                               name="username" placeholder="Masukkan username" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="password" class="form-label fw-semibold">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="bi bi-lock"></i>
                                        </span>
                                        <input type="password" class="form-control border-start-0" id="password" 
                                               name="password" placeholder="Masukkan password" required>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>Login
                                </button>
                            </form>

                            <div class="text-center mt-4">
                                <p class="text-muted mb-0">Belum punya akun? 
                                    <a href="register.jsp" class="text-primary fw-semibold text-decoration-none">
                                        Daftar di sini
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
