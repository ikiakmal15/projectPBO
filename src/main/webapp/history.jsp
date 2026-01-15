<%-- 
    Document   : history
    Created on : 15 Jan 2026, 11.45.07
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Transaksi> transaksiList = (List<Transaksi>) request.getAttribute("transaksiList");
    Double totalBelanja = (Double) request.getAttribute("totalBelanja");
    Integer totalTransaksi = (Integer) request.getAttribute("totalTransaksi");

    if (totalBelanja == null) {
        totalBelanja = 0.0;
    }
    if (totalTransaksi == null)
        totalTransaksi = 0;
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Riwayat Belanja - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="dashboard.jsp">
                    <i class="bi bi-shop-window"></i>
                    <span class="ms-2">Sistem Toko</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="bi bi-speedometer2"></i>
                                <span class="ms-1">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="product?action=catalog">
                                <i class="bi bi-grid-fill"></i>
                                <span class="ms-1">Katalog Produk</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="transaksi?action=myhistory">
                                <i class="bi bi-clock-history"></i>
                                <span class="ms-1">Riwayat Belanja</span>
                            </a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center text-white" href="#" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle fs-5 me-2"></i>
                                <div class="d-flex flex-column align-items-start">
                                    <span class="fw-semibold"><%= user.getNamaLengkap()%></span>
                                    <small class="badge bg-light text-primary">Buyer (Pembeli)</small>
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><i class="bi bi-person-fill me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-gear-fill me-2"></i>Pengaturan</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="auth?action=logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container-fluid py-4">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h2 class="fw-bold">
                        <i class="bi bi-clock-history text-primary me-2"></i>Riwayat Belanja
                    </h2>
                    <p class="text-muted">Lihat semua transaksi belanja Anda</p>
                </div>
                <div class="col-md-6 text-end">
                    <a href="product?action=catalog" class="btn btn-primary">
                        <i class="bi bi-bag-plus me-2"></i>Belanja Lagi
                    </a>
                </div>
            </div>

            <!-- Summary Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 fw-semibold">Total Transaksi</p>
                                    <h2 class="fw-bold mb-0 text-primary"><%= totalTransaksi%></h2>
                                </div>
                                <div class="bg-primary bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-receipt text-primary" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 fw-semibold">Total Belanja</p>
                                    <h2 class="fw-bold mb-0 text-success">Rp <%= String.format("%,.0f", totalBelanja)%></h2>
                                </div>
                                <div class="bg-success bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-cash-stack text-success" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Transaction List -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-list-ul me-2"></i>Daftar Transaksi
                    </h5>
                </div>
                <div class="card-body">
                    <% if (transaksiList != null && !transaksiList.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy HH:mm");
                        for (Transaksi transaksi : transaksiList) {%>
                    <div class="card mb-3 border">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary bg-opacity-10 p-3 rounded me-3">
                                            <i class="bi bi-receipt-cutoff text-primary fs-3"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-1 fw-bold"><%= transaksi.getKodeTransaksi()%></h6>
                                            <small class="text-muted">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                <%= sdf.format(transaksi.getTanggal())%>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <small class="text-muted d-block">Total Belanja</small>
                                    <h5 class="mb-0 text-success fw-bold">
                                        Rp <%= String.format("%,d", (int) transaksi.getTotal())%>
                                    </h5>
                                </div>
                                <div class="col-md-3">
                                    <small class="text-muted d-block">Status</small>
                                    <span class="badge bg-success fs-6">
                                        <i class="bi bi-check-circle me-1"></i><%= transaksi.getStatus()%>
                                    </span>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-outline-primary btn-sm" 
                                            onclick="viewDetail(<%= transaksi.getId()%>)">
                                        <i class="bi bi-eye me-1"></i>Lihat Detail
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-inbox" style="font-size: 5rem;"></i>
                        <p class="mt-3 fs-5">Belum ada transaksi</p>
                        <a href="product?action=catalog" class="btn btn-primary mt-2">
                            <i class="bi bi-bag-plus me-2"></i>Mulai Belanja
                        </a>
                    </div>
                    <% }%>
                </div>
            </div>
        </div>

        <!-- Detail Modal -->
        <div class="modal fade" id="detailModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">
                            <i class="bi bi-receipt me-2"></i>Detail Transaksi
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="detailContent">
                        <div class="text-center py-5">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        function viewDetail(id) {
                                                            const modal = new bootstrap.Modal(document.getElementById('detailModal'));
                                                            modal.show();

                                                            // Fetch detail via AJAX
                                                            fetch('transaksi?action=detail&id=' + id)
                                                                    .then(response => response.text())
                                                                    .then(html => {
                                                                        // Extract content from response
                                                                        const parser = new DOMParser();
                                                                        const doc = parser.parseFromString(html, 'text/html');
                                                                        const content = doc.querySelector('.container-fluid');

                                                                        if (content) {
                                                                            document.getElementById('detailContent').innerHTML = content.innerHTML;
                                                                        } else {
                                                                            document.getElementById('detailContent').innerHTML = '<p class="text-center text-muted">Gagal memuat detail</p>';
                                                                        }
                                                                    })
                                                                    .catch(error => {
                                                                        console.error('Error:', error);
                                                                        document.getElementById('detailContent').innerHTML = '<p class="text-center text-danger">Terjadi kesalahan</p>';
                                                                    });
                                                        }
        </script>
    </body>
</html>
