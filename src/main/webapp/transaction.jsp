<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.mycompany.kasirtoko.model.Produk" %>
        <%@ page import="com.mycompany.kasirtoko.model.DetailTransaksi" %>
            <%@ page import="java.util.List" %>
                <%@ page import="java.math.BigDecimal" %>
                    <%@ page import="com.mycompany.kasirtoko.model.Pengguna" %>
                        <% Pengguna user=(Pengguna) session.getAttribute("user"); if (user==null) {
                            response.sendRedirect("index.jsp"); return; } List<Produk> productList = (List<Produk>)
                                request.getAttribute("productList");
                                List<DetailTransaksi> cart = (List<DetailTransaksi>) session.getAttribute("cart");
                                        BigDecimal grandTotal = BigDecimal.ZERO;
                                        if (cart != null) {
                                        for (DetailTransaksi dt : cart) {
                                        grandTotal = grandTotal.add(dt.getSubtotal());
                                        }
                                        }
                                        %>
                                        <!DOCTYPE html>
                                        <html>

                                        <head>
                                            <title>Transaction - KasirToko</title>
                                            <link rel="stylesheet" href="css/style.css">
                                            <style>
                                                .split-container {
                                                    display: flex;
                                                    gap: 20px;
                                                    width: 100%;
                                                }

                                                .section {
                                                    flex: 1;
                                                    padding: 20px;
                                                }

                                                .product-grid {
                                                    display: grid;
                                                    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                                                    gap: 15px;
                                                    max-height: 60vh;
                                                    overflow-y: auto;
                                                }

                                                .product-card {
                                                    background: rgba(255, 255, 255, 0.6);
                                                    padding: 10px;
                                                    border-radius: 8px;
                                                    text-align: center;
                                                }

                                                .cart-table {
                                                    width: 100%;
                                                    margin-top: 20px;
                                                    background: rgba(255, 255, 255, 0.5);
                                                    border-radius: 8px;
                                                }

                                                .cart-table td,
                                                .cart-table th {
                                                    padding: 8px;
                                                    text-align: left;
                                                }

                                                .total-box {
                                                    margin-top: 20px;
                                                    font-size: 1.5em;
                                                    font-weight: bold;
                                                    text-align: right;
                                                    color: var(--primary-color);
                                                }
                                            </style>
                                        </head>

                                        <body>
                                            <div class="dashboard-container glass-container" style="max-width: 1400px;">
                                                <div class="nav-bar">
                                                    <h2>Cashier Transaction</h2>
                                                    <div class="nav-links">
                                                        <a href="dashboard.jsp">Home</a>
                                                        <a href="products">Products</a>
                                                        <a href="transaction">Cashier</a>
                                                        <a href="auth?action=logout">Logout</a>
                                                    </div>
                                                </div>

                                                <% String msg=request.getParameter("success"); String
                                                    err=request.getParameter("error"); if (msg !=null) { %>
                                                    <div style="color: green; margin-bottom: 10px;">
                                                        <%= msg %>
                                                    </div>
                                                    <% } if (err !=null) { %>
                                                        <div class="error-msg">
                                                            <%= err %>
                                                        </div>
                                                        <% } %>

                                                            <div class="split-container">
                                                                <!-- Left: Product List -->
                                                                <div class="section glass-container"
                                                                    style="flex: 1.5; box-shadow: none; border: 1px solid rgba(255,255,255,0.2);">
                                                                    <h3>Available Products</h3>
                                                                    <div class="product-grid">
                                                                        <% if (productList !=null) { for (Produk p :
                                                                            productList) { %>
                                                                            <div class="product-card">
                                                                                <h4>
                                                                                    <%= p.getNama() %>
                                                                                </h4>
                                                                                <p>Rp <%= p.getHarga() %>
                                                                                </p>
                                                                                <p>Stok: <%= p.getStok() %>
                                                                                </p>
                                                                                <form action="transaction"
                                                                                    method="post">
                                                                                    <input type="hidden" name="action"
                                                                                        value="add">
                                                                                    <input type="hidden" name="produkId"
                                                                                        value="<%= p.getId() %>">
                                                                                    <input type="number" name="qty"
                                                                                        value="1" min="1"
                                                                                        max="<%= p.getStok() %>"
                                                                                        style="width: 60px; padding: 5px;">
                                                                                    <button type="submit"
                                                                                        style="margin-top: 5px; padding: 5px;">Add</button>
                                                                                </form>
                                                                            </div>
                                                                            <% } } %>
                                                                    </div>
                                                                </div>

                                                                <!-- Right: Cart -->
                                                                <div class="section glass-container"
                                                                    style="flex: 1; box-shadow: none; border: 1px solid rgba(255,255,255,0.2);">
                                                                    <h3>Current Cart</h3>
                                                                    <table class="cart-table">
                                                                        <tr>
                                                                            <th>Item</th>
                                                                            <th>Qty</th>
                                                                            <th>Subtotal</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                        <% if (cart !=null) { int idx=0; for
                                                                            (DetailTransaksi dt : cart) { %>
                                                                            <tr>
                                                                                <td>
                                                                                    <%= dt.getNamaProduk() %>
                                                                                </td>
                                                                                <td>
                                                                                    <%= dt.getJumlah() %>
                                                                                </td>
                                                                                <td>
                                                                                    <%= dt.getSubtotal() %>
                                                                                </td>
                                                                                <td>
                                                                                    <form action="transaction"
                                                                                        method="post"
                                                                                        style="display:inline;">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="remove">
                                                                                        <input type="hidden"
                                                                                            name="index"
                                                                                            value="<%= idx++ %>">
                                                                                        <button type="submit"
                                                                                            style="background:#d63031; padding: 2px 8px; margin:0; font-size:0.8em;">X</button>
                                                                                    </form>
                                                                                </td>
                                                                            </tr>
                                                                            <% } } %>
                                                                    </table>

                                                                    <div class="total-box">
                                                                        Total: Rp <%= grandTotal %>
                                                                    </div>

                                                                    <div
                                                                        style="display: flex; gap: 10px; margin-top: 20px;">
                                                                        <form action="transaction" method="post"
                                                                            style="flex:1;">
                                                                            <input type="hidden" name="action"
                                                                                value="clear">
                                                                            <button type="submit"
                                                                                style="background: #fab1a0; color: #333;">Clear
                                                                                Cart</button>
                                                                        </form>
                                                                        <form action="transaction" method="post"
                                                                            style="flex:1;">
                                                                            <input type="hidden" name="action"
                                                                                value="checkout">
                                                                            <button type="submit"
                                                                                style="background: #00b894;">Checkout</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                            </div>
                                        </body>

                                        </html>