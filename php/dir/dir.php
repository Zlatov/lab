<?php

echo __DIR__;
echo PHP_EOL;

$current_dir = opendir(__DIR__);
$sub_dir = opendir(__DIR__ . DIRECTORY_SEPARATOR . 'sub_dir');

/* Именно такой способ чтения элементов каталога является правильным. */
while (false !== ($file_name = readdir($current_dir))) {
  echo $file_name;
  echo PHP_EOL;
}

while (false !== ($file_name = readdir($sub_dir))) {
  echo $file_name;
  echo PHP_EOL;
}
