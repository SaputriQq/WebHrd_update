<!-- #include file='../../connection.asp' -->
<%
    nip = trim(Request.QueryString("nip"))
    id = trim(Request.QueryString("id"))

    set bayar_cmd = Server.CreateObject("ADODB.Command")
    bayar_cmd.activeConnection = mm_cargo_string

    set lunas_cmd = Server.CreateObject("ADODB.Command")
    lunas_cmd.activeConnection = mm_cargo_string

    lunas_cmd.commandText = "SELECT HRD_T_PK_Elektronik.TPK_PP, (ISNULL(HRD_T_PK_Elektronik.TPK_PP,0) - ISNULL(SUM(HRD_T_BK_Elektronik.TPK_PP),0)) AS jmlcicilan  FROM HRD_T_PK_Elektronik LEFT OUTER JOIN HRD_T_BK_Elektronik ON HRD_T_PK_Elektronik.TPK_ID_Elektronik = SUBSTRING(dbo.HRD_T_BK_Elektronik.TPK_Ket, 1, 18) WHERE HRD_T_PK_Elektronik.TPK_ID_Elektronik = '"& id &"' AND HRD_T_PK_Elektronik.TPK_Nip = '"& nip &"' AND HRD_T_PK_Elektronik.TPK_AktifYN = 'Y' AND HRD_T_BK_Elektronik.TPK_AktifYN = 'Y' AND HRD_T_BK_Elektronik.TPK_Nip = '"& nip &"' GROUP BY HRD_T_PK_Elektronik.TPK_PP"

    set lunas = lunas_cmd.execute

    if not lunas.eof then
        Response.Write lunas("jmlcicilan")
    else
        bayar_cmd.commandText = "SELECT TPK_PP FROM HRD_T_PK_Elektronik WHERE TPK_ID_Elektronik = '"& id &"' AND TPK_Nip = '"& nip &"' AND TPK_AktifYN = 'Y'"
        set bayar = bayar_cmd.execute

        Response.Write bayar("TPK_PP")
    end if

%>