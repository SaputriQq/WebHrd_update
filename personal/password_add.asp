<!-- #include file='../connection_personal.asp' -->
<!-- #include file='../md5.asp' -->
<!-- #include file='../layout/header.asp' -->
<% 
nip = trim(Request.Form("nip"))
pnip = trim(Request.Form("pnip"))
passlama = md5(trim(Request.Form("paswordlama")))
passbaru = md5(trim(Request.Form("passwordbaru")))


set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = MM_Cargo_string

karyawan_cmd.commandText = "SELECT Kry_nama, Kry_nip, Kry_pass_login_loading_barang FROM HRD_M_Karyawan WHERE Kry_Nip = '"& pnip &"' AND Kry_pass_login_loading_barang = '"& passlama &"' AND Kry_AktifYN = 'Y'"
' Response.Write karyawan_cmd.commandText & "<br>"
set karyawan = karyawan_cmd.execute

if karyawan.eof then
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Password Tidak Valid</span><img src='../logo/gagal_dakota.PNG'><a href='index.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_pass_login_loading_barang = '"& passbaru &"' WHERE Kry_Nip = '"& pnip &"'"
    ' Response.Write karyawan_cmd.commandText & "<br>"
    karyawan_cmd.execute

    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Password Terganti</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../layout/footer.asp' -->