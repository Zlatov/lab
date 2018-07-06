<?php

echo PHP_EOL . 'Текущая директория __DIR__' . PHP_EOL;
echo '__DIR__: ' . var_export(__DIR__, true) . PHP_EOL;

/* Именно такой способ чтения элементов каталога является правильным. */
echo PHP_EOL . 'Чтение текущей директории' . PHP_EOL;
$current_dir_handler = opendir(__DIR__);
if ($current_dir_handler) {
  while (false !== ($file_name = readdir($current_dir_handler))) {
    echo $file_name;
    echo PHP_EOL;
  }
  closedir($current_dir_handler);
}

echo PHP_EOL . 'Чтение подкатегории sub_dir' . PHP_EOL;
$sub_dir = opendir(__DIR__ . DIRECTORY_SEPARATOR . 'sub_dir');
while (false !== ($file_name = readdir($sub_dir))) {
  echo $file_name;
  echo PHP_EOL;
}

echo PHP_EOL . 'Проверка существования директории' . PHP_EOL;
$a = 'sub_dir';
$b = file_exists($a) && is_dir($a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;

echo PHP_EOL . 'Удаление директории' . PHP_EOL;
echo 'Удаление несуществующей' . PHP_EOL;
$a = 'temp';
if (is_dir($a)) rmdir($a);
$b = @rmdir($a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
echo 'Удаление существующей' . PHP_EOL;
mkdir($a);
$b = rmdir($a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;

echo PHP_EOL . 'Создание директории' . PHP_EOL;
$a = 'temp';
$b = mkdir($a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
