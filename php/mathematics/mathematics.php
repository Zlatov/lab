<?php

$count = 10;

$log = log($count);
echo $log.PHP_EOL;

// $levels = round($log);
// echo $levels.PHP_EOL;
$levels = ceil($log);
echo $levels.PHP_EOL;

$level = 1;
$count_level = ceil($count/$levels);
$count_on_level = $count_level*$level;
for ($i=1; $i <= $count; $i++) {
	// $from = ceil($count/$levels)*($l-1) + 1;
	// $to = ceil($count/$levels)*($l) + 1;
	// echo $from.' '.$to.PHP_EOL;
	// switch (true) {
	// 	case :
	// 		break;
	// 	default:
	// 		break;
	// }
	if ($i>$count_on_level) {
		$level++;
		$count_on_level = $count_level*$level;
	}
	// echo "$i $level $count_on_level".PHP_EOL;
	if ($level===1) {
		$from = 0;
		$to = 0;
		$pid = 'NULL';
	} else {
		$from = $count_level*($level-1)-$count_level+1;
		$to = $count_level*($level-1);
		$pid = mt_rand($from, $to);
	}
	echo "$i $pid $from $to".PHP_EOL;
	// for ($i=ceil($count/$levels); $i < $levels; $i++) { 
	// }
}
echo 'gg';

echo 0%10;