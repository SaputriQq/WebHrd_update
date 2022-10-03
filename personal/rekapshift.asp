<!-- #include file='../connection_personal.asp' -->
<% 
    ' set add data
    set shift = server.createobject("ADODB.Command")
    shift.activeConnection = MM_Cargo_string

    shift.commandText = "SELECT   Shf_NIP, Shf_Tanggal, Shf_UpdateID, Shf_UpdateTime FROM HRD_T_Shift "
    set shift_p = shift.execute
    
    set histori_cmd = server.createobject("ADODB.Command")
        histori_cmd.activeConnection = MM_Cargo_string

        histori_cmd.commandText = "SELECT TOP 10 dbo.HRD_T_Shift.Shf_GSCode, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.Sh_ID, dbo.HRD_M_Shift.Sh_Name, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.shf_UpdateTime, dbo.HRD_T_Shift.Shf_updateID, HRD_M_Karyawan.Kry_Nama FROM dbo.HRD_T_Shift LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Shift.Shf_Nip = HRD_M_Karyawan.Kry_Nip where HRD_M_Shift.Sh_ID <> '' order by shf_nip, shf_tanggal ASC "

        set histori = histori_cmd.execute
%>
<table class="table table-striped table-hover">
    <tr>
        <td>Jam masuk</td>
        <td>Jam keluar</td>
        <td>Beda hari</td>
        <td>NIP</td>
        <td>Nama</td>
        <td>Tanggal</td>
        <td>Update ID</td>
        <td>Tanggal Update</td>
    </tr>
    <%
       do until histori.eof 
        ' definisi jam masuk dan keluar 
        jamMasuk = right("00"&histori("SH_JamIn"),2)&":"&right("00"&histori("Sh_MenitIn"),2)
        jamKeluar = right("00"&histori("Sh_JamOut"),2)&":"&right("00"&histori("Sh_MenitOut"),2)

        ' cek beda hari 
        if histori("SH_iHari") = "N" then   
            bhari = "No"
        else
            bhari = "Yes"
        end if
    %>
    <tr>
        <td><%= jamMasuk %> </td>
        <td><%= jamKeluar %> </td>
        <td><%= bhari %> </td>
        <td><%= histori("Shf_NIP") %> </td>
        <td><%= histori("Kry_Nama") %> </td>
        <td><%= histori("Shf_Tanggal") %> </td>
        <td><%= histori("Shf_updateID") %> </td>
        <td><%= histori("shf_UpdateTime") %> </td>
    </tr>
    <% 
        histori.movenext
        loop
    %>
</table>