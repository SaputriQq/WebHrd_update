<!-- #include file='../../connection.asp' -->
<% 
    dim key 
    dim karyawan

    key = Request.QueryString("key")

    set karyawan = Server.CreateObject("ADODB.COmmand")
    karyawan.activeConnection = mm_cargo_string

    karyawan.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_Nama LIKE '%"& key &"%' AND Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%' ORDER BY Kry_Nama ASC"
    ' Response.Write karyawan.commandText & "<br>"
    set karyawan = karyawan.execute
%>
    <style>
        .tableKaryawan{
            display: block;
            width:20rem;
            height: 15em;
            overflow-x: scroll;
            font-size:12px;
            margin-left: auto; 
            margin-right: 0;
        }
    </style>
    <%if karyawan.eof then %>
        <div class='row'>
            <div class='col'>
            <p style="color:red;">DATA NAMA TIDAK DI TEMUKAN</p>
            </div>
        </div>
    <% else %>
        <table class="table tableKaryawan">
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
