<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.mycompany.kasirtoko.model.Produk" %>
        <%@ page import="java.util.List" %>
            <%@ page import="com.mycompany.kasirtoko.model.Pengguna" %>
                <% Pengguna user=(Pengguna) session.getAttribute("user"); if (user==null) {
                    response.sendRedirect("index.jsp"); return; } List<Produk> list = (List<Produk>)
                        request.getAttribute("listProduk");
                        Produk editProduk = (Produk) request.getAttribute("produk");
                        boolean showEdit = request.getAttribute("showEdit") != null && (Boolean)
                        request.getAttribute("showEdit");
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Product Management - KasirToko</title>
                            <link rel="stylesheet" href="css/style.css">
                            <style>
                                .table-container {
                                    width: 100%;
                                    overflow-x: auto;
                                    margin-top: 20px;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                    background: rgba(255, 255, 255, 0.7);
                                    border-radius: 10px;
                                    overflow: hidden;
                                }

                                th,
                                td {
                                    padding: 12px;
                                    text-align: left;
                                    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                                }

                                th {
                                    background: var(--primary-color);
                                    color: white;
                                }

                                .action-btn {
                                    padding: 5px 10px;
                                    margin: 0 2px;
                                    border-radius: 4px;
                                    text-decoration: none;
                                    color: white;
                                    font-size: 0.9em;
                                }

                                .btn-edit {
                                    background: #0984e3;
                                }

                                .btn-delete {
                                    background: #d63031;
                                }

                                .form-container {
                                    margin-bottom: 30px;
                                }

                                .form-row {
                                    display: flex;
                                    gap: 10px;
                                }
                            </style>
                        </head>

                        <body>
                            <div class="dashboard-container glass-container">
                                <div class="nav-bar">
                                    <h2>Product Management</h2>
                                    <div class="nav-links">
                                        <a href="dashboard.jsp">Home</a>
                                        <a href="products">Products</a>
                                        <a href="transaction">Cashier</a>
                                        <a href="auth?action=logout">Logout</a>
                                    </div>
                                </div>

                                <div class="form-container">
                                    <h3>
                                        <%= showEdit ? "Edit Product" : "Add New Product" %>
                                    </h3>
                                    <form action="products" method="post">
                                        <input type="hidden" name="action" value="<%= showEdit ? " update" : "add" %>">
                                        <% if (showEdit) { %>
                                            <input type="hidden" name="id" value="<%= editProduk.getId() %>">
                                            <% } %>

                                                <div class="form-row">
                                                    <input type="text" name="kode" placeholder="Product Code"
                                                        value="<%= showEdit ? editProduk.getKode() : "" %>" required>
                                                    <input type="text" name="nama" placeholder="Product Name"
                                                        value="<%= showEdit ? editProduk.getNama() : "" %>" required>
                                                </div>
                                                <div class="form-row">
                                                    <input type="number" name="harga" placeholder="Price" step="0.01"
                                                        value="<%= showEdit ? editProduk.getHarga() : "" %>" required>
                                                    <input type="number" name="stok" placeholder="Stock"
                                                        value="<%= showEdit ? editProduk.getStok() : "" %>" required>
                                                    <input type="number" name="kategoriId" placeholder="Category ID"
                                                        value="<%= showEdit ? editProduk.getKategoriId() : "" %>"
                                                        required>
                                                </div>
                                                <button type="submit" style="width: 200px;">
                                                    <%= showEdit ? "Update Product" : "Save Product" %>
                                                </button>
                                                <% if (showEdit) { %>
                                                    <a href="products"
                                                        style="margin-left: 10px; color: #d63031;">Cancel</a>
                                                    <% } %>
                                    </form>
                                </div>

                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Code</th>
                                                <th>Name</th>
                                                <th>Price</th>
                                                <th>Stock</th>
                                                <th>Category ID</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% if (list !=null) { for (Produk p : list) { %>
                                                <tr>
                                                    <td>
                                                        <%= p.getId() %>
                                                    </td>
                                                    <td>
                                                        <%= p.getKode() %>
                                                    </td>
                                                    <td>
                                                        <%= p.getNama() %>
                                                    </td>
                                                    <td>
                                                        <%= p.getHarga() %>
                                                    </td>
                                                    <td>
                                                        <%= p.getStok() %>
                                                    </td>
                                                    <td>
                                                        <%= p.getKategoriId() %>
                                                    </td>
                                                    <td>
                                                        <a href="products?action=edit&id=<%= p.getId() %>"
                                                            class="action-btn btn-edit">Edit</a>
                                                        <a href="products?action=delete&id=<%= p.getId() %>"
                                                            class="action-btn btn-delete"
                                                            onclick="return confirm('Delete?');">Delete</a>
                                                    </td>
                                                </tr>
                                                <% } } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </body>

                        </html>