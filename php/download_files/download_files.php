<?php

// 
// $sub_dir = 'Saharov - Svarog';
// 
// $tpl_url = 'https://audioknigi-online.site/audio/1/Popadanci/Saharov/Svarog/1/-=value=-.mp3';
// 
// $array = [
//  '01.01',
//  '01.02',
// ];
// 
// или
// 
// $array1 = range(101,109);
// $array2 = range(201,210);
// $array3 = range(301,312);
// $array = array_merge($array1, $array2, $array3);
// 
// или
// 
// $array = range(9,25);
// 

// START Настройки

$sub_dir = 'Saharov - Svarog';
$tpl_url = 'https://audioknigi-online.site/audio/1/Popadanci/Saharov/Svarog/1/-=value=-.mp3';
$array = range(1,29);
$time_limit = 60*20;

// FINISH Настройки

set_time_limit($time_limit);
echo $time_limit . '<br>';

if (!is_dir($sub_dir)) mkdir($sub_dir);
$sub_dir_handler = opendir($sub_dir);
if ($sub_dir_handler) {
  while (false !== ($file_name = readdir($sub_dir_handler))) {
    if ($file_name !== '.' && $file_name !== '..' && is_file($sub_dir . DIRECTORY_SEPARATOR . $file_name)) {
      unlink($sub_dir . DIRECTORY_SEPARATOR . $file_name);
    }
  }
}

flush();
ob_flush();

foreach ($array as $value) {
  $url = str_replace('-=value=-', $value, $tpl_url);
	echo 'start ' . $url;
  // TODO не сбрасывает 'start url' ждёт конца file_put_contents и выводит с '…done.'
  flush();
  ob_flush();
	file_put_contents("{$sub_dir}/{$value}.mp3", fopen("$url", 'r'));
	echo ' done.' . '<br>';
  flush();
  ob_flush();
}
ob_end_clean();
