<!-- #include file='../../connection.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../../login.asp")
end if 
dim id, nip, update, update_cmd, pinjaman

id = Request.form("id")
nip = Request.form("nip")

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

update_cmd.commandText = "SELECT HRD_T_PK.*, HRD_M_Karyawan.Kry_Nama FROM HRD_T_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_PK.TPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE TPK_ID = '"& id &"' and TPK_Nip = '"& nip &"'"
set update = update_cmd.execute

tcicilan = update("TPK_PP") / update("TPK_Lama")

dim data(11)

data(0)= update("TPK_ID")
data(1)= update("TPK_Tanggal")
data(2)= update("TPK_Nip")
data(3)= update("TPK_Ket") 
data(4)= update("TPK_PP") 
data(5)= update("TPK_bunga") 
data(6)= update("TPK_Lama")
data(7)= update("TPK_AktifYN")
data(8)= update("TPK_updateID")
data(9)= update("TPK_UpdateTime")
data(10)= update("Kry_Nama")
data(11)= tcicilan


for each x in data
    Response.Write (x) &","
Next

 %>