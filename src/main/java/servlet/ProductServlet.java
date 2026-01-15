package servlet;

import dao.ProductDAO;
import dao.JenisDAO;
import model.Product;
import model.Jenis;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    private JenisDAO jenisDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
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
                listProduct(request, response);
                break;
            case "catalog":
                showCatalog(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                listProduct(request, response);
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
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            default:
                listProduct(request, response);
                break;
        }
    }
    
    private void listProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Product> productList = productDAO.getAllProducts();
            List<Jenis> jenisList = jenisDAO.getAllJenis();
            request.setAttribute("productList", productList);
            request.setAttribute("jenisList", jenisList);
            request.getRequestDispatcher("product.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product?error=list");
        }
    }
    
    // NEW METHOD: Show catalog for buyers
    private void showCatalog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Product> productList = productDAO.getAllProducts();
            List<Jenis> jenisList = jenisDAO.getAllJenis();
            request.setAttribute("productList", productList);
            request.setAttribute("jenisList", jenisList);
            request.getRequestDispatcher("catalog.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=catalog");
        }
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String kode = request.getParameter("kode");
            String nama = request.getParameter("nama");
            String idjenisStr = request.getParameter("idjenis");
            String kondisi = request.getParameter("kondisi");
            String hargaStr = request.getParameter("harga");
            String stokStr = request.getParameter("stok");
            String foto = request.getParameter("foto");
            
            // Validasi input
            if (kode == null || kode.trim().isEmpty() ||
                nama == null || nama.trim().isEmpty() ||
                idjenisStr == null || idjenisStr.trim().isEmpty() ||
                kondisi == null || kondisi.trim().isEmpty() ||
                hargaStr == null || hargaStr.trim().isEmpty() ||
                stokStr == null || stokStr.trim().isEmpty()) {
                
                response.sendRedirect("product?error=validation");
                return;
            }
            
            int idjenis = Integer.parseInt(idjenisStr);
            double harga = Double.parseDouble(hargaStr);
            int stok = Integer.parseInt(stokStr);
            
            if (foto == null || foto.trim().isEmpty()) {
                foto = "";
            }
            
            Product product = new Product();
            product.setKode(kode.trim());
            product.setNama(nama.trim());
            product.setIdjenis(idjenis);
            product.setKondisi(kondisi);
            product.setHarga(harga);
            product.setStok(stok);
            product.setFoto(foto.trim());
            
            boolean success = productDAO.addProduct(product);
            
            if (success) {
                response.sendRedirect("product?success=add");
            } else {
                response.sendRedirect("product?error=add");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("product?error=format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product?error=add");
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String kode = request.getParameter("kode");
            String nama = request.getParameter("nama");
            int idjenis = Integer.parseInt(request.getParameter("idjenis"));
            String kondisi = request.getParameter("kondisi");
            double harga = Double.parseDouble(request.getParameter("harga"));
            int stok = Integer.parseInt(request.getParameter("stok"));
            String foto = request.getParameter("foto");
            
            if (foto == null || foto.trim().isEmpty()) {
                foto = "";
            }
            
            Product product = new Product();
            product.setId(id);
            product.setKode(kode.trim());
            product.setNama(nama.trim());
            product.setIdjenis(idjenis);
            product.setKondisi(kondisi);
            product.setHarga(harga);
            product.setStok(stok);
            product.setFoto(foto.trim());
            
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                response.sendRedirect("product?success=update");
            } else {
                response.sendRedirect("product?error=update");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product?error=update");
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = productDAO.deleteProduct(id);
            
            if (success) {
                response.sendRedirect("product?success=delete");
            } else {
                response.sendRedirect("product?error=delete");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product?error=delete");
        }
    }
}