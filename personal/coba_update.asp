<!-- #include file='../connection_personal.asp' -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
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
        ' Response.write settingshift_cmd.commandText &"<br>" 
        set result = settingshift_cmd.execute

        if result.eof THEN 
            insertshift_cmd.commandText ="UPDATE HRD_T_Shift SET Shf_GSCode='"& shiftName &"',Shf_NIP='"& nip(a) &"',Shf_Tanggal='"& myrosterdate &"',Shf_updateID='"& nipatasan &"' WHERE Shf_ID='"&result("Shf_ID")&"'"
            insertshift_cmd.execute
            ' Response.write insertshift_cmd.commandText &"<br>" 
        end if

        next

    next
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/personal/settingshift.asp?nip="& nipatasan &"' class='btn btn-primary'>kembali</a></div>"
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/personal/settingshift.asp?nip="& nipatasan &"' class='btn btn-primary'>kembali</a></div>"
 %>
 <!--#include file="../layout/footer.asp"-->
