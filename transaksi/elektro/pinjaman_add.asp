<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
if session("HT2AA") = false then
    Response.Redirect("pinjaman.asp")
end if

dim pinjaman_cmd, pinjaman
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

id = Request.Form("id")
tgl = Request.Form("tgl")
nip = Request.Form("nip")
hutang = replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",","")
thutang = replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",","")
bunga = Request.Form("bunga")
lama = Request.Form("lama")
potgaji = trim(Request.Form("potgaji"))

kode = mid(nip,1,3)

keterangan = "Elektronik Ke"

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = mm_cargo_String

set pinjaman_cmd = Server.CreateObject("ADODB.Command")
pinjaman_cmd.activeConnection = mm_cargo_String

pinjaman_cmd.commandText = "SELECT * FROM HRD_T_PK_Elektronik WHERE TPK_Nip = '"& nip &"' and TPK_Tanggal = '"& tgl &"' and TPK_AktifYN = 'Y'"
set pinjaman = pinjaman_cmd.execute

if pinjaman.eof then
    karyawan_cmd.commandText = "SELECT ISNULL(COUNT(TPK_ID_Elektronik), 0) + 1 AS ke FROM HRD_T_PK_Elektronik WHERE TPK_Nip = '"& nip &"' AND (TPK_AktifYN = 'Y') AND (TPK_Ket LIKE '%"& keterangan &"%')"
    ' Response.Write karyawan_cmd.commandText & "<br>"
    set karyawan = karyawan_cmd.execute

    ke = karyawan("ke")

    pinjaman_cmd.commandText = "exec sp_AddHRD_T_PK_Elektronik '"& kode &"','"& tgl &"','"& nip &"','"& keterangan&"-"&ke&"',"& hutang &","& bunga &","& lama &",'"& session("username") &"'"
    ' Response.Write pinjaman_cmd.commandText
    set data = pinjaman_cmd.execute

    ' set id untuk pinjaman elektronik
    pinjamanid = data("ID")

    ' update potongan gaji
    update_cmd.commandText = "SELECT TPK_ID_Elektronik FROM HRD_T_PK_Elektronik WHERE TPK_Tanggal = '"& tgl &"' AND TPK_Nip = '"& nip &"' AND TPK_Ket = '"& keterangan&"-"&ke&"' AND TPK_PP = '"&  hutang &"' AND TPK_Lama = '"& lama &"' AND TPK_Bunga = '"& bunga &"'"
    set data = update_cmd.execute

    if not data.eof then
        update_cmd.commandText = "UPDATE HRD_T_PK_Elektronik SET TPK_PotongGajiYN = '"& potgaji &"' WHERE TPK_ID_Elektronik = '"& data("TPK_ID_Elektronik") &"' "
        update_cmd.execute
    end if

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "CREATE"
    key = pinjamanid
    url = ""

    keterangan = "TAMBAH PINJAMAN BARANG KARYAWAN UNTUK NIP ("& nip &") DI PROSES "& Cdate(tgl) 
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
end if



 %>
<!--#include file="../../layout/footer.asp"-->