<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
if session("HT3AA") = false then
    response.Redirect("pinjaman.asp")
end if

dim pinjaman_cmd, pinjaman
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

id = Request.Form("id")
tgl = Request.Form("tgl")
nip = Request.Form("nip")
keterangan = replace(trim(Request.Form("keterangan")), vbcrlf, "")
hutang = replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",","")
thutang = replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",","")
bunga = replace(replace(replace(Request.Form("bunga"),".",""),"-",""),",","")
lama = Request.Form("lama")
potgaji = trim(Request.Form("potgaji"))

kode = mid(nip,1,3)

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

set pinjaman_cmd = Server.CreateObject("ADODB.Command")
pinjaman_cmd.activeConnection = mm_cargo_String

pinjaman_cmd.commandText = "SELECT * FROM HRD_T_PK_Bank WHERE TPK_Nip = '"& nip &"' and TPK_Tanggal = '"& tgl &"' AND TPK_Ket = '"& keterangan &"' AND TPK_PP = '"& hutang &"' and TPK_AktifYN = 'Y'"

set pinjaman = pinjaman_cmd.execute

if pinjaman.eof then
    pinjaman_cmd.commandText = "exec sp_AddHRD_T_PK_Bank '"& kode &"','"& tgl &"','"& nip &"','"& keterangan &"',"& hutang &","& bunga &","& lama &",'"& session("username") &"'"
    ' Response.Write pinjaman_cmd.commandText
    set data = pinjaman_cmd.execute

    ' cek id yang sudah di store
    pinjamanid = data("ID")

    ' update data potong gaji
    update_cmd.commandText = "SELECT TPK_ID_Bank FROM HRD_T_PK_Bank WHERE TPK_Tanggal = '"& tgl &"' AND TPK_Nip = '"& nip &"' AND TPK_Ket = '"& keterangan &"' AND TPK_PP = '"&  hutang &"' AND TPK_Lama = '"& lama &"' AND TPK_Bunga = '"& bunga &"'"
    set data = update_cmd.execute
    
    if not data.eof then
        update_cmd.commandText = "UPDATE HRD_T_PK_Bank SET TPK_PotongGajiYN = '"& potgaji &"' WHERE TPK_Nip = '"& nip &"' AND TPK_Tanggal = '"& tgl &"' AND TPK_Ket = '"& keterangan &"' AND TPK_PP = '"& hutang &"' AND TPK_Lama = '"& lama &"'"
        update_cmd.execute
    end if

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "CREATE"
    key = pinjamanid
    url = ""

    keterangan = "TAMBAH PINJAMAN BANK UNTUK NIP ("& nip &") DI PROSES "& Cdate(tgl) 
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
end if



 %>
<!--#include file="../../layout/footer.asp"-->