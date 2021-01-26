<?php
echo "<pre>";
print_r(file_get_contents('http://sign-forum.ru/api/v1/api.php?action=getLastPosts'));
echo "</pre>";
die();

// Сжатый gzip-ом файл
$log_path = $phpbb_root_path . DIRECTORY_SEPARATOR . 'log' . DIRECTORY_SEPARATOR . $file_name;
$log_content = file_get_contents('compress.zlib://' . $log_path);
