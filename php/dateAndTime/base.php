<pre>
<?php
$datetime = '2016-02-28 22:48:55';
var_dump($datetime);
echo "\n";

$timestamp = strtotime($datetime);
var_dump($timestamp);
echo "\n";

$str = strftime('%Y-%m-%d %H:%M:%S');
var_dump($str);
echo "\n";

// not in windows !!! !!! !!!
$array = strptime($str, '%Y-%m-%d %H:%M:%S');
var_dump($array);
echo "\n";

$str = date($timestamp);
var_dump($str);
echo "\n";

$str = date('Y', $timestamp);
var_dump($str);
echo "\n";

$str = strftime('%Y', $timestamp);
var_dump($str);
echo "\n";

?>
</pre>