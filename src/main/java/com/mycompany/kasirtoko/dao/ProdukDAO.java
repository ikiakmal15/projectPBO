package com.mycompany.kasirtoko.dao;

import com.mycompany.kasirtoko.model.Produk;
import com.mycompany.kasirtoko.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdukDAO {
    
    public List<Produk> getAllProduk() {
        List<Produk> list = new ArrayList<>();
        String sql = "SELECT p.*, k.nama_kategori as kategori_nama FROM produk p LEFT JOIN kategori k ON p.kategori_id = k.id ORDER BY p.id";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Produk p = new Produk();
                p.setId(rs.getInt("id"));
                p.setKode(rs.getString("kode_produk"));
                p.setNama(rs.getString("nama_produk"));
                p.setHarga(rs.getBigDecimal("harga"));
                p.setStok(rs.getInt("stok"));
                p.setKategoriId(rs.getInt("kategori_id"));
                p.setKategoriNama(rs.getString("kategori_nama"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addProduk(Produk p) {
        String sql = "INSERT INTO produk (kode_produk, nama_produk, harga, stok, kategori_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getKode());
            ps.setString(2, p.getNama());
            ps.setBigDecimal(3, p.getHarga());
            ps.setInt(4, p.getStok());
            ps.setInt(5, p.getKategoriId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduk(Produk p) {
        String sql = "UPDATE produk SET kode_produk=?, nama_produk=?, harga=?, stok=?, kategori_id=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getKode());
            ps.setString(2, p.getNama());
            ps.setBigDecimal(3, p.getHarga());
            ps.setInt(4, p.getStok());
            ps.setInt(5, p.getKategoriId());
            ps.setInt(6, p.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduk(int id) {
        String sql = "DELETE FROM produk WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public Produk getProdukById(int id) {
        Produk p = null;
        String sql = "SELECT * FROM produk WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Produk();
                    p.setId(rs.getInt("id"));
                    p.setKode(rs.getString("kode_produk"));
                    p.setNama(rs.getString("nama_produk"));
                    p.setHarga(rs.getBigDecimal("harga"));
                    p.setStok(rs.getInt("stok"));
                    p.setKategoriId(rs.getInt("kategori_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }
}
