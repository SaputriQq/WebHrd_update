<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
    if session("HT1BB") = false then
        response.Redirect("pembayaran.asp")
    end if
    dim nomor, tgl, nip, nama, keterangan, pp
    dim update_cmd, update

    nomor = trim(Request.Form("nomor"))
    tgl = trim(Request.Form("tgl"))
    nip = trim(Request.Form("nip"))
    keterangan = replace(trim(Request.Form("keterangan")), vbcrlf, "")
    pp = trim(replace(replace(replace(Request.Form("cicilan"),"-",""),".",""),",",""))
    id = trim(Request.Form("id"))

    set update_cmd = Server.CreateObject("ADODB.Command")
    update_cmd.activeConnection = mm_cargo_string

    update_cmd.commandText = "SELECT * FROM HRD_T_BK WHERE TPK_Nip = '"& nip &"' AND TPK_ID = '"& nomor &"' AND TPK_AktifYN = 'Y'"
    set data = update_cmd.execute

    if not data.eof then
        update_cmd.commandText = "UPDATE HRD_T_BK SET TPK_Tanggal = '"& tgl &"', TPK_Ket = '"& keterangan &"', TPK_PP = "& pp &", TPK_UpdateID = '"& id &"', TPK_UpdateTime = GETDATE() WHERE TPK_ID = '"& nomor &"' and TPK_Nip = '"& nip &"'"

        update_cmd.execute

        'updateLog system
        ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
        browser = Request.ServerVariables("http_user_agent")
        dateTime = now()
        eventt = "UPDATE"
        key = nomor
        url = ""

        keterangan = "UPDATE KLAIM PEMBAYARAN KARYAWAN UNTUK NIP ("& nip &") DENGAN NOMOR ("& nomor &") "
        call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
    else 
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
    end if
%>
<!-- #include file='../../layout/footer.asp' -->