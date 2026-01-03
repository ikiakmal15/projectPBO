package com.mycompany.kasirtoko.servlet;

import com.mycompany.kasirtoko.dao.ProdukDAO;
import com.mycompany.kasirtoko.model.Produk;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    private ProdukDAO produkDAO = new ProdukDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                produkDAO.deleteProduk(id);
                response.sendRedirect("products");
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addProduk(request, response);
        } else if ("update".equals(action)) {
            updateProduk(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Produk> list = produkDAO.getAllProduk();
        request.setAttribute("listProduk", list);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Produk p = produkDAO.getProdukById(id);
        request.setAttribute("produk", p);
        request.setAttribute("listProduk", produkDAO.getAllProduk()); // Refresh list
        request.setAttribute("showEdit", true);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    private void addProduk(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String kode = request.getParameter("kode");
        String nama = request.getParameter("nama");
        BigDecimal harga = new BigDecimal(request.getParameter("harga"));
        int stok = Integer.parseInt(request.getParameter("stok"));
        int kategoriId = Integer.parseInt(request.getParameter("kategoriId"));

        Produk p = new Produk(0, kode, nama, harga, stok, kategoriId);
        produkDAO.addProduk(p);
        response.sendRedirect("products");
    }
    
    private void updateProduk(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String kode = request.getParameter("kode");
        String nama = request.getParameter("nama");
        BigDecimal harga = new BigDecimal(request.getParameter("harga"));
        int stok = Integer.parseInt(request.getParameter("stok"));
        int kategoriId = Integer.parseInt(request.getParameter("kategoriId"));

        Produk p = new Produk(id, kode, nama, harga, stok, kategoriId);
        produkDAO.updateProduk(p);
        response.sendRedirect("products");
    }
}
