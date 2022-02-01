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
// exit(0);

echo '> Последний ключ' . PHP_EOL;
$a = [1, 2, 3];
end($a);
$last_key = key($a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$last_key: ' . var_export($last_key, true) . PHP_EOL;
// exit(0);

echo '> Merge' . PHP_EOL;
$a = [1,2,3];
$b = [2,3];
$c = array_merge($a, $b);
echo '$a: ' . print_r($a, true) . PHP_EOL;
echo '$b: ' . print_r($b, true) . PHP_EOL;
echo '$c: ' . print_r($c, true) . PHP_EOL;
