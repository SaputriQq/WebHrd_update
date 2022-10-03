<!-- #include file='../../connection.asp' -->
<% 
    if session("HT3B") = false then
        Response.Redirect("index.asp")
    end if
    
    dim pembayaran_cmd, pembayaran
    dim root, tgla, tgle, nip, nama, area

    ckTgl = Request.Form("ckTgl")
    if ckTgl = "" then
        ckTgl = Request.QueryString("ckTgl")
    end if

    ckNama = Request.Form("ckNama")
    if ckNama = "" then
        ckNama = Request.QueryString("ckNama")
    end if

    ckArea = Request.Form("ckArea")
    if ckArea = "" then
        ckArea = Request.QueryString("ckArea")
    end if

    tgla = Request.Form("tgla")
    if tgla = "" then
        tgla = Request.QueryString("tgla")
    end if

    tgle = Request.Form("tgle")
    if tgle = "" then
        tgle = Request.QueryString("tgle")
    end if

    nip = Request.Form("nip")
    if nip = "" then
        nip = Request.QueryString("nip")
    end if

    nama = trim(Request.Form("nama"))
    if nama = "" then
        nama = trim(Request.QueryString("nama"))
    end if

    area = Request.Form("area")
    if area = "" then
        area = Request.QueryString("area")
    end if

    ' setting default query 
    query = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_T_BK_Bank.TPK_ID_Bank, HRD_T_BK_Bank.TPK_Tanggal, HRD_T_BK_Bank.TPK_Nip, HRD_T_BK_Bank.TPK_Ket, HRD_T_BK_Bank.TPK_PP, HRD_T_BK_Bank.TPK_AktifYN, HRD_T_BK_Bank.TPK_UpdateID, HRD_T_BK_Bank.TPK_UpdateTime FROM HRD_M_Karyawan RIGHT OUTER JOIN HRD_T_BK_Bank ON HRD_M_karyawan.Kry_Nip = HRD_T_BK_Bank.TPK_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.kry_AktifYN = 'Y'"

    if tgla <> "" And tgle <> "" then
        filterTgl =  " AND HRD_T_BK_Bank.TPK_tanggal BETWEEN '"& Cdate(tgla) &"' AND '"& Cdate(tgle) &"'"
    else 
        filterTgl = ""
    end if

    if nama <> "" then
        filterNama = " AND HRD_M_Karyawan.Kry_Nama LIKE '%"& nama &"%'"
    else
        filterNama = ""
    end if

    if area <> "" then
        filterArea = " AND HRD_M_Karyawan.Kry_AgenID = '"& area &"'"
    else
        filterArea = ""
    end if

    orderBy = " ORDER BY HRD_T_BK_Bank.TPK_Tanggal DESC" 

    If ckTgl <> "" and ckNama <> "" then
        root = query + filterTgl + filterNama + orderBy
    elseIf ckTgl <> "" and ckArea <> "" then
        root = query + filterTgl + filterArea + orderBy
    elseIf ckNama <> "" and ckArea <> "" then
        root = query + filterNama + filterArea + orderBy
    elseIf ckTgl <> "" then
        root = query + filterTgl + orderBy
    elseIf ckNama <> "" then
        root = query + filterNama + orderBy
    elseIf ckArea <> "" then
        root = query + filterArea + orderBy
    else
        root = query + orderBy
    end if  

    ' execute table data
    set pembayaran_cmd = Server.CreateObject("ADODB.Command")
    pembayaran_cmd.activeConnection = mm_cargo_string

    pembayaran_cmd.commandText = root
    ' Response.Write pembayaran_cmd.commandText & "<br>"
    set pembayaran = pembayaran_cmd.execute

    ' pencarian berdasarkan agen
    pembayaran_cmd.commandText = "SELECT Agen_id, Agen_Nama FROM HRD_M_Karyawan INNER JOIN HRD_T_BK_Bank ON HRD_M_Karyawan.Kry_Nip = HRD_T_BK_Bank.TPK_Nip LEFT OUTER JOIN GLB_M_Agen ON GLB_M_Agen.Agen_ID = HRD_M_Karyawan.Kry_AgenID WHERE GLB_M_Agen.Agen_AktifYN = 'Y' GROUP BY Agen_id, Agen_Nama ORDER BY Agen_Nama ASC"
    set agen = pembayaran_cmd.execute

    ' paggination
    Set Connection = Server.CreateObject("ADODB.Connection")
    Connection.Open MM_Cargo_string

    dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal, sql
    dim orderBy
    dim angka

    angka = request.QueryString("angka")
    if len(angka) = 0 then 
        angka = 1
    else 
        angka = angka + 1
    end if

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = root

    sql= sqlawal

    rs.open sql, Connection

    ' records per halaman
    recordsonpage = 15

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

    set rs = server.CreateObject("adodb.recordset")

    sqlawal = root

    sql=sqlawal

    rs.open sql, Connection

    ' reads first records (offset) without showing them (can't find another solution!)
    hiddenrecords = requestrecords
    do until hiddenrecords = 0 OR rs.EOF
        hiddenrecords = hiddenrecords - 1
        rs.movenext
        if rs.EOF then
        lastrecord = 1
        end if	
    loop
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PEMBAYARAN BANK</title>
    <!-- #include file='../../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <script>
        function format(number){
            var rupiah = '';
            var angkarev = number.toString().split('').reverse().join('');
            for (var i = 0; i < angkarev.length; i++) if (i % 3 === 0) rupiah += angkarev.substr(i, 3) + '.';
            return rupiah.split('', rupiah.length - 1).reverse().join('') + ',-';
            // console.log(angkarev);
        }
        function rupiah(nilai){
            if (nilai == ""){
            $('#cicilan').val(format(0));
            }else{
            $('#cicilan').val(format(nilai));
            }
        }
        function tambahPembayaran(){
            var dnow = new Date();
            var localdate= (dnow.getMonth()+1) + '/' + dnow.getDate() + '/' + dnow.getFullYear() 
            $('#tgl').val(localdate);
            $('#tgl').attr('readonly', true);

            $('#nomor').val('');
            $('#nip').val('');
            $('#nama').val('');
            $('#keterangan').val('').attr("readonly", true);
            $('#cicilan').val('');

            $('.modal-body form').attr('action', 'pembayaran_add.asp');
        }
        function updatePembayaran(id,tgl,nip,nama,ket,pp){
            $('#tgl').attr("type","text");
            $('#tgl').attr("readonly",true);

            $('#nomor').val(id);
            $('#tgl').val(tgl);
            $('#nip').val(nip);
            $('#nama').val(nama);
            $('#keterangan').val(ket).attr("readonly",true);
            $('#cicilan').val(format(pp));

            $('.modal-body form').attr('action', 'pembayaranUpdate_add.asp');

        }
        function aktifPembayaran(e,i,nip){
            if (confirm("ANDA YAKIN UNTUK MERUBAH???") == true){
            window.location.href="aktifPembayaran.asp?p="+e+"&i="+i+"&nip="+ nip
            }
        }
        function getTgl(){
            $('#tgl').attr("readonly",false);
            $('#tgl').attr("type","date");
        }
    </script>
    <style>
        #form-tgla{
            background:none;
        }
        #form-tgle{
            background:none;
        }
        #form-nip{
            background:none;
        }
        #form-nama{
            background:none;
        }
        #area{
            background:none;
        }
        hr{
            padding:0;
            margin-top:-1px;
            margin-bottom:-3px;
        }
        .checkTgl{
            width:15px;
            margin-top:7px;
        }
        .tablePembayaran{
            font-size:12px;
            overflow-x:scroll;
            display:block;
        }
        .tablePembayaran thead{
            background-color:gray;
            color:#fff;
            border-color:#fff;
            white-space: nowrap;
        }
        .btn-group button{
            font-size:12px;
        }
        #notifPinjaman{
            width:70%;
            height:15vh;
            margin:auto;
            margin-top:50px;
            text-align: center;
            position:relative;
        }
        #notifPinjaman h2{
            position:absolute;
            top:60%;
            left:50%;
            transform:translate(-50%, -50%);
        }
        @media (min-width: 576px) {
            .tablePembayaran{
            font-size:14px;
            }
            .btn-group button{
            font-size:14px;
            }
        }
    </style>
</head>

<body>
<div class='container'>
    <div class='row'>
        <div class='col text-center mt-3'>
            <h3>PEMBAYARAN PINJAMAN BANK</h3>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
            <button type="button" class="btn btn-secondary btn-sm" onclick="window.location.href='index.asp'"><i class="fa fa-backward" aria-hidden="true"></i> Kembali</button>
            <%if session("HT3BA") = true then%>
            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPembayaran" onclick="return tambahPembayaran()"><i class="fa fa-plus" aria-hidden="true"></i> Tambah</button>
            <%end if%>
            <%if not rs.eof then%>
                <%if session("HT3BD") = true then%>
                <% if tgla <> "" OR tgle <> "" OR nama <> "" OR area <> "" then %>
                    <button type="button" class="btn btn-success btn-sm" onclick="window.open('Export-Allpembayaran.asp?tgla=<%=tgla%>&tgle=<%=tgle%>&nip=<%=nip%>&nama=<%=nama%>&area=<%=area%>&ckTgl=<%=ckTgl%>&ckNama=<%=ckNama%>&ckArea=<%=ckArea%>')"><i class="fa fa-print" aria-hidden="true"></i> Cetak</button>
                <% end if %>
                <% end if %>
            <% end if %>
            </div>
        </div>
    </div>

    <div class="header p-2 mt-2">
        <div class='row'>
        <form action="pembayaran.asp" method="post" id="form-cari">
            <div class='col'>
            <div class="mb-3 row ">
                <div class='col-sm-1 checkTgl'>
                <input class="form-check-input" type="checkbox" name="ckTgl" id="ckTgl">
                </div>
                <label for="ckTgl" class="col-sm-2 col-form-label">Priode Tanggal</label>
                <div class="col-sm-2">
                <input type="date" class="form-control border-0" id="form-tgla" name="tgla">
                <hr>
                </div>
                <div class="col-sm-2">
                <input type="date" class="form-control border-0" id="form-tgle" name="tgle">
                <hr>
                </div>
            </div>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
            <div class="mb-3 row">
                <div class='col-sm-1 checkTgl'>
                <input class="form-check-input" type="checkbox" name="ckNama" id="ckNama">
                </div>
                <label for="ckNama" class="col-sm-2 col-form-label">Nama Karyawan</label>
                <div class="col-sm-7">
                <input type="text" class="form-control border-0" id="form-nama" name="nama" placeholder="Nama" autocomplete="off">
                <hr>
                </div>
            </div>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
            <div class="mb-3 row">
                <div class='col-sm-1 checkTgl'>
                <input class="form-check-input" type="checkbox" name="ckArea" id="ckArea">
                </div>
                <label for="ckArea" class="col-sm-2 col-form-label">Area Aktif</label>
                <div class="col-sm-7 mb-3">
                <select class="form-select border-0" aria-label="Default select example" id="area" name="area">
                    <option value="">Pilih</option>
                    <% do until agen.eof %>
                    <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                    <% 
                    agen.movenext
                    loop
                    %>
                </select>
                <hr>
                </div>
                <div class='col align-self-end'>
                <button type="submit" class="btn btn-primary btn-sm" id="cariPembayaran"><i class="fa fa-search" aria-hidden="true"></i> cari</button>
                </div>
        </form>
            </div>
            </div>
        </div>
    </div>
    <div class='row'>
        <div class='col text-center'>
            <% if rs.eof then%>
            <div data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h3>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h3></div>
            <% else %>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table tablePembayaran">
                <thead>
                    <tr>
                    <th scope="col" class="text-center">No</th>
                    <th scope="col">Tanggal</th>
                    <th scope="col">Nip</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Ketarangan</th>
                    <th scope="col">Aktif</th>
                    <%if session("HT3BB") = true OR session("HT3BC") = true OR session("HT3BD") = true then %>
                        <th scope="col" class="text-center">Aksi</th>
                    <%end if%>
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
                    <th><%= rs("TPK_ID_Bank") %></th>
                    <td><%= rs("TPK_Tanggal") %></td>
                    <td><%= rs("TPK_Nip") %></td>
                    <td><%= rs("Kry_Nama") %></td>
                    <td><%= rs("TPK_Ket") %></td>
                    <td>
                        <% if rs("TPK_AktifYN") = "Y" then %>
                            Aktif
                        <% else %>
                            No
                        <% end if %>
                    </td>
                    <td>
                        <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                            <%if session("HT3BB") = true then%>
                                <button type="button" class="btn btn-primary btn-sm py-0 px-2" onclick="return updatePembayaran('<%=rs("TPK_ID_Bank")%>','<%= rs("TPK_tanggal") %>','<%= rs("TPK_Nip") %>','<%= rs("Kry_Nama") %>','<%= rs("TPK_Ket") %>','<%= rs("TPK_PP") %>')" data-bs-toggle="modal" data-bs-target="#modalPembayaran">Edit</button>
                            <%end if%>
                            <%if session("HT3BC") = true then%>
                                <% if rs("TPK_AktifYN") = "Y" then %>
                                    <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return aktifPembayaran('<%=rs("TPK_ID_Bank")%>','<%= rs("TPK_AktifYN") %>','<%= rs("TPK_Nip") %>')">NonAktif</button>
                                <% else %>
                                    <button type="button" class="btn btn-warning btn-sm py-0 px-2" onclick="return aktifPembayaran('<%=rs("TPK_ID_Bank")%>','<%= rs("TPK_AktifYN") %>','<%= rs("TPK_Nip") %>')">Aktif</button>
                                <% end if %>
                            <% end if %>
                            <%if session("HT3BD") = true then%>
                                <button type="button" class="btn btn-secondary btn-sm py-0 px-2" onclick="window.open('EXPORT-Pembayaran.asp?p=<%= rs("TPK_ID_Bank") %>')">Cetak</button>
                            <%end if%>
                        </div>
                    </td>
                </tr>
                <% 
                    response.flush
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
            <!-- paggination -->
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item">
                <% 
                    page = Request.QueryString("Page")
                    if page = "" then
                        npage = 1
                    else
                        npage = page - 1
                    end if
                %>
                            <% if requestrecords <> 0 then %>
                                <a class="page-link" href="pembayaran.asp?offset=<%= requestrecords - recordsonpage%>&Page=<%=npage%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNama=<%= ckNama %>&ckArea=<%= ckArea %>">&#x25C4; Previous </a>
                            <% else %>
                                <p class="page-link-p">&#x25C4; Previous </p>
                            <% end if %>
                        </li>
                        <li class="page-item d-flex" style="overflow-y:auto;">	
                        <%                
                    pagelist = 0
                    pagelistcounter = 0
                    do until pagelist > allrecords  
                    pagelistcounter = pagelistcounter + 1

                    if page = "" then
                        page = 1
                    else
                        page = page
                    end if
                    
                    if Cint(page) = pagelistcounter then
                        %>	
                            <a class="page-link hal d-flex bg-primary text-light" href="pembayaran.asp?offset=<%= pagelist %>&Page=<%=pagelistcounter%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNama=<%= ckNama %>&ckArea=<%= ckArea %>"><%= pagelistcounter %></a>   
                        <% else %>
                            <a class="page-link hal d-flex" href="pembayaran.asp?offset=<%= pagelist %>&Page=<%=pagelistcounter%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNama=<%= ckNama %>&ckArea=<%= ckArea %>"><%= pagelistcounter %></a>   
                <% end if %>
                <%
                        pagelist = pagelist + recordsonpage
                        loop
                        %>
                        </li>
                        <li class="page-item">
                <% 
                    if page = "" then
                        page = 1
                    else
                        page = page + 1
                    end if
                %>
                            <% if(recordcounter > 1) and (lastrecord <> 1) then %>
                                <a class="page-link next" href="pembayaran.asp?offset=<%= requestrecords + recordsonpage %>&Page=<%=page%>&tgla=<%= tgla %>&tgle=<%= tgle %>&nama=<%= nama %>&nip=<%= nip %>&area=<%= area %>&ckTgl=<%= ckTgl %>&ckNama=<%= ckNama %>&ckArea=<%= ckArea %>">Next &#x25BA;</a>
                            <% else %>
                                <p class="page-link next-p">Next &#x25BA;</p>
                            <% end if %>
					</li>	
				</ul>
			</nav>
            <!--end pagging -->
        </div>
    </div>
</div>
<% end if %>
<!-- Modal -->
    <div class="modal fade modalPinjaman" id="modalPembayaran" data-bs-backdrop="static" data-bs-keyboard="false" tabpembayaran="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">From Pembayaran</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
        <form action='pembayaran_add.asp' method='post'>
            <div class="row mb-3">
            <label for="nomor" class="col-sm-4 col-form-label col-form-label-sm">Nomor</label>
            <div class="col-sm-5">
                <input type="text" class="form-control form-control-sm" id="nomor" name='nomor' placeholder="Nomor" readonly>
            </div>
            </div>
            <div class="row mb-3">
            <label for="tgl" class="col-sm-4 col-form-label col-form-label-sm">Tanggal</label>
            <div class="col-sm-5">
                <input type="text" class="form-control form-control-sm" id="tgl" name='tgl' required>
            </div>
            <div class="col-sm-2">
                <button type="button" class="ui-datepicker-trigger" onclick="return getTgl()" id="calender"><i class="fa fa-calendar-check-o" aria-hidden="true"></i></button>
            </div>
            <div class="col-sm-2">
                <button type="button" class="ui-datepicker-trigger" style="display:none;background-color:none;" onclick="return getTgl()" id="calender"><i class="fa fa-calendar-check-o" aria-hidden="true"></i></button>
            </div>
            </div>
            <div class="row mb-3">
            <label for="nama" class="col-sm-4 col-form-label col-form-label-sm">Nama Karyawan</label>
            <div class="col-sm-3">
                <input type="number" class="form-control form-control-sm  m-0" id="nip" name='nip' placeholder="Nip" readonly>
            </div>
            <div class="col-sm-5">
                <input type="text" class="form-control form-control-sm m-0" id="nama" name='nama' placeholder="Masukan Nama" autocomplete="off" required>
            </div>
            </div>
            <div class='row'>
            <div class="col-sm-12 tableKaryawanBayar">
            </div>
            </div>
            <div class="row mb-3">
            <label for="keterangan" class="col-sm-4 col-form-label col-form-label-sm">Keterangan</label>
            <div class="col-sm-8">
                <textarea class="form-control" placeholder="Leave a comment here" id="keterangan" name='keterangan' placeholder="Keterangan" required></textarea>
            </div>
            </div>
            <div class='row justify-content-end'>
            <div class="col-sm-8 p-0 tableKeterangan">
            </div>
            </div>
            <div class="row mb-3">
            <label for="cicilan" class="col-sm-4 col-form-label col-form-label-sm">Cicilan</label>
            <div class="col-sm-4">
                <input type="text" class="form-control form-control-sm" id="cicilan" name='cicilan' value="0" autocomplete="off" onchange="rupiah($(this).val())">
                <input type="hidden" class="form-control form-control-sm" id="id" name='id' value ="<%= session("username") %>" >
            </div>
            </div>
        </div>
        
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary">Save</button>
        </div>

        </form>
        </div>
    </div>
    </div>
<script>
  // seach nama karyawan
    $('#nama').on('keyup', function (result) {
        $.get(`cariKaryawan.asp?key=${$('#nama').val().toUpperCase().replace(' ', '%20')}`, function (data) {
            $(".tableKaryawanBayar").show();
            $(".tableKaryawanBayar").html(data);
        });
    });
    function clickRadio(value1,value2, value3){
        $('#nip').val(value1);
        $('#nama').val(value2);
        $('#keterangan').val(value3);
        $(".tableKaryawanBayar").hide();
    }
</script>
<!-- #include file='../../layout/footer.asp' -->