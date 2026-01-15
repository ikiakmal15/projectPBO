<%-- 
    Document   : detail-transaksi
    Created on : 15 Jan 2026, 11.45.45
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Transaksi transaksi = (Transaksi) request.getAttribute("transaksi");
    if (transaksi == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detail Transaksi - Sistem Toko</title>
        <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/yeti/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid py-4">
            <!-- Transaction Info -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="fw-bold mb-3">Informasi Transaksi</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td width="40%">Kode Transaksi</td>
                                            <td><strong><%= transaksi.getKodeTransaksi()%></strong></td>
                                        </tr>
                                        <tr>
                                            <td>Tanggal</td>
                                            <td><%= sdf.format(transaksi.getTanggal())%></td>
                                        </tr>
                                        <tr>
                                            <td>Pembeli</td>
                                            <td><%= transaksi.getUserNama()%></td>
                                        </tr>
                                        <tr>
                                            <td>Status</td>
                                            <td><span class="badge bg-success"><%= transaksi.getStatus()%></span></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h5 class="fw-bold mb-3">Ringkasan Pembayaran</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td width="40%">Total Belanja</td>
                                            <td class="text-end"><strong>Rp <%= String.format("%,d", (int) transaksi.getTotal())%></strong></td>
                                        </tr>
                                        <tr>
                                            <td>Bayar</td>
                                            <td class="text-end">Rp <%= String.format("%,d", (int) transaksi.getBayar())%></td>
                                        </tr>
                                        <tr>
                                            <td>Kembalian</td>
                                            <td class="text-end">Rp <%= String.format("%,d", (int) transaksi.getKembalian())%></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items -->
            <div class="row">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0 fw-bold">
                                <i class="bi bi-bag-check me-2"></i>Item Belanja
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th width="5%">No</th>
                                            <th>Produk</th>
                                            <th width="15%" class="text-center">Qty</th>
                                            <th width="20%" class="text-end">Harga</th>
                                            <th width="20%" class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        int no = 1;
                                        for (DetailTransaksi detail : transaksi.getDetails()) {%>
                                        <tr>
                                            <td><%= no++%></td>
                                            <td class="fw-semibold"><%= detail.getProductNama()%></td>
                                            <td class="text-center">
                                                <span class="badge bg-primary"><%= detail.getQty()%></span>
                                            </td>
                                            <td class="text-end">Rp <%= String.format("%,d", (int) detail.getHarga())%></td>
                                            <td class="text-end fw-bold text-success">
                                                Rp <%= String.format("%,d", (int) detail.getSubtotal())%>
                                            </td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                    <tfoot class="table-light">
                                        <tr>
                                            <td colspan="4" class="text-end fw-bold">TOTAL:</td>
                                            <td class="text-end fw-bold text-success fs-5">
                                                Rp <%= String.format("%,d", (int) transaksi.getTotal())%>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
