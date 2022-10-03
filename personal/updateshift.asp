<!-- #include file='../connection_personal.asp' -->
<%
    nip =request.queryString("nip")

    set karyawan = server.createobject("ADODB.Command")
    karyawan.activeConnection = MM_Cargo_string

    karyawan.commandText="SELECT Agen_ID, Agen_Nama FROM HRD_M_Karyawan RIGHT OUTER JOIN GLB_M_AGEN ON HRD_M_Karyawan.Kry_AgenID = GLB_M_AGEN.Agen_ID WHERE HRD_M_Karyawan.Kry_Nip = '"&nip&"'"
    ' response.write karyawan.commandText &"<br>"

    set karyawan = karyawan.execute
    
    set pshift = server.createobject("ADODB.Command")
    pshift.activeConnection = MM_Cargo_string

    pshift.commandText ="SELECT * FROM HRD_M_Shift Where Sh_AktifYN = 'Y'"
    set pshift = pshift.execute
%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>UPDATE SETTING SHIFT</title>
    <!--#include file="../layout/header.asp"-->
     

  </head>
  <body>
        <div class="container">
            <div class="row mt-3">
                <div class="col-12">
                    <h1 class="text-center">UPDATE SETTING SHIFT</h1>
                </div>
            </div>
        <form method="post" action="coba.asp" class="form-group" name="formsetshift"  > 
            <div class = "row mt-5 justify-content-center">
                <div class="col-lg-3">
                    <label class="control-label" for="text">Nama Cabang</label>
                    <input class="form-control" id="ncabang" name="ncabang"  type="text" autocomplete="off" value ="<%=karyawan("Agen_Nama")%>"readonly/> 
                    <input class="form-control" id="idcabang" name="idcabang"  type="hidden" autocomplete="off" value ="<%=karyawan("Agen_ID")%>"/>
                    <input class="form-control" id="nipatasan" name="nipatasan"  type="hidden" autocomplete="off" value ="<%=nip%>"/>
                </div>
            </div>
            <div class="row mt-3 justify-content-center">
                <div class="col-lg-3">
                    <label class="control-label" for="date">Pilih Tanggal Awal</label>
                    <input class="form-control" id="tglpertama" name="tglpertama"  type="date" autocomplete="off" required/>
                </div>
                <div class="col-lg-3">
                    <label class="control-label" for="date">Pilih Tanggal Akhir</label>
                    <input class="form-control" id="tglkedua" name="tglkedua"  type="date" autocomplete="off" required/>  
                </div>
                <div class="col-lg-3">
                    <label class="control-label" for="text">Pilih Shift</label>
                    <select required class="form-select" aria-label="Default select example" name="shiftid" id="shiftid" required >
                        <option value="">Pilih</option>
                        <% do until pshift.eof %> 
                        <option value="<%= pshift("Sh_ID") %> ">Shift ID <%= pshift("Sh_ID") %> | <%= pshift("SH_Name") %> </option>
                        <% pshift.movenext
                        loop %> 
                    </select>
                </div>
            </div>
            <div class = "row mt-3 justify-content-center">
                <div class="col-lg-3">
                </div>
            </div>
            <div class="row mt-3 justify-content-center">
                <div class="col-lg-9">
                    <div class="p-2 btn-group" role="group" aria-label="Basic example">
                        <button type="button" class="btn btn-danger" onclick="window.location.href='index.asp'">Kembali</button>
                        <button type="submit" class="btn btn-success">Cari</button>
                    </div>
                </div>
            </div> 
        </form>    
        </div>


  <!--#include file="../layout/footer.asp"-->
    
    

