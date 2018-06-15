<?php
echo phpversion() . PHP_EOL;
$asd = function_exists('mysqli_connect');
echo '$asd: ' . var_export($asd, true) . PHP_EOL;
die();
// phpinfo();
