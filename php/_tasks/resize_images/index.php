<?php

require_once "../../../vendor/autoload.php";

use zlatov\ResizeImg;

// $a = 'Zlatov\ResizeImg\ResizeImg_Errors'; print(class_exists($a) ? "+: $a" : "-: $a");

Twig_Autoloader::register();

$loader = new Twig_Loader_Filesystem(__DIR__ . '/views');
$twig = new Twig_Environment($loader, array(
  'cache' => __DIR__ . '/views/cache',
  'auto_reload' => true
));

if (isset($_POST)&&!empty($_POST)) {
  $path = __DIR__;
  $dir = opendir($path);
  chdir($path);

  $paramImg = [
    'width' => (int)$_POST['imgwidth'],
    'height' => (int)$_POST['imgheight'],
    'kind' => $_POST['imgtype'],
    'subFolder' => (isset($_POST['subfolder'])&&($_POST['subfolder']==='true'))?true:false,
    'nameSufix' => false,
  ];
  $paramThumbnail = [
    'width' => (int)$_POST['thumbnailwidth'],
    'height' => (int)$_POST['thumbnailheight'],
    'kind' => $_POST['thumbnailtype'],
    'subFolder' => (isset($_POST['subfolder'])&&($_POST['subfolder']==='true'))?true:false,
    'nameSufix' => true,
  ];

  while ($f = readdir($dir))
  {
    if (is_file($f) && ($f !== ".") && ($f !== "..") && in_array(mb_strtolower(pathinfo($f)['extension']), ['png','jpg','jpeg']))
    {
      $pathToFile = $path . DIRECTORY_SEPARATOR . $f;
      try {
        $img = new ResizeImg($pathToFile);
        switch ($_POST['do']) {
          case 'resizeandthumbnails':
            $img->resize($paramImg);
            echo '<p>' . $img->imgTag . '</p>';
            $img->resize($paramThumbnail);
            echo '<p>' . $img->imgTag . '</p>';
            break;
          case 'thumbnails':
            $img->resize($paramThumbnail);
            echo '<p>' . $img->imgTag . '</p>';
            break;
          case 'resize':
            $img->resize($paramImg);
            echo '<p>' . $img->imgTag . '</p>';
            break;
        }
        $img = null;
      } catch (Exception $e) {
        echo "<p>Ошибка: " . $e->getMessage() . "</p>";
      }
    }
  }
}

echo $twig->render('index/index.html', []);
