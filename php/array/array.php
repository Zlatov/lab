<?php

$a = [];
array_push($a, 0);
var_dump($a);
var_dump(array_keys($a));
echo var_export(array_keys($a), true) . PHP_EOL;
// exit;

$a = array();
$a[] = 0;
var_dump($a);

$a = [1, 2, 3];
$b = end($a);
echo '$a: ' . PHP_EOL; var_dump($a);
echo '$b: ' . PHP_EOL; var_dump($b);

$a = [1, 2, 3];
$b = end($a);
$c = key($a);
echo '$a: ' . PHP_EOL; var_dump($a);
echo '$b: ' . PHP_EOL; var_dump($b);
echo '$c: ' . PHP_EOL; var_dump($c);

$a = [1,2,3];
foreach ($a as $key => $value) {
    echo "${key} ${value}" . PHP_EOL;
}
