package com.mycompany.kasirtoko.servlet;

import com.mycompany.kasirtoko.dao.ProdukDAO;
import com.mycompany.kasirtoko.dao.TransaksiDAO;
import com.mycompany.kasirtoko.model.DetailTransaksi;
import com.mycompany.kasirtoko.model.Pengguna;
import com.mycompany.kasirtoko.model.Produk;
import com.mycompany.kasirtoko.model.Transaksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TransactionServlet", urlPatterns = {"/transaction"})
public class TransactionServlet extends HttpServlet {

    private ProdukDAO produkDAO = new ProdukDAO();
    private TransaksiDAO transaksiDAO = new TransaksiDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null) {
            session.setAttribute("cart", new ArrayList<DetailTransaksi>());
        }
        
        request.setAttribute("productList", produkDAO.getAllProduk());
        request.getRequestDispatcher("transaction.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<DetailTransaksi> cart = (List<DetailTransaksi>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        if ("add".equals(action)) {
            int prodId = Integer.parseInt(request.getParameter("produkId"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            
            Produk p = produkDAO.getProdukById(prodId);
            if (p != null) {
                // Check if already in cart
                boolean exists = false;
                for (DetailTransaksi dt : cart) {
                    if (dt.getProdukId() == prodId) {
                        dt.setJumlah(dt.getJumlah() + qty);
                        dt.setSubtotal(p.getHarga().multiply(new BigDecimal(dt.getJumlah())));
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    cart.add(new DetailTransaksi(prodId, p.getNama(), p.getHarga(), qty));
                }
            }
            session.setAttribute("cart", cart);
            response.sendRedirect("transaction");
            
        } else if ("remove".equals(action)) {
            int index = Integer.parseInt(request.getParameter("index"));
            if (index >= 0 && index < cart.size()) {
                cart.remove(index);
            }
            session.setAttribute("cart", cart);
            response.sendRedirect("transaction");
            
        } else if ("checkout".equals(action)) {
            if (!cart.isEmpty()) {
                Pengguna user = (Pengguna) session.getAttribute("user");
                if (user != null) {
                    Transaksi t = new Transaksi();
                    t.setTanggal(new Timestamp(System.currentTimeMillis()));
                    t.setPenggunaId(user.getId());
                    t.setDetails(cart);
                    
                    BigDecimal total = BigDecimal.ZERO;
                    for (DetailTransaksi dt : cart) {
                        total = total.add(dt.getSubtotal());
                    }
                    t.setTotalHarga(total);
                    
                    if (transaksiDAO.saveTransaksi(t)) {
                        session.removeAttribute("cart");
                        response.sendRedirect("transaction?success=Transaction Completed");
                        return;
                    }
                }
            }
            response.sendRedirect("transaction?error=Process Failed");
        } else if ("clear".equals(action)) {
            session.removeAttribute("cart");
            response.sendRedirect("transaction");
        }
    }
}
