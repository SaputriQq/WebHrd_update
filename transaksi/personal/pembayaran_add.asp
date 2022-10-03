<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
    if session("HT3BA") = false then
        response.Redirect("pembayaran.asp")
    end if

dim tgl, nip, nama, keterangan, cicilan, id
dim tambah,tambah_cmd, kode

tgl = Trim(Request.Form("tgl"))
nip = Trim(Request.form("nip"))
nama = Trim(Request.form("nama"))
keterangan = Trim(Request.form("keterangan"))
id = Trim(Request.form("id"))
cicilan = replace(replace(replace(Request.form("cicilan"),",",""),"-",""),".","")

set tambah_cmd = Server.CreateObject("ADODB.Command")
tambah_cmd.activeConnection = mm_cargo_string

tambah_cmd.commandText = "SELECT * FROM HRD_T_BK_Pribadi WHERE TPK_Tanggal = '"& tgl &"' AND TPK_Nip = '"& nip &"' AND TPK_Ket = '"& keterangan &"'"
set tambah = tambah_cmd.execute

kode = mid(nip,1,3)

if tambah.eof then
    tambah_cmd.commandText = "exec sp_AddHRD_T_BK_Pribadi '"& kode &"','"& tgl &"','"& nip &"','"& keterangan &"','"& cicilan &"','"& id &"'"
    set data = tambah_cmd.execute

    ' set id pembayaran
    pembayaranid = data("ID")
    
    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "CREATE"
    key = pembayaranid
    url = ""

    keterangan = "TAMBAH PEMBAYARAN PRIBADI KARYAWAN UNTUK NIP ("& nip &") DI PROSES ("& tgl &") "
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!--#include file="../../layout/footer.asp"-->