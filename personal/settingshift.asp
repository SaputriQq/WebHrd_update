
<!-- #include file='../connection_personal.asp' -->

<% nip = Request.QueryString("nip")%>
<% 
    ' set agen
    set pagen = server.createobject("ADODB.Command")
    pagen.activeConnection = MM_Cargo_string

    pagen.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.kry_nip = '"&nip&"'"
    set pagen = pagen.execute

    ' set shift
    set pshift = server.createobject("ADODB.Command")
    pshift.activeConnection = MM_Cargo_string
    pshift.commandText ="SELECT * FROM HRD_M_Shift Where Sh_AktifYN = 'Y'"
    set pshift = pshift.execute

    ' set karyawan
    set pkaryawan = server.createobject("ADODB.Command")
    pkaryawan.activeConnection = MM_Cargo_string

    pkaryawan.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AgenID = '"&pagen("Agen_ID")&"'ORDER BY Kry_Nama ASC"
    set pkaryawan = pkaryawan.execute

    ' set divisi
    set pdivisi = server.createobject("ADODB.Command")
    pdivisi.activeConnection = MM_Cargo_string

    pdivisi.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AgenID = '"&pagen("Agen_ID")&"' GROUP BY Div_Code, Div_Nama ORDER BY Div_Nama ASC"
    set pdivisi = pdivisi.execute
%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <title>SETTING SHIFT</title>
    <!--#include file="../layout/header.asp"-->
    <script type="text/javascript" src="../js/jqueryshiftkerja.js"></script>

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
    <link rel="stylesheet" type="text/css" href="../css/style.css" >
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <!--Select All CheckBox-->
        <script type="text/javascript">
                function checkAll(ele) {
                    var checkboxes = document.getElementsByTagName('input');
                        if (ele.checked) {
                            for (var i = 0; i < checkboxes.length; i++) {
                                if (checkboxes[i].type == 'checkbox' ) {
                                    checkboxes[i].checked = true;
                                }
                            }
                        } else {
                            for (var i = 0; i < checkboxes.length; i++) {
                                if (checkboxes[i].type == 'checkbox') {
                                    checkboxes[i].checked = false;
                                }
                            }
                        }
                }
        </script>
    
    <style>
        td {
            font-size: 14px;

        }

        th {
            font-size : 15px;

        }
        .logo-db{
            width:14%;
        }
    </style>
    
    
  </head>
  
  <body>
   <div class="container ">
   <div class="col-lg mt-2">
        <img src="<%=url%>/logo/landing.png" id="imgd" class="logo-db" >
    </div>
        <div class="row mt-4">
            <div class="col-md">
                <h2 class="text-center">FORM SETTING SHIFT</h1>
            </div>
        </div>
        <form method="post" action="settingshift_add.asp" class="form-group" name="formsetshift" > 
        <input type="hidden" id="nipatasan" class="form-control" value="<%=nip%>" name ="nipatasan">
            <div class="row ">
                <div class="col-12">
                    <div class="col-auto">
                        <div class="col-12">
                            <div class="col-auto">
                                <label for="" class="form-label">Agen</label>
                                <input type="hidden" id="agenid" class="form-control" value="<%=pagen("Agen_ID")%>" name ="agenid">
                            <fieldset disabled>
                                <input type="text" id="namaagen" class="form-control" value="<%=pagen("Agen_Nama")%>" name="namaagen">
                                <input type="hidden" id="atasannip" class="form-control" value="<%=nip%>" name="atasannip">
                            </fieldset>
                                
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <div class="col-auto">
                        <label for="shiftName" class="form-label">Pilih Shift</label>
                            <select required class="form-select" aria-label="Default select example" name="shiftName" id="shiftName" required >
                                <option value="">Pilih</option>
                                    <% do until pshift.eof %> 
                                    <option value="<%= pshift("Sh_ID") %> ">Shift ID <%= pshift("Sh_ID") %> | <%= pshift("SH_Name") %> </option>
                                    <% pshift.movenext
                                    loop %> 
                            </select>
                    </div>
                </div>
            </div>    
            <div class="row mt-3">
                <div class="col-12">
                    <div class="col-auto">
                        <label for="exampleInputEmail1" class="form-label">Pilih Divisi</label>
                            <select class="form-select" aria-label="Default select example" name="divisi" id="divisi" onchange="return getKaryawan()" >
                                <option value="">Pilih</option>
                                    <% do until pdivisi.eof %> 
                                    <option value="<%= pdivisi("Div_Code") %> "><%= pdivisi("Div_Nama") %>
                                    </option>
                                    <% pdivisi.movenext
                                    loop %> 
                            </select>
                    </div>
                </div>
            </div>    
            
            <div class="row justify-content-md-center ">
                <div class="col col-lg-11">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><input type="checkbox" onchange="checkAll(this)" name="chk[]" id="chk[]" font-size="10px"  >
                                    Pilih Semua
                                </th>
                                <th>
                                    Nama
                                </th>
                            </tr>
                        </thead>
                        <tbody id="datakaryawan" class="datakaryawan">
                            <% do while not pkaryawan.eof %>
                            <tr>
                                <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="<%=pkaryawan("Kry_Nip")%>" id="nipbawahan" name="nipbawahan">
                                </div>
                                
                                </td>
                                <td>
                                    <%=pkaryawan("Kry_Nama") %>
                                </td>
                            </tr>
                            <%pkaryawan.movenext
                            loop%>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="form-group">
                            <!-- set tanggal -->
                            <label class="control-label" for="date">Pilih Tanggal</label>
                            <input class="form-control" id="myrosterdate" name="myrosterdate" placeholder="MM/DD/YYY" type="text" autocomplete="off" required/>
                        </div>
                
            <div class='row mt-4'>
                <div class="d-flex mb-3">
                    <div class="p-2 btn-group" role="group" aria-label="Basic example">
                        <button type="button" class="btn btn-danger" onclick="window.location.href='index.asp'">Kembali</button>
                        <button type="button" class="btn btn-warning" onclick="window.location.href='updateshift.asp?nip=<%=nip%>'">Update</button>
                    </div>
                    <div class="ms-auto p-2">
                    
                    <input type="submit" class="btn btn-success" value="simpan" onclick="return valid()" >
                    </div>
                </div>
            </div>   
    </div>  
        </form>
    </body>
    <script>
        function valid() {
            let checked=false;
            let elements = document.getElementsByName("nipbawahan");
            let shift = document.getElementById("divisi").value;
           

                for(let i=0; i < elements.length; i++){
                    if(elements[i].checked) {
                        checked = true;
                        
                        
                    }
                }
                if (!checked) {
                    alert('Pilih Salah Satu');
                    
                }
                return checked;    
        } 
        // function carikaryawandivisi(e){
        //     let agen = document.getElementById("agenid");
        //     $.get("C_Kry_Shift.asp?divisi="+e+"&agen="+agen, function(data){
        //         // C_kar_shift.asp?divisi=0018&agen=pusat
        //     });
        // }
        function getKaryawan(){
        $.ajax({
        type: "get",
        url: "C_Kry_Shift.asp?divisi="+document.getElementById("divisi").value+"&agen="+document.getElementById("agenid").value,
            success: function (url) {
            $('.datakaryawan').html(url);
                                            
            }
        });
        }

        
    </script>
    
    
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
    <script src="../../js/script.js">

    </script>
</html>