package dao;

import model.Transaksi;
import model.DetailTransaksi;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransaksiDAO {
    
    public boolean saveTransaksi(Transaksi transaksi) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Insert transaksi
            String sqlTransaksi = "INSERT INTO transaksi (kode_transaksi, user_id, total, bayar, kembalian, status) " +
                                  "VALUES (?, ?, ?, ?, ?, ?) RETURNING id";
            PreparedStatement stmtTransaksi = conn.prepareStatement(sqlTransaksi);
            stmtTransaksi.setString(1, transaksi.getKodeTransaksi());
            stmtTransaksi.setInt(2, transaksi.getUserId());
            stmtTransaksi.setDouble(3, transaksi.getTotal());
            stmtTransaksi.setDouble(4, transaksi.getBayar());
            stmtTransaksi.setDouble(5, transaksi.getKembalian());
            stmtTransaksi.setString(6, transaksi.getStatus());
            
            ResultSet rs = stmtTransaksi.executeQuery();
            int transaksiId = 0;
            if (rs.next()) {
                transaksiId = rs.getInt(1);
            }
            
            // Insert detail transaksi
            String sqlDetail = "INSERT INTO detail_transaksi (transaksi_id, product_id, qty, harga, subtotal) " +
                               "VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmtDetail = conn.prepareStatement(sqlDetail);
            
            ProductDAO productDAO = new ProductDAO();
            
            for (DetailTransaksi detail : transaksi.getDetails()) {
                stmtDetail.setInt(1, transaksiId);
                stmtDetail.setInt(2, detail.getProductId());
                stmtDetail.setInt(3, detail.getQty());
                stmtDetail.setDouble(4, detail.getHarga());
                stmtDetail.setDouble(5, detail.getSubtotal());
                stmtDetail.addBatch();
                
                // Update stok
                productDAO.updateStok(detail.getProductId(), detail.getQty());
            }
            
            stmtDetail.executeBatch();
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    public List<Transaksi> getAllTransaksi() {
        List<Transaksi> transaksiList = new ArrayList<>();
        String sql = "SELECT t.*, u.nama_lengkap as user_nama FROM transaksi t " +
                     "LEFT JOIN users u ON t.user_id = u.id ORDER BY t.tanggal DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Transaksi transaksi = new Transaksi();
                transaksi.setId(rs.getInt("id"));
                transaksi.setKodeTransaksi(rs.getString("kode_transaksi"));
                transaksi.setTanggal(rs.getTimestamp("tanggal"));
                transaksi.setUserId(rs.getInt("user_id"));
                transaksi.setUserNama(rs.getString("user_nama"));
                transaksi.setTotal(rs.getDouble("total"));
                transaksi.setBayar(rs.getDouble("bayar"));
                transaksi.setKembalian(rs.getDouble("kembalian"));
                transaksi.setStatus(rs.getString("status"));
                transaksiList.add(transaksi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transaksiList;
    }
    
    // NEW METHOD: Get transaksi by user ID (untuk buyer)
    public List<Transaksi> getTransaksiByUserId(int userId) {
        List<Transaksi> transaksiList = new ArrayList<>();
        String sql = "SELECT t.*, u.nama_lengkap as user_nama FROM transaksi t " +
                     "LEFT JOIN users u ON t.user_id = u.id " +
                     "WHERE t.user_id = ? ORDER BY t.tanggal DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Transaksi transaksi = new Transaksi();
                transaksi.setId(rs.getInt("id"));
                transaksi.setKodeTransaksi(rs.getString("kode_transaksi"));
                transaksi.setTanggal(rs.getTimestamp("tanggal"));
                transaksi.setUserId(rs.getInt("user_id"));
                transaksi.setUserNama(rs.getString("user_nama"));
                transaksi.setTotal(rs.getDouble("total"));
                transaksi.setBayar(rs.getDouble("bayar"));
                transaksi.setKembalian(rs.getDouble("kembalian"));
                transaksi.setStatus(rs.getString("status"));
                transaksiList.add(transaksi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transaksiList;
    }
    
    public Transaksi getTransaksiById(int id) {
        String sql = "SELECT t.*, u.nama_lengkap as user_nama FROM transaksi t " +
                     "LEFT JOIN users u ON t.user_id = u.id WHERE t.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Transaksi transaksi = new Transaksi();
                transaksi.setId(rs.getInt("id"));
                transaksi.setKodeTransaksi(rs.getString("kode_transaksi"));
                transaksi.setTanggal(rs.getTimestamp("tanggal"));
                transaksi.setUserId(rs.getInt("user_id"));
                transaksi.setUserNama(rs.getString("user_nama"));
                transaksi.setTotal(rs.getDouble("total"));
                transaksi.setBayar(rs.getDouble("bayar"));
                transaksi.setKembalian(rs.getDouble("kembalian"));
                transaksi.setStatus(rs.getString("status"));
                
                // Get details
                transaksi.setDetails(getDetailTransaksi(id));
                return transaksi;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<DetailTransaksi> getDetailTransaksi(int transaksiId) {
        List<DetailTransaksi> details = new ArrayList<>();
        String sql = "SELECT dt.*, p.nama as product_nama FROM detail_transaksi dt " +
                     "LEFT JOIN product p ON dt.product_id = p.id WHERE dt.transaksi_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, transaksiId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                DetailTransaksi detail = new DetailTransaksi();
                detail.setId(rs.getInt("id"));
                detail.setTransaksiId(rs.getInt("transaksi_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setProductNama(rs.getString("product_nama"));
                detail.setQty(rs.getInt("qty"));
                detail.setHarga(rs.getDouble("harga"));
                detail.setSubtotal(rs.getDouble("subtotal"));
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
    
    public String generateKodeTransaksi() {
        String prefix = "TRX";
        String sql = "SELECT COUNT(*) as total FROM transaksi WHERE DATE(tanggal) = CURRENT_DATE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                int count = rs.getInt("total") + 1;
                String date = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                return prefix + date + String.format("%04d", count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prefix + System.currentTimeMillis();
    }
}