<?php

// Секунды [Int] в дату [DateTime]
echo PHP_EOL . 'Секунды [Int] в дату [DateTime]' . PHP_EOL;
$a = 1522339254;
$b = new DateTime();
$b->setTimestamp($a);
$c = $b->format('Y m d H i s');
echo '$a: ' . print_r($a, true) . PHP_EOL;
echo '$b: ' . print_r($b, true) . PHP_EOL;
echo '$c: ' . print_r($c, true) . PHP_EOL;

// Строку формата [Y-m-d H:i:s] в дату [DateTime]
echo PHP_EOL . 'Строку формата [Y-m-d H:i:s] в дату [DateTime]' . PHP_EOL;
$a = '2018-03-29 19:00:54';
$b = new DateTime($a);
echo '$a: ' . print_r($a, true) . PHP_EOL;
echo '$b: ' . print_r($b, true) . PHP_EOL;

// Дату в число
echo PHP_EOL . 'Дату в число' . PHP_EOL;
$a = new DateTime('2018-03-29 19:00:54');
$b = $a->getTimestamp();
echo '$a: ' . print_r($a, true) . PHP_EOL;
echo '$b: ' . print_r($b, true) . PHP_EOL;

echo '> Перевод DateTime в строку' . PHP_EOL;
$a = new DateTime();
$b = $a->format('Y-m-d H:i:s');
$b = (new DateTime())->format('Y-m-d H:i:s');
echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
