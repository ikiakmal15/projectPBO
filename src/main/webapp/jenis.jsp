<%-- 
    Document   : jenis
    Created on : 15 Jan 2026, 10.40.46
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

    List<Jenis> jenisList = (List<Jenis>) request.getAttribute("jenisList");
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kategori - Sistem Toko</title>
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
                    <h2 class="fw-bold">Manajemen Kategori</h2>
                    <p class="text-muted">Kelola kategori produk toko Anda</p>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                        <i class="bi bi-plus-circle me-2"></i>Tambah Kategori
                    </button>
                </div>
            </div>

            <!-- Alert Messages -->
            <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>
                <% if (request.getParameter("success").equals("add")) { %>
                Kategori berhasil ditambahkan!
                <% } else if (request.getParameter("success").equals("update")) { %>
                Kategori berhasil diupdate!
                <% } else if (request.getParameter("success").equals("delete")) { %>
                Kategori berhasil dihapus!
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>
                Terjadi kesalahan! Silakan coba lagi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Table -->
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th width="10%">ID</th>
                                    <th width="70%">Nama Kategori</th>
                                    <th width="20%" class="text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (jenisList != null && !jenisList.isEmpty()) {
                                        for (Jenis jenis : jenisList) {%>
                                <tr>
                                    <td><span class="badge bg-primary"><%= jenis.getId()%></span></td>
                                    <td class="fw-semibold"><%= jenis.getNama()%></td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-warning" 
                                                onclick="editJenis(<%= jenis.getId()%>, '<%= jenis.getNama()%>')">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <a href="jenis?action=delete&id=<%= jenis.getId()%>" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Yakin ingin menghapus kategori ini?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                                        <p class="mt-2">Belum ada kategori</p>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Modal -->
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold">Tambah Kategori</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="jenis" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="nama" class="form-label fw-semibold">Nama Kategori</label>
                                <input type="text" class="form-control" id="nama" name="nama" 
                                       placeholder="Masukkan nama kategori" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save me-2"></i>Simpan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold">Edit Kategori</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="jenis" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="editId">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editNama" class="form-label fw-semibold">Nama Kategori</label>
                                <input type="text" class="form-control" id="editNama" name="nama" 
                                       placeholder="Masukkan nama kategori" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                            <button type="submit" class="btn btn-warning">
                                <i class="bi bi-save me-2"></i>Update
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                               function editJenis(id, nama) {
                                                   document.getElementById('editId').value = id;
                                                   document.getElementById('editNama').value = nama;
                                                   new bootstrap.Modal(document.getElementById('editModal')).show();
                                               }
        </script>
    </body>
</html>
