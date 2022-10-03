<!-- #include file='../connection.asp' -->
<!-- #include file="../landing.asp" -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KATEGORI</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
      @import url('https://fonts.googleapis.com/css?family=Heebo:400,700|Open+Sans:400,700');

      :root {
        --color: #3c3163;
        --transition-time: 0.5s;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        min-height: 100vh;
        font-family: 'Open Sans';
        background: #fafafa;
      }

      a {
        color: inherit;
      }

      .cards-wrapper {
        display: grid;
        justify-content: center;
        align-items: center;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        grid-gap: 4rem;
        padding: 2rem;
        margin: 0 auto;
        width: max-content;
      }

      .card {
        font-family: 'Heebo';
        --bg-filter-opacity: 0.5;
        background-image: linear-gradient(rgba(0,0,0,var(--bg-filter-opacity)),rgba(0,0,0,var(--bg-filter-opacity))), var(--bg-img);
        height: 15em;
        width: 10em;
        font-size: 1.5em;
        color: white;
        border-radius: 1em;
        padding: 1em;
        /*margin: 2em;*/
        display: flex;
        align-items: flex-end;
        background-size: cover;
        background-position: center;
        box-shadow: 0 0 3em -1em black;
        transition: all, var(--transition-time);
        position: relative;
        overflow: hidden;
        border: 5px solid #ccc;
        text-decoration: none;
      }

      .card:hover {
        transform: rotate(0);
      }

      .card h1 {
        margin: 0;
        font-size: 1.5em;
        line-height: 1.2em;
      }

      .card p {
        font-size: 0.75em;
        font-family: 'Open Sans';
        margin-top: 0.5em;
        line-height: 2em;
      }

      .card .tags {
        display: flex;
      }

      .card .tags .tag {
        font-size: 0.75em;
        background: rgba(255,255,255,0.5);
        border-radius: 0.3rem;
        padding: 0 0.5em;
        margin-right: 0.5em;
        line-height: 1.5em;
        transition: all, var(--transition-time);
      }

      .card:hover .tags .tag {
        background: var(--color);
        color: white;
      }

      .card .date {
        position: absolute;
        top: 0;
        right: 0;
        font-size: 0.75em;
        padding: 1em;
        line-height: 1em;
        opacity: .8;
      }

      .card:before, .card:after {
        content: '';
        transform: scale(0);
        transform-origin: top left;
        border-radius: 50%;
        position: absolute;
        left: -50%;
        top: -50%;
        z-index: -5;
        transition: all, var(--transition-time);
        transition-timing-function: ease-in-out;
      }

      .card:before {
        background: #ddd;
        width: 250%;
        height: 250%;
      }

      .card:after {
        background: white;
        width: 200%;
        height: 200%;
      }

      .card:hover {
        color: var(--color);
      }

      .card:hover:before, .card:hover:after {
        transform: scale(1);
      }

      .info {
        font-size: 1.2em;
        display: block;
        padding: 1em 3em;
        height: 4em;
      }

      .info img {
        height: 3em;
        margin-right: 0.5em;
      }

      .info h1 {
        font-size: 1em;
        font-weight: normal;
      }

      /* MEDIA QUERIES */
      @media screen and (max-width: 1285px) {
        .cards-wrapper {
          grid-template-columns: 1fr 1fr;
        }
      }

      @media screen and (max-width: 900px) {
        .cards-wrapper {
          grid-template-columns: 1fr;
        }
        .info {
          justify-content: center;
        }
        .card-grid-space .num {
          /margin-left: 0;
          /text-align: center;
        }
      }

      @media screen and (max-width: 500px) {
        .cards-wrapper {
          padding: 4rem 2rem;
        }
        .card {
          max-width: calc(100vw - 4rem);
        }
      }

      @media screen and (max-width: 450px) {
        .info {
          display: block;
          text-align: center;
        }
        .info h1 {
          margin: 0;
        }
      }
    </style>
</head>

<body>

<section class="info">
  <h3 class="text-center">KATEGORI PROSES TRANSAKSI KARYAWAN</h3>
</section>
<section class="cards-wrapper">
  <%if session("HT1") = true then%>
  <div class="card-grid-space">
    <a class="card" href="klaim" style="--bg-img: url(../logo/dolarpinjaman.jpg)">
      <div>
        <h2>KLAIM PINJAMAN</h2>
        <p>SEMUA RINCIAN PINJAMAN KARYAWAN</p>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HT2") = true then%>
  <div class="card-grid-space">
    <a class="card" href="elektro" style="--bg-img: url(../logo/elektro.jpg)">
      <div>
        <h2>PINJAMAN ELEKTRONIK</h2>
          <p>Proses untuk karyawan yang mengambil dan membayar barang barang elektronik</p>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HT3") = true then%>
  <div class="card-grid-space">
    <a class="card" href="bank" style="--bg-img: url(../logo/bank.jpg)">
      <div>
        <h2>PINJAMAN BANK</h2>
        <p>Pinjaman karyawan ke bank</p>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HT4") = true then%>
  <div class="card-grid-space">
    <a class="card" href="personal" style="--bg-img: url(../logo/personal.jpg)">
      <div>
        <h2>PINJAMAN PRIBADI</h2>
        <p>Pinjaman Pribadi karyawan</p>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
</section>
<!-- #include file='../layout/footer.asp' -->