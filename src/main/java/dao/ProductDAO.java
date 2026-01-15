/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, j.nama as jenis_nama FROM product p "
                + "LEFT JOIN jenis j ON p.idjenis = j.id ORDER BY p.id DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        String sql = "SELECT p.*, j.nama as jenis_nama FROM product p "
                + "LEFT JOIN jenis j ON p.idjenis = j.id WHERE p.id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO product (kode, nama, idjenis, kondisi, harga, stok, foto) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getKode());
            stmt.setString(2, product.getNama());
            stmt.setInt(3, product.getIdjenis());
            stmt.setString(4, product.getKondisi());
            stmt.setDouble(5, product.getHarga());
            stmt.setInt(6, product.getStok());
            stmt.setString(7, product.getFoto());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE product SET kode = ?, nama = ?, idjenis = ?, kondisi = ?, "
                + "harga = ?, stok = ?, foto = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getKode());
            stmt.setString(2, product.getNama());
            stmt.setInt(3, product.getIdjenis());
            stmt.setString(4, product.getKondisi());
            stmt.setDouble(5, product.getHarga());
            stmt.setInt(6, product.getStok());
            stmt.setString(7, product.getFoto());
            stmt.setInt(8, product.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM product WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStok(int productId, int qty) {
        String sql = "UPDATE product SET stok = stok - ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, qty);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setKode(rs.getString("kode"));
        product.setNama(rs.getString("nama"));
        product.setIdjenis(rs.getInt("idjenis"));
        product.setJenisNama(rs.getString("jenis_nama"));
        product.setKondisi(rs.getString("kondisi"));
        product.setHarga(rs.getDouble("harga"));
        product.setStok(rs.getInt("stok"));
        product.setFoto(rs.getString("foto"));
        return product;
    }
}
