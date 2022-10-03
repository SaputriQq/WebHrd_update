<!-- #include file='../connection_personal.asp' -->

<!-- #include file='../layout/header.asp' -->


<%
    agenid = request.form("agenid")
    shiftName =trim(request.form("shiftName"))
    divisi =trim(request.form("divisi"))
    nipbawahan =trim(request.form("nipbawahan"))
    myrosterdate =request.form("myrosterdate")
    nipatasan = request.form("nipatasan")
    nipp  = request.form("nipatasan") 

    set settingshift_cmd = Server.CreateObject("ADODB.Command")
    settingshift_cmd.activeConnection = MM_Cargo_string

    set insertshift_cmd = Server.CreateObject("ADODB.Command")
    insertshift_cmd.activeConnection = MM_Cargo_string
    

    nip = split(trim(nipbawahan),", ")
    
    tanggal = split(trim(myrosterdate),",")

    for i = 0 to Ubound(tanggal)

        for a = 0 to Ubound(nip)
        settingshift_cmd.commandText ="SELECT * FROM HRD_T_SHIFT WHERE Shf_NIP = '"&nip(a)&"' AND Shf_Tanggal = '"& tanggal(i) &"'  "
        'Response.write settingshift_cmd.commandText &"<br>" 
        set result = settingshift_cmd.execute

        if result.eof THEN 
            insertshift_cmd.commandText ="exec sp_ADDHRD_T_Shift'"& shiftName &"','"& nip(a) &"','"&tanggal(i) &"','"& nipatasan &"'"
            insertshift_cmd.execute
            'Response.write insertshift_cmd.commandText &"<br>" 
        end if

        next

    next
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/personal/settingshift.asp?nip="& nipp &"' class='btn btn-primary'>kembali</a></div>"
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/personal/settingshift.asp?nip="& nipp &"' class='btn btn-primary'>kembali</a></div>"
 %>
 <!--#include file="../layout/footer.asp"-->
