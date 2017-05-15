<?php
function memoryUsage($usage, $base_memory_usage, $current_memory_usage, $text='') {
	printf("{$text} - Текущще относительно старта: %d. Относительно предыдущего: %" . (($usage - $base_memory_usage - $current_memory_usage == 0)?'':'+') . "d<br>" . PHP_EOL, $usage - $base_memory_usage, $usage - $base_memory_usage - $current_memory_usage);
	return $usage - $base_memory_usage;
}
function someBigValue() {
	return str_repeat('SOME BIG STRING', 1024);
}
