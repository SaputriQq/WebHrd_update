<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
if session("HT3AB") = false then
    response.Redirect("pinjaman.asp")
end if

dim update_cmd
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

nomor = trim(Request.Form("nomor"))
tgl = trim(Request.Form("tgl"))
nip = trim(Request.Form("nip"))
keterangan = replace(trim(Request.Form("keterangan")), vbcrlf, "")
hutang = trim(replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",",""))
thutang = trim(replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",",""))
bunga = trim(replace(replace(replace(Request.Form("bunga"),".",""),"-",""),",",""))
lama = trim(Request.Form("lama"))
potgaji = trim(Request.Form("potgaji"))

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

update_cmd.commandText = "SELECT * FROM HRD_T_PK_Bank WHERE TPK_ID_Bank = '"& nomor &"' AND TPK_Nip = '"& nip &"' AND TPK_AktifYN = 'Y'"
set data = update_cmd.execute

if not data.eof then
    update_cmd.commandText = "UPDATE HRD_T_PK_Bank SET TPK_Tanggal = '"& tgl &"', TPK_PP = '"& hutang &"', TPK_Bunga = '"& bunga &"', TPK_Lama = '"& lama &"', TPK_updateID = '"& id &"', TPK_UpdateTIme = '"& date() &"', TPK_PotongGajiYN = '"& potgaji &"', TPK_Ket = '"& keterangan &"' WHERE TPK_ID_Bank = '"& nomor &"'"
    ' Response.Write update_cmd.commandText
    update_cmd.execute

    ' updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "UPDATE"
    key = nomor
    url = ""

    keterangan = "UPDATE PINJAMAN BANK UNTUK NIP ("& nip &") DENGAN NOMOR "& nomor
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
end if
%>
<!-- #include file='../../layout/footer.asp' -->