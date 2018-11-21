<?php

// 
// print_r — Выводит удобочитаемую информацию о переменной
// mixed print_r ( mixed $expression [, bool $return = FALSE ] )
// 
// var_dump — Вструктурированную информацию об одном или нескольких выражениях, включая их тип и значение
// var_dump ( mixed $expression [, mixed $... ] )
// 
// var_export — Выводит или возвращает интерпретируемое строковое представление переменной
// mixed var_export ( mixed $expression [, bool $return = FALSE ] )
// 

$a = [
    "asd" => "asd",
    "zxc" => "zxc qwe"
];

echo print_r($a, true) . PHP_EOL;

var_dump($a); echo PHP_EOL;

echo var_export($a, true) . PHP_EOL;

// ----

echo '$a: ' . var_export($a, true) . PHP_EOL;
