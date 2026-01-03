package com.mycompany.kasirtoko.servlet;

import com.mycompany.kasirtoko.dao.PenggunaDAO;
import com.mycompany.kasirtoko.model.Pengguna;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    private PenggunaDAO penggunaDAO = new PenggunaDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("logout".equals(action)) {
            handleLogout(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        Pengguna user = penggunaDAO.login(u, p);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("index.jsp?error=Invalid Credentials");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        String n = request.getParameter("nama");
        // Default role or selected role? For now let's say default is 'kasir' or input.
        // Let's allow simple role selection or default to 'staff'.
        String r = "staff"; 

        Pengguna user = new Pengguna();
        user.setUsername(u);
        user.setPassword(p);
        user.setNama(n);
        user.setRole(r);

        try {
            penggunaDAO.register(user);
            response.sendRedirect("index.jsp?success=Registration Successful! Please Login.");
        } catch (Exception e) {
            e.printStackTrace();
            // Pass the error message to the JSP
            String errorMsg = e.getMessage();
            if (errorMsg == null) errorMsg = e.toString();
            response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("Error: " + errorMsg, "UTF-8"));
        }
    }
}
