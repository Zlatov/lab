<?php

echo '> Простая замена' . PHP_EOL;
$a = "asd
zxc
qwe";
$c = preg_replace('/zxc/', '', $a);
echo '$c: ' . var_export($c, true) . PHP_EOL;

echo '> Простая замена' . PHP_EOL;
$a = "asd
http://zxc asd
https://zxc zxc
qwe http://zxc zxc
qwe";
$c = preg_replace('/http[s]?:\/\/\S+/', '', $a);
echo '$c: ' . var_export($c, true) . PHP_EOL;
