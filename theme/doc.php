<?php

  // pathinfo использует текущие настройки локали.
  // Для корректной работы при использовании многобайтных кодировок
  // необходимо явно устанавливать локаль через setlocale
  // Посмотреть список установленных локалей можно так:
  // locale -a
  setlocale(LC_ALL, 'ru_RU.utf8');

  $ruri = urldecode($_SERVER['REQUEST_URI']);
  $dir_path = pathinfo($ruri, PATHINFO_DIRNAME);
  $dirs = array_filter(explode('/', $dir_path), function($v) {return $v != '';});
  $last_dir = end($dirs);
  $file_name = pathinfo($ruri, PATHINFO_FILENAME);
  $doc_url = '/' . implode('/', array_slice($dirs, 0, 2)) . '/index.html';
  $doc_header = reset($dirs);
  $header = $file_name ? $file_name : '';

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
  <p><a href="<?= $doc_url ?>">Документация <?= $doc_header ?></a></p>
  <h1><?= $header ?></h1>
  <div id="toc"></div>

  <?php
    include_once $_SERVER['DOCUMENT_ROOT'] . $_SERVER['REDIRECT_URL'];
  ?>

  <!-- jQuery -->
  <script src="/theme/bower/jquery/dist/jquery.min.js"></script>
  <!-- Подсветка синтаксиса кода -->
  <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
  <!-- DOC -->
  <script src="/js/_libs/doc/doc.js" type="text/javascript"></script>
  <!-- TOC -->
  <script src="/js/_libs/toc/toc.js" type="text/javascript"></script>
  <!-- copyToClipboard -->
  <script src="/theme/copyToClipboard/js.js" type="text/javascript"></script>
  <!-- custom -->
  <script src="/theme/js/custom.js" type="text/javascript"></script>
</body>
</html>
