/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import dao.TransaksiDAO;
import model.Transaksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LaporanServlet", urlPatterns = {"/laporan"})
public class LaporanServlet extends HttpServlet {
    
    private TransaksiDAO transaksiDAO;
    
    @Override
    public void init() {
        transaksiDAO = new TransaksiDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Transaksi> transaksiList = transaksiDAO.getAllTransaksi();
        
        // Calculate statistics
        double totalPendapatan = 0;
        int totalTransaksi = transaksiList.size();
        
        for (Transaksi t : transaksiList) {
            totalPendapatan += t.getTotal();
        }
        
        request.setAttribute("transaksiList", transaksiList);
        request.setAttribute("totalPendapatan", totalPendapatan);
        request.setAttribute("totalTransaksi", totalTransaksi);
        
        request.getRequestDispatcher("laporan.jsp").forward(request, response);
    }
}
