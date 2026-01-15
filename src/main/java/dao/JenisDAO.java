/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Jenis;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JenisDAO {
    
    public List<Jenis> getAllJenis() {
        List<Jenis> jenisList = new ArrayList<>();
        String sql = "SELECT * FROM jenis ORDER BY id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Jenis jenis = new Jenis();
                jenis.setId(rs.getInt("id"));
                jenis.setNama(rs.getString("nama"));
                jenisList.add(jenis);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jenisList;
    }
    
    public Jenis getJenisById(int id) {
        String sql = "SELECT * FROM jenis WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Jenis jenis = new Jenis();
                jenis.setId(rs.getInt("id"));
                jenis.setNama(rs.getString("nama"));
                return jenis;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addJenis(String nama) {
        String sql = "INSERT INTO jenis (nama) VALUES (?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nama);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateJenis(int id, String nama) {
        String sql = "UPDATE jenis SET nama = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nama);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteJenis(int id) {
        String sql = "DELETE FROM jenis WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
