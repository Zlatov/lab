<?php

require_once "../../../vendor/autoload.php";

use Zlatov\ResizeImg;

// $a = 'Zlatov\ResizeImg\ResizeImg_Errors'; print(class_exists($a) ? "+: $a" : "-: $a");

Twig_Autoloader::register();

$loader = new Twig_Loader_Filesystem(__DIR__ . '/views');
$twig = new Twig_Environment($loader, array(
  'cache' => __DIR__ . '/cache/views/',
  'auto_reload' => true
));

$images = [];

if (isset($_POST)&&!empty($_POST)) {
  $images_path = __DIR__ . DIRECTORY_SEPARATOR . 'images';
  $destination_path = __DIR__ . DIRECTORY_SEPARATOR . 'destination';
  $images_dir = opendir($images_path);

  $is_resize = isset($_POST['do']) && ($_POST['do'] == 'resizeandthumbnails' || $_POST['do'] == 'resize');
  $is_thumb = isset($_POST['do']) && ($_POST['do'] == 'resizeandthumbnails' || $_POST['do'] == 'thumbnails');

  while ($file_name = readdir($images_dir)) {
    if (
      !is_file($images_path . DIRECTORY_SEPARATOR . $file_name) ||
      ($file_name == ".") ||
      ($file_name == "..") ||
      !in_array(mb_strtolower(pathinfo($file_name)['extension']), ['png','jpg','jpeg'])
    ) {
      continue;
    }

    $img = new ResizeImg($images_path . DIRECTORY_SEPARATOR . $file_name);
    if ($is_resize) {
      array_push($images, $img->resize([
        'width' => (int)$_POST['imgwidth'],
        'height' => (int)$_POST['imgheight'],
        'scaleType' => $_POST['imgtype'],
        'destination' => $destination_path,
      ]));
    }
    if ($is_thumb) {
      array_push($images, $img->resize([
        'width' => (int)$_POST['thumbnailwidth'],
        'height' => (int)$_POST['thumbnailheight'],
        'scaleType' => $_POST['thumbnailtype'],
        'nameSuffix' => '_thumbnail',
        'destination' => $destination_path,
      ]));
    }
  }
  closedir($images_dir);
}

echo $twig->render('index/index.html', [
  'images' => $images
]);
