<!-- #include file='../../connection.asp' -->
<%
    response.Buffer=true
    server.ScriptTimeout=1000000000

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = mm_cargo_String

    set payment_cmd = Server.CreateObject("ADODB.Command")
    payment_cmd.activeConnection = mm_cargo_String

    payment_cmd.commandText = "SELECT HRD_T_BK.TPK_PP, HRD_T_BK.TPK_Nip FROM HRD_T_BK LEFT OUTER JOIN HRD_T_PK ON HRD_T_BK.TPK_NIP = HRD_T_PK.TPK_Nip WHERE HRD_T_PK.TPK_PotongGajiYN = 'Y' AND HRD_T_PK.TPK_AktifYN = 'Y' AND HRD_T_BK.TPK_AktifYN = 'Y' AND Month(HRD_T_BK.TPK_Tanggal) = MONTH(GETDATE()) AND YEAR(HRD_T_BK.TPK_Tanggal) = YEAR(GETDATE()) GROUP BY HRD_T_BK.TPK_PP, HRD_T_BK.TPK_Nip "
    ' Response.Write payment_cmd.commandText & "<br>"
    set payment = payment_cmd.execute

    do while not payment.eof
        karyawan_cmd.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE Sal_Nip = '"& payment("TPK_Nip") &"'"
        set salary = karyawan_cmd.execute

        if not salary.eof then
            karyawan_cmd.commandText = "UPDATE HRD_T_Salary_Convert SET Sal_Klaim = '"& payment("TPK_PP") &"' WHERE Sal_Nip = '"& salary("Sal_Nip") &"' AND month(Sal_StartDate) = MONTH(GETDATE()) AND YEAR(Sal_StartDate) = YEAR(GETDATE()) "
            karyawan_cmd.execute
        end if
        
    payment.movenext
    loop

    Response.Redirect("proses.asp")
%>