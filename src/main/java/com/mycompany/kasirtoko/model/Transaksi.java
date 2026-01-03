package com.mycompany.kasirtoko.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Transaksi {
    private int id;
    private Timestamp tanggal;
    private BigDecimal totalHarga;
    private int penggunaId;
    
    // Transient - for displaying/processing
    private List<DetailTransaksi> details = new ArrayList<>();

    public Transaksi() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Timestamp getTanggal() { return tanggal; }
    public void setTanggal(Timestamp tanggal) { this.tanggal = tanggal; }

    public BigDecimal getTotalHarga() { return totalHarga; }
    public void setTotalHarga(BigDecimal totalHarga) { this.totalHarga = totalHarga; }

    public int getPenggunaId() { return penggunaId; }
    public void setPenggunaId(int penggunaId) { this.penggunaId = penggunaId; }
    
    public List<DetailTransaksi> getDetails() { return details; }
    public void setDetails(List<DetailTransaksi> details) { this.details = details; }
    
    public void addDetail(DetailTransaksi dt) { this.details.add(dt); }
}
