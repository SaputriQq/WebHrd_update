<!-- #include file='../../../connection.asp' -->
<% 
    if session("HT1C") = false then
        Response.Redirect("../index.asp")
    end if
    dim mutasi_cmd, mutasi
    dim bulan, tahun, nip, nama, area, radio, saldoakhir, tpinjaman, tbayar

    bulan = trim(Request.Form("bulan"))
    tahun = trim(Request.Form("tahun"))
    nama = trim(Request.Form("nama"))
    area = trim(Request.Form("area"))
    radio = Request.Form("option")

    set mutasi_cmd = Server.CreateObject("ADODB.Command")
    mutasi_cmd.activeConnection = mm_cargo_string

    set noname_cmd = Server.CreateObject("ADODB.Command")
    noname_cmd.activeConnection = mm_cargo_string
 
    if bulan = "" then
        if radio = "detail" then
            if nama = "" then
                noname_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP,  sapk_awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write noname_cmd.commandText & "<br>"
                set mutasi = noname_cmd.execute
            else
                noname_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, sapk_awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = noname_cmd.execute
            end if
        else
            if nama = "" then
                noname_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam12 AS pinjam, SAPK_Bayar12 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam12, SAPK_Bayar12, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                set mutasi = noname_cmd.execute
            else
                noname_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam12 AS pinjam, SAPK_Bayar12 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam12, SAPK_Bayar12, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = noname_cmd.execute
            end if
        end if
    else
        ' DETAIL
        if radio = "detail" then
            if nama = "" then
                if bulan = "1" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, (SAPK_Awal + SAPK_Pinjam01) - SAPK_Bayar01 AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'') <> '' AND (sapk_awal + SAPK_Pinjam01) <> 0 GROUP BY SAPK_NIP,  sapk_awal, (SAPK_Awal + SAPK_Pinjam01) - SAPK_Bayar01, HRD_M_Karyawan.Kry_nama order by HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "2" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, (SAPK_Awal + SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01 + SAPK_Bayar02) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'') <> '' AND (sapk_awal + SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01) <> 0 GROUP BY SAPK_NIP,  sapk_awal, (SAPK_Awal + SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01 + SAPK_Bayar02), HRD_M_Karyawan.Kry_nama order by HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "3" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'') <> '' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01 + SAPK_Bayar02)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "4" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "5" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "6" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "7" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "8" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "9" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "10" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "11" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "12" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                end if
            else
                if bulan = "1" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + SAPK_Pinjam01) - (SAPK_Bayar01) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE(SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'') <> '' AND (sapk_awal + SAPK_Pinjam01) <> 0 AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01)) - (SAPK_Bayar01), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "2" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'') <> '' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND ( sapk_awal +  (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "3" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "4" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "5" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "6" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "7" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "8" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "9" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "10" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "11" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "12" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, SAPK_Awal, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                    set mutasi = mutasi_cmd.execute
                end if
            end if
            ' END DETAIL
        else
            ' REKAPITULASI 
            if nama = "" then
                if bulan = "1" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam01 AS pinjam, SAPK_Bayar01 AS bayar, SAPK_Awal + (SAPK_Pinjam01) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01)) - (SAPK_Bayar01) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  (SAPK_Pinjam01) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam01, SAPK_Bayar01, SAPK_Awal + (SAPK_Pinjam01), (SAPK_Awal + (SAPK_Pinjam01)) - (SAPK_Bayar01), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                    ' Response.Write mutasi_cmd.commandText & "<br>"
                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "2" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam02 AS pinjam, SAPK_Bayar02 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam02, SAPK_Bayar02, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "3" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam03 AS pinjam, SAPK_Bayar03 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam03, SAPK_Bayar03, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "4" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam04 AS pinjam, SAPK_Bayar04 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam04, SAPK_Bayar04, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "5" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam05 AS pinjam, SAPK_Bayar05 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam05, SAPK_Bayar05, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "6" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam06 AS pinjam, SAPK_Bayar06 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam06, SAPK_Bayar06, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "7" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam07 AS pinjam, SAPK_Bayar07 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam07, SAPK_Bayar07, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "8" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam08 AS pinjam, SAPK_Bayar08 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam08, SAPK_Bayar08, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "9" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam09 AS pinjam, SAPK_Bayar09 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam09, SAPK_Bayar09, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                    
                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "10" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam10 AS pinjam, SAPK_Bayar10 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam10, SAPK_Bayar10, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "11" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam11 AS pinjam, SAPK_Bayar11 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam11, SAPK_Bayar11, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "12" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam12 AS pinjam, SAPK_Bayar12 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam12, SAPK_Bayar12, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                    ' Response.Write mutasi_cmd.commandTExt & "<br>"
                    set mutasi = mutasi_cmd.execute
                end if
            else
                if bulan = "1" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam01 AS pinjam, SAPK_Bayar01 AS bayar, SAPK_Awal + (SAPK_Pinjam01) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01)) - (SAPK_Bayar01) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal + (SAPK_Pinjam01) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam01, SAPK_Bayar01, SAPK_Awal + (SAPK_Pinjam01), (SAPK_Awal + (SAPK_Pinjam01)) - (SAPK_Bayar01), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "2" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam02 AS pinjam, SAPK_Bayar02 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam02, SAPK_Bayar02, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02)) - (SAPK_Bayar01 + SAPK_Bayar02), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "3" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam03 AS pinjam, SAPK_Bayar03 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01 + SAPK_Bayar02) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam03, SAPK_Bayar03, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01 + SAPK_Bayar02), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "4" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam04 AS pinjam, SAPK_Bayar04 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam04, SAPK_Bayar04, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "5" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam05 AS pinjam, SAPK_Bayar05 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam05, SAPK_Bayar05, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "6" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam06 AS pinjam, SAPK_Bayar06 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam06, SAPK_Bayar06, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "7" then 
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam07 AS pinjam, SAPK_Bayar07 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam07, SAPK_Bayar07, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "8" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam08 AS pinjam, SAPK_Bayar08 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam08, SAPK_Bayar08, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "9" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam09 AS pinjam, SAPK_Bayar09 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam09, SAPK_Bayar09, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "10" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam10 AS pinjam, SAPK_Bayar10 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam10, SAPK_Bayar10, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "11" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam11 AS pinjam, SAPK_Bayar11 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam11, SAPK_Bayar11, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10) , (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                elseIf bulan = "12" then
                    mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal, SAPK_Pinjam12 AS pinjam, SAPK_Bayar12 AS bayar, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11) AS totalpinjamstaun, (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12) AS tsaldoakhir, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' and isnull(sapk_nip,'')<>'' AND sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) <> 0 GROUP BY SAPK_NIP, sapk_awal, SAPK_Pinjam12, SAPK_Bayar12, SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11), (SAPK_Awal + (SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11 + SAPK_Pinjam12)) - (SAPK_Bayar01 + SAPK_Bayar02 + SAPK_Bayar03 + SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11 + SAPK_Bayar12), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                    set mutasi = mutasi_cmd.execute
                end if
            end if
            ' END REKAPITULASI
        end if
    end if

    ' filter bulan for query
    if bulan <> "" then
        filterBln = "Month(TPK_Tanggal) BETWEEN '1' AND '"& bulan &"' AND"
    else
        filterBln = ""
    end if
