<?php
set_time_limit(60*5);
$array1 = range(101,109);
$array2 = range(201,210);
$array3 = range(301,312);
$array = array_merge($array1, $array2, $array3);
foreach ($array as $value) {
	$url = "https://get3.sweetbook.net/b/39460/J-FHLVoSTJHPLoKYO6UlqdOslkVbYB9zMQkE_5HVn4Y,/AL_VybOr_{$value}.mp3";
	file_put_contents("{$value}.mp3", fopen("$url", 'r'));
	echo $url . ' done.<br>' . PHP_EOL;
}
