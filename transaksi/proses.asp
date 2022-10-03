<!-- #include file='../connection.asp' -->
<% 
    

if session("username") <> "dausit" then
    response.Redirect("index.asp")
end if

transaksi = Cint(Request.Form("transaksi"))
tahun = Request.Form("tahun")

set proses_cmd = Server.CreateObject("ADODB.COmmand")
proses_cmd.activeConnection = mm_cargo_string

    if request.serverVariables("request_method") = "POST" then
        if transaksi = 1 then
            tables = "HRD_T_SA_PK"
        elseif transaksi = 2 then
            tables = "HRD_T_SA_PK_Elektronik"
        elseif transaksi = 3 then
            tables = "HRD_T_SA_PK_Bank"
        else
            tables = "HRD_T_SA_PK_Pribadi"
        end if

        proses_cmd.CommandText = "SELECT * FROM "&tables&" WHERE SAPK_Tahun = '"& tahun &"'"
        ' Response.Write proses_cmd.commandText & "<br>"
        set data = proses_cmd.execute

        do while not data.eof
            proses_cmd.CommandText = "UPDATE "&tables&" SET SAPK_Awal = '0', SAPK_bayar01 = '0', SAPK_bayar02 = '0', SAPK_bayar03 = '0', SAPK_bayar04 = '0', SAPK_bayar05 = '0', SAPK_bayar06 = '0', SAPK_bayar07 = '0', SAPK_bayar08 = '0', SAPK_bayar09 = '0', SAPK_bayar10 = '0', SAPK_bayar11 = '0',SAPK_bayar12 = '0', SAPK_pinjam01 = '0', SAPK_pinjam02 = '0', SAPK_pinjam03 = '0', SAPK_pinjam04 = '0', SAPK_pinjam05 = '0', SAPK_pinjam06 = '0', SAPK_pinjam07 = '0', SAPK_pinjam08 = '0', SAPK_pinjam09 = '0', SAPK_pinjam10 = '0', SAPK_pinjam11 = '0',SAPK_pinjam12 = '0' WHERE SAPK_Nip = '"& data("SAPK_Nip") &"' AND SAPK_Tahun = '"& tahun &"'"
            proses_cmd.execute        
        response.flush
        data.movenext
        loop
        
    end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BACKDOR PROSES</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>
    <div class="container">
        <div class="row mt-3">
            <div class="col-lg-5">
                <form method="post" action="proses.asp">
                    <div class="mb-3">
                        <label for="transaksi" class="form-label">TRANSAKSI</label>
                        <select class="form-select" id="transaksi" name="transaksi" required>
                            <option value="">Pilih</option>
                            <option value="1">klaim</option>
                            <option value="2">elektronik</option>
                            <option value="3">bank</option>
                            <option value="4">pribadi</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="tahun" class="form-label">TAHUN</label>
                        <input type="number" class="form-control" id="tahun" name="tahun" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->