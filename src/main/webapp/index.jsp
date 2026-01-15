<%-- 
    Document   : index
    Created on : 15 Jan 2026, 10.48.16
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Selamat Datang - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <!-- Hero Section -->
        <div class="min-vh-100 d-flex align-items-center">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-5 mb-lg-0">
                        <div class="text-center text-lg-start">
                            <div class="mb-4">
                                <i class="bi bi-shop text-primary" style="font-size: 5rem;"></i>
                            </div>
                            <h1 class="display-3 fw-bold mb-4">
                                Sistem Toko
                                <span class="text-primary">Modern</span>
                            </h1>
                            <p class="lead text-muted mb-4">
                                Kelola toko Anda dengan mudah dan efisien. Sistem manajemen toko yang lengkap dengan fitur transaksi, inventori, dan laporan penjualan.
                            </p>
                            <div class="d-grid d-sm-flex gap-3 justify-content-center justify-content-lg-start">
                                <a href="login.jsp" class="btn btn-primary btn-lg px-5 py-3">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>Login
                                </a>
                                <a href="register.jsp" class="btn btn-outline-primary btn-lg px-5 py-3">
                                    <i class="bi bi-person-plus me-2"></i>Daftar
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100 card-hover">
                                    <div class="card-body text-center p-4">
                                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex p-4 mb-3">
                                            <i class="bi bi-box-seam text-primary" style="font-size: 3rem;"></i>
                                        </div>
                                        <h5 class="fw-bold mb-2">Manajemen Produk</h5>
                                        <p class="text-muted mb-0">Kelola produk dan stok dengan mudah</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100 card-hover">
                                    <div class="card-body text-center p-4">
                                        <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex p-4 mb-3">
                                            <i class="bi bi-cart-check text-success" style="font-size: 3rem;"></i>
                                        </div>
                                        <h5 class="fw-bold mb-2">Transaksi Cepat</h5>
                                        <p class="text-muted mb-0">Proses transaksi yang cepat dan akurat</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100 card-hover">
                                    <div class="card-body text-center p-4">
                                        <div class="bg-warning bg-opacity-10 rounded-circle d-inline-flex p-4 mb-3">
                                            <i class="bi bi-file-earmark-text text-warning" style="font-size: 3rem;"></i>
                                        </div>
                                        <h5 class="fw-bold mb-2">Laporan Lengkap</h5>
                                        <p class="text-muted mb-0">Laporan penjualan yang detail</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100 card-hover">
                                    <div class="card-body text-center p-4">
                                        <div class="bg-info bg-opacity-10 rounded-circle d-inline-flex p-4 mb-3">
                                            <i class="bi bi-shield-check text-info" style="font-size: 3rem;"></i>
                                        </div>
                                        <h5 class="fw-bold mb-2">Aman & Terpercaya</h5>
                                        <p class="text-muted mb-0">Data Anda aman dan terenkripsi</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features Section -->
                <div class="row mt-5 pt-5">
                    <div class="col-12 text-center mb-5">
                        <h2 class="fw-bold">Fitur Lengkap</h2>
                        <p class="text-muted">Semua yang Anda butuhkan untuk mengelola toko</p>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-primary bg-opacity-10 rounded p-3">
                                    <i class="bi bi-tags text-primary fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Kategori Produk</h5>
                                <p class="text-muted mb-0">Organisir produk berdasarkan kategori untuk memudahkan pencarian</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-success bg-opacity-10 rounded p-3">
                                    <i class="bi bi-graph-up text-success fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Tracking Stok</h5>
                                <p class="text-muted mb-0">Pantau stok produk secara real-time dan otomatis</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-warning bg-opacity-10 rounded p-3">
                                    <i class="bi bi-cash-stack text-warning fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Laporan Keuangan</h5>
                                <p class="text-muted mb-0">Lihat pendapatan dan statistik penjualan Anda</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-info bg-opacity-10 rounded p-3">
                                    <i class="bi bi-people text-info fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Multi User</h5>
                                <p class="text-muted mb-0">Kelola akses untuk admin dan kasir dengan role berbeda</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-danger bg-opacity-10 rounded p-3">
                                    <i class="bi bi-speedometer2 text-danger fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Dashboard Interaktif</h5>
                                <p class="text-muted mb-0">Dashboard yang informatif dengan statistik lengkap</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <div class="bg-primary bg-opacity-10 rounded p-3">
                                    <i class="bi bi-phone text-primary fs-3"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fw-bold">Responsive Design</h5>
                                <p class="text-muted mb-0">Akses dari perangkat apapun, desktop atau mobile</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        <h5 class="fw-bold mb-2">
                            <i class="bi bi-shop me-2"></i>Sistem Toko
                        </h5>
                        <p class="text-white-50 mb-0">Solusi manajemen toko yang modern dan efisien</p>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <p class="text-white-50 mb-0">
                            &copy; 2026 Sistem Toko. All rights reserved.
                        </p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
