package com.mycompany.kasirtoko.model;

import java.math.BigDecimal;

public class Produk {
    private int id;
    private String kode;
    private String nama;
    private BigDecimal harga;
    private int stok;
    private int kategoriId;
    
    // Transient field for display
    private String kategoriNama;

    public Produk() {}

    public Produk(int id, String kode, String nama, BigDecimal harga, int stok, int kategoriId) {
        this.id = id;
        this.kode = kode;
        this.nama = nama;
        this.harga = harga;
        this.stok = stok;
        this.kategoriId = kategoriId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getKode() { return kode; }
    public void setKode(String kode) { this.kode = kode; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public BigDecimal getHarga() { return harga; }
    public void setHarga(BigDecimal harga) { this.harga = harga; }

    public int getStok() { return stok; }
    public void setStok(int stok) { this.stok = stok; }

    public int getKategoriId() { return kategoriId; }
    public void setKategoriId(int kategoriId) { this.kategoriId = kategoriId; }

    public String getKategoriNama() { return kategoriNama; }
    public void setKategoriNama(String kategoriNama) { this.kategoriNama = kategoriNama; }
}
