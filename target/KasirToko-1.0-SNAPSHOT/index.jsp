<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - KasirToko</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="glass-container">
            <h2>Kasir Login</h2>
            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="error-msg">
                    <%= error %>
                </div>
                <% } %>
                    <form action="auth" method="post">
                        <input type="hidden" name="action" value="login">
                        <input type="text" name="username" placeholder="Username" required>
                        <input type="password" name="password" placeholder="Password" required>
                        <button type="submit">Login</button>
                    </form>
                    <div style="margin-top: 15px; font-size: 0.9em;">
                        <a href="register.jsp" style="color: var(--text-color); text-decoration: none;">Don't have an
                            account? Register</a>
                    </div>
        </div>
    </body>

    </html>