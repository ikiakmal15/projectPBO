<%-- 
    Document   : laporan
    Created on : 15 Jan 2026, 10.45.34
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
    Double totalPendapatan = (Double) request.getAttribute("totalPendapatan");
    Integer totalTransaksi = (Integer) request.getAttribute("totalTransaksi");

    if (totalPendapatan == null) {
        totalPendapatan = 0.0;
    }
    if (totalTransaksi == null)
        totalTransaksi = 0;
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laporan - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <!-- Navbar - Dashboard Style -->
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
                            <a class="nav-link active" href="dashboard.jsp">
                                <i class="bi bi-speedometer2"></i>
                                <span class="ms-1">Dashboard</span>
                            </a>
                        </li>

                        <% if (user.getRole().equals("kasir")) { %>
                        <!-- Menu untuk Kasir (Admin) -->
                        <li class="nav-item">
                            <a class="nav-link" href="jenis">
                                <i class="bi bi-tags-fill"></i>
                                <span class="ms-1">Kategori</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="product">
                                <i class="bi bi-box-seam-fill"></i>
                                <span class="ms-1">Kelola Produk</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="transaksi">
                                <i class="bi bi-cart-check-fill"></i>
                                <span class="ms-1">Transaksi</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="laporan">
                                <i class="bi bi-file-earmark-bar-graph-fill"></i>
                                <span class="ms-1">Laporan</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="gallery.jsp">
                                <i class="bi bi-images"></i>
                                <span class="ms-1">Gallery</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.jsp">
                                <i class="bi bi-info-circle-fill"></i>
                                <span class="ms-1">About Us</span>
                            </a>
                        </li>
                        <% } else { %>
                        <!-- Menu untuk Buyer (Pembeli) -->
                        <li class="nav-item">
                            <a class="nav-link" href="product?action=catalog">
                                <i class="bi bi-grid-fill"></i>
                                <span class="ms-1">Katalog Produk</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="transaksi?action=myhistory">
                                <i class="bi bi-clock-history"></i>
                                <span class="ms-1">Riwayat Belanja</span>
                            </a>
                        </li>
                        <% }%>
                    </ul>
                    <div class="d-flex align-items-center">
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center text-white" href="#" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle fs-5 me-2"></i>
                                <div class="d-flex flex-column align-items-start">
                                    <span class="fw-semibold"><%= user.getNamaLengkap()%></span>
                                    <small class="badge bg-light text-primary">
                                        <%= user.getRole().equals("kasir") ? "Kasir (Admin)" : "Buyer (Pembeli)"%>
                                    </small>
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="#">
                                        <i class="bi bi-person-fill me-2"></i>Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#">
                                        <i class="bi bi-gear-fill me-2"></i>Pengaturan
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="auth?action=logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                                    </a>
                                </li>
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
                    <h2 class="fw-bold">Laporan Transaksi</h2>
                    <p class="text-muted">Riwayat transaksi penjualan</p>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn btn-success" onclick="window.print()">
                        <i class="bi bi-printer me-2"></i>Cetak Laporan
                    </button>
                </div>
            </div>

            <!-- Summary Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1">Total Transaksi</p>
                                    <h2 class="fw-bold mb-0"><%= totalTransaksi%></h2>
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
                                    <p class="text-muted mb-1">Total Pendapatan</p>
                                    <h2 class="fw-bold mb-0 text-success">Rp <%= String.format("%,.0f", totalPendapatan)%></h2>
                                </div>
                                <div class="bg-success bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-cash-stack text-success" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Kode Transaksi</th>
                                    <th>Tanggal</th>
                                    <th>Kasir</th>
                                    <th>Total</th>
                                    <th>Bayar</th>
                                    <th>Kembalian</th>
                                    <th>Status</th>
                                    <th class="text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (transaksiList != null && !transaksiList.isEmpty()) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                    for (Transaksi transaksi : transaksiList) {%>
                                <tr>
                                    <td><span class="badge bg-primary"><%= transaksi.getKodeTransaksi()%></span></td>
                                    <td><%= sdf.format(transaksi.getTanggal())%></td>
                                    <td><%= transaksi.getUserNama()%></td>
                                    <td class="fw-bold text-success">Rp <%= String.format("%,d", (int) transaksi.getTotal())%></td>
                                    <td>Rp <%= String.format("%,d", (int) transaksi.getBayar())%></td>
                                    <td>Rp <%= String.format("%,d", (int) transaksi.getKembalian())%></td>
                                    <td><span class="badge bg-success"><%= transaksi.getStatus()%></span></td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-info text-white" 
                                                onclick="viewDetail(<%= transaksi.getId()%>)">
                                            <i class="bi bi-eye"></i> Detail
                                        </button>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                                        <p class="mt-2">Belum ada transaksi</p>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            function viewDetail(id) {
                                                                window.location.href = 'transaksi?action=detail&id=' + id;
                                                            }
        </script>
    </body>
</html>
