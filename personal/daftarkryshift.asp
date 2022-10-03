<!-- #include file='../connection_personal.asp' -->

<% 
    dim code, daftarkry_cmd, daftarkry

    code = request.queryString("id")
    bulana = request.queryString("bulana")
    bulane = request.queryString("bulane")
    cabang = request.queryString("cabang")

    set daftarkry_cmd = server.createobject("ADODB.Command")
    daftarkry_cmd.activeConnection = MM_Cargo_string

    daftarkry_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.DIv_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_T_Shift ON HRD_M_Karyawan.Kry_Nip = HRD_T_Shift.SHF_Nip WHERE HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_DDBID = '"& code &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' AND GLB_M_Agen.Agen_ID = '"& cabang &"' AND HRD_T_Shift.SHF_Tanggal BETWEEN '"& bulana &"' AND '"& bulane &"' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama ORDER BY Kry_Nama ASC"
    
    set daftarkry = daftarkry_cmd.execute

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KARYAWAN SHIFT</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    a{
        text-decoration:none;
    }
    .logo-db{
            width:14%;
        }
    </style>
</head>
<body>
    <div class='container'>
        <div class="col-lg mt-2">
                <img src="<%=url%>/logo/landing.png" id="imgd" class="logo-db" >
        </div>
    <% if daftarkry.eof then %>
        <div class='row'>
            <div class='col-lg text-center mt-3'>
                <h3 Class="mt-3 mb-2">SHIFT KARYAWAN </h3>
            </div>
        </div>
        <div class="row mt-2">
            <div class="d-flex justify-content-center">
                <div class="col-lg-4">
                    <div class="input-group mb-3 ">
                        <span class="input-group-text" id="divisi" style="">Divisi</span>
                        <input type="text" class="form-control"  value="" style="align-item:center;" disabled>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg">
            <button class="btn btn-success btn-sm" type="button" onclick="window.location.href=`carishift.asp`">Kembali</button>
        </div>
            <div class='text-center bg-dark p-2 text-white bg-opacity-25 mt-2'>
                <div class='notiv-header mt-4'>
                    <label>WARNING !!!</label>
                </div>
                <div class='content-pernama mb-4'>
                    <p>DATA TIDAK DI TEMUKAN</p>
                    <p>MOHON UNTUK MELAKUKAN SETTING SHIFT TERLEBIH DAHULU</p>

                </div>
	        </div>
    <% else %>    
        <div class='row'>
            <div class='col-lg text-center mt-3'>
                <h3 Class="mt-3 mb-2">SHIFT KARYAWAN </h3>
            </div>
        </div>
        <div class="row mt-2">
            <div class="d-flex justify-content-center">
                <div class="col-lg-4">
                    <div class="input-group mb-3 ">
                        <span class="input-group-text" id="divisi" style="background-color:#34495E;color:white;">Divisi</span>
                        <input type="text" class="form-control"  value="<%=ucase(daftarkry("Div_Nama"))%> " style="text-align:center;" disabled>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg">
            <button class="btn btn-success btn-sm" type="button" onclick="window.location.href=`carishift.asp`">Kembali</button>
        </div>
        
        <div class="row">
            <div class="col-lg">
                <table class="table table-striped table-hover mt-1">
                    <thead class="bg-dark text-light">
                        <tr>
                            <th>No</th>
                            <th>Nip</th>
                            <th>Nama</th>
                            <th>Status Shift</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            dim i
                            i = 0 
                            do until daftarkry.eof 
                            i = i + 1
                            'Response.Write i %> 
                            <tr>   
                                <td><%= i %></td> 
                                <td><%= daftarkry("Kry_Nip") %> </td>
                                <td><%= daftarkry("Kry_Nama") %> </td>
                                <td><a href="infoshift.asp?nip=<%=daftarkry("Kry_NIP")%>&nama=<%=daftarkry("Kry_Nama")%>&divisi=<%=daftarkry("Div_nama")%>" class="badge bg-primary text-light">Info</a>
                                    <!--<a href="#" class="badge bg-danger text-light">Edit</a>-->
                                </td>
                            </tr>
                            <% daftarkry.movenext
                            loop 
                        %>
                    </tbody>
                </table>
                    <% 
                        i = 0
                    %> 
            </div>
        </div>
        <% end if %>
    </div>
<!--#include file="../layout/footer.asp"-->