<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="<%= url %>/layout/font-awesome/css/font-awesome.min.css">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Righteous&display=swap');
    body{
        background-color:#ebebeb;
    }
    .container {
        width: 415px;
        box-shadow: 0px 0px 18px 0px grey;
        border-radius: 24px;
        position: relative;
        background: inherit;
        padding: 12px;
        overflow: hidden;
        background: #070F82;
        margin-top:20vh;
    }
    .container:before {
        content: "";
        position: absolute;
        background: inherit;
        z-index: -1;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        box-shadow: inset 0 0 2000px rgba(255, 255, 255, .5);
        filter: blur(10px);
        margin: -20px;
    }
    .textbox{   
        width:auto;
        overflow:hidden;
        font-size:20px;
        padding:8px 0;
        margin:8px 0;
        border-bottom: 1px solid #fff;
    }
    .textbox i {
        width:26px;
        float:left;
        margin-top:5px;
        color:#fff;
        text-align:center;
    }
    .textbox input{
        border:none;
        outline:none;
        background:none;
        color:white;
        font-size:18px;
        width:88%;
        margin:0 10px;
    }
    .textbox select{
        border:none;
        outline:none;
        background:transparent;
        background-color:#5baeff;
        color:#fff;
        font-size:18px;
        width:auto;
        margin:0 10px;
    }
    .sigin{
        width:100%;
        background:#e07000;
        color:white;
        font-size:18px;
        cursor:pointer;
        margin:12px 0;
    }
    h3
    {
        font-family:"Righteous";
        color:#fff;
    }
    img
    { 
        width:200px;
    }
    /* Portrait and Landscape */
    @media (min-device-width: 375px) and (max-device-width: 812px) and (-webkit-min-device-pixel-ratio: 3)
    { 
        .container:before {
            width: 10px;
        }
        .container {
            width: 360px;
            box-shadow: 0px 0px 18px 0px grey;
            border-radius: 24px;
            position: relative;
            background: inherit;
            padding: 12px;
            overflow: hidden;
            background: #5baeff;
            margin-top:20vh;
            margin-left:8px;
            margin-right:auto;
        }
        .textbox i {
            float:left;
            margin-top:5px;
            color:#fff;
            text-align:center;
        }
        .textbox{   
            width:auto;
            overflow:hidden;
            font-size:20px;
            padding:8px 0;
            margin:8px 0;
            border-bottom: 1px solid #fff;
        }
        .textbox input{
            border:none;
            outline:none;
            background:none;
            color:white;
            font-size:14px;
            width:85%;
            margin:0 10px;
        }
        .textbox select{
            border:none;
            outline:none;
            background:transparent;
            background-color:#5baeff;
            color:#fff;
            font-size:14px;
            width:auto;
            margin:0 10px;
        }
        .btn{
            width:100%;
            background:#800000;
            color:white;
            font-size:14px;
            cursor:pointer;
            margin:12px 0;
        }
    }
    @media (min-width: 411px) and (max-width: 731px) {
        .container {
            width: 80%;
            box-shadow: 0px 0px 18px 0px grey;
            border-radius: 24px;
            position: relative;
            background: inherit;
            padding: 12px;
            overflow: hidden;
            background: #5baeff;
            margin-top:20vh;
        }
        .textbox i {
            float:left;
            margin-top:5px;
            color:#fff;
            text-align:center;
        }
        .textbox{   
            width:auto;
            overflow:hidden;
            font-size:20px;
            padding:8px 0;
            margin:8px 0;
            border-bottom: 1px solid #fff;
        }
        .textbox input{
            border:none;
            outline:none;
            background:none;
            color:white;
            font-size:14px;
            width:85%;
            margin:0 10px;
        }
        .textbox select{
            border:none;
            outline:none;
            background:transparent;
            background-color:#5baeff;
            color:#fff;
            font-size:14px;
            width:auto;
            margin:0 10px;
        }
        img
        { 
            width:150px;
            position:fixed;
        }
    }
    
    </style>
</head>

<body>
<div class='container'>
    <div class='row'>
        <div class='col mt-3 text-center'>
            <h3>LOGIN</h3>
        </div>
    </div>
    <div class='row'>
        <form action="../login_add.asp" method="post">
            <div class='col'>
                <div class='textbox mb-4'>
                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                    <input type="text" name="username" id="username"autocomplete="off">
                </div>
                <div class='textbox mb-4'>
                    <i class="fa fa-lock" aria-hidden="true"></i>
                    <input type="password" name="password" id="password"autocomplete="off">
                </div>
                    <input class="btn sigin" type="submit" name="submit" id="submit" value="SIGN-IN" onclick="return validasilogin()">
            </div>
        </form>
    </div>
</div>
    <div class='row'>
        <div class='col text-center mt-3'>
            <img src="../logo/landing.png">
        </div>
    </div>
<script>
    function validasilogin() {
        var nama = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		if (nama != "" && password!="") {
			return true;
		}else{
			alert('Data harus diisi dahulu !');
            return false;
		}
    }
</script>
<!-- #include file='../layout/footer.asp' -->
