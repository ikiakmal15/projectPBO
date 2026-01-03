<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Register - KasirToko</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="glass-container">
            <h2>Register New Account</h2>
            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="error-msg">
                    <%= error %>
                </div>
                <% } %>
                    <form action="auth" method="post">
                        <input type="hidden" name="action" value="register">
                        <input type="text" name="nama" placeholder="Full Name" required>
                        <input type="text" name="username" placeholder="Username" required>
                        <input type="password" name="password" placeholder="Password" required>
                        <button type="submit">Sign Up</button>
                    </form>
                    <div style="margin-top: 15px; font-size: 0.9em;">
                        <a href="index.jsp" style="color: var(--text-color); text-decoration: none;">Already have an
                            account? Login</a>
                    </div>
        </div>
    </body>

    </html>