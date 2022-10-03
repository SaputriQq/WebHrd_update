<!-- #include file='../connection_personal.asp' -->
<%  nip = Request.QueryString("nip")
    nama = Request.QueryString("nama")
    divisi = Request.QueryString("divisi")

    set shiftkry_cmd = server.createobject("ADODB.Command")
        shiftkry_cmd.activeConnection = MM_Cargo_string

        shiftkry_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip,  HRD_M_Karyawan.Kry_Nama, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.Sh_ID, dbo.HRD_M_Shift.Sh_Name, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.shf_UpdateTime, dbo.HRD_T_Shift.Shf_updateID FROM dbo.HRD_T_Shift LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Shift.Shf_Nip = HRD_M_Karyawan.Kry_Nip WHERE shf_NIP='"& nip &"' order by shf_tanggal DESC "

        set shiftkry= shiftkry_cmd.execute

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info Shift</title>
    <!--#include file="../layout/header.asp"--> 
    <style>
        .logo-db{
            width:14%;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col-lg mt-2">
            <img src="<%=url%>/logo/landing.png" id="imgd" class="logo-db" >
        </div>
        <div class="col-lg mt-2">
            <div class='row'>
                <div class='col-sm text-center '>
                    <h3> SHIFT KARYAWAN </h3>
                </div>
            </div>
        </div>
        <div class="row mt-4 ">
            <div class="d-flex justify-content-center">
                <div class="col-lg-6 mb-3">
                    <div class="align-self-end">
                        <div class="input-group ">
                            <span class="input-group-text" id="inputGroup-sizing-default" style="background-color:#34495E;color:white;">NIP</span>
                            <input type="text" class="form-control" value="<%= nip %>" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" style="text-align:center;" readonly>
                            <span class="input-group-text" id="inputGroup-sizing-default" style="background-color:#34495E;color:white;">NAMA</span>
                            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="<%= nama%>" style="text-align:center;" readonly>
                        </div>
                        <div class="input-group ">
                            <span class="input-group-text" id="inputGroup-sizing-default" style="background-color:#34495E;color:white;">DIVISI</span>
                            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="<%= divisi%>" style="text-align:center;" readonly>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-lg">
            <a href="carishift.asp">
                <button type="button" class="btn btn-success ">Kembali</button></a>
            </div>
        </div>
        <div class="row mt-2 ">
            <div class="col-lg-12">
                <table class="table table-hover">
                    <thead class="bg-dark text-light">
                        <tr>
                            <th>Kode Shift </th>
                            <th>Shift Karyawan</th>
                            <th>Tanggal</th>
                            <th>Jam Masuk</th>
                            <th>Jam Keluar</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        do until shiftkry.eof
                        ' definisi jam masuk dan keluar 
                            jamMasuk = right("00"&shiftkry("SH_JamIn"),2)&":"&right("00"&shiftkry("Sh_MenitIn"),2)
                            jamKeluar = right("00"&shiftkry("Sh_JamOut"),2)&":"&right("00"&shiftkry("Sh_MenitOut"),2)

                    %>
                    
                        <tr>
                            <td><%= shiftkry("sh_ID") %></td>
                            <td><%= shiftkry("sh_Name") %></td>
                            <td><%= shiftkry("shf_Tanggal") %></td>
                            <td><%= jamMasuk %></td>
                            <td><%= jamKeluar %></td>
                            <td><%= shiftkry("shf_UpdateTime") %></td>
                        </tr>
                        <% 
                            response.flush
                            shiftkry.movenext
                            loop 
                        %> 
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<!--#include file="../layout/footer.asp"-->