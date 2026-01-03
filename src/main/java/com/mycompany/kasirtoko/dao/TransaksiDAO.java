package com.mycompany.kasirtoko.dao;

import com.mycompany.kasirtoko.model.DetailTransaksi;
import com.mycompany.kasirtoko.model.Transaksi;
import com.mycompany.kasirtoko.util.DBConnection;
import java.sql.*;

public class TransaksiDAO {
    
    public boolean saveTransaksi(Transaksi t) {
        Connection conn = null;
        PreparedStatement psTrans = null;
        PreparedStatement psDetail = null;
        PreparedStatement psStock = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 1. Insert Transaksi Header
            String sqlTrans = "INSERT INTO transaksi (tanggal, total_harga, pengguna_id) VALUES (?, ?, ?) RETURNING id";
            // Note: PostgreSQL returns generated keys via RETURNING or getGeneratedKeys
            psTrans = conn.prepareStatement(sqlTrans, Statement.RETURN_GENERATED_KEYS);
            psTrans.setTimestamp(1, t.getTanggal());
            psTrans.setBigDecimal(2, t.getTotalHarga());
            psTrans.setInt(3, t.getPenggunaId());
            
            psTrans.executeUpdate();
            
            int transId = 0;
            try (ResultSet rs = psTrans.getGeneratedKeys()) {
                if(rs.next()) {
                    transId = rs.getInt(1);
                }
            }
            
            // 2. Insert Details & Update Stock
            String sqlDetail = "INSERT INTO detail_transaksi (transaksi_id, produk_id, jumlah, subtotal) VALUES (?, ?, ?, ?)";
            psDetail = conn.prepareStatement(sqlDetail);
            
            String sqlStock = "UPDATE produk SET stok = stok - ? WHERE id = ?";
            psStock = conn.prepareStatement(sqlStock);
            
            for (DetailTransaksi dt : t.getDetails()) {
                // Insert detail
                psDetail.setInt(1, transId);
                psDetail.setInt(2, dt.getProdukId());
                psDetail.setInt(3, dt.getJumlah());
                psDetail.setBigDecimal(4, dt.getSubtotal());
                psDetail.addBatch();
                
                // Update stock
                psStock.setInt(1, dt.getJumlah());
                psStock.setInt(2, dt.getProdukId());
                psStock.addBatch();
            }
            
            psDetail.executeBatch();
            psStock.executeBatch();
            
            conn.commit();
            success = true;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        } finally {
            try { if (psStock != null) psStock.close(); } catch (Exception e) {}
            try { if (psDetail != null) psDetail.close(); } catch (Exception e) {}
            try { if (psTrans != null) psTrans.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return success;
    }
}
