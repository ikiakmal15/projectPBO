<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.User" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("kasir")) {
            response.sendRedirect("dashboard.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="id">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>About Us - Sistem Toko</title>
                <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <style>
                    .hero-section {
                        background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                        color: white;
                        padding: 80px 0;
                        margin-bottom: 50px;
                    }

                    .feature-card {
                        transition: all 0.3s ease;
                        border: none;
                        height: 100%;
                    }

                    .feature-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
                    }

                    .feature-icon {
                        width: 70px;
                        height: 70px;
                        border-radius: 15px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2rem;
                        margin-bottom: 20px;
                    }

                    .icon-blue {
                        background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                        color: white;
                    }

                    .icon-green {
                        background: linear-gradient(135deg, #198754 0%, #146c43 100%);
                        color: white;
                    }

                    .icon-purple {
                        background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%);
                        color: white;
                    }

                    .icon-orange {
                        background: linear-gradient(135deg, #fd7e14 0%, #ca6510 100%);
                        color: white;
                    }

                    .icon-red {
                        background: linear-gradient(135deg, #dc3545 0%, #b02a37 100%);
                        color: white;
                    }

                    .icon-teal {
                        background: linear-gradient(135deg, #20c997 0%, #199d76 100%);
                        color: white;
                    }

                    .stats-card {
                        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                        border-radius: 15px;
                        padding: 30px;
                        text-align: center;
                    }

                    .timeline {
                        position: relative;
                        padding: 20px 0;
                    }

                    .timeline-item {
                        position: relative;
                        padding-left: 50px;
                        margin-bottom: 30px;
                    }

                    .timeline-item::before {
                        content: '';
                        position: absolute;
                        left: 15px;
                        top: 0;
                        bottom: -30px;
                        width: 2px;
                        background: #0d6efd;
                    }

                    .timeline-item:last-child::before {
                        display: none;
                    }

                    .timeline-dot {
                        position: absolute;
                        left: 8px;
                        top: 5px;
                        width: 16px;
                        height: 16px;
                        border-radius: 50%;
                        background: #0d6efd;
                        border: 3px solid white;
                        box-shadow: 0 0 0 3px #0d6efd;
                    }
                </style>
            </head>

            <body class="bg-light">
                <!-- Navbar - Dashboard Style -->
                <nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
                    <div class="container-fluid">
                        <a class="navbar-brand fw-bold" href="dashboard.jsp">Sistem Toko</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="jenis">Kategori</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="product">Kelola Produk</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="transaksi">Transaksi</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="laporan">Laporan</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="gallery.jsp">Gallery</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="about.jsp">About Us</a>
                                </li>
                            </ul>
                            <div class="d-flex align-items-center text-white">
                                <i class="bi bi-person-circle me-2"></i>
                                <div>
                                    <div class="fw-semibold">
                                        <%= user.getNamaLengkap() %>
                                    </div>
                                    <small>Kasir (Admin)</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Hero Section -->
                <div class="hero-section">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-8 mx-auto text-center">
                                <h1 class="display-4 fw-bold mb-3">
                                    <i class="bi bi-shop-window me-3"></i>Sistem Toko
                                </h1>
                                <p class="lead mb-4">
                                    Solusi Manajemen Toko Modern untuk Meningkatkan Efisiensi Bisnis Anda
                                </p>
                                <div class="d-flex justify-content-center gap-3">
                                    <span class="badge bg-light text-primary px-3 py-2">
                                        <i class="bi bi-check-circle-fill me-2"></i>Mudah Digunakan
                                    </span>
                                    <span class="badge bg-light text-primary px-3 py-2">
                                        <i class="bi bi-lightning-fill me-2"></i>Cepat & Efisien
                                    </span>
                                    <span class="badge bg-light text-primary px-3 py-2">
                                        <i class="bi bi-shield-check me-2"></i>Aman & Terpercaya
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- About Section -->
                <div class="container mb-5">
                    <div class="row mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-5">
                                    <h2 class="fw-bold mb-4">
                                        <i class="bi bi-info-circle text-primary me-2"></i>Tentang Sistem Toko
                                    </h2>
                                    <p class="lead text-muted mb-4">
                                        Sistem Toko adalah aplikasi manajemen toko berbasis web yang dirancang untuk
                                        membantu
                                        pemilik toko dan kasir dalam mengelola operasional bisnis sehari-hari dengan
                                        lebih efisien.
                                    </p>
                                    <p class="mb-3">
                                        Dengan antarmuka yang intuitif dan fitur-fitur lengkap, Sistem Toko memungkinkan
                                        Anda untuk:
                                    </p>
                                    <ul class="list-unstyled">
                                        <li class="mb-2"><i
                                                class="bi bi-check-circle-fill text-success me-2"></i>Mengelola produk
                                            dan kategori dengan mudah</li>
                                        <li class="mb-2"><i
                                                class="bi bi-check-circle-fill text-success me-2"></i>Memproses
                                            transaksi penjualan secara cepat</li>
                                        <li class="mb-2"><i
                                                class="bi bi-check-circle-fill text-success me-2"></i>Memantau stok
                                            barang secara real-time</li>
                                        <li class="mb-2"><i
                                                class="bi bi-check-circle-fill text-success me-2"></i>Menghasilkan
                                            laporan penjualan yang detail</li>
                                        <li class="mb-2"><i
                                                class="bi bi-check-circle-fill text-success me-2"></i>Mengelola data
                                            pelanggan dan riwayat pembelian</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Features Section -->
                    <div class="row mb-5">
                        <div class="col-12 text-center mb-5">
                            <h2 class="fw-bold">
                                <i class="bi bi-stars text-primary me-2"></i>Fitur Unggulan
                            </h2>
                            <p class="text-muted">Berbagai fitur lengkap untuk mendukung operasional toko Anda</p>
                        </div>

                        <!-- Dashboard -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-blue">
                                        <i class="bi bi-speedometer2"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Dashboard Interaktif</h5>
                                    <p class="text-muted mb-3">
                                        Pantau performa bisnis Anda dengan dashboard yang menampilkan statistik
                                        penjualan,
                                        produk terlaris, dan ringkasan transaksi dalam satu tampilan.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Statistik penjualan real-time</li>
                                        <li><i class="bi bi-dot"></i>Grafik penjualan harian/bulanan</li>
                                        <li><i class="bi bi-dot"></i>Produk terlaris & stok menipis</li>
                                        <li><i class="bi bi-dot"></i>Ringkasan transaksi terbaru</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Product Management -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-green">
                                        <i class="bi bi-box-seam-fill"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Kelola Produk</h5>
                                    <p class="text-muted mb-3">
                                        Manajemen produk yang lengkap dengan fitur CRUD (Create, Read, Update, Delete),
                                        pencarian, dan filter berdasarkan kategori.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Tambah, edit, hapus produk</li>
                                        <li><i class="bi bi-dot"></i>Upload gambar produk</li>
                                        <li><i class="bi bi-dot"></i>Kelola stok & harga</li>
                                        <li><i class="bi bi-dot"></i>Pencarian & filter produk</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Category Management -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-purple">
                                        <i class="bi bi-tags-fill"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Manajemen Kategori</h5>
                                    <p class="text-muted mb-3">
                                        Organisir produk dengan sistem kategori yang fleksibel untuk memudahkan
                                        pencarian dan pengelompokan produk.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Buat kategori baru</li>
                                        <li><i class="bi bi-dot"></i>Edit & hapus kategori</li>
                                        <li><i class="bi bi-dot"></i>Lihat produk per kategori</li>
                                        <li><i class="bi bi-dot"></i>Deskripsi kategori</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Transaction -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-orange">
                                        <i class="bi bi-cart-check-fill"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Transaksi Penjualan</h5>
                                    <p class="text-muted mb-3">
                                        Proses transaksi penjualan dengan cepat dan akurat, dilengkapi dengan
                                        keranjang belanja dan perhitungan otomatis.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Keranjang belanja interaktif</li>
                                        <li><i class="bi bi-dot"></i>Perhitungan total otomatis</li>
                                        <li><i class="bi bi-dot"></i>Validasi stok real-time</li>
                                        <li><i class="bi bi-dot"></i>Cetak struk transaksi</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Reports -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-red">
                                        <i class="bi bi-file-earmark-bar-graph-fill"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Laporan Penjualan</h5>
                                    <p class="text-muted mb-3">
                                        Generate laporan penjualan yang detail dengan filter berdasarkan tanggal,
                                        produk, atau kategori untuk analisis bisnis.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Laporan harian/bulanan/tahunan</li>
                                        <li><i class="bi bi-dot"></i>Filter berdasarkan periode</li>
                                        <li><i class="bi bi-dot"></i>Export ke PDF/Excel</li>
                                        <li><i class="bi bi-dot"></i>Grafik visualisasi data</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Gallery -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card feature-card shadow-sm">
                                <div class="card-body p-4">
                                    <div class="feature-icon icon-teal">
                                        <i class="bi bi-images"></i>
                                    </div>
                                    <h5 class="fw-bold mb-3">Gallery Produk</h5>
                                    <p class="text-muted mb-3">
                                        Tampilkan koleksi produk dalam galeri visual yang menarik dengan
                                        fitur lightbox dan filter kategori.
                                    </p>
                                    <ul class="list-unstyled small">
                                        <li><i class="bi bi-dot"></i>Galeri produk interaktif</li>
                                        <li><i class="bi bi-dot"></i>Filter berdasarkan kategori</li>
                                        <li><i class="bi bi-dot"></i>Lightbox zoom gambar</li>
                                        <li><i class="bi bi-dot"></i>Navigasi keyboard</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Technology Stack -->
                    <div class="row mb-5">
                        <div class="col-12 text-center mb-4">
                            <h2 class="fw-bold">
                                <i class="bi bi-code-slash text-primary me-2"></i>Teknologi yang Digunakan
                            </h2>
                            <p class="text-muted">Dibangun dengan teknologi modern dan terpercaya</p>
                        </div>
                        <div class="col-lg-10 mx-auto">
                            <div class="row g-4">
                                <div class="col-md-3 col-6">
                                    <div class="stats-card">
                                        <i class="bi bi-filetype-java text-danger" style="font-size: 3rem;"></i>
                                        <h6 class="fw-bold mt-3">Java</h6>
                                        <p class="small text-muted mb-0">Backend Logic</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-6">
                                    <div class="stats-card">
                                        <i class="bi bi-filetype-jsp text-warning" style="font-size: 3rem;"></i>
                                        <h6 class="fw-bold mt-3">JSP</h6>
                                        <p class="small text-muted mb-0">View Layer</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-6">
                                    <div class="stats-card">
                                        <i class="bi bi-bootstrap-fill text-primary" style="font-size: 3rem;"></i>
                                        <h6 class="fw-bold mt-3">Bootstrap 5</h6>
                                        <p class="small text-muted mb-0">UI Framework</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-6">
                                    <div class="stats-card">
                                        <i class="bi bi-database-fill text-success" style="font-size: 3rem;"></i>
                                        <h6 class="fw-bold mt-3">PostgreSQL</h6>
                                        <p class="small text-muted mb-0">Database</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- System Architecture -->
                    <div class="row mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-5">
                                    <h2 class="fw-bold mb-4 text-center">
                                        <i class="bi bi-diagram-3 text-primary me-2"></i>Arsitektur Sistem
                                    </h2>
                                    <div class="timeline">
                                        <div class="timeline-item">
                                            <div class="timeline-dot"></div>
                                            <h6 class="fw-bold">Presentation Layer (JSP)</h6>
                                            <p class="text-muted small mb-0">
                                                Antarmuka pengguna yang responsif dan modern menggunakan Bootstrap 5 dan
                                                JSP
                                            </p>
                                        </div>
                                        <div class="timeline-item">
                                            <div class="timeline-dot"></div>
                                            <h6 class="fw-bold">Business Logic Layer (Servlet)</h6>
                                            <p class="text-muted small mb-0">
                                                Logika bisnis yang menangani request, validasi, dan kontrol alur
                                                aplikasi
                                            </p>
                                        </div>
                                        <div class="timeline-item">
                                            <div class="timeline-dot"></div>
                                            <h6 class="fw-bold">Data Access Layer (DAO)</h6>
                                            <p class="text-muted small mb-0">
                                                Lapisan akses data yang mengelola komunikasi dengan database PostgreSQL
                                            </p>
                                        </div>
                                        <div class="timeline-item">
                                            <div class="timeline-dot"></div>
                                            <h6 class="fw-bold">Database Layer (PostgreSQL)</h6>
                                            <p class="text-muted small mb-0">
                                                Penyimpanan data yang aman dan terstruktur dengan relasi yang optimal
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contact/Support -->
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="card border-0 shadow-sm"
                                style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
                                <div class="card-body p-5 text-white text-center">
                                    <h3 class="fw-bold mb-3">Butuh Bantuan?</h3>
                                    <p class="mb-4">
                                        Tim support kami siap membantu Anda dalam menggunakan Sistem Toko
                                    </p>
                                    <div class="d-flex justify-content-center gap-3 flex-wrap">
                                        <a href="#" class="btn btn-light btn-lg">
                                            <i class="bi bi-envelope-fill me-2"></i>Email Support
                                        </a>
                                        <a href="#" class="btn btn-outline-light btn-lg">
                                            <i class="bi bi-book-fill me-2"></i>Dokumentasi
                                        </a>
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
                            <div class="col-md-6 text-center text-md-start">
                                <p class="mb-0">
                                    <i class="bi bi-shop-window me-2"></i>
                                    <strong>Sistem Toko</strong> &copy; 2026 - All Rights Reserved
                                </p>
                            </div>
                            <div class="col-md-6 text-center text-md-end">
                                <p class="mb-0">
                                    Made with <i class="bi bi-heart-fill text-danger"></i> using Java & Bootstrap
                                </p>
                            </div>
                        </div>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>