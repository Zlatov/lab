<?php

echo '> Строку в массив' . PHP_EOL;
$a = 'asd/zxc/qwe';
$b = explode('/', $a);
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
echo '> null в массив, желательно после разбиения фильтрация' . PHP_EOL;
$a = null;
$b = explode('/', $a);
$c = array_filter($b, function($value) {return $value ? true : false;});
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
echo '$c: ' . var_export($c, true) . PHP_EOL;
// exit;

echo '> Многострочный текст' . PHP_EOL;
$a = <<< STRING
1
  2
STRING;
echo '$a: ' . var_export($a, true) . PHP_EOL;

echo '> Замена подстроки' . PHP_EOL;
$a = <<< STRING
1
asd
STRING;
$b = str_replace('asd', '2', $a);
echo '$b: ' . var_export($b, true) . PHP_EOL;

echo '> Переменные в многострочном тексте' . PHP_EOL;
$a = 'asd';
$b = <<< SQL
$a
{$a}
zxc
SQL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
// die();

// $a = 'asd';
// $b = mb_strlen($a);
// var_dump($a); echo PHP_EOL;
// var_dump($b); echo PHP_EOL;

echo '> Пустая ли строка?' . PHP_EOL;
$a = empty('');
$b = empty(' ');
$c = empty(' a');
$d = empty('asd');
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
echo '$c: ' . var_export($c, true) . PHP_EOL;
echo '$d: ' . var_export($d, true) . PHP_EOL;

echo '> Вставка в строку со скобками {}' . PHP_EOL;
$a = ['asd' => 'asdasd', 'zxc' => 'zxczxc'];
$b = "${a['asd']} ${a['zxc']}";
echo '$b: ' . var_export($b, true) . PHP_EOL;
