<!-- #include file='../../connection_personal.asp' -->
    <%  
    nip = request.form("nipatasan")
    tglpertama = request.form("tglpertama")
    tglkedua = request.form("tglkedua")
    cabang = request.form("idcabang")
    shift = request.form("shiftid")
    
    set ptanggal_cmd=server.createobject("ADODB.Command")
    ptanggal_cmd.activeConnection = MM_Cargo_string

    ptanggal_cmd.commandText = "SELECT HRD_T_SHIFT.Shf_NIP,HRD_M_Karyawan.Kry_Nama FROM HRD_T_SHIFT LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SHIFT.Shf_NIP = HRD_M_Karyawan.Kry_NIP  WHERE Shf_Tanggal BETWEEN '"& tglpertama &"' AND '"& tglkedua &"' GROUP BY HRD_T_SHIFT.Shf_NIP,HRD_M_Karyawan.Kry_Nama "
    ' response.write  ptanggal_cmd.commandText &"<br>"
    set ptanggal = ptanggal_cmd.execute 

    nomor = 0
    do while not ptanggal.eof
        nomor = nomor + 1
        response.write ptanggal("Shf_NIP")
    ptanggal.movenext
        if not ptanggal.eof THEN 
        response.write ","
        end if
    loop

    ' response.redirect("../coba.asp?cabang="&cabang&"&nip="&nip&"&shift="&shift)
    %>    