package servlet;

import dao.TransaksiDAO;
import dao.ProductDAO;
import model.Transaksi;
import model.DetailTransaksi;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TransaksiServlet", urlPatterns = {"/transaksi"})
public class TransaksiServlet extends HttpServlet {
    
    private TransaksiDAO transaksiDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        transaksiDAO = new TransaksiDAO();
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "form";
        }
        
        switch (action) {
            case "form":
                showForm(request, response);
                break;
            case "list":
                listTransaksi(request, response);
                break;
            case "myhistory":
                myHistory(request, response);
                break;
            case "detail":
                detailTransaksi(request, response);
                break;
            default:
                showForm(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "save";
        }
        
        switch (action) {
            case "save":
                saveTransaksi(request, response);
                break;
            default:
                showForm(request, response);
                break;
        }
    }
    
    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("transaksi.jsp").forward(request, response);
    }
    
    private void listTransaksi(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Transaksi> transaksiList = transaksiDAO.getAllTransaksi();
        request.setAttribute("transaksiList", transaksiList);
        request.getRequestDispatcher("laporan.jsp").forward(request, response);
    }
    
    private void myHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Transaksi> transaksiList = transaksiDAO.getTransaksiByUserId(user.getId());
        
        double totalBelanja = 0;
        int totalTransaksi = transaksiList.size();
        
        for (Transaksi t : transaksiList) {
            totalBelanja += t.getTotal();
        }
        
        request.setAttribute("transaksiList", transaksiList);
        request.setAttribute("totalBelanja", totalBelanja);
        request.setAttribute("totalTransaksi", totalTransaksi);
        
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
    
    private void detailTransaksi(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Transaksi transaksi = transaksiDAO.getTransaksiById(id);
            request.setAttribute("transaksi", transaksi);
            request.getRequestDispatcher("detail-transaksi.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=detail");
        }
    }
    
    private void saveTransaksi(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // SUPER DEFENSIVE PARSING
            String totalStr = request.getParameter("total");
            String bayarStr = request.getParameter("bayar");
            String kembalianStr = request.getParameter("kembalian");
            
            System.out.println("=== TRANSAKSI DEBUG ===");
            System.out.println("Total String: [" + totalStr + "]");
            System.out.println("Bayar String: [" + bayarStr + "]");
            System.out.println("Kembalian String: [" + kembalianStr + "]");
            
            // Check for null or empty
            if (totalStr == null || totalStr.trim().isEmpty()) {
                System.err.println("ERROR: Total is null or empty!");
                response.sendRedirect("transaksi?error=empty_total");
                return;
            }
            
            if (bayarStr == null || bayarStr.trim().isEmpty()) {
                System.err.println("ERROR: Bayar is null or empty!");
                response.sendRedirect("transaksi?error=empty_bayar");
                return;
            }
            
            if (kembalianStr == null || kembalianStr.trim().isEmpty()) {
                System.err.println("ERROR: Kembalian is null or empty!");
                response.sendRedirect("transaksi?error=empty_kembalian");
                return;
            }
            
            // Parse with error handling
            double total = 0;
            double bayar = 0;
            double kembalian = 0;
            
            try {
                total = Double.parseDouble(totalStr.trim());
                System.out.println("Total parsed: " + total);
            } catch (NumberFormatException e) {
                System.err.println("ERROR parsing total: " + e.getMessage());
                response.sendRedirect("transaksi?error=invalid_total");
                return;
            }
            
            try {
                bayar = Double.parseDouble(bayarStr.trim());
                System.out.println("Bayar parsed: " + bayar);
            } catch (NumberFormatException e) {
                System.err.println("ERROR parsing bayar: " + e.getMessage());
                response.sendRedirect("transaksi?error=invalid_bayar");
                return;
            }
            
            try {
                kembalian = Double.parseDouble(kembalianStr.trim());
                System.out.println("Kembalian parsed: " + kembalian);
            } catch (NumberFormatException e) {
                System.err.println("ERROR parsing kembalian: " + e.getMessage());
                response.sendRedirect("transaksi?error=invalid_kembalian");
                return;
            }
            
            // Validate amounts
            if (total <= 0) {
                System.err.println("ERROR: Total must be > 0");
                response.sendRedirect("transaksi?error=invalid_total_amount");
                return;
            }
            
            if (bayar < total) {
                System.err.println("ERROR: Bayar < Total");
                response.sendRedirect("transaksi?error=insufficient_payment");
                return;
            }
            
            String kodeTransaksi = transaksiDAO.generateKodeTransaksi();
            System.out.println("Kode Transaksi: " + kodeTransaksi);
            
            Transaksi transaksi = new Transaksi();
            transaksi.setKodeTransaksi(kodeTransaksi);
            transaksi.setUserId(userId);
            transaksi.setTotal(total);
            transaksi.setBayar(bayar);
            transaksi.setKembalian(kembalian);
            transaksi.setStatus("selesai");
            
            // Get cart items
            String[] productIds = request.getParameterValues("productId[]");
            String[] qtys = request.getParameterValues("qty[]");
            String[] hargas = request.getParameterValues("harga[]");
            String[] subtotals = request.getParameterValues("subtotal[]");
            
            System.out.println("Product IDs: " + (productIds != null ? productIds.length : 0));
            System.out.println("Qtys: " + (qtys != null ? qtys.length : 0));
            System.out.println("Hargas: " + (hargas != null ? hargas.length : 0));
            System.out.println("Subtotals: " + (subtotals != null ? subtotals.length : 0));
            
            // Validate cart items exist
            if (productIds == null || productIds.length == 0) {
                System.err.println("ERROR: No cart items!");
                response.sendRedirect("transaksi?error=nocart");
                return;
            }
            
            // Add items to transaction
            int validItems = 0;
            for (int i = 0; i < productIds.length; i++) {
                System.out.println("Processing item " + i);
                System.out.println("  ProductID: [" + productIds[i] + "]");
                System.out.println("  Qty: [" + qtys[i] + "]");
                System.out.println("  Harga: [" + hargas[i] + "]");
                System.out.println("  Subtotal: [" + subtotals[i] + "]");
                
                // Skip if any value is null or empty
                if (productIds[i] == null || productIds[i].trim().isEmpty() ||
                    qtys[i] == null || qtys[i].trim().isEmpty() ||
                    hargas[i] == null || hargas[i].trim().isEmpty() ||
                    subtotals[i] == null || subtotals[i].trim().isEmpty()) {
                    System.err.println("  SKIPPED: Empty value");
                    continue;
                }
                
                try {
                    DetailTransaksi detail = new DetailTransaksi();
                    detail.setProductId(Integer.parseInt(productIds[i].trim()));
                    detail.setQty(Integer.parseInt(qtys[i].trim()));
                    detail.setHarga(Double.parseDouble(hargas[i].trim()));
                    detail.setSubtotal(Double.parseDouble(subtotals[i].trim()));
                    transaksi.getDetails().add(detail);
                    validItems++;
                    System.out.println("  ADDED successfully");
                } catch (NumberFormatException e) {
                    System.err.println("  ERROR parsing: " + e.getMessage());
                    continue;
                }
            }
            
            System.out.println("Valid items: " + validItems);
            
            // Check if we have valid items
            if (validItems == 0) {
                System.err.println("ERROR: No valid items!");
                response.sendRedirect("transaksi?error=noitems");
                return;
            }
            
            boolean success = transaksiDAO.saveTransaksi(transaksi);
            System.out.println("Save result: " + success);
            System.out.println("=== END DEBUG ===");
            
            if (success) {
                response.sendRedirect("transaksi?success=true&kode=" + kodeTransaksi);
            } else {
                response.sendRedirect("transaksi?error=save");
            }
            
        } catch (Exception e) {
            System.err.println("EXCEPTION in saveTransaksi:");
            e.printStackTrace();
            response.sendRedirect("transaksi?error=exception&msg=" + e.getMessage());
        }
    }
}