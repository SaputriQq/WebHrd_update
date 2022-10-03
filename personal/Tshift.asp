<!-- #include file='../connection_personal.asp' -->
<% nip = Request.QueryString("nip")%>
<% 
    set histori_cmd = server.createobject("ADODB.Command")
        histori_cmd.activeConnection = MM_Cargo_string

        histori_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip,  HRD_M_Karyawan.Kry_Nama, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.Sh_ID, dbo.HRD_M_Shift.Sh_Name, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.shf_UpdateTime, dbo.HRD_T_Shift.Shf_updateID FROM dbo.HRD_T_Shift LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Shift.Shf_Nip = HRD_M_Karyawan.Kry_Nip order by shf_tanggal DESC "

        set histori = histori_cmd.execute

        Response.Buffer = true


%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HISTORI DATA SHIFT</title>
<!--#include file="../layout/header.asp"-->
</head>
<body>
    <div class="container">
        <div class='row'>
            <div class='col-sm text-center mt-3'>
                <h3>HISTORI SHIFT KERJA </h3>
            </div>
        </div>
        <div class="row mt-4 mb-2">
            <div class="col d-flex justify-content-start" >
                <a href="index.asp?nip=<%=nip%>" name="kembali" id="kembali"><button type="button" class="btn btn-danger keluar btn-sm">Kembali</button></a>
            </div>
        </div>
        <div class='row'>
            <div class='col-lg'>
                <table class="table table-striped table-hover">
                    <thead class="bg-secondary text-light">
                        <tr>
                            <th>Jam masuk</th>
                            <th>Jam keluar</th>
                            <th>Beda hari</th>
                            <th>NIP</th>
                            <th>Nama</th>
                            <th>Tanggal</th>
                            <th>Update ID</th>
                            <th>Tanggal Update</th>
                            <!--<td>Aksi</td>-->
                        </tr>
                    </thead>
                    </tbody>
                        <% 
                        do until histori.eof 
                            ' definisi jam masuk dan keluar 
                            jamMasuk = right("00"&histori("SH_JamIn"),2)&":"&right("00"&histori("Sh_MenitIn"),2)
                            jamKeluar = right("00"&histori("Sh_JamOut"),2)&":"&right("00"&histori("Sh_MenitOut"),2)

                            ' cek beda hari 
                            if histori("SH_iHari") = "N" then   
                                bhari = "No"
                            else
                                bhari = "Yes"
                            end if
                        %> 
                            <tr>
                                <td><%= jamMasuk %> </td>
                                <td><%= jamKeluar %> </td>
                                <td><%= bhari %> </td>
                                <td><%= histori("Shf_Nip") %> </td>
                                <td><%= histori("Kry_Nama") %> </td>
                                <td><%= histori("Shf_Tanggal") %> </td>
                                <td><%= histori("Shf_updateID") %> </td>
                                <td><%= histori("shf_UpdateTime") %> </td>
                                <!--<td><a href="" class="badge bg-warning" style="text-decoration:none;color:;">edit</a></td>-->
                            </tr>
                        <% 
                        response.flush
                        histori.movenext
                        loop 
                        %> 
                    </tbody>
            </table>
        </div>
        <div class="row">
            <div class="col">
                <!--pagination-->
                
                
                <!-- end pagging -->
            </div>
        </div>
    </div>
</body>