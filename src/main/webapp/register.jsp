<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container">
            <div class="row justify-content-center align-items-center min-vh-100">
                <div class="col-md-6">
                    <div class="card shadow-lg border-0 rounded-4">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-person-plus text-primary" style="font-size: 3rem;"></i>
                                <h2 class="fw-bold mt-3">Daftar Akun Baru</h2>
                                <p class="text-muted">Lengkapi form di bawah untuk mendaftar</p>
                            </div>

                            <% if (request.getAttribute("error") != null) {%>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error")%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% }%>

                            <form action="auth" method="post">
                                <input type="hidden" name="action" value="register">

                                <div class="mb-3">
                                    <label for="namaLengkap" class="form-label fw-semibold">Nama Lengkap</label>
                                    <input type="text" class="form-control" id="namaLengkap" 
                                           name="namaLengkap" placeholder="Masukkan nama lengkap" required>
                                </div>

                                <div class="mb-3">
                                    <label for="username" class="form-label fw-semibold">Username</label>
                                    <input type="text" class="form-control" id="username" 
                                           name="username" placeholder="Masukkan username" required>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label fw-semibold">Password</label>
                                    <input type="password" class="form-control" id="password" 
                                           name="password" placeholder="Masukkan password" required>
                                </div>

                                <div class="mb-4">
                                    <label for="role" class="form-label fw-semibold">Role</label>
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="buyer">Buyer (Pembeli)</option>
                                        <option value="kasir">Kasir (Admin)</option>
                                    </select>
                                    <small class="text-muted">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Pilih <strong>Buyer</strong> untuk pembeli, <strong>Kasir</strong> untuk admin
                                    </small>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                                    <i class="bi bi-person-check me-2"></i>Daftar
                                </button>
                            </form>

                            <div class="text-center mt-4">
                                <p class="text-muted mb-0">Sudah punya akun? 
                                    <a href="login.jsp" class="text-primary fw-semibold text-decoration-none">
                                        Login di sini
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