<!-- #include file='../../connection.asp' -->
<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("HT3AC") = false then
    response.Redirect("pinjaman.asp")
end if

dim id, p
dim Aktif

id = Request.QueryString("id")
p = Request.QueryString("p")
nip = Request.QueryString("nip")

set aktif = Server.CreateObject("ADODB.Command")
aktif.activeConnection = mm_cargo_String

if p = "Y" then
    aktif.commandText = "UPDATE HRD_T_PK_Bank SET TPK_AktifYN = 'N' WHERE TPK_ID_Bank = '"& id &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write Aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = id
    url = ""

    keterangan = "NONAKTIF PINJAMAN BANK ("& nip &") DENGAN NOMOR (" & id &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
else
    aktif.commandText = "UPDATE HRD_T_PK_Bank SET TPK_AktifYN = 'Y' WHERE TPK_ID_Bank = '"& id &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write Aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = id
    url = ""

    keterangan = "AKTIF PINJAMAN BANK ("& nip &") DENGAN NOMOR (" & id &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
end if

Response.Redirect("pinjaman.asp")
%>