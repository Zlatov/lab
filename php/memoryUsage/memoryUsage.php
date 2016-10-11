<?php
$parent_memory_usage = null;
function memoryUsage($memoryUsage, $text = null, $print = true) {
	global $parent_memory_usage, $base_memory_usage;
	if ($text && $print) {
		print('<br>' . $text . ':');
	}
	if ($print) {
		printf("<br>Разница меж текущим и начальным байт: %d" . PHP_EOL, $memoryUsage - $base_memory_usage);
		printf("<br>Разница меж текущим и предыдущим байт: %d" . PHP_EOL, $memoryUsage - $base_memory_usage - $parent_memory_usage);
	}
	$parent_memory_usage = $memoryUsage - $base_memory_usage;
}
$base_memory_usage = memory_get_usage();
$base_memory_usage = memory_get_usage();