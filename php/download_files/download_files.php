<?php
set_time_limit(60*5);
$array = range(41,42);
foreach ($array as $value) {
	$url = "http://audioknigi-online.site/audio/1/Phantastika/Zlotnikov/Knights-Porog/4/{$value}.mp3";
	file_put_contents("{$value}.mp3", fopen("$url", 'r'));
	echo $url . ' done.<br>' . PHP_EOL;
}
