<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.mycompany.kasirtoko.model.Pengguna" %>
        <% Pengguna user=(Pengguna) session.getAttribute("user"); if (user==null) { response.sendRedirect("index.jsp");
            return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Dashboard - KasirToko</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <div class="dashboard-container glass-container">
                    <div class="nav-bar">
                        <h2>Welcome, <%= user.getNama() %>
                        </h2>
                        <div class="nav-links">
                            <a href="dashboard.jsp">Home</a>
                            <a href="products">Products</a>
                            <a href="transaction">Cashier</a>
                            <form action="auth" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="logout">
                                <button type="submit"
                                    style="width: auto; margin: 0; padding: 5px 15px; background: #d63031;">Logout</button>
                            </form>
                        </div>
                    </div>

                    <div style="text-align: left; margin-top: 50px;">
                        <h3>Quick Actions</h3>
                        <div style="display: flex; gap: 20px; margin-top: 20px;">
                            <a href="products" class="card-btn">
                                <div class="glass-container" style="width: 200px; padding: 20px; cursor: pointer;">
                                    <h4>Manage Products</h4>
                                    <p>Add, Edit, Delete Products & Stock</p>
                                </div>
                            </a>
                            <a href="transaction" class="card-btn">
                                <div class="glass-container" style="width: 200px; padding: 20px; cursor: pointer;">
                                    <h4>New Transaction</h4>
                                    <p>Process Sales & Checkout</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </body>

            </html>