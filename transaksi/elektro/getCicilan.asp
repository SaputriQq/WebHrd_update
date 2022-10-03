<!-- #include file='../../connection.asp' -->
<%
    key = trim(Request.QueryString("key"))
    
    set tpk_cmd = Server.CreateObject("ADODB.Command")
    tpk_cmd.activeConnection = mm_cargo_string

    set cicilan_cmd = Server.CreateObject("ADODB.Command")
    cicilan_cmd.activeConnection = mm_cargo_string

    cicilan_cmd.commandTExt = "SELECT COUNT(TPK_ID_Elektronik) + 1 AS ke FROM HRD_T_BK_Elektronik WHERE TPK_Ket LIKE '%"& key &"%'"
    ' Response.Write cicilan_cmd.commandText & "<br>"
    set cicilan = cicilan_cmd.execute


    tpk_cmd.commandText = "SELECT TPK_Lama FROM HRD_T_PK_Elektronik WHERE TPK_ID_Elektronik = '"& key &"'"
    ' Response.Write tpk_cmd.commandText & "<br>"
    set tpk = tpk_cmd.execute

    if not cicilan.eof then
        Response.Write tpk("TPK_Lama")&","&cicilan("ke") 
    else    
        Response.Write tpk("TPK_Lama")&","&"1"
    end if

    '
%>