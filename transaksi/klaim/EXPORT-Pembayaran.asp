<!-- #include file='../../constend/constanta.asp' -->
<!-- #include file='../../connection.asp' -->
<% 
    if session("HT1BD") = false then
        Response.Redirect("pembayaran.asp")
    end if

    dim p
    dim cetak 

    p = Request.QueryString("p")

    set cetak = Server.CreateObject("ADODB.Command")
    cetak.activeConnection = mm_cargo_string

    cetak.commandText = "SELECT HRD_T_BK.*, HRD_M_Karyawan.Kry_Nama FROM HRD_T_BK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_BK.TPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE TPK_ID = '"& p &"'"
    set cetak = cetak.execute
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PEMBAYARAN KARYAWAN</title>
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
                <td>No.Pembayaran</td>
                <td>:</td>
                <td><%= cetak("TPK_ID") %></td>
            </tr>
            <tr>
                <td>Tgl.Pembayaran</td>
                <td>:</td>
                <td><%= cetak("TPK_TAnggal") %></td>
            </tr>
            <tr>
                <td>NIP</td>
                <td>:</td>
                <td><%= cetak("TPK_Nip") %></td>
            </tr>
            <tr>
                <td>Nama</td>
                <td>:</td>
                <td><%= cetak("Kry_Nama") %></td>
            </tr>
            <tr>
                <td>Ketarangan</td>
                <td>:</td>
                <td><%= cetak("TPK_Ket") %></td>
            </tr>
            <tr>
                <td>Besar Cicilan</td>
                <td>:</td>
                <td><%= replace(formatCurrency(cetak("TPK_PP")),"$","Rp.") %></td>
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
                messageBottom: '<div class="d-flex justify-content-between mt-2 mb-5"><span>Mengetahui</span><span>Menyetujui</span><span>Peminjam.</span></div><div class="d-flex justify-content-between mt-2"><span>(...................)</span><span>(...................)</span><span>(...................)</span></div>' 
            }
        ]
    } );
} );
</script>
</html>