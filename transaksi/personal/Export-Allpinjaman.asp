<!-- #include file='../../connection.asp' -->
<%  
    if session("HT4AD") = false Then    
        Response.Redirect("pinjaman.asp")
    end if

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", "filename=LAPORANPINJAMANPRIBADI.xls"

    ckTgl = Request.QueryString("ckTgl")
    ckNama = Request.QueryString("ckNama")
    ckArea = Request.QueryString("ckArea")

    tgla = Request.QueryString("tgla")
    tgle = Request.QueryString("tgle")
    area = trim(Request.QueryString("area"))
    nama = trim(Request.QueryString("nama"))

    function Ceil(Number)
 
        Ceil = Int(Number)

        if Ceil <> Number then

            Ceil = Ceil + 1

        end if

    end function


    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = mm_cargo_string

    set pinjaman_cmd = Server.CreateObject("ADODB.Command")
    pinjaman_cmd.activeConnection = mm_cargo_String

    query = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_Karyawan.Kry_Nip, HRD_M_Jabatan.Jab_Nama,HRD_T_PK_PRIBADI.TPK_ID_Pribadi, HRD_T_PK_PRIBADI.TPK_Tanggal, HRD_T_PK_PRIBADI.TPK_Nip, HRD_T_PK_PRIBADI.TPK_Ket, HRD_T_PK_PRIBADI.TPK_PP, HRD_T_PK_PRIBADI.TPK_Bunga, HRD_T_PK_PRIBADI.TPK_Lama, HRD_T_PK_PRIBADI.TPK_AktifYN, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_PK_PRIBADI ON HRD_M_karyawan.Kry_Nip = HRD_T_PK_PRIBADI.TPK_Nip LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND TPK_ID_Pribadi IS NOT NULL"

    if tgla <> "" and tgle <> "" then
        filterTgl = " AND HRD_T_PK_PRIBADI.TPK_tanggal BETWEEN '"& Cdate(tgla) &"' AND '"& Cdate(tgle) &"'"
    else
        filterTgl = ""
    end if

    if nama <> "" then
        filterNama = " AND HRD_M_karyawan.Kry_Nama LIKE '%"& nama &"%'"
    else  
        filterNama = ""
    end if

    if area <> "" then
        filterArea = " AND HRD_M_Karyawan.Kry_AgenID = '"& area &"'"
    else
        filterArea = ""
    end if
    orderBy = " ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

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

    pinjaman_cmd.commandText = root
    ' Response.Write pinjaman_cmd.commandText & "<br>"
    set pinjaman = pinjaman_cmd.execute

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EXPORT PINJAMAN PRIBADI</title>
    <!-- #include file='../../layout/header.asp' -->
    <style>
        tr {
            width: 1%;
            white-space: nowrap;
        }
    </style>
</head>

<body>
    <table style="font-size:14px;">
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
            <td colspan="11" style="text-align: center;">
                LAPORAN PINJAMAN PRIBADI
            </td>
        </tr>
        <tr >
            <td colspan="11" style="text-align: center;"> 
                <% if tgla <> "" AND tgle <> "" then %>
                    <p class="text-center">PERIODE <b><%= Cdate(tgla) & " - " & Cdate(tgle) %></b></p>
                <% end if %>
            </td>
        </tr>
        <tr>
            <td style="font-size:10px;" colspan="11">Tanggal Cetak <%= (Now) %></td>
        </tr>
                    <tr>
                        <th scope="col">Cabang</th>
                        <th scope="col">Nip</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Jabatan</th>
                        <th scope="col">Tgl Pinjam</th>
                        <th scope="col">No Pinjaman</th>
                        <th scope="col">Keterangan</th>
                        <th scope="col">Pokok Pinjaman</th>
                        <th scope="col">Bunga</th>
                        <th scope="col">Lama</th>
                        <th scope="col">Cicilan</th>
                    </tr>
                <tbody>
                <% 
                do while not pinjaman.eof
                cicilan = Ceil(pinjaman("TPK_PP") / pinjaman("TPK_Lama"))
                %>
                    <tr>
                        <td style="mso-number-format:\@;"><%= pinjaman("agen_nama") %></td>
                        <td style="mso-number-format:\@;"><%= pinjaman("Kry_Nip") %></td>
                        <td><%= pinjaman("Kry_Nama") %></td>
                        <td><%= pinjaman("Jab_nama") %></td>
                        <td><%= pinjaman("TPK_Tanggal") %></td>
                        <td style="mso-number-format:\@;"><%= pinjaman("TPK_ID_Pribadi") %></td>
                        <td><%= pinjaman("TPK_Ket") %></td>
                        <td><%= Replace(FormatCurrency(pinjaman("TPK_PP")),"$","") %></td>
                        <td><%= Replace(FormatCurrency(pinjaman("TPK_Bunga")),"$","") %></td>
                        <td><%= pinjaman("TPK_Lama")%></td>
                        <td><%= replace(formatCurrency(cicilan),"$","") %></td>
                    </tr>
                <% 
                    pinjaman.movenext
                    loop
                %>
                </tbody>
            </table>



<!-- #include file='../../layout/footer.asp' -->