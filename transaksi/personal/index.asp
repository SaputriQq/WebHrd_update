<!-- #include file='.../../../../connection.asp' -->
<%
    if session("HT4") = false then
        Response.Redirect("../index.asp")
    end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PINJAMAN PERSONAL</title>
    <!-- #include file='../../layout/header.asp' -->
    <link rel="stylesheet" href="<%= url %>/css/klaim.css">
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-12 text-center mb-3 labelHeader">
            <h3>PINJAMAN DAN PEMBAYARAN PERSONAL</h3>
        </div>
    </div>
    <div class="row">
        <% if session("HT4A") = true then%>
        <div class="col-sm-3 mb-3 d-flex justify-content-center">
            <a href="pinjaman.asp">
                <div class="card" style="background:url(../../logo/personalPinjam.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">PINJAMAN</h3>
                        <p>Detail data pinjaman Personal karyawan</p>
                    </div>
                </div>
            </a>
        </div>
        <%end if%>
        <%if session("HT4B") = true then%>
        <div class="col-sm-3 mb-3  d-flex justify-content-center" >
            <a href="pembayaran.asp" >
                <div class="card" style="background:url(../../logo/personalBayar.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">PEMBAYARAN</h3>
                        <p>Detail pembayaran cicilan PERSONAL karyawan</p>
                    </div>
                </div>
            </a>
        </div>
        <%end if%>
        <%if session("HT4C") = true then%>
        <div class="col-sm-3 mb-3  d-flex justify-content-center" >
            <a href="mutasi.asp" >
                <div class="card" style="background:url(../../logo/personalMutasi.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">LAPORAN</h3>
                        <p>Detail Pengambilan dan pembayaran cicilan personal</p>
                    </div>
                </div>
            </a>
        </div>
        <%end if%>
        <%if session("HT4D") = true then%>
        <div class="col-sm-3 mb-3  d-flex justify-content-center" >
            <a href="proses.asp" >
                <div class="card" style="background:url(../../logo/personalProses.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">PROSES</h3>
                        <p>Proses Pengambilan dan pembayaran cicilan personal </p>
                    </div>
                </div>
            </a>
        </div>
        <%end if%>
    </div>
    <div class="row">
        <div class="col-sm-12 text-center" >
            <a href="../../dashboard.asp" style="text-decoration: none;"><i class="fa fa-long-arrow-left" aria-hidden="true"></i> kembali</a>
        </div>
    </div>  
</div>


<!-- #include file='../../layout/footer.asp' -->