<% 
    nip = Request.QueryString("nip")

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FORM RUBAH PASSWORD</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    .personalPassword{
        background-color:#070F82;
        padding:20px;
        border-radius:10px;
        color:#fff;
        width:50%;
        position: absolute;
        top: 50%;
        left: 50%;
        -moz-transform: translateX(-50%) translateY(-50%);
        -webkit-transform: translateX(-50%) translateY(-50%);
        transform: translateX(-50%) translateY(-50%);
    }
    .personalPassword input{
        background:transparent;
        border:none;
        color:#fff;
    }
    .changeType{
        border:none;
        color:#fff;
    }
    .changeType:hover{
        background:none;
    }
    .changeType:focus{
        background:transparent;
        box-shadow: inset 0 0 0;
        
    }
    .personalPassword hr{
        margin-top:-3px;
    }
    .personalPassword input:focus{
        background:transparent;
        box-shadow: inset 0 0 0;
        color:#fff;
    }
    h3{
        font-family:"Righteous";
        color:#fff;
    }
    #personal-form{
        width:100%;
    }  
    .footer{
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background: #263238;
        text-align: center;
        color: #f4f4f4;
    } 
    .icons{
        padding-top: 1rem;
    }
    .company-name{
        font-size: 12px;
        margin-top: 0.5rem;
    }
    @media screen and (max-width: 995px), 
        screen and (max-height: 700px){
            .personalPassword{
               width:90%;
               font-size:12px;
               top:50%;
               left:53%;
            }
            .company-name{
                font-size: 10px;
            }
    }
    @media screen and (orientation:landscape) {
        form{
            margin-top:70rem;
        }
    }
    </style>
    <script>
    function notiv(){
        $(".container").hide();
        Swal.fire({
            title: 'Yakin untuk merubah password??',
            text: "merubah password akan berpengaruh pada data login loading barang",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
                $(".container").show();
            }else{
                window.location.href = `index.asp`
            }
        });
    }
    </script>
</head>

<body onload="return notiv()">

<div class='container'>
    <div class='row personalPassword'>
        <div class='row'>
            <div class='col-sm-12 text-center'>
                <h3>FORM RUBAH PASSWORD</h3>
            </div>
        </div>
        <form action="password_add.asp" method="post" id="personal-form" autocomplete="off">
            <div class="mb-3">
                <label for="nip" class="form-label">Nip</label>
                <input type="hidden" class="form-control" id="pnip" name="pnip" maxlength="10" value="<%= nip %>">
                <input type="text" class="form-control" id="nip" name="nip" maxlength="10" autocomplete="off" value="<%= nip %>" style="background-color:transparent;" readonly>
                <hr>
                <div class="form-text text-danger">Pastikan nip yang anda masukan benar</div>
            </div>
            <div class="mb-3">
                <label for="paswordlama" class="form-label">Pasword Lama</label>
                <div class="input-group mb-3 imb1">
                    <input type="password" class="form-control" id="paswordlama" name="paswordlama" autocomplete="off" required aria-describedby="button-addon2">
                    <button class="btn btn-sm changeType" type="button" onclick="return changeinput('1')" id="btnpasslama"><i class="fa fa-eye-slash" aria-hidden="true"></i></button>
                </div>
                <hr>
            </div>
            <div class="mb-3">
                <label for="passwordbaru" class="form-label">Password Baru</label>
                <div class="input-group mb-3">
                    <input type="password" class="form-control" id="passwordbaru" name="passwordbaru" autocomplete="off" required>
                    <button class="btn btn-sm changeType" type="button" onclick="return changeinput('2')" id="btnpassbaru"><i class="fa fa-eye-slash" aria-hidden="true"></i></button>
                </div>
                <hr>
            </div>
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto"><button type="button" class="btn btn-sm btn-secondary" onclick="window.location.href=`index.asp?nip=<%= nip %>`">Kembali</button></div>
                <div class=""><button type="submit" class="btn btn-sm btn-danger">Submit</button></div>
            </div>
        </form>
    </div>
</div>
<footer class="footer">
        <div class="icons">
            <p class="company-name">
                Copyright &copy; 2022, ALL Rights Reserved MuhamadFirdaus-IT Division </br>
                V.1 Mobile Responsive 2022
            </p>
        </div>
</footer>
<script>
function changeinput(e){
    if (e == 1){
        if ($('#paswordlama').attr("type") == "text" ){
            $('#paswordlama').attr('type','password');
            $("#btnpasslama").html(`<i class="fa fa-eye-slash" aria-hidden="true"></i>`);
        }else{
            $('#paswordlama').attr('type','text');
            $("#btnpasslama").html(`<i class="fa fa-eye" aria-hidden="true"></i>`);
        }
    }
    if (e == 2){
        if($('#passwordbaru').attr('type') == "text"){
            $('#passwordbaru').attr('type','password');
            $("#btnpassbaru").html(`<i class="fa fa-eye-slash" aria-hidden="true"></i>`);
        }else{
            $('#passwordbaru').attr('type','text');
            $("#btnpassbaru").html(`<i class="fa fa-eye" aria-hidden="true"></i>`);
        }
    }
}
</script>
<!-- #include file='../layout/footer.asp' -->