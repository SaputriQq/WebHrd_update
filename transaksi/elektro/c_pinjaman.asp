<!-- #include file='../../connection.asp' -->
<% 
  dim key 
  dim karyawan

  nip = trim(Request.QueryString("nip"))

  set tpk_cmd = Server.CreateObject("ADODB.COmmand")
  tpk_cmd.activeConnection = mm_cargo_string

  set karyawan = Server.CreateObject("ADODB.COmmand")
  karyawan.activeConnection = mm_cargo_string

  karyawan.commandText = "SELECT dbo.HRD_T_PK_Elektronik.TPK_ID_Elektronik, dbo.HRD_T_PK_Elektronik.TPK_Lama, dbo.HRD_T_PK_Elektronik.TPK_Ket, ISNULL(COUNT(dbo.HRD_T_BK_Elektronik.TPK_Ket),0) + 1 AS JMLBAYAR,HRD_T_PK_Elektronik.TPK_PP FROM dbo.HRD_T_PK_Elektronik LEFT OUTER JOIN dbo.HRD_T_BK_Elektronik ON dbo.HRD_T_PK_Elektronik.TPK_ID_Elektronik = SUBSTRING(dbo.HRD_T_BK_Elektronik.TPK_Ket, 1, 18) WHERE (dbo.HRD_T_PK_Elektronik.TPK_NIP ='"& nip &"') AND (dbo.HRD_T_PK_Elektronik.TPK_AktifYN = 'Y') AND (dbo.HRD_T_PK_Elektronik.TPK_Ket LIKE '%Elektronik%') GROUP BY dbo.HRD_T_PK_Elektronik.TPK_ID_Elektronik, dbo.HRD_T_PK_Elektronik.TPK_Lama, dbo.HRD_T_PK_Elektronik.TPK_Ket, HRD_T_PK_Elektronik.TPK_PP HAVING ISNULL(SUM(HRD_T_BK_Elektronik.TPK_PP),0) < HRD_T_PK_Elektronik.TPK_PP"
  ' Response.Write karyawan.commandText & "<br>"
  set karyawan = karyawan.execute 
%>
    <style>
      .table-carikaryawan{
        display: block;
        width:auto;
        height: 200px;
        overflow-y: scroll;
        font-size:12px;
      }
    </style>
    <script>
        function CariCicilan(e){
            let str = e.substring(0,19);
            $.get(`getCicilan.asp?key=${str}`, function(data){
                let array = data.split(",");
                $("#pembayaranke").val(array[1]);
                $("#inplama").val(array[0]);
            });
        }
    </script>
      <% if karyawan.eof then %>
      <div class='row'>
        <div class='col'>
          <p style="color:red;">DATA NAMA TIDAK DI TEMUKAN</p>
        </div>
      </div>
      <% else%>
          <select class="form-select" aria-label="Default select example" name="keterangan" id="keterangan" onchange="return CariCicilan(this.value)" required>
                <option value="">Pilih</option>
                <%
                do until karyawan.eof
                %>
                <option value="<%= karyawan("TPK_ID_Elektronik") &" - "& karyawan("JMLBAYAR") &"/"& karyawan("TPK_Lama") %>"><%= karyawan("TPK_Ket")%></option>
                <% 
                    karyawan.movenext
                    loop
                %>
            </select>
    <% end if %>