<!-- #include file='../connection_personal.asp' -->
<%
    nip = request.form("nipatasan")
    tglpertama = request.form("tglpertama")
    tglkedua = request.form("tglkedua")
    cabang = request.form("idcabang")
    shift = request.form("shiftid")

    ' query filter shift nip
    set ptanggal_cmd=server.createobject("ADODB.Command")
    ptanggal_cmd.activeConnection = MM_Cargo_string

    ptanggal_cmd.commandText = "SELECT HRD_T_SHIFT.Shf_NIP,HRD_M_Karyawan.Kry_Nama FROM HRD_T_SHIFT LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SHIFT.Shf_NIP = HRD_M_Karyawan.Kry_NIP  WHERE Shf_Tanggal BETWEEN '"& tglpertama &"' AND '"& tglkedua &"' GROUP BY HRD_T_SHIFT.Shf_NIP,HRD_M_Karyawan.Kry_Nama "
    ' response.write  ptanggal_cmd.commandText &"<br>"
    set ptanggal = ptanggal_cmd.execute 
    
    ' looping / ngulang data yang ada didatabase
    p = ""
    do while not ptanggal.eof
        p = p & ptanggal("Shf_NIP")& ","
    ptanggal.movenext
        if ptanggal.eof THEN
            'HITUNG JUMLAH CHARAKTER 
            nochar = len(P) - 1
            ' HAPUS KOMA DI KARAKTER TERAKHIR
            datanip = left(p,nochar)
            ' response.write(right(datanip,1))
        end if
    loop

    ' filter agen
    set namacabang = server.createobject("ADODB.Command")
    namacabang.activeConnection = MM_Cargo_string

    namacabang.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.kry_nip = '"&nip&"' " 
    'response.write namacabang.commandText &"<br>"
    set namacabang = namacabang.execute

    ' filter shift
    set shiftdata = server.createobject("ADODB.Command")
    shiftdata.activeConnection = MM_Cargo_string

    shiftdata.commandText ="SELECT * FROM HRD_M_Shift Where Sh_ID = '"& shift &"'"
    'response.write shiftdata.commandText &"<br>"
    set shiftdata = shiftdata.execute

    set pshift = server.createobject("ADODB.Command")
    pshift.activeConnection = MM_Cargo_string

    pshift.commandText ="SELECT * FROM HRD_M_Shift Where Sh_AktifYN = 'Y' ORDER BY Sh_Name Desc"
    'response.write pshift.commandText &"<br>"
    set pshift = pshift.execute

    set pdivisi = server.createobject("ADODB.Command")
    pdivisi.activeConnection = MM_Cargo_string

    pdivisi.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AgenID = '"& namacabang("Agen_ID") &"' GROUP BY Div_Code, Div_Nama ORDER BY Div_Nama ASC"
    set pdivisi = pdivisi.execute

    ' filter nipbawahan
    set pkaryawan = server.createobject("ADODB.Command")
    pkaryawan.activeConnection = MM_Cargo_string

    pkaryawan.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AgenID = '"& namacabang("Agen_ID")&"'AND Kry_NIP NOT LIKE '%H%' AND Kry_NIP NOT LIKE '%A%' ORDER BY Kry_Nama ASC"
    set pkaryawan = pkaryawan.execute

    listkaryawan = ""
    do while not pkaryawan.eof
        listkaryawan = listkaryawan & pkaryawan("Kry_NIP")& ","
    pkaryawan.movenext
        if pkaryawan.eof THEN
            'HITUNG JUMLAH CHARAKTER 
            nochar = len(listkaryawan) - 1
            ' HAPUS KOMA DI KARAKTER TERAKHIR
            dkaryawan = left(listkaryawan,nochar)
            ' response.write(right(datanip,1))
        end if
    loop
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

        function getData(e){
            let arryDatalama = e.split(",");
            // console.log(arryDatalama);
            var checknomor = document.getElementById('checknomor').value;
            
                for (let i = 1; i < checknomor;i++){
                    let checkboxes = document.getElementById('nipbawahan('+i+')').value;
                    if (arryDatalama.indexOf(checkboxes)!== -1){
                        document.getElementById('nipbawahan('+i+')').checked = true;
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
    </style>
    
    
  </head>
  
  <body onload="getData('<%=datanip%>')">
   <div class="container ">
        <div class="row mt-4">
            <div class="col-md">
                <h1 class="text-center">FORM UPDATE SHIFT</h1>
            </div>
        </div>
        <form method="post" action="coba_update.asp" class="form-group" name="formsetshift" > 
            <input type="hidden" id="nipatasan" class="form-control" value="<%=nip%>" name ="nipatasan">
            <div class="row mt-3">
                <div class="col-12">
                    <div class="col-auto">
                        <div class="col-12">
                            <div class="col-auto">
                                <label for="" class="form-label">Nama Cabang</label>
                                <% do while not namacabang.eof %>
                                <input type="hidden" id="agenid" class="form-control" value="<%=namacabang("Agen_ID")%>" name ="agenid">
                                <fieldset disabled>
                                    <input type="text" id="namaagen" class="form-control" value="<%=namacabang("Agen_Nama")%>" name="namaagen">
                                </fieldset>
                                <% namacabang.movenext
                                loop %>
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
                                <option value="<%= shiftdata("Sh_ID") %> ">Shift ID <%= shiftdata("Sh_ID") %> | <%= shiftdata("SH_Name") %> </option>
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
                            <% 
                                pkaryawan.movefirst
                                nomor = 0
                                do while not pkaryawan.eof 
                                nomor = nomor+1
                            %>
                                
                            <tr>
                                <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="<%=pkaryawan("Kry_Nip")%>" id="nipbawahan(<%=nomor%>)" name="nipbawahan">
                                </div>
                                </td>
                                <td>
                                    <%=pkaryawan("Kry_Nama") %>
                                </td>
                            </tr>
                            <%pkaryawan.movenext
                            loop%>
                            <input type="hidden" id="checknomor" value="<%=nomor%> ">
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

                    </div>
                    <div class="ms-auto p-2">
                    
                    <input type="submit" class="btn btn-primary" value="simpan" onclick="return valid()" >
                    </div>
                </div>
            </div>   
    </div>  
        </form>
    </body>
    <script>
        //FUNGCTION VALIDASI
        function valid() {
            let checked=false;
            let elements = document.getElementsByName("nipbawahan");
            let shift = document.getElementById("divisi").value;
            console.log(elements);
           

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
        //FUNCTION AJAX
        function getKaryawan(){
        $.ajax({
        type: "get",
        url: "C_Kry_Shift.asp?divisi="+document.getElementById("divisi").value+"&agen="+document.getElementById("agenid").value,
            success: function (url) {
            console.log(url);
            $('.datakaryawan').html(url);
                                            
            }
        });
        }

        function coba(){ //
            let checked = false;
            let dataa = document.getElementsByName("nipke");
            for( let i=0; i < dataa.length; i++ ){
                var hasildataa = dataa[i].value;
                // console.log(hasildataa);
            }
            // console.log(dataa);
            let datab = document.getElementsByName("nipbawahan");
            for( let i=0; i < datab.length; i++ ){
                var hasildatab = datab[i].value;
                if( hasildataa = hasildatab ){
                    // console.log("sama");
                }else{
                    // console.log("tidak sama");
                }
            }
                
            
        }

        
    </script>
    
    
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
    <script src="../js/script.js">

    </script>
</html>