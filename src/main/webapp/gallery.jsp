<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.User" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("kasir")) {
            response.sendRedirect("dashboard.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="id">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Gallery - Sistem Toko</title>
                <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <style>
                    .card-hover {
                        transition: all 0.3s ease;
                        cursor: pointer;
                    }

                    .card-hover:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
                    }

                    .card-hover img {
                        transition: transform 0.3s ease;
                        height: 250px;
                        object-fit: cover;
                    }

                    .card-hover:hover img {
                        transform: scale(1.05);
                    }

                    .lightbox {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.95);
                        z-index: 9999;
                        align-items: center;
                        justify-content: center;
                    }

                    .lightbox.active {
                        display: flex;
                    }

                    .lightbox-content {
                        position: relative;
                        max-width: 90%;
                        max-height: 90%;
                        animation: zoomIn 0.3s ease;
                    }

                    @keyframes zoomIn {
                        from {
                            transform: scale(0.8);
                            opacity: 0;
                        }

                        to {
                            transform: scale(1);
                            opacity: 1;
                        }
                    }

                    .lightbox-image {
                        max-width: 100%;
                        max-height: 90vh;
                        border-radius: 10px;
                        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
                    }

                    .lightbox-close {
                        position: absolute;
                        top: -50px;
                        right: 0;
                        background: white;
                        color: #333;
                        border: none;
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        font-size: 24px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .lightbox-close:hover {
                        background: #0d6efd;
                        color: white;
                        transform: rotate(90deg);
                    }

                    .lightbox-nav {
                        position: absolute;
                        top: 50%;
                        transform: translateY(-50%);
                        background: rgba(255, 255, 255, 0.9);
                        color: #333;
                        border: none;
                        width: 50px;
                        height: 50px;
                        border-radius: 50%;
                        font-size: 24px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .lightbox-nav:hover {
                        background: white;
                        transform: translateY(-50%) scale(1.1);
                    }

                    .lightbox-prev {
                        left: 20px;
                    }

                    .lightbox-next {
                        right: 20px;
                    }

                    .lightbox-info {
                        position: absolute;
                        bottom: -80px;
                        left: 0;
                        right: 0;
                        text-align: center;
                        color: white;
                    }

                    .lightbox-info h3 {
                        font-size: 1.5rem;
                        font-weight: 600;
                        margin-bottom: 5px;
                    }

                    .zoom-badge {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background: rgba(255, 255, 255, 0.9);
                        padding: 8px 12px;
                        border-radius: 20px;
                        opacity: 0;
                        transition: opacity 0.3s ease;
                    }

                    .card-hover:hover .zoom-badge {
                        opacity: 1;
                    }
                </style>
            </head>

            <body class="bg-light">
                <!-- Navbar - Dashboard Style -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="dashboard.jsp">Sistem Toko</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                    <a class="nav-link active" href="transaksi">Transaksi</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="laporan">Laporan</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="kasir/gallery.jsp">Gallery</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="kasir/about.jsp">About Us</a>
                </li>
            </ul>
            <div class="d-flex align-items-center text-white">
                <i class="bi bi-person-circle me-2"></i>
                <div>
                    <div class="fw-semibold"><%= user.getNamaLengkap() %></div>
                    <small>Kasir (Admin)</small>
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
                                <i class="bi bi-images text-primary me-2"></i>Gallery Produk
                            </h2>
                            <p class="text-muted">Koleksi produk elektronik dan furniture terbaik</p>
                        </div>
                    </div>

                    <!-- Gallery Tabs -->
                    <ul class="nav nav-pills mb-4" id="galleryTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="all-tab" data-bs-toggle="pill" data-bs-target="#all"
                                type="button">
                                <i class="bi bi-grid me-2"></i>Semua Produk
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="electronics-tab" data-bs-toggle="pill"
                                data-bs-target="#electronics" type="button">
                                <i class="bi bi-laptop me-2"></i>Elektronik
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="furniture-tab" data-bs-toggle="pill"
                                data-bs-target="#furniture" type="button">
                                <i class="bi bi-house me-2"></i>Furniture
                            </button>
                        </li>
                    </ul>

                    <!-- Gallery Content -->
                    <div class="tab-content" id="galleryTabContent">
                        <!-- All Products -->
                        <div class="tab-pane fade show active" id="all" role="tabpanel">
                            <div class="row g-4">
                                <!-- Laptop Gaming -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=800"
                                        data-title="Laptop Gaming" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Laptop Gaming">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Laptop Gaming</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Smartphone -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800"
                                        data-title="Smartphone Premium" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Smartphone">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Smartphone Premium</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Headphone -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800"
                                        data-title="Wireless Headphone" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Headphone">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Wireless Headphone</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Keyboard -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=800"
                                        data-title="Mechanical Keyboard RGB" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Keyboard">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Mechanical Keyboard RGB</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Gaming Mouse -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=800"
                                        data-title="Gaming Mouse RGB" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Mouse">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Gaming Mouse RGB</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Monitor 4K -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=800"
                                        data-title="Monitor 4K Ultra Wide" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Monitor">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Monitor 4K Ultra Wide</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modern Sofa -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800"
                                        data-title="Modern Minimalist Sofa" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Sofa">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Modern Minimalist Sofa</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Office Desk -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=800"
                                        data-title="Modern Office Desk" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Desk">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Modern Office Desk</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bookshelf -->
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1594620302200-9a762244a156?w=800"
                                        data-title="Wooden Bookshelf" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Bookshelf">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Wooden Bookshelf</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Electronics Only -->
                        <div class="tab-pane fade" id="electronics" role="tabpanel">
                            <div class="row g-4">
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=800"
                                        data-title="Laptop Gaming" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Laptop Gaming">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Laptop Gaming</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800"
                                        data-title="Smartphone Premium" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Smartphone">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Smartphone Premium</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800"
                                        data-title="Wireless Headphone" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Headphone">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Wireless Headphone</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=800"
                                        data-title="Mechanical Keyboard RGB" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Keyboard">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Mechanical Keyboard RGB</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=800"
                                        data-title="Gaming Mouse RGB" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Mouse">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Gaming Mouse RGB</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=800"
                                        data-title="Monitor 4K Ultra Wide" data-category="Elektronik">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Monitor">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Monitor 4K Ultra Wide</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Elektronik
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Furniture Only -->
                        <div class="tab-pane fade" id="furniture" role="tabpanel">
                            <div class="row g-4">
                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800"
                                        data-title="Modern Minimalist Sofa" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Sofa">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Modern Minimalist Sofa</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=800"
                                        data-title="Modern Office Desk" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Desk">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Modern Office Desk</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-lg-3">
                                    <div class="card border-0 shadow-sm card-hover"
                                        data-image="https://images.unsplash.com/photo-1594620302200-9a762244a156?w=800"
                                        data-title="Wooden Bookshelf" data-category="Furniture">
                                        <div class="position-relative overflow-hidden">
                                            <img src="https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500&h=500&fit=crop"
                                                class="card-img-top" alt="Bookshelf">
                                            <div class="zoom-badge">
                                                <i class="bi bi-zoom-in text-primary"></i>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold mb-1">Wooden Bookshelf</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="bi bi-tag me-1"></i>Furniture
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Lightbox Modal -->
                <div class="lightbox" id="lightbox">
                    <div class="lightbox-content">
                        <button class="lightbox-close" id="lightboxClose">
                            <i class="bi bi-x"></i>
                        </button>
                        <button class="lightbox-nav lightbox-prev" id="lightboxPrev">
                            <i class="bi bi-chevron-left"></i>
                        </button>
                        <img src="" alt="" class="lightbox-image" id="lightboxImage">
                        <button class="lightbox-nav lightbox-next" id="lightboxNext">
                            <i class="bi bi-chevron-right"></i>
                        </button>
                        <div class="lightbox-info">
                            <h3 id="lightboxTitle"></h3>
                            <p id="lightboxCategory"></p>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    const lightbox = document.getElementById('lightbox');
                    const lightboxImage = document.getElementById('lightboxImage');
                    const lightboxTitle = document.getElementById('lightboxTitle');
                    const lightboxCategory = document.getElementById('lightboxCategory');
                    const lightboxClose = document.getElementById('lightboxClose');
                    const lightboxPrev = document.getElementById('lightboxPrev');
                    const lightboxNext = document.getElementById('lightboxNext');

                    let currentImages = [];
                    let currentIndex = 0;

                    const galleryItems = document.querySelectorAll('.card-hover');

                    galleryItems.forEach((item, index) => {
                        item.addEventListener('click', function () {
                            const activeTab = document.querySelector('.tab-pane.active');
                            currentImages = Array.from(activeTab.querySelectorAll('.card-hover'));
                            currentIndex = currentImages.indexOf(item);
                            showLightbox(currentIndex);
                        });
                    });

                    function showLightbox(index) {
                        const item = currentImages[index];
                        lightboxImage.src = item.dataset.image;
                        lightboxTitle.textContent = item.dataset.title;
                        lightboxCategory.textContent = item.dataset.category;
                        lightbox.classList.add('active');
                        document.body.style.overflow = 'hidden';
                    }

                    function closeLightbox() {
                        lightbox.classList.remove('active');
                        document.body.style.overflow = 'auto';
                    }

                    lightboxClose.addEventListener('click', closeLightbox);
                    lightbox.addEventListener('click', function (e) {
                        if (e.target === lightbox) closeLightbox();
                    });

                    lightboxPrev.addEventListener('click', function (e) {
                        e.stopPropagation();
                        currentIndex = (currentIndex - 1 + currentImages.length) % currentImages.length;
                        showLightbox(currentIndex);
                    });

                    lightboxNext.addEventListener('click', function (e) {
                        e.stopPropagation();
                        currentIndex = (currentIndex + 1) % currentImages.length;
                        showLightbox(currentIndex);
                    });

                    document.addEventListener('keydown', function (e) {
                        if (lightbox.classList.contains('active')) {
                            if (e.key === 'Escape') closeLightbox();
                            else if (e.key === 'ArrowLeft') {
                                currentIndex = (currentIndex - 1 + currentImages.length) % currentImages.length;
                                showLightbox(currentIndex);
                            } else if (e.key === 'ArrowRight') {
                                currentIndex = (currentIndex + 1) % currentImages.length;
                                showLightbox(currentIndex);
                            }
                        }
                    });
                </script>
            </body>

            </html>