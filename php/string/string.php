<?php
$a = <<< STRING
1
  2
STRING;
var_dump($a); echo PHP_EOL;

$a = <<< STRING
1
asd
STRING;
$b = str_replace('asd', '2', $a);
var_dump($a); echo PHP_EOL;
var_dump($b); echo PHP_EOL;

$a = 'asd';
$b = mb_strlen($a);
var_dump($a); echo PHP_EOL;
var_dump($b); echo PHP_EOL;
