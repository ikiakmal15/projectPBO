package servlet;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("namaLengkap", user.getNamaLengkap());
            session.setAttribute("role", user.getRole());

            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Username atau password salah!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String namaLengkap = request.getParameter("namaLengkap");
        String role = request.getParameter("role");

        // Set default role ke buyer (pembeli) jika tidak dipilih
        if (role == null || role.isEmpty()) {
            role = "buyer";
        }

        boolean success = userDAO.register(username, password, namaLengkap, role);

        if (success) {
            request.setAttribute("success", "Registrasi berhasil! Silakan login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registrasi gagal! Username mungkin sudah digunakan.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}