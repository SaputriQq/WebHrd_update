<!-- #include file='../../connection.asp' -->
<% 
if session("HT2AC") = false then
    Response.Redirect("pinjaman.asp")
end if

dim id, p
dim Aktif

id = Request.QueryString("id")
p = Request.QueryString("p")
nip = Request.QueryString("nip")

set aktif = Server.CreateObject("ADODB.Command")
aktif.activeConnection = mm_cargo_String

if p = "Y" then
    aktif.commandText = "UPDATE HRD_T_PK_Elektronik SET TPK_AktifYN = 'N' WHERE TPK_ID_Elektronik = '"& id &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write Aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = id
    url = ""

    keterangan = "NONAKTIF PINJAMAN BARANG KARYAWAN ("& nip &") DENGAN NOMOR (" & id &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
else
    aktif.commandText = "UPDATE HRD_T_PK_Elektronik SET TPK_AktifYN = 'Y' WHERE TPK_ID_Elektronik = '"& id &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write Aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = id
    url = ""

    keterangan = "AKTIF PINJAMAN BARANG KARYAWAN ("& nip &") DENGAN NOMOR (" & id &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
end if

Response.Redirect("pinjaman.asp")
 %>