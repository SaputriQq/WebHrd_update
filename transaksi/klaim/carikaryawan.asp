<!-- #include file='../../connection.asp' -->
<% 
  dim key 
  dim karyawan

  key = Request.QueryString("key")

  set karyawan = Server.CreateObject("ADODB.COmmand")
  karyawan.activeConnection = mm_cargo_string

  karyawan.commandText = "SELECT HRD_T_PK.TPK_ID, HRD_T_PK.TPK_NIP, HRD_T_PK.TPK_Ket, HRD_T_PK.TPK_PP, ISNULL(SUM(HRD_T_BK.TPK_PP), 0) AS terbayar, HRD_T_PK.TPK_PP - ISNULL(SUM(HRD_T_BK.TPK_PP), 0) AS utang, HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_Tanggal FROM HRD_T_PK LEFT OUTER JOIN HRD_T_BK ON HRD_T_PK.TPK_Ket = HRD_T_BK.TPK_Ket AND HRD_T_PK.TPK_NIP = HRD_T_BK.TPK_NIP LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_PK.TPK_NIP = HRD_M_Karyawan.Kry_Nip WHERE (HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%') AND HRD_T_PK.TPK_AktifYN = 'Y' AND HRD_T_PK.TPK_ket NOT LIKE '%elektronik ke%' GROUP BY HRD_T_PK.TPK_ID, HRD_T_PK.TPK_NIP, HRD_T_PK.TPK_Ket, HRD_T_PK.TPK_PP, HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_Tanggal HAVING (HRD_T_PK.TPK_PP - ISNULL(SUM(HRD_T_BK.TPK_PP), 0) > 0) ORDER BY HRD_T_PK.TPK_Tanggal DESC"
  ' Response.Write karyawan.commandText & "<br>"
  set karyawan = karyawan.execute
 %>
    <style>
    .table-carikaryawan{
      display: block;
      height: 200px;
      overflow-x: scroll;
      font-size:12px;
    }
    </style>
      <% 
      if karyawan.eof then 
      %>
      <div class='row'>
        <div class='col'>
          <p style="color:red;">DATA NAMA TIDAK DI TEMUKAN</p>
        </div>
      </div>
      <% else %>
      <table class="table table-carikaryawan">
        <thead>
          <tr>
            <th scope="col">Pilih</th>
            <th scope="col">NIP</th>
            <th scope="col">NAMA</th>
            <th scope="col">KETERANGAN</th>
          </tr>
        </thead>
        <tbody class="tr-table">
          <% 
          do until karyawan.eof 
          %>
          <tr>
            <th><input class="form-check-input" type="radio" name="resultCari" id="resultCari" onclick="return clickRadio('<%= karyawan("TPK_Nip") %>','<%= karyawan("Kry_Nama") %>', '<%= karyawan("TPK_Ket") %>')"></th>
            <td id="cariNip"><%= karyawan("TPK_Nip") %></td>
            <td id="cariNama"><%= karyawan("Kry_Nama") %></td>
            <td id="cariKeterangan"><%= karyawan("TPK_Ket") %></td>
          </tr>
          <% 
          karyawan.movenext
          loop
          %>
        </tbody>
    </table>
    <% end if %>