%>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MUTASI PINJAMAN</title>
    <!-- #include file='../../../layout/header.asp' -->
    <style>
        .form-mutasi{
            padding:10px;
            background-color:#fff;
            border-radius:10px;
            margin-top:5px;
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(210,220,222,1) 0%, rgba(255,255,255,1) 100%);
        }
        .form-mutasi input[type="text"]{
            background: transparent;
            border:none;
        }
        .form-mutasi input[type="number"]{
            background: transparent;
            border:none;
        }
        .form-mutasi hr{
            margin-top:-1px;
        }
        </style>
        <script>
        function validasiMutasi(){

        }
    </script>
</head>
<div class='container'>
    <div class='form-mutasi'>
        <div class='row mb-3'>
            <div class='col text-center'>
                <h3>MUTASI PINJAMAN KARYAWAN</h3>
            </div>
        </div>
        <form action="index.asp" method="post" name="form-mutasi">
        <div class='row'>
            <div class='col-sm-2 mt-2'>
                <label>Priode Bulan</label>
            </div>
            <div class='col-sm-2'>
                <input type="number" id="bulan" name="bulan" class="form-control" autocomplete="off" min="1" max="12">
                <hr>
            </div>
            <div class='col-auto mt-2'>
                <label>Tahun</label>
            </div>
            <div class='col-sm-2'>
                <input type="number" id="tahun" name="tahun" class="form-control" autocomplete="off" required>
                <hr>
            </div>
            <div class='col'>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="option" id="detail" value="detail" required>
                    <label class="form-check-label" for="detail">Detail</label>
                </div>
                <div class="form-check form-check-inline align-self-end">
                    <input class="form-check-input" type="radio" name="option" id="rekap" value="rekap">
                    <label class="form-check-label" for="rekap">Rekapitulasi</label>
                </div>
            </div>
        </div>
        <div class='row mt-2'>
            <div class='col-sm-2 mt-2'>
                <label>Nama Karyawan</label>
            </div>
            <div class='col-sm-7'>
                <input type="text" id="nama" name="nama" class="form-control" autocomplete="off">
                <hr>
            </div>
            <div class='col'>
                <div class="btn-group" role="group" aria-label="Basic example">
                    <button type="button" class="btn btn-danger btn-sm" onclick="window.location.href='../index.asp'">Kembali</button>
                    <% if bulan <> "" OR tahun <> "" then%>
                    <button type="button" class="btn btn-primary btn-sm" onclick="window.location.href='exportXls-proses.asp?bulan=<%=bulan%>&tahun=<%=tahun%>&nama=<%=nama%>&radio=<%=radio%>'">Export</button>
                    <% end if %>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="icon-cogs"></i> Proses</button>
                </div>
            </div>
        </div>
        </form>
    </div>
    <!--kontent -->
    <%if tahun <> "" then%>
    <div class='header'>
        <div class='row mt-2 '>
            <div class='col'>
                <ul style="list-style:none;">
                    <li>PT Dakota Buana Semesta</li>
                    <li>JL.WIBAWA MUKTI II NO 8.JATI ASIH BEKASI</li>
                    <li>BEKASI</li>
                </ul>
            </div>
        </div>
    <% if radio = "detail" then  %>
        <div class='row'>
            <div class='col text-center'>
                <label><b><u>MUTASI PINJAMAN KARYAWAN DETAIL</u></b></label></br>
                <%if bulan <> "" then%>
                <label>Priode Bulan <%= MonthName(bulan) &" Tahun "& tahun%></label>
                <%else%>
                    <label>Priode Tahun <%= tahun%></label>
                <%end if%>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <label>Tanggal Cetak</label>
                <label><%= month(now) &"/"& day(now) &"/"& year(now) %></label>
            </div>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Tanggal</th>
                        <th scope="col">No Transaksi</th>
                        <th scope="col">Keterangan</th>
                        <th scope="col">Pinjaman</th>
                        <th scope="col">Pembayaran</th>
                        <th scope="col">Saldo Akhir</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if nama = "" then
                        do while not mutasi.eof 
                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_PK WHERE "& filterBln &" Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                            set pk = mutasi_cmd.execute

                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_BK WHERE "& filterBln &" Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                            set bk = mutasi_cmd.execute 
                    %>
                            <tr>
                                <th colspan="2">
                                    Nama/Nip : <%= mutasi("SAPK_Nip") %>
                                </th>
                                <th colspan="4">
                                    <%= mutasi("Kry_Nama") %>
                                </th>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                                <td>Saldo Awal</td>
                                <td colspan="3"><%= replace(formatCurrency(mutasi("SAPK_Awal")),"$","") %></td>
                            </tr>   
                            <% 
                                pinjam = 0  
                                do while not pk.eof 
                                pinjam = pinjam + pk("TPK_PP")
                            %>
                                <tr>
                                    <td><%= pk("TPK_Tanggal") %></td>
                                    <td><%= pk("TPK_ID") %></td>
                                    <td><%= pk("TPK_Ket") %></td>   
                                    <td colspan="3"><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>   
                                </tr>   
                                <%
                                pk.movenext
                                loop
                                ' total pinjaman
                                tpinjaman = mutasi("SAPK_Awal") + pinjam

                                bayar = 0
                                do while not bk.eof
                                bayar = bayar + bk("TPK_PP")
                                %>
                            <tr>
                                    <td><%= bk("TPK_Tanggal") %></td>
                                    <td><%= bk("TPK_ID") %></td>
                                    <td><%= bk("TPK_Ket") %></td>   
                                    <td></td>
                                    <td colspan="2"><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td>   
                            </tr> 
                                <% 
                                bk.movenext
                                loop
                                ' total bayar
                                tbayar = bayar

                                %>
                            <tr>
                                <td colspan="2"></td>
                                <th>Subtotal</th>   
                                <th><%= replace(formatCurrency(tpinjaman),"$","") %></th>   
                                <th><%= replace(formatCurrency(tbayar),"$","") %></th>   
                                <th><%=replace(formatCurrency(mutasi("tsaldoakhir")),"$","") %></th>   
                            </tr>   
                        <% 
                        response.flush
                        mutasi.movenext 
                        loop  
                    else
                        if mutasi.eof then 
                        %>
                            <th colspan="6" rowspan="3" class="text-center" data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h5>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h5></th>
                        <% 
                        else
                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_PK WHERE "& filterBln &" Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"
                            set pk = mutasi_cmd.execute

                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_BK WHERE "& filterBln &" Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                            set bk = mutasi_cmd.execute                        
                    %>
                            <tr>
                                <th colspan="2">
                                    Nama/Nip : <%= mutasi("SAPK_Nip") %>
                                </th>
                                <th colspan="4">
                                    <%= mutasi("Kry_Nama") %>
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>Saldo Awal</td>
                                <td colspan="3"><%= replace(formatCurrency(mutasi("SAPK_Awal")),"$","") %></td>
                            </tr>   
                            <% 
                            tpinjaman = 0
                            tbayar = 0
                            saldoakhir = 0
                            pinjam = 0
                            do while not pk.eof
                                pinjam = pinjam + pk("TPK_PP")    
                            %>
                                <tr>
                                    <td><%= pk("TPK_Tanggal") %></td>
                                    <td><%= pk("TPK_ID") %></td>
                                    <td><%= pk("TPK_Ket") %></td>   
                                    <td colspan="3"><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>   
                                </tr>     
                            <%
                            response.flush
                            pk.movenext
                            loop
                            
                            ' total pinjaman
                            tpinjaman = mutasi("SAPK_Awal") + pinjam

                            do while not bk.eof
                            bayar = bayar + bk("TPK_PP")
                            %>  
                            <tr>
                                <td><%= bk("TPK_Tanggal") %></td>
                                <td><%= bk("TPK_ID") %></td>
                                <td><%= bk("TPK_Ket") %></td>   
                                <td></td>
                                <td colspan="2"><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td>  
                            </tr>
                            <%
                            response.flush
                            bk.movenext
                            loop
                            
                            ' total pembayaran
                            tbayar = bayar

                            ' cek saldo akhir
                            saldoakhir = tpinjaman - tbayar
                            %>   
                            <tr>
                                <td></td>
                                <td></td>
                                <th>Subtotal</th>   
                                <th><%= replace(formatCurrency(tpinjaman),"$","") %></th>   
                                <th><%= replace(formatCurrency(tbayar),"$","") %></th>   
                                <th><%= replace(formatCurrency(saldoakhir),"$","") %></th>   
                            </tr>   
                        <% 
                            end if
                        end if
                        %>
                </tbody>
            </table>
        </div>
    </div>
    <% else %>
    <div class='row'>
        <div class='row'>
            <div class='col text-center'>
                <label><b><u>MUTASI PINJAMAN KARYAWAN REKAPITULASI</u></b></label></br>
                <%if bulan <> "" then%>
                    <label>Priode Bulan <%= MonthName(bulan) &" Tahun "& tahun%></label>
                <%else%>
                    <label>Priode Tahun <%= tahun%></label>
                <%end if%>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <label>Tanggal Cetak</label>
                <label><%= month(now) &"/"& day(now) &"/"& year(now) %></label>
            </div>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">NIP</th>
                        <th scope="col">Nama Karyawan</th>
                        <th scope="col">Saldo Awal</th>
                        <th scope="col">Pinjaman</th>
                        <th scope="col">Pembayaran</th>
                        <th scope="col">Saldo Akhir</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if nama = "" then
                            nol = 0 'untuk value yang tidak ada isinya
                            tsaldoawal = 0 'totalkeseluruhan saldo awal
                            tsaldoakhir = 0 'totalsaldo akhir
                            tbayar = 0
                            pinjam = 0
                            bayar = 0
                            saldoakhir = 0

                            do until mutasi.eof 
                    %>
                            <tr>
                                <td><%= mutasi("SAPK_Nip") %></td>
                                <td><%= mutasi("Kry_Nama") %></td>
                                <td><%= replace(formatCurrency(mutasi("totalpinjamstaun")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("pinjam")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("bayar")),"$","") %></td> 
                                <td><%= replace(formatCurrency(mutasi("tsaldoakhir")),"$","") %></td>   
                            </tr>
                        <% 
                                'cek total smua 
                                tsaldoawal = tsaldoawal + mutasi("totalpinjamstaun")
                                tpinjaman = tpinjaman + mutasi("pinjam")
                                tbayar = tbayar + mutasi("bayar")
                                tsaldoakhir = tsaldoakhir + mutasi("tsaldoakhir")

                            response.flush
                            mutasi.movenext 
                            loop  
                        %>
                            <tr>
                                <td></td>
                                <th>Total keseluruhan</th>
                                <th><%= replace(formatcurrency(tsaldoawal),"$","") %></th>
                                <th><%= replace(formatcurrency(tpinjaman),"$","") %></th>
                                <th><%= replace(formatcurrency(tbayar),"$","") %></th>
                                <th><%= replace(formatcurrency(tsaldoakhir),"$","") %></th>
                            </tr>
                        <%
                        else
                            if mutasi.eof then 
                        %>
                            <th colspan="6" rowspan="3" class="text-center" data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h5>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h5></th>
                        <% 
                            else

                            tpinjaman = 0
                            tbayar = 0
                            saldoakhir = 0
                            pinjam = 0
                            bayar = 0
                        %>
                            <tr>
                                <td><%= mutasi("SAPK_Nip") %></td>
                                <td><%= mutasi("Kry_Nama") %></td>
                                <td><%= replace(formatCurrency(mutasi("totalpinjamstaun")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("pinjam")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("bayar")),"$","") %></td> 
                                <td><%= replace(formatCurrency(mutasi("tsaldoakhir")),"$","") %></td> 
                            </tr>
                            <tr>
                                <td></td>
                                <th>Total keseluruhan</th>
                                <td><%= replace(formatCurrency(mutasi("totalpinjamstaun")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("pinjam")),"$","") %></td>
                                <td><%= replace(formatCurrency(mutasi("bayar")),"$","") %></td>
                                <td>
                                    <% if mutasi("tsaldoakhir") <> 0 then 
                                        Response.Write  replace(formatCurrency(mutasi("tsaldoakhir")),"$","")
                                    else
                                        Response.Write "LUNAS"
                                    end if %>
                                </td>   
                            </tr>
                        <% 
                            end if
                        end if
                        %>
                </tbody>
            </table>
        </div>
    </div>
    <% end if %>
    <!--end kontent -->
    <% end if %>
</div>

<!-- #include file='../../../layout/footer.asp' -->