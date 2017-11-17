<?php
  $pathinfo = pathinfo($_SERVER['REDIRECT_URL']);
  $explode = explode('/',$pathinfo['dirname']);
  $last = end($explode);
  // echo 'end($explode): <pre>';
  // print_r(end($explode));
  // array_shift($explode)
  // print_r(end($explode));
  // echo '</pre>';
  // die();
  $header = $last?$last:'';
?>

<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="utf-8">
  <title><?= $header ?></title>
  <!-- Favicon -->
  <link rel="shortcut icon" href="/theme/favicon.ico" type="image/x-icon">
  <!-- TOC -->
  <link rel="stylesheet" type="text/css" href="/js/_libs/toc/toc.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" type="text/css" href="/theme/font-awesome/css.css">
</head>
<body>
  <h1><?= $header ?></h1>
  <div id="toc"></div>

  <?php
    include_once $_SERVER['DOCUMENT_ROOT'] . $_SERVER['REDIRECT_URL'];
  ?>

  <!-- jQuery -->
  <script src="/theme/bower/jquery/dist/jquery.min.js"></script>
  <!-- Подсветка синтаксиса кода -->
  <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
  <!-- TOC -->
  <script src="/js/_libs/toc/toc.js" type="text/javascript"></script>
  <!-- copyToClipboard -->
  <script src="/theme/copyToClipboard/js.js" type="text/javascript"></script>
  <!-- custom -->
  <script src="/theme/js/custom.js" type="text/javascript"></script>
</body>
</html>
