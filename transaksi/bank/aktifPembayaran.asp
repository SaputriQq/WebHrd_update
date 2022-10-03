<!-- #include file='../../connection.asp' -->
<% 
if session("HT3BC") = false then
    response.Redirect("pembayaran.asp")
end if

dim p,i,aktif

p = Request.QueryString("p")
i = Request.QueryString("i")
nip = Request.QueryString("nip")

set aktif = Server.CreateObject("ADODB.Command")
aktif.activeConnection = mm_cargo_string

if i = "Y" then
    aktif.commandText = "UPDATE HRD_T_BK_Bank SET TPK_AktifYN = 'N' WHERE TPK_ID_Bank = '"& p &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = p
    url = ""

    keterangan = "NONAKTIF PEMBAYARAN BANK KARYAWAN ("& nip &") DENGAN NOMOR (" & p &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
else
    aktif.commandText = "UPDATE HRD_T_BK_Bank SET TPK_AktifYN = 'Y' WHERE TPK_ID_Bank = '"& p &"' AND TPK_Nip = '"& nip &"'"
    ' Response.Write aktif.commandText
    aktif.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = p
    url = ""

    keterangan = "AKTIF PEMBAYARAN BANK KARYAWAN ("& nip &") DENGAN NOMOR (" & p &")"
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
end if

Response.Redirect("pembayaran.asp")
 %>