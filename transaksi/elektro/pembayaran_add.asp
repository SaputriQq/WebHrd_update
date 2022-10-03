<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
    if session("HT2BA") = false then
        Response.Redirect("pembayaran.asp")
    end if

    dim tgl, nip, nama, keterangan, cicilan, id
    dim tambah,tambah_cmd, kode

    tgl = Trim(Request.Form("tgl"))
    nip = Trim(Request.form("nip"))
    nama = Trim(Request.form("nama"))
    keterangan = replace(Trim(Request.form("keterangan")), vbcrlf, "")
    inplama = trim(Request.Form("inplama"))
    id = Trim(Request.form("id"))
    pembayaranke = Trim(Request.form("pembayaranke"))
    cicilan = replace(replace(replace(Request.form("cicilan"),",",""),"-",""),".","")

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = mm_cargo_string

    set tambah_cmd = Server.CreateObject("ADODB.Command")
    tambah_cmd.activeConnection = mm_cargo_string

    tambah_cmd.commandText = "SELECT * FROM HRD_T_BK_Elektronik WHERE TPK_Tanggal = '"& tgl &"' AND TPK_Nip = '"& nip &"' AND TPK_Ket = '"& keterangan &"'"

    set tambah = tambah_cmd.execute

    kode = mid(nip,1,3)

    if tambah.eof then
        tambah_cmd.commandText = "exec sp_AddHRD_T_BK_Elektronik '"& kode &"','"& tgl &"','"& nip &"','"& keterangan &"','"& cicilan &"','"& id &"'"
        set data = tambah_cmd.execute

        ' get id bk
        pembayaranid = data("ID")
        'updateLog system
        ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
        browser = Request.ServerVariables("http_user_agent")
        dateTime = now()
        eventt = "CREATE"
        key = pembayaranid
        url = ""

        keterangan = "TAMBAH PEMBAYARAN BARANG KARYAWAN UNTUK NIP ("& nip &") DI PROSES "& Cdate(tgl) 
        call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
    else
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
    end if
%>
<!--#include file="../../layout/footer.asp"-->