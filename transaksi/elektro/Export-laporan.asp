<!-- #include file='../../connection.asp' -->
<%
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=LAPORANCICILAN.xls"
    tgla = trim(Request.querystring("tgla"))
    tgle = trim(Request.querystring("tgle"))
    nama = trim(Request.querystring("nama"))


    set lunas_cmd = Server.CreateObject("ADODB.COmmand")
    lunas_cmd.activeConnection = mm_cargo_string

    set karyawan_cmd = Server.CreateObject("ADODB.COmmand")
    karyawan_cmd.activeConnection = mm_cargo_string

    if tgla <> "" and tgle <> "" then  
        if nama <> "" then
            filterNama = " AND HRD_M_Karyawan.Kry_Nama LIKE '%"& nama &"%'"
        else
            filterNama = ""
        end if
        karyawan_cmd.commandText = "SELECT src.TPK_Tanggal, GLB_M_Agen.Agen_Nama, HRD_M_Karyawan.Kry_NIP, HRD_M_Karyawan.Kry_Nama, HRD_M_Jabatan.Jab_Nama, HRD_T_PK.TPK_ID, ISNULL(HRD_T_PK.TPK_PP, 0) AS pinjam, src.TPK_Ket, HRD_T_PK.TPK_Lama, ISNULL(src.TPK_PP, 0) AS cicil, (SELECT ISNULL(COUNT(TPK_PP), 0) AS jcicil FROM HRD_T_BK WHERE (LEFT(TPK_Ket, 18) = HRD_T_PK.TPK_ID) AND (TPK_Tanggal <= src.TPK_Tanggal)) AS jcicil,(SELECT ISNULL(SUM(TPK_PP), 0) AS tcicilan FROM HRD_T_BK WHERE (LEFT(TPK_Ket, 18) = HRD_T_PK.TPK_ID) AND (TPK_Tanggal <= src.TPK_Tanggal)) AS tcicilan, ISNULL(HRD_T_PK.TPK_PP, 0) - (SELECT ISNULL(SUM(TPK_PP), 0) AS tcicilan FROM HRD_T_BK WHERE (LEFT(TPK_Ket, 18) = HRD_T_PK.TPK_ID) AND (TPK_Tanggal <= src.TPK_Tanggal)) AS sisaklaim FROM HRD_M_Karyawan INNER JOIN HRD_T_PK ON HRD_M_Karyawan.Kry_NIP = HRD_T_PK.TPK_NIP LEFT OUTER JOIN HRD_T_BK AS src ON HRD_T_PK.TPK_ID = LEFT(src.TPK_Ket, 18) AND HRD_T_PK.TPK_NIP = src.TPK_NIP LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code WHERE (src.TPK_Tanggal BETWEEN '"&tgla&"' AND '"&tgle&"') "& filterNama &" AND (HRD_M_Karyawan.Kry_AktifYN = 'Y') AND (HRD_T_PK.TPK_Ket LIKE '%Elektronik Ke%') AND (HRD_T_PK.TPK_AktifYN = 'Y') AND (src.TPK_AktifYN = 'Y') GROUP BY src.TPK_Tanggal, GLB_M_Agen.Agen_Nama, HRD_M_Karyawan.Kry_NIP, HRD_M_Karyawan.Kry_Nama, HRD_M_Jabatan.Jab_Nama, ISNULL(HRD_T_PK.TPK_PP, 0), ISNULL(src.TPK_PP, 0), src.TPK_Ket, HRD_T_PK.TPK_Lama, HRD_T_PK.TPK_ID ORDER BY HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_ID"
        ' Response.Write karyawan_cmd.commandText & "<br>"
        set karyawan = karyawan_cmd.execute

    end if
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LAPORAN</title>
    <!-- #include file='../../layout/header.asp' -->
</head>
<body>
    <table class="table" style="text-algin:left;">
        <tr>
            <td colspan="12" style="text-align:center;"> 
                LAPORAN PENGAMBILAN DAN PEMBAYARAN CICILAN
            </td>
        </tr>
        <tr>
            <td colspan="12" style="text-align:center;"> 
                Priode : <%= Cdate(tgla) %> - <%= Cdate(tgle) %>
            </td>
        </tr>
    <%if tgla <> "" then
        if not karyawan.eof then
        %>
        <tr>
            <th scope="col">No</th>
            <th scope="col">Cabang</th>
            <th scope="col">Nip</th>
            <th scope="col">Nama</th>
            <th scope="col">Jabatan</th>
            <th scope="col">Pinjaman</th>
            <th scope="col">Bayar</th>
            <th scope="col">SisaKlaim</th>
            <th scope="col">Keterangan</th>
            <th scope="col">Cicilan</th>
            <th scope="col">Sisa Cicilan</th>
            <th scope="col">Lama</th>
        </tr>
        <%
        no = 0
        cicilanperbulan = 0
        do while not karyawan.eof
        no = no + 1

        'hitung cicilan perbulan
        cicilanperbulan = Round(karyawan("pinjam") / karyawan("TPK_Lama"))

        ' hitung sisa cicilan
        scicilan = Cint(karyawan("TPK_Lama")) - Cint(karyawan("jcicil"))
        %>
        <tr>
            <th scope="row"><%= no %></th>
            <td><%= karyawan("Agen_Nama") %></td>
            <td style="mso-number-format:\@;"><%= karyawan("Kry_Nip") %></td>
            <td><%= karyawan("Kry_Nama") %></td>
            <td><%= karyawan("Jab_Nama") %></td>
            <td><%= replace(formatCurrency(karyawan("pinjam")),"$","") %></td>
            <td><%= replace(formatCurrency(karyawan("cicil")),"$","") %></td>
            <td><%= replace(formatCurrency(karyawan("sisaklaim")),"$","") %></td>
            <td style="mso-number-format:\@;"><%= karyawan("TPK_Ket") %></td>
            <td><%= replace(formatCurrency(cicilanperbulan),"$","") %></td>
            <td><%= scicilan %></td>
            <td><%= karyawan("TPK_Lama") %></td>
        </tr>
        <%
            karyawan.movenext
            loop
        %>
             <%else%>
        <tr>
            <td colspan="12">DATA TIDAK DITEMUKAN !</td>
        </tr>
        <%
            end if
        end if
        %>
    </table>
   
<!-- #include file='../../layout/footer.asp' -->
