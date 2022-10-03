<!-- #include file='../connection_personal.asp' -->
<%
    divisi = Request.QueryString("divisi")
    agen = Request.QueryString("agen")

    if divisi <> "" then
        filterDivisi = "AND Kry_DDBID = '"& divisi &"'"
    else
        filterDivisi = ""
    end if

    orderBy = " ORDER BY Kry_nama ASC"

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = MM_Cargo_string

    karyawan_cmd.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AktifYN = 'Y' AND Kry_AgenID = '"& agen &"' "& filterDivisi &" "& orderBy &""
    set karyawan = karyawan_cmd.execute
%>
    <%do while not karyawan.eof%>
    
        <tr>
            <td>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value=" <%= karyawan("Kry_Nip") %>" id="nipbawahan" name="nipbawahan">
			</div>
            </td>
            <td>
                <%= karyawan("Kry_Nama") %>
            </td>
        </tr>
    
    <%
    karyawan.movenext
    loop
    %>