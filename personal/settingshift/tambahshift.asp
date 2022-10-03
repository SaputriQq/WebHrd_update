<!-- #include file='../../connection_personal.asp' -->

<% 
    nip = Request.QueryString("nip")

    ' set agen
    set agent_cmd =  server.createobject("ADODB.Command")
    agent_cmd.activeConnection = MM_Cargo_String

    agent_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.kry_nip = '"&nip&"'"

    set agent = agent_cmd.execute

    ' set shift
    set shift_cmd = server.createobject("ADODB.Command")
    shift_cmd.activeConnection = MM_Cargo_String

    shift_cmd.commandText = "SELECT * FROM HRD_M_Shift Where Sh_AktifYN = 'Y'"
    set shift = shift_cmd.execute

    ' set karyawan
    set karyawans_cmd = server.createobject("ADODB.Command")
    karyawans_cmd.activeConnection = MM_Cargo_String

    karyawans_cmd.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AgenID = '"&agent("Agen_ID")&"'ORDER BY Kry_Nama ASC"

    set karyawans = karyawans_cmd.execute

    ' set divisi
    set divisit_cmd = server.createobject("ADODB.Command")
    divisit_cmd.activeConnection = MM_Cargo_String

    divisit_cmd.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AgenID = '"&agent("Agen_ID")&"' GROUP BY Div_Code, Div_Nama ORDER BY Div_Nama ASC"

    set divisit = divisit_cmd.execute
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Halaman Shift Kerja</title>
    <!--#include file="../../layout/header.asp"-->
    <script type="text/javascript" src="js/jqueryshiftkerja.js"></script>

    <!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
    <link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />

    <!-- Bootstrap Date-Picker Plugin -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

    <script type="text/javascript">

        $(document).ready(function(){
            var date_input=$('input[name="myrosterdate"]'); //our date input has the name "myrosterdate"
            var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
            var options={
                multidate:true,
                format: 'yyyy-mm-dd',
                container: container,
                todayHighlight: true,
                autoclose: false,
            };
                date_input.datepicker(options);
        });
    </script>   
    <!--CSS-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Viga&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css" >
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <!--#include file="../../layout/header.asp"-->
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
    <div class='row mt-3'>
        <div class='col-lg'>
            <h3 class="text-center">SETTING SHIFT KERJA</h3>
        </div>
    </div>
    <div class="row">
        <div class="col mt-2">
            <div class="col-lg">
                <div class="form-floating  mb-2">
                    <!-- Form code begins -->
                    <form method="post" action="#" class="form-group" name="formsetshift">
                        <fieldset disabled>
                            <input type="hidden" id="nipatasan" class="form-control" value="<%= nip%>" name="nipatasan" >
                        </fieldset>
                        <div class="row" >
                            <div class="col-12">
                                <div class="col-auto">
                                    <label for="Agen" class="form-label">Agen</label>
                                    <input type ="hidden" id="agenid" class="form-control" value="<%= agent("Agen_ID")%>" name ="agenid">
                                    <fieldset disabled>
                                        <input type="text" id="namaagen" class="form-control" value="<%=agent("Agen_Nama")%>" name="namaagen">
                                        <input type="hidden" id="atasannip" class="form-control" value="<%=nip%>" name="atasannip">
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="col-auto">
                                    <label for="shiftName" class="form-label">Pilih Shift</label>
                                    <select required class="form-select" aria-label="Default select example" name="shiftName" id="shiftName" required>
                                        <option value="">Pilih</option>
                                        <% do until shift.eof %> 
                                        <option value="<%= shift("Sh_ID") %> ">Shift ID <%= shift("Sh_ID") %> | <%= shift("SH_Name") %> </option>
                                        <% shift.movenext
                                        loop %> 
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pilagen" class="form-label">Pilih Agen</label>
                            <select class="form-select" id="select-agen" required>
                                <option value="pilihagen">Pilih </option>
                                <% do while not agent.eof %>
                                    <option value="<%= agent("Agen_ID")%>"><%= agent("Agen_Nama")%></option>
                                <% 
                                    agent.movenext 
                                    loop
                                %>
                                
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pildivisi" class="form-label">Pilih Divisi</label>
                            <select class="form-select" id="select-divisi">
                                <option value="pilihdivisi">Pilih</option>
                                <% do while not divisit.eof %>
                                    <option value="<%= divisit("Div_Code")%>"><%= divisit("Div_Nama")%></option>
                                <% 
                                    divisit.movenext
                                    loop
                                %>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

