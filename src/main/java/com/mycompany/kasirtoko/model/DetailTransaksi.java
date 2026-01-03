package com.mycompany.kasirtoko.model;

import java.math.BigDecimal;

public class DetailTransaksi {
    private int id;
    private int transaksiId;
    private int produkId;
    private int jumlah;
    private BigDecimal subtotal;
    
    // Transient
    private String namaProduk;
    private BigDecimal hargaSatuan;

    public DetailTransaksi() {}
    
    public DetailTransaksi(int produkId, String namaProduk, BigDecimal hargaSatuan, int jumlah) {
        this.produkId = produkId;
        this.namaProduk = namaProduk;
        this.hargaSatuan = hargaSatuan;
        this.jumlah = jumlah;
        this.subtotal = hargaSatuan.multiply(new BigDecimal(jumlah));
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTransaksiId() { return transaksiId; }
    public void setTransaksiId(int transaksiId) { this.transaksiId = transaksiId; }

    public int getProdukId() { return produkId; }
    public void setProdukId(int produkId) { this.produkId = produkId; }

    public int getJumlah() { return jumlah; }
    public void setJumlah(int jumlah) { this.jumlah = jumlah; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
    
    public String getNamaProduk() { return namaProduk; }
    public void setNamaProduk(String namaProduk) { this.namaProduk = namaProduk; }
    
    public BigDecimal getHargaSatuan() { return hargaSatuan; }
    public void setHargaSatuan(BigDecimal hargaSatuan) { this.hargaSatuan = hargaSatuan; }
}
