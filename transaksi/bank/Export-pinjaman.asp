<!-- #include file='../../connection.asp' -->
<% 
    if session("HT3AD") = false then
        Response.Redirect("pinjaman.asp")
    end if
    
    dim p 
    dim pinjaman, cicilan

    p = Request.QueryString("p")

    ' Response.ContentType = "application/vnd.ms-excel"
    ' Response.AddHeader "content-disposition", "filename=LAPORAN PINJAMAN " & p & ".xls"

    set pinjaman = Server.CreateObject("ADODB.Command")
    pinjaman.activeConnection = mm_cargo_String

    pinjaman.commandText = "SELECT HRD_T_PK_Bank.*, HRD_M_Karyawan.Kry_Nama, HRD_M_Jabatan.Jab_Nama, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_PK_Bank ON HRD_M_Karyawan.Kry_Nip = HRD_T_PK_Bank.TPK_Nip LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN GLB_M_agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_T_PK_Bank.TPK_ID_BANK = '"& p &"'"
    set pinjaman = pinjaman.execute

    cicilan = pinjaman("TPK_PP") / pinjaman("TPK_Lama")
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN PINJAMAN BANK</title>
    <!-- #include file='../../layout/header.asp' -->
    <link rel="stylesheet" href="<%= url %>/layout/buttonsdatatable/datatablebutton.css">
    <link rel="stylesheet" href="<%= url %>/layout/datatable/button.css">

</head>

<body>
<div class='container'>
    <table id="example" class="display nowrap" style="width:100%" onload="return table()">
        <thead>
            <tr>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>No.Peminjaman</td>
            <td>:</td>
            <td style="mso-number-format:\@;"><%= pinjaman("TPK_ID_Bank") %></td>
        </tr>
        <tr>
            <td>Tgl.Peminjaman</td>
            <td>:</td>
            <td><%= pinjaman("TPK_TAnggal") %></td>
        </tr>
        <tr>
            <td>NIP</td>
            <td>:</td>
            <td style="mso-number-format:\@;"><%= pinjaman("TPK_Nip") %></td>
        </tr>
        <tr>
            <td>Nama</td>
            <td>:</td>
            <td><%= pinjaman("Kry_Nama") %></td>
        </tr>
        <tr>
            <td>Cabang</td>
            <td>:</td>
            <td><%= pinjaman("Agen_Nama") %></td>
        </tr>
        <tr>
            <td>Jabatan</td>
            <td>:</td>
            <td><%= pinjaman("Jab_Nama") %></td>
        </tr>
        <tr>
            <td>Ketarangan</td>
            <td>:</td>
            <td><%= pinjaman("TPK_Ket") %></td>
        </tr>
        <tr>
            <td>Besar Pinjaman</td>
            <td>:</td>
            <td><%= replace(formatCurrency(pinjaman("TPK_PP")),"$","Rp.") %></td>
        </tr>
        <tr>
            <td>Bunga</td>
            <td>:</td>
            <td><%= replace(formatCurrency(pinjaman("TPK_Bunga")),"$","Rp.") %></td>
        </tr>
        <tr>
            <td>Total Pinjaman</td>
            <td>:</td>
            <td><%= replace(formatCurrency(pinjaman("TPK_PP")),"$","Rp.") %></td>
        </tr>
        <tr>
            <td>Lama Cicilan</td>
            <td>:</td>
            <td><%= pinjaman("TPK_Lama") %> Bulan</td>
        </tr>
        <tr>
            <td>Besar Cicilan</td>
            <td>:</td>
            <td><%= replace(formatCurrency(Round(cicilan)),"$","Rp.") %></td>
        </tr>
        </tbody>
        
    </table>
</div>

</body>
<script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
<script src="<%= url %>/layout/datatable/datatables.min.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/buttondatatable.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/zipdatatable.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/fdmake.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/vfp_font.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/buttonhtml5.js"></script> 
<script src="<%= url %>/layout/buttonsdatatable/print.js"></script> 
<script>
$(document).ready(function() {
    $('#example').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            // 'excel', 'pdf', 'print'
            {
                extend: 'excel',
                messageTop: 'PT.Dakota Buana Semesta',
                messageBottom: 'Mengetahui,                        Menyetujui,                             Peminjam'
            },
            {
                extend: 'pdfHtml5',
                messageTop: 'PT.Dakota Buana Semesta',
                messageBottom: 'Mengetahui,                                                  Menyetujui,                                                    Peminjam'
            },
            {
                extend: 'print',
                messageTop: 'PT.Dakota Buana Semesta',
                messageBottom: '<div class="d-flex justify-content-between mt-2 mb-5"><span>Mengetahui</span><span>Menyetujui</span><span>Peminjam.</span></div><div class="d-flex justify-content-between mt-2"><span>(...................)</span><span>(...................)</span><span>(...................).</span></div>' 
            }
        ]
    } );
} );
</script>
</html>