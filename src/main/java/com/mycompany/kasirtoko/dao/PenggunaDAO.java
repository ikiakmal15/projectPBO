package com.mycompany.kasirtoko.dao;

import com.mycompany.kasirtoko.model.Pengguna;
import com.mycompany.kasirtoko.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PenggunaDAO {
    
    public Pengguna login(String username, String password) {
        Pengguna user = null;
        String query = "SELECT * FROM pengguna WHERE username = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Pengguna();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setNama(rs.getString("nama"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void register(Pengguna user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // 1. Get Max ID
            int nextId = 1;
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT MAX(id) FROM pengguna");
            if (rs.next()) {
                nextId = rs.getInt(1) + 1;
            }
            rs.close();
            stmt.close();
            
            // 2. Insert with explicit ID
            String query = "INSERT INTO pengguna (id, username, password, nama, role) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setInt(1, nextId);
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getNama());
            ps.setString(5, user.getRole());
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            // Introspect columns to help debugging
            StringBuilder columns = new StringBuilder();
            try (Connection c2 = DBConnection.getConnection();
                 Statement s2 = c2.createStatement();
                 ResultSet rs2 = s2.executeQuery("SELECT * FROM pengguna WHERE 1=0")) {
                java.sql.ResultSetMetaData rsmd = rs2.getMetaData();
                int colCount = rsmd.getColumnCount();
                for (int i = 1; i <= colCount; i++) {
                    columns.append(rsmd.getColumnName(i)).append(", ");
                }
            } catch (Exception ex) { ex.printStackTrace(); }
            
            throw new Exception("Error: " + e.getMessage() + ". Available columns: " + columns.toString());
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (ps != null) try { ps.close(); } catch(Exception e) {}
            if (conn != null) try { conn.close(); } catch(Exception e) {}
        }
    }
}
