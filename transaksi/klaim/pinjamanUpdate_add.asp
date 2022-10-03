<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
if session("HT1AB") = false then
    response.Redirect("pinjamanKaryawan.asp")
end if

 
dim update_cmd
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

nomor = trim(Request.Form("nomor"))
tgl = Request.Form("tgl")
nip = trim(Request.Form("nip"))
keterangan = replace(trim(Request.Form("keterangan")), vbcrlf, "")
hutang = replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",","")
thutang = replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",","")
bunga = replace(replace(replace(Request.Form("bunga"),".",""),"-",""),",","")
lama = Request.Form("lama")
potgaji = trim(Request.Form("potgaji"))

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

update_cmd.commandText = "SELECT * FROM HRD_T_PK WHERE TPK_ID = '"& nomor &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& nip &"'"
set data = update_cmd.execute

if not data.eof then
    update_cmd.commandText = "UPDATE HRD_T_PK SET TPK_Tanggal = '"& tgl &"', TPK_ket = '"& keterangan &"', TPK_PP = '"& hutang &"', TPK_Bunga = '"& bunga &"', TPK_Lama = '"& lama &"', TPK_updateID = '"& id &"', TPK_UpdateTIme = '"& date() &"', TPK_PotongGajiYN = '"& potgaji &"' WHERE TPK_ID = '"& nomor &"'"
    ' Response.Write update_cmd.commandText
    update_cmd.execute

    ' set id data update
    pinjamanid = nomor

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "UPDATE"
    key = pinjamanid
    url = ""

    keterangan = "UPDATE KLAIM PINJAMAN KARYAWAN UNTUK NIP ("& nip &") DENGAN NOMOR ("& pinjamanid &") "
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pinjamanKaryawan.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pinjamanKaryawan.asp' class='btn btn-primary'>kembali</a></div>"
end if


%>
<!-- #include file='../../layout/footer.asp' -->