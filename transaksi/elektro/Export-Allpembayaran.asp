<!-- #include file='../../connection.asp' -->
<% 
    if session("HT2BD") = false then
        Response.Redirect("pembayaran.asp")
    end if 
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=LAPORANPEMBAYARANELEKTRONIK.xls"

    dim name, nip, area, tgla, tgle, print, root

    ckTgl = Request.QueryString("ckTgl")
    ckNama = Request.QueryString("ckNama")
    ckArea = Request.QueryString("ckArea")
    tgla = Request.QueryString("tgla")
    tgle = Request.QueryString("tgle")
    nama = Request.QueryString("nama")
    area = Request.QueryString("area")

    ' setting default query 
    query = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_T_PK_Elektronik.TPK_ID_Elektronik, HRD_T_BK_Elektronik.TPK_ID_Elektronik, HRD_T_BK_Elektronik.TPK_Tanggal, HRD_T_BK_Elektronik.TPK_Nip, HRD_T_BK_Elektronik.TPK_Ket, HRD_T_BK_Elektronik.TPK_PP, HRD_T_BK_Elektronik.TPK_AktifYN, HRD_T_BK_Elektronik.TPK_UpdateID, HRD_T_BK_Elektronik.TPK_UpdateTime FROM HRD_M_Karyawan RIGHT OUTER JOIN HRD_T_BK_Elektronik ON HRD_M_karyawan.Kry_Nip = HRD_T_BK_Elektronik.TPK_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_T_PK_Elektronik ON SUBSTRING(HRD_T_BK_Elektronik.TPK_Ket,1,18) = HRD_T_PK_Elektronik.TPK_ID_Elektronik WHERE HRD_M_Karyawan.kry_AktifYN = 'Y' AND HRD_T_PK_Elektronik.TPK_Ket LIKE '%ELEKTRONIK%' "

    if tgla <> "" And tgle <> "" then
        filterTgl =  " AND HRD_T_BK_Elektronik.TPK_tanggal BETWEEN '"& Cdate(tgla) &"' AND '"& Cdate(tgle) &"'"
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
    orderBy = " GROUP BY HRD_M_Karyawan.Kry_Nama, HRD_T_BK_Elektronik.TPK_ID_Elektronik, HRD_T_PK_Elektronik.TPK_ID_Elektronik, HRD_T_BK_Elektronik.TPK_Tanggal, HRD_T_BK_Elektronik.TPK_Nip, HRD_T_BK_Elektronik.TPK_Ket, HRD_T_BK_Elektronik.TPK_PP, HRD_T_BK_Elektronik.TPK_AktifYN, HRD_T_BK_Elektronik.TPK_UpdateID, HRD_T_BK_Elektronik.TPK_UpdateTime ORDER BY HRD_T_BK_Elektronik.TPK_Tanggal DESC" 

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
        root = query + filterAre + orderBy
    else
        root = query 
    end if

    ' execute table data
    set print_cmd = Server.CreateObject("ADODB.Command")
    print_cmd.activeConnection = mm_cargo_string

    print_cmd.commandText = root
    '   Response.Write print_cmd.commandText & "<br>"
    set print = print_cmd.execute
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DAFTAR PEMBAYARAN KARYAWAN</title>
</head>

<body>
    <table style="white-space: nowrap;font-size:14px;">
         <tr>
            <td colspan="3">
                PT.Dakota Buana Semesta
            </td>
        </tr>
        <tr>
            <td colspan="3">
                JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI
            </td>
        </tr>
        <tr>
            <td colspan="3">
                BEKASI
            </td>
        </tr>
            
        <tr >
            <td colspan="6" style="text-align: center;">
                LAPORAN PEMBAYARAN BARANG ELEKTRONIK
            </td>
        </tr>
        <tr >
            <td colspan="6" style="text-align: center;"> 
                <% if tgla <> "" AND tgle <> "" then %>
                    <p class="text-center">PERIODE <b><%= Cdate(tgla) & " - " & Cdate(tgle) %></b></p>
                <% end if %>
            </td>
        </tr>
        <tr>
            <td style="font-size:10px;" colspan="6">Tanggal Cetak <%= (Now) %></td>
        </tr>
        <tr>
            <th>No.Pembayaran</th>
            <th>Tgl.Pembayaran</th>
            <th>NIP</th>
            <th>Nama</th>
            <th>Ketarangan</th>
            <th>Cicilan</th>
        </tr>
        <tbody>
        <% do until print.eof %>
            <tr>
                <th style="mso-number-format:\@;"><%= print("TPK_ID_Elektronik") %></th>
                <td><%= print("TPK_Tanggal") %></td>
                <td style="mso-number-format:\@;"><%= print("TPK_Nip") %></td>
                <td><%= print("Kry_Nama") %></td>
                <td  style="mso-number-format:\@;"><%= print("TPK_Ket") %></td>
                <td><%= replace(formatCurrency(print("TPK_PP")),"$","Rp.") %></td>
            </tr>
            <% 
            print.movenext
            loop
            %>
        </tbody>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">Mengetahui,</td>
            <td colspan="2" style="text-align: center;">Menyetujui,</td>
            <td colspan="2" style="text-align: center;">Peminjam,</td>
        </tr>
    </table>
