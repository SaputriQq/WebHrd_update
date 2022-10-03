<!-- #include file='../../connection.asp' -->
<% 
  dim key 
  dim karyawan

  key = Request.QueryString("key")

  set tpk_cmd = Server.CreateObject("ADODB.COmmand")
  tpk_cmd.activeConnection = mm_cargo_string

  set karyawan = Server.CreateObject("ADODB.COmmand")
  karyawan.activeConnection = mm_cargo_string

  karyawan.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_PK_Elektronik ON HRD_M_Karyawan.Kry_Nip = HRD_T_PK_Elektronik.TPK_Nip WHERE HRD_T_PK_Elektronik.TPK_aktifYN = 'Y' AND HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama ORDER BY Kry_Nama ASC "
  ' Response.Write karyawan.commandText & "<br>"
  set karyawan = karyawan.execute
 %>
    <style>
    .table-carikaryawan{
      display: block;
      height: 150px;
      margin-right:7px;
      overflow-y: scroll;
      font-size:12px;
    }
    </style>
      <% if not karyawan.eof then %>
      <table class="table table-carikaryawan">
        <thead>
            <tr>
                <th scope="col">Pilih</th>
                <th scope="col">NIP</th>
                <th scope="col">NAMA</th>
            </tr>
        </thead>
        <tbody class="tr-table">
            <% 
            no = 0
            do until karyawan.eof 
            
            %>
            <tr>
                <th><input class="form-check-input" type="radio" name="resultCari" id="resultCari" onclick="return clickRadio('<%= karyawan("Kry_Nama") %>', '<%= karyawan("Kry_Nip") %>')"></th>
                <td id="cariNip"><%= karyawan("Kry_Nip") %></td>
                <td id="cariNama"><%= karyawan("Kry_Nama") %></td>
            </tr>
            <% 
            karyawan.movenext
            loop
            %>
        </tbody>
    </table>
    <% else %>
      <div class='row table-carikaryawan'>
        <div class='col'>
          <p style="color:red;">DATA NAMA TIDAK DI TEMUKAN</p>
        </div>
      </div>
    <% end if %>