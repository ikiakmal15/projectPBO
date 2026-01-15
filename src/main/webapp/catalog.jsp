<%-- 
    Document   : catalog
    Created on : 15 Jan 2026, 11.41.43
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Product> productList = (List<Product>) request.getAttribute("productList");
    List<Jenis> jenisList = (List<Jenis>) request.getAttribute("jenisList");
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Katalog Produk - Sistem Toko</title>
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
                            <a class="nav-link active" href="product?action=catalog">
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
                <div class="col-12">
                    <h2 class="fw-bold">
                        <i class="bi bi-grid-fill text-primary me-2"></i>Katalog Produk
                    </h2>
                    <p class="text-muted">Pilih produk yang ingin Anda beli</p>
                </div>
            </div>

            <!-- Filter & Search -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" class="form-control" id="searchProduct" 
                               placeholder="Cari produk...">
                    </div>
                </div>
                <div class="col-md-6">
                    <select class="form-select" id="filterKategori">
                        <option value="">Semua Kategori</option>
                        <% if (jenisList != null) {
                                for (Jenis jenis : jenisList) {%>
                        <option value="<%= jenis.getNama()%>"><%= jenis.getNama()%></option>
                        <% }
                            } %>
                    </select>
                </div>
            </div>

            <!-- Product Grid -->
            <div class="row g-4" id="productGrid">
                <% if (productList != null && !productList.isEmpty()) {
                        for (Product product : productList) {%>
                <div class="col-md-4 col-lg-3 product-item" 
                     data-name="<%= product.getNama().toLowerCase()%>"
                     data-kategori="<%= product.getJenisNama()%>">
                    <div class="card border-0 shadow-sm h-100 card-hover">
                        <div class="card-body">
                            <div class="text-center mb-3">
                                <% if (product.getFoto() != null && !product.getFoto().isEmpty()) {%>
                                <img src="<%= product.getFoto()%>" class="img-fluid rounded" 
                                     style="max-height: 150px; object-fit: cover;" alt="<%= product.getNama()%>">
                                <% } else { %>
                                <div class="bg-primary bg-opacity-10 rounded p-4">
                                    <i class="bi bi-box-seam text-primary" style="font-size: 4rem;"></i>
                                </div>
                                <% }%>
                            </div>
                            <span class="badge bg-info mb-2"><%= product.getJenisNama()%></span>
                            <h5 class="card-title fw-bold mb-2"><%= product.getNama()%></h5>
                            <p class="text-muted small mb-2">
                                <i class="bi bi-upc me-1"></i><%= product.getKode()%>
                            </p>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-success fw-bold mb-0">
                                    Rp <%= String.format("%,d", (int) product.getHarga())%>
                                </h4>
                                <% if (product.getStok() > 0) {%>
                                <span class="badge bg-success">Stok: <%= product.getStok()%></span>
                                <% } else { %>
                                <span class="badge bg-danger">Habis</span>
                                <% } %>
                            </div>
                            <% if (product.getStok() > 0) {%>
                            <button class="btn btn-primary w-100" 
                                    onclick="addToCart(<%= product.getId()%>, '<%= product.getNama()%>', <%= product.getHarga()%>, <%= product.getStok()%>)">
                                <i class="bi bi-cart-plus me-2"></i>Tambah ke Keranjang
                            </button>
                            <% } else { %>
                            <button class="btn btn-secondary w-100" disabled>
                                <i class="bi bi-x-circle me-2"></i>Stok Habis
                            </button>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% }
                } else { %>
                <div class="col-12">
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-inbox" style="font-size: 5rem;"></i>
                        <p class="mt-3 fs-5">Belum ada produk tersedia</p>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <!-- Cart Modal -->
        <div class="modal fade" id="cartModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">
                            <i class="bi bi-cart3 me-2"></i>Keranjang Belanja
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div id="cartItems"></div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Total:</h4>
                            <h3 class="text-primary mb-0" id="totalAmount">Rp 0</h3>
                        </div>
                        <div class="mb-3">
                            <label for="bayar" class="form-label fw-semibold">Bayar:</label>
                            <input type="number" class="form-control form-control-lg" id="bayar" 
                                   placeholder="Masukkan jumlah bayar" oninput="calculateChange()">
                        </div>
                        <div class="alert alert-info">
                            <strong>Kembalian:</strong>
                            <h4 class="mb-0" id="kembalian">Rp 0</h4>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                        <button type="button" class="btn btn-success" onclick="checkout()" id="checkoutBtn" disabled>
                            <i class="bi bi-check-circle me-2"></i>Checkout
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Floating Cart Button -->
        <button class="btn btn-primary btn-lg rounded-circle position-fixed bottom-0 end-0 m-4 shadow-lg" 
                style="width: 60px; height: 60px; z-index: 1000;" 
                data-bs-toggle="modal" data-bs-target="#cartModal" id="floatingCartBtn">
            <i class="bi bi-cart3 fs-4"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="cartCount">
                0
            </span>
        </button>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            let cart = [];
                            let total = 0;

                            // Search & Filter
                            document.getElementById('searchProduct').addEventListener('input', filterProducts);
                            document.getElementById('filterKategori').addEventListener('change', filterProducts);

                            function filterProducts() {
                                const searchTerm = document.getElementById('searchProduct').value.toLowerCase();
                                const kategori = document.getElementById('filterKategori').value;
                                const items = document.querySelectorAll('.product-item');

                                items.forEach(item => {
                                    const name = item.getAttribute('data-name');
                                    const kat = item.getAttribute('data-kategori');
                                    const matchSearch = name.includes(searchTerm);
                                    const matchKategori = kategori === '' || kat === kategori;

                                    if (matchSearch && matchKategori) {
                                        item.style.display = '';
                                    } else {
                                        item.style.display = 'none';
                                    }
                                });
                            }

                            function addToCart(id, nama, harga, stok) {
                                const existingItem = cart.find(item => item.id === id);

                                if (existingItem) {
                                    if (existingItem.qty < stok) {
                                        existingItem.qty++;
                                        existingItem.subtotal = existingItem.qty * existingItem.harga;
                                    } else {
                                        alert('Stok tidak mencukupi!');
                                        return;
                                    }
                                } else {
                                    cart.push({
                                        id: id,
                                        nama: nama,
                                        harga: harga,
                                        qty: 1,
                                        stok: stok,
                                        subtotal: harga
                                    });
                                }

                                updateCart();

                                // Show modal
                                new bootstrap.Modal(document.getElementById('cartModal')).show();
                            }

                            function removeFromCart(id) {
                                cart = cart.filter(item => item.id !== id);
                                updateCart();
                            }

                            function updateQty(id, qty) {
                                const item = cart.find(item => item.id === id);
                                if (item) {
                                    if (qty > 0 && qty <= item.stok) {
                                        item.qty = qty;
                                        item.subtotal = item.qty * item.harga;
                                        updateCart();
                                    } else if (qty > item.stok) {
                                        alert('Stok tidak mencukupi!');
                                    }
                                }
                            }

                            function updateCart() {
                                const cartContainer = document.getElementById('cartItems');
                                const cartCount = document.getElementById('cartCount');

                                if (cart.length === 0) {
                                    cartContainer.innerHTML = '<p class="text-center text-muted">Keranjang kosong</p>';
                                    cartCount.textContent = '0';
                                    document.getElementById('checkoutBtn').disabled = true;
                                    return;
                                }

                                let html = '';
                                cart.forEach(item => {
                                    html += `
                        <div class="card mb-2">
                            <div class="card-body p-3">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <h6 class="mb-1">${item.nama}</h6>
                                        <small class="text-muted">Rp ${item.harga.toLocaleString('id-ID')}</small>
                                    </div>
                                    <button class="btn btn-sm btn-danger" onclick="removeFromCart(${item.id})">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="input-group" style="width: 150px;">
                                        <button class="btn btn-outline-secondary btn-sm" onclick="updateQty(${item.id}, ${item.qty - 1})">-</button>
                                        <input type="number" class="form-control form-control-sm text-center" value="${item.qty}" 
                                               onchange="updateQty(${item.id}, parseInt(this.value))" min="1" max="${item.stok}">
                                        <button class="btn btn-outline-secondary btn-sm" onclick="updateQty(${item.id}, ${item.qty + 1})">+</button>
                                    </div>
                                    <strong class="text-primary">Rp ${item.subtotal.toLocaleString('id-ID')}</strong>
                                </div>
                            </div>
                        </div>
                    `;
                                });

                                cartContainer.innerHTML = html;
                                cartCount.textContent = cart.length;

                                total = cart.reduce((sum, item) => sum + item.subtotal, 0);
                                document.getElementById('totalAmount').textContent = 'Rp ' + total.toLocaleString('id-ID');
                                calculateChange();
                            }

                            function calculateChange() {
                                const bayar = parseFloat(document.getElementById('bayar').value) || 0;
                                const kembalian = bayar - total;

                                document.getElementById('kembalian').textContent = 'Rp ' + kembalian.toLocaleString('id-ID');

                                if (bayar >= total && total > 0) {
                                    document.getElementById('checkoutBtn').disabled = false;
                                } else {
                                    document.getElementById('checkoutBtn').disabled = true;
                                }
                            }

                            function checkout() {
                                const bayar = parseFloat(document.getElementById('bayar').value);
                                const kembalian = bayar - total;

                                if (cart.length === 0) {
                                    alert('Keranjang masih kosong!');
                                    return;
                                }

                                if (bayar < total) {
                                    alert('Jumlah bayar kurang!');
                                    return;
                                }

                                const form = document.createElement('form');
                                form.method = 'POST';
                                form.action = 'transaksi';

                                form.innerHTML = `
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="total" value="${total}">
                    <input type="hidden" name="bayar" value="${bayar}">
                    <input type="hidden" name="kembalian" value="${kembalian}">
                `;

                                cart.forEach(item => {
                                    form.innerHTML += `
                        <input type="hidden" name="productId[]" value="${item.id}">
                        <input type="hidden" name="qty[]" value="${item.qty}">
                        <input type="hidden" name="harga[]" value="${item.harga}">
                        <input type="hidden" name="subtotal[]" value="${item.subtotal}">
                    `;
                                });

                                document.body.appendChild(form);
                                form.submit();
                            }
        </script>
    </body>
</html>
