<!-- #include file='../../connection.asp' -->
<% 
if session("HT2BC") = false then
    response.Redirect("pembayaran.asp")
end if

dim p,i,aktif

p = Request.QueryString("p")
i = Request.QueryString("i")
nip = Request.QueryString("nip")

set aktif_cmd = Server.CreateObject("ADODB.Command")
aktif_cmd.activeConnection = mm_cargo_string

aktif_cmd.commandTExt = "SELECT TPK_AktifYN FROM HRD_T_BK_Elektronik WHERE TPK_ID_Elektronik = '"& p &"'"
set data = aktif_cmd.execute

if not data.eof then
    if i = "Y" then
        aktif_cmd.commandText = "UPDATE HRD_T_BK_Elektronik SET TPK_AktifYN = 'N' WHERE TPK_ID_Elektronik = '"& p &"'"
        ' Response.Write aktif.commandText
        aktif_cmd.execute

        'updateLog system
        ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
        browser = Request.ServerVariables("http_user_agent")
        dateTime = now()
        eventt = "DELETE"
        key = nip
        url = ""

        keterangan = "NONAKTIF PEMBAYARAN BARANG KARYAWAN UNTUK NIP ("& nip &") DENGAN NOMOR (" & p &")"
        call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
    else
        aktif_cmd.commandText = "UPDATE HRD_T_BK_Elektronik SET TPK_AktifYN = 'Y' WHERE TPK_ID_Elektronik = '"& p &"'"
        ' Response.Write aktif.commandText
        aktif_cmd.execute

        'updateLog system
        ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
        browser = Request.ServerVariables("http_user_agent")
        dateTime = now()
        eventt = "DELETE"
        key = nip
        url = ""

        keterangan = "AKTIF PEMBAYARAN BARANG KARYAWAN UNTUK NIP ("& nip &") DENGAN NOMOR (" & p &")"
        call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan)
    end if
end if

Response.Redirect("pembayaran.asp")
 %>