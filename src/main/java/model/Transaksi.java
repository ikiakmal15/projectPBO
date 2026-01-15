package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Transaksi {
    private int id;
    private String kodeTransaksi;
    private Timestamp tanggal;
    private int userId;
    private String userNama;
    private double total;
    private double bayar;
    private double kembalian;
    private String status;
    private List<DetailTransaksi> details;

    public Transaksi() {
        this.details = new ArrayList<>();
    }

    // Getters and Setters
    public int getId() { 
        return id; 
    }
    
    public void setId(int id) { 
        this.id = id; 
    }

    public String getKodeTransaksi() { 
        return kodeTransaksi; 
    }
    
    public void setKodeTransaksi(String kodeTransaksi) { 
        this.kodeTransaksi = kodeTransaksi; 
    }

    public Timestamp getTanggal() { 
        return tanggal; 
    }
    
    public void setTanggal(Timestamp tanggal) { 
        this.tanggal = tanggal; 
    }

    public int getUserId() { 
        return userId; 
    }
    
    public void setUserId(int userId) { 
        this.userId = userId; 
    }

    public String getUserNama() { 
        return userNama; 
    }
    
    public void setUserNama(String userNama) { 
        this.userNama = userNama; 
    }

    public double getTotal() { 
        return total; 
    }
    
    public void setTotal(double total) { 
        this.total = total; 
    }

    public double getBayar() { 
        return bayar; 
    }
    
    public void setBayar(double bayar) { 
        this.bayar = bayar; 
    }

    public double getKembalian() { 
        return kembalian; 
    }
    
    public void setKembalian(double kembalian) { 
        this.kembalian = kembalian; 
    }

    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }

    public List<DetailTransaksi> getDetails() { 
        return details; 
    }
    
    public void setDetails(List<DetailTransaksi> details) { 
        this.details = details; 
    }
}