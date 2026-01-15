/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import dao.JenisDAO;
import model.Jenis;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "JenisServlet", urlPatterns = {"/jenis"})
public class JenisServlet extends HttpServlet {

    private JenisDAO jenisDAO;

    @Override
    public void init() {
        jenisDAO = new JenisDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listJenis(request, response);
                break;
            case "delete":
                deleteJenis(request, response);
                break;
            default:
                listJenis(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addJenis(request, response);
                break;
            case "update":
                updateJenis(request, response);
                break;
            default:
                listJenis(request, response);
                break;
        }
    }

    private void listJenis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Jenis> jenisList = jenisDAO.getAllJenis();
        request.setAttribute("jenisList", jenisList);
        request.getRequestDispatcher("jenis.jsp").forward(request, response);
    }

    private void addJenis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nama = request.getParameter("nama");

        boolean success = jenisDAO.addJenis(nama);

        if (success) {
            response.sendRedirect("jenis?success=add");
        } else {
            response.sendRedirect("jenis?error=add");
        }
    }

    private void updateJenis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nama = request.getParameter("nama");

        boolean success = jenisDAO.updateJenis(id, nama);

        if (success) {
            response.sendRedirect("jenis?success=update");
        } else {
            response.sendRedirect("jenis?error=update");
        }
    }

    private void deleteJenis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        boolean success = jenisDAO.deleteJenis(id);

        if (success) {
            response.sendRedirect("jenis?success=delete");
        } else {
            response.sendRedirect("jenis?error=delete");
        }
    }
}
