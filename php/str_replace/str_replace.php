<?php

// mixed str_replace ( mixed $search , mixed $replace , mixed $subject [, int &$count ] )

$a = 'asd';
$b = str_replace('s', 'S', $a);

echo '$a: ' . var_export($a, true) . PHP_EOL;
echo '$b: ' . var_export($b, true) . PHP_EOL;
