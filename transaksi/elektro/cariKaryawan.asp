<!-- #include file='../../connection.asp' -->
<% 

dim nama 
dim karyawan 

nama = Request.QueryString("key")

set karyawan = Server.CreateObject("ADODB.COmmand")
karyawan.activeConnection = mm_cargo_String

karyawan.commandText = "SELECT Kry_Nama, Kry_Nip FROM HRD_M_Karyawan WHERE Kry_Nama LIKE '%"& nama &"%' AND Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%'"
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
          </tr>
        </thead>
        <tbody class="tr-table">
          <% 
          do until karyawan.eof 
          %>
          <tr>
            <th><input class="form-check-input" type="radio" name="resultCari" id="resultCari" onclick="return clickRadio('<%= karyawan("Kry_Nip") %>','<%= karyawan("Kry_Nama") %>')"></th>
            <td id="cariNip"><%= karyawan("Kry_Nip") %></td>
            <td id="cariNama"><%= karyawan("Kry_Nama") %></td>
          </tr>
          <% 
          karyawan.movenext
          loop
          %>
        </tbody>
      </table>
      <% end if %>