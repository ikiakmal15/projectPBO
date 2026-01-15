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
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaksi - Sistem Toko</title>
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/style.css" rel="stylesheet">
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
                    <i class="bi bi-cart-check-fill text-primary me-2"></i>Transaksi Penjualan
                </h2>
                <p class="text-muted">Buat transaksi penjualan baru</p>
            </div>
        </div>

        <!-- Alert Messages -->
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>
                Transaksi berhasil! Kode: <strong><%= request.getParameter("kode") %></strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>
                <% String error = request.getParameter("error");
                   if (error.equals("empty_total")) { %>
                    Total kosong!
                <% } else if (error.equals("empty_bayar")) { %>
                    Jumlah bayar kosong!
                <% } else if (error.equals("empty_kembalian")) { %>
                    Kembalian kosong!
                <% } else if (error.equals("invalid_total")) { %>
                    Format total tidak valid!
                <% } else if (error.equals("invalid_bayar")) { %>
                    Format bayar tidak valid!
                <% } else if (error.equals("invalid_kembalian")) { %>
                    Format kembalian tidak valid!
                <% } else if (error.equals("invalid_total_amount")) { %>
                    Total harus lebih dari 0!
                <% } else if (error.equals("insufficient_payment")) { %>
                    Jumlah bayar kurang!
                <% } else if (error.equals("nocart")) { %>
                    Keranjang belanja kosong!
                <% } else if (error.equals("noitems")) { %>
                    Tidak ada item yang valid di keranjang!
                <% } else if (error.equals("exception")) { %>
                    Exception: <%= request.getParameter("msg") %>
                <% } else { %>
                    Terjadi kesalahan: <%= error %>
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <div class="row">
            <!-- Product List -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0 fw-bold">Daftar Produk</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <input type="text" class="form-control" id="searchProduct" 
                                   placeholder="Cari produk...">
                        </div>
                        <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                            <table class="table table-hover align-middle">
                                <thead class="table-light sticky-top">
                                    <tr>
                                        <th>Produk</th>
                                        <th>Harga</th>
                                        <th>Stok</th>
                                        <th width="15%">Aksi</th>
                                    </tr>
                                </thead>
                                <tbody id="productTableBody">
                                    <% if (productList != null && !productList.isEmpty()) {
                                        for (Product product : productList) { %>
                                            <tr data-product-name="<%= product.getNama().toLowerCase() %>">
                                                <td>
                                                    <div class="fw-semibold"><%= product.getNama() %></div>
                                                    <small class="text-muted"><%= product.getKode() %> - <%= product.getJenisNama() %></small>
                                                </td>
                                                <td class="text-success fw-bold">Rp <%= String.format("%,d", (int)product.getHarga()) %></td>
                                                <td>
                                                    <% if (product.getStok() > 0) { %>
                                                        <span class="badge bg-success"><%= product.getStok() %></span>
                                                    <% } else { %>
                                                        <span class="badge bg-danger">Habis</span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <% if (product.getStok() > 0) { %>
                                                        <button class="btn btn-sm btn-primary" 
                                                                onclick="addToCart(<%= product.getId() %>, '<%= product.getNama() %>', <%= product.getHarga() %>, <%= product.getStok() %>)">
                                                            <i class="bi bi-plus-circle"></i>
                                                        </button>
                                                    <% } else { %>
                                                        <button class="btn btn-sm btn-secondary" disabled>
                                                            <i class="bi bi-x-circle"></i>
                                                        </button>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <% }
                                    } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cart -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm sticky-top" style="top: 20px;">
                    <div class="card-header text-white py-3" style="background: linear-gradient(135deg, #008cba 0%, #006f94 100%);">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-cart3 me-2"></i>Keranjang Belanja
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="cartItems" style="max-height: 300px; overflow-y: auto;">
                            <div class="text-center text-muted py-5" id="emptyCart">
                                <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                                <p class="mt-2">Keranjang kosong</p>
                            </div>
                        </div>

                        <hr>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="fw-semibold">Total:</span>
                                <span class="fw-bold text-primary fs-4" id="totalAmount">Rp 0</span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="bayar" class="form-label fw-semibold">Bayar:</label>
                            <input type="number" class="form-control form-control-lg" id="bayar" 
                                   placeholder="Masukkan jumlah bayar" oninput="calculateChange()">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kembalian:</label>
                            <div class="alert alert-info mb-0">
                                <h4 class="mb-0" id="kembalian">Rp 0</h4>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button class="btn btn-success btn-lg" onclick="checkout()" id="checkoutBtn" disabled>
                                <i class="bi bi-check-circle me-2"></i>Proses Transaksi
                            </button>
                            <button class="btn btn-outline-danger" onclick="clearCart()" id="clearBtn" disabled>
                                <i class="bi bi-trash me-2"></i>Kosongkan Keranjang
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let cart = [];
        let total = 0;

        // Search product
        document.getElementById('searchProduct').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#productTableBody tr');
            
            rows.forEach(row => {
                const productName = row.getAttribute('data-product-name');
                if (productName.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

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
            
            renderCart();
            calculateTotal();
        }

        function removeFromCart(id) {
            cart = cart.filter(item => item.id !== id);
            renderCart();
            calculateTotal();
        }

        function updateQty(id, qty) {
            const item = cart.find(item => item.id === id);
            if (item) {
                if (qty > 0 && qty <= item.stok) {
                    item.qty = qty;
                    item.subtotal = item.qty * item.harga;
                    renderCart();
                    calculateTotal();
                } else if (qty > item.stok) {
                    alert('Stok tidak mencukupi!');
                } else if (qty <= 0) {
                    removeFromCart(id);
                }
            }
        }

        function renderCart() {
            const cartContainer = document.getElementById('cartItems');
            const emptyCart = document.getElementById('emptyCart');
            
            if (cart.length === 0) {
                emptyCart.style.display = 'block';
                document.getElementById('checkoutBtn').disabled = true;
                document.getElementById('clearBtn').disabled = true;
                return;
            }
            
            emptyCart.style.display = 'none';
            document.getElementById('clearBtn').disabled = false;
            
            let html = '';
            cart.forEach(item => {
                html += `
                    <div class="card mb-2 border">
                        <div class="card-body p-2">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">${item.nama}</h6>
                                    <small class="text-muted">Rp ${item.harga.toLocaleString('id-ID')}</small>
                                </div>
                                <button class="btn btn-sm btn-danger" onclick="removeFromCart(${item.id})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="input-group input-group-sm" style="width: 120px;">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="updateQty(${item.id}, ${item.qty - 1})">-</button>
                                    <input type="number" class="form-control text-center" value="${item.qty}" 
                                           onchange="updateQty(${item.id}, parseInt(this.value) || 0)" min="1" max="${item.stok}">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="updateQty(${item.id}, ${item.qty + 1})">+</button>
                                </div>
                                <strong class="text-primary">Rp ${item.subtotal.toLocaleString('id-ID')}</strong>
                            </div>
                        </div>
                    </div>
                `;
            });
            
            cartContainer.innerHTML = html;
        }

        function calculateTotal() {
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
                document.getElementById('kembalian').className = 'mb-0 text-success';
            } else {
                document.getElementById('checkoutBtn').disabled = true;
                document.getElementById('kembalian').className = 'mb-0 text-danger';
            }
        }

        function clearCart() {
            if (confirm('Yakin ingin mengosongkan keranjang?')) {
                cart = [];
                total = 0;
                document.getElementById('bayar').value = '';
                renderCart();
                calculateTotal();
            }
        }

        function checkout() {
            const bayar = parseFloat(document.getElementById('bayar').value);
            const kembalian = bayar - total;
            
            // DEBUGGING: Log semua data
            console.log('=== CHECKOUT DEBUG ===');
            console.log('Total:', total);
            console.log('Bayar:', bayar);
            console.log('Kembalian:', kembalian);
            console.log('Cart:', cart);
            
            if (cart.length === 0) {
                alert('Keranjang masih kosong!');
                return;
            }
            
            if (!bayar || bayar <= 0 || isNaN(bayar)) {
                alert('Masukkan jumlah bayar yang valid!');
                return;
            }
            
            if (bayar < total) {
                alert('Jumlah bayar kurang!');
                return;
            }
            
            // Validate all cart items before submitting
            let hasInvalidItem = false;
            cart.forEach((item, index) => {
                console.log(`Item ${index}:`, item);
                if (!item.id || !item.qty || !item.harga || !item.subtotal) {
                    console.error(`Invalid item at index ${index}:`, item);
                    hasInvalidItem = true;
                }
            });
            
            if (hasInvalidItem) {
                alert('Ada item yang tidak valid di keranjang!');
                return;
            }
            
            // Create form
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'transaksi';
            
            // Add hidden fields - PASTIKAN TIDAK ADA NILAI KOSONG
            const hiddenFields = `
                <input type="hidden" name="action" value="save">
                <input type="hidden" name="total" value="${total.toFixed(2)}">
                <input type="hidden" name="bayar" value="${bayar.toFixed(2)}">
                <input type="hidden" name="kembalian" value="${kembalian.toFixed(2)}">
            `;
            form.innerHTML = hiddenFields;
            
            console.log('Hidden fields:', hiddenFields);
            
            // Add cart items - VALIDASI SETIAP ITEM
            let itemsHTML = '';
            cart.forEach((item, index) => {
                const itemHTML = `
                    <input type="hidden" name="productId[]" value="${item.id}">
                    <input type="hidden" name="qty[]" value="${item.qty}">
                    <input type="hidden" name="harga[]" value="${item.harga.toFixed(2)}">
                    <input type="hidden" name="subtotal[]" value="${item.subtotal.toFixed(2)}">
                `;
                itemsHTML += itemHTML;
                console.log(`Item ${index} HTML:`, itemHTML);
            });
            
            form.innerHTML += itemsHTML;
            
            console.log('Form HTML:', form.innerHTML);
            console.log('=== END DEBUG ===');
            
            // Submit form
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>