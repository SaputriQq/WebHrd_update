<!-- #include file='../connection_personal.asp' -->
<% 
    ' filter tanggal dan bulan 
    bulana = trim(Request.QueryString("bulana"))
    if bulana = "" then
        bulana = trim(Request.Form("bulana"))
    end if

    bulane = trim(Request.QueryString("bulane"))
    if bulane = "" then 
        bulane = trim(Request.Form("bulane"))
    end if

    cabang = Request.QueryString("cabang")
    if cabang = "" then
        cabang = Request.Form("cabang")
    end if

    dim shiftkaryawan_cmd, shiftkaryawan

    SET shiftkry_cmd = server.createobject("ADODB.Command")
    shiftkry_cmd.activeConnection = MM_Cargo_string

    SET cabangagen_cmd = server.createobject("ADODB.Command")
    cabangagen_cmd.activeConnection = MM_Cargo_string

    cabangagen_cmd.commandText = "SELECT Agen_ID, Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_agenID = GLB_M_Agen.Agen_ID WHERE Agen_Nama NOT LIKE '%XXX%' AND Agen_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_tglKeluar = '' GROUP BY Agen_ID, Agen_Nama ORDER BY Agen_Nama ASC"
    ' response.write cabangagen_cmd &"<br>"
    SET cabangagen = cabangagen_cmd.execute

    if bulana <> "" and bulane <> "" then
        root = "SELECT HRD_M_Divisi.DIv_Nama, HRD_M_Divisi.Div_Code, HRD_M_Divisi.Div_AktifYN FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN HRD_T_Shift ON HRD_M_Karyawan.Kry_Nip = HRD_T_Shift.SHF_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_T_Shift.SHF_Tanggal BETWEEN '"& bulana &"' AND '"& bulane &"' AND GLB_M_Agen.Agen_ID = '"& cabang &"' AND (ISNULL(HRD_M_DIvisi.Div_Nama, '') <> '') GROUP BY HRD_M_Divisi.DIv_Nama, HRD_M_Divisi.Div_Code, HRD_M_Divisi.Div_AktifYN ORDER BY HRD_M_Divisi.Div_NAma ASC"
        ' Response.Write root & "<br>"

        set shiftkaryawan = shiftkaryawan_cmd.execute
    ' paggination
        set conn = Server.CreateObject("ADODB.Connection")
        conn.open MM_Cargo_string
        dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
        dim angka
        dim code, nama, aktifId, UpdateId, uTIme, orderBy
        set rs = Server.CreateObject("ADODB.Recordset")
        sqlawal = root
        sql=sqlawal
        rs.open sql, conn
        ' records per halaman
        recordsonpage = 10
        ' count all records
        allrecords = 0
        do until rs.EOF
            allrecords = allrecords + 1
            rs.movenext
        loop
        ' if offset is zero then the first page will be loaded
        offset = Request.QueryString("offset")
        if offset = 0 OR offset = "" then
            requestrecords = 0
        else
            requestrecords = requestrecords + offset
        end if
        rs.close
        set rs = server.CreateObject("ADODB.RecordSet")
        sqlawal = root
        sql=sqlawal + orderBy
        rs.open sql, conn
        ' reads first records (offset) without showing them (can't find another solution!)
        hiddenrecords = requestrecords
        do until hiddenrecords = 0 OR rs.EOF
            hiddenrecords = hiddenrecords - 1
            rs.movenext
        if rs.EOF then
            lastrecord = 1
        end if	
        loop
    
    end if
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SHIFT KARYAWAN</title>
    <!--#include file="../layout/header.asp"-->
    <style>
    a{
        text-decoration:none;
    }
    .wiw{
        color:white;
    }
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
        <% if bulana = "" and bulane = "" then %>
        <div class="row text-center">
            <div class="col-lg mt-5" >
                <h3 class="mb-3 mt-4">PENCARIAN SHIFT</h3>
            </div>
        </div>
        <div class='row mb-3 mt-4'>
            <div class='col-sm-12 '>
                <form action="carishift.asp" method="post">
                    <div class="mb-3 row justify-content-md-center">
                        <label for="bulana" class="col-sm-2 col-form-label">Tgl. Dari</label>
                        <div class="col-sm-6">
                            <input type="date" aria-label="Bulana" class="form-control" name="bulana" id="bulana" required>
                        </div>
                    </div>
                    <div class="mb-3 row justify-content-md-center">
                        <label for="bulane" class="col-sm-2 col-form-label">Tgl.Sampai</label>
                            <div class="col-sm-6">
                                <input type="date" aria-label="Bulane" class="form-control" name="bulane" id="bulane" required>
                            </div>
                    </div>
                    <div class="mb-3 row justify-content-md-center">
                        <label for="agen" class="col-sm-2 col-form-label">Agen/Cabang</label>
                        <div class="col-sm-6">
                            <select class="form-select" aria-label="Default select example" id="cabang" name="cabang" required>
                            <option value="">Pilih</option>
                            <% do while not cabangagen.eof %>
                                <option value="<%= cabangagen("Agen_ID") %>"><%= cabangagen("Agen_Nama") %></option>
                            <% 
                                cabangagen.movenext
                                loop
                            %>
                        </select>
                        </div>
                    </div>
                    <div class="row text-center">
                        <div class="col-sm-12 mt-2">
                            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" aria-hidden="true"></i> CARI</button>
                            <button type="button" class="btn btn-sm btn-danger" onclick="window.location.href='index.asp'">Kembali</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <% end if %>
        <% if bulana <> "" and bulane <> "" then %>
            <div class="row text-center">
                <div class="col-lg">
                    <h3 class="mt-3 mb-4">DAFTAR DIVISI SETTING SHIFT</h3>
                </div>
            </div>
            <button class="btn btn-primary btn-sm" type="button" onclick="window.location.href=`carishift.asp`"><i class="fa fa-coffee"></i> Refresh</button>
            <div class='row mt-3'>
                <div class='col-lg'>    
                    <table class="table table-striped table-hover table-daftardivisi">
                        <thead>
                            <tr class="bg-dark text-light">
                                <th>Nama</th>
                                <th>Status</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                showrecords = recordsonpage
                                recordcounter = requestrecords
                                do until showrecords = 0 OR  rs.EOF
                                recordcounter = recordcounter + 1
                            %>
                            <tr>
                                <td>
                                    <%= rs("Div_Nama") %>
                                </td>
                                <td>Aktif</td>
                                <td>
                                    <a href="daftarkryshift.asp?id=<%= rs("Div_Code") %>&bulana=<%= bulana %>&bulane=<%= bulane %>&cabang=<%= cabang %>"class="badge bg-success text-light" class="badge bg-success text-light" >Detail</a>
                                </td>
                            </tr>
                            <% 
                                showrecords = showrecords - 1
                                rs.movenext
                                if rs.EOF then
                                lastrecord = 1
                                end if
                                loop
                                rs.close    
                        
                            %> 
                        </tbody>
                    </table>
                </div>
            </div>
            <div class='row'>
                <div class='col'>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item">
                            <% if requestrecords <> 0 then %>
                                <a class="page-link prev" href="shiftkaryawan.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=pagelistcounter%>&bulana=<%= bulana %>&bulane=<%= bulane %>">&#x25C4; Prev </a>
                            <% else %>
                                <p class="page-link prev-p">&#x25C4; Prev </p>
                            <% end if %>
                            </li>
                            <li class="page-item d-flex" style="overflow-y:auto;">	
                            <%
                            pagelist = 0
                            pagelistcounter = 0
                            do until pagelist > allrecords  
                            pagelistcounter = pagelistcounter + 1
                            %>
                                <a class="page-link hal" href="shiftkaryawan.asp?offset=<% = pagelist %>&page=<%=pagelistcounter%>&bulana=<%= bulana %>&bulane=<%= bulane %>"><%= pagelistcounter %></a> 
                            <%
                            pagelist = pagelist + recordsonpage
                            loop
                            %>

                            </li>
                            <li class="page-item">

                                <% if(recordcounter > 1) and (lastrecord <> 1) then %>
                                <a class="page-link next" href="shiftkaryawan.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=pagelistcounter%>&bulana=<%= bulana %>&bulane=<%= bulane %>">Next &#x25BA;</a>
                                <% else %>
                                <p class="page-link next-p">Next &#x25BA;</p>
                                <% end if %>              
                            </li>	
                        </ul>
                    </nav> 
                    <!-- end pagging --> 
                </div>
        </div>    
        <% end if %>
       
        
    </div>
    <script>
        function toggleMenu(){
            let navigation = document.querySelector('.navigation');
            navigation.classList.toggle('active');
        }
    </script>

