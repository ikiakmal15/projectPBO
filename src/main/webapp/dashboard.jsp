<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="dao.TransaksiDAO" %>
<%@ page import="dao.JenisDAO" %>
<%@ page import="model.Transaksi" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get statistics
    ProductDAO productDAO = new ProductDAO();
    TransaksiDAO transaksiDAO = new TransaksiDAO();
    JenisDAO jenisDAO = new JenisDAO();

    int totalProduct = productDAO.getAllProducts().size();
    int totalJenis = jenisDAO.getAllJenis().size();

    // For buyer, only show their own transactions
    int totalTransaksi = 0;
    double totalPendapatan = 0;

    if (user.getRole().equals("kasir")) {
        totalTransaksi = transaksiDAO.getAllTransaksi().size();
        List<Transaksi> transaksiList = transaksiDAO.getAllTransaksi();
        for (Transaksi t : transaksiList) {
            totalPendapatan += t.getTotal();
        }
    } else {
        // Buyer only sees their own transactions
        List<Transaksi> myTransaksi = transaksiDAO.getTransaksiByUserId(user.getId());
        totalTransaksi = myTransaksi.size();
        for (Transaksi t : myTransaksi) {
            totalPendapatan += t.getTotal();
        }
    }
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Sistem Toko</title>
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
                <div class="col-12">
                    <h2 class="fw-bold">
                        <i class="bi bi-speedometer2 text-primary me-2"></i>Dashboard
                    </h2>
                    <p class="text-muted">Selamat datang, <strong><%= user.getNamaLengkap()%></strong>!</p>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm h-100 card-hover">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">Total Produk</p>
                                    <h3 class="fw-bold mb-0 text-primary"><%= totalProduct%></h3>
                                </div>
                                <div class="bg-primary bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-box-seam-fill text-primary" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <% if (user.getRole().equals("kasir")) {%>
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm h-100 card-hover">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">Total Kategori</p>
                                    <h3 class="fw-bold mb-0 text-success"><%= totalJenis%></h3>
                                </div>
                                <div class="bg-success bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-tags-fill text-success" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }%>

                <div class="col-md-3">
                    <div class="card border-0 shadow-sm h-100 card-hover">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">
                                        <%= user.getRole().equals("kasir") ? "Total Transaksi" : "Transaksi Saya"%>
                                    </p>
                                    <h3 class="fw-bold mb-0 text-warning"><%= totalTransaksi%></h3>
                                </div>
                                <div class="bg-warning bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-cart-check-fill text-warning" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card border-0 shadow-sm h-100 card-hover">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">
                                        <%= user.getRole().equals("kasir") ? "Total Pendapatan" : "Total Belanja"%>
                                    </p>
                                    <h4 class="fw-bold mb-0 text-info">Rp <%= String.format("%,.0f", totalPendapatan)%></h4>
                                </div>
                                <div class="bg-info bg-opacity-10 p-3 rounded-3">
                                    <i class="bi bi-cash-stack text-info" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions & Info -->
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header text-white py-3" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
                            <h5 class="mb-0 fw-bold">
                                <i class="bi bi-lightning-charge-fill me-2"></i>Quick Actions
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="d-grid gap-3">
                                <% if (user.getRole().equals("kasir")) { %>
                                <a href="transaksi" class="btn btn-primary btn-lg shadow-sm">
                                    <i class="bi bi-cart-plus-fill me-2"></i>Buat Transaksi Baru
                                </a>
                                <a href="product" class="btn btn-outline-primary btn-lg">
                                    <i class="bi bi-plus-circle-fill me-2"></i>Tambah Produk
                                </a>
                                <a href="laporan" class="btn btn-outline-secondary btn-lg">
                                    <i class="bi bi-file-earmark-bar-graph-fill me-2"></i>Lihat Laporan
                                </a>
                                <% } else { %>
                                <a href="product?action=catalog" class="btn btn-primary btn-lg shadow-sm">
                                    <i class="bi bi-bag-plus-fill me-2"></i>Belanja Sekarang
                                </a>
                                <a href="transaksi?action=myhistory" class="btn btn-outline-primary btn-lg">
                                    <i class="bi bi-clock-history me-2"></i>Lihat Riwayat Belanja
                                </a>
                                <% }%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header text-white py-3" style="background: linear-gradient(135deg, #198754 0%, #146c43 100%);">
                            <h5 class="mb-0 fw-bold">
                                <i class="bi bi-info-circle-fill me-2"></i>Informasi Sistem
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-0">
                                <li class="mb-3 d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 p-2 rounded me-3">
                                        <i class="bi bi-person-badge-fill text-primary fs-4"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Username</small>
                                        <strong><%= user.getUsername()%></strong>
                                    </div>
                                </li>
                                <li class="mb-3 d-flex align-items-center">
                                    <div class="bg-success bg-opacity-10 p-2 rounded me-3">
                                        <i class="bi bi-shield-check text-success fs-4"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Role</small>
                                        <strong><%= user.getRole().equals("kasir") ? "Kasir (Admin)" : "Buyer (Pembeli)"%></strong>
                                    </div>
                                </li>
                                <li class="mb-0 d-flex align-items-center">
                                    <div class="bg-info bg-opacity-10 p-2 rounded me-3">
                                        <i class="bi bi-calendar-check-fill text-info fs-4"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Tanggal</small>
                                        <strong><%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date())%></strong>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/script.js"></script>
    </body>
</html>