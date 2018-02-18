<?php
$time_limit = 60*20;
set_time_limit($time_limit);
echo $time_limit;
flush();
ob_flush();

// $array1 = range(101,109);
// $array2 = range(201,210);
// $array3 = range(301,312);
// $array = array_merge($array1, $array2, $array3);


// $array = [
// 	'01.01',
// 	'01.02',
// 	'01.03',
// 	'01.04',
// 	'01.05',
// 	'01.06',
// 	'02.01',
// 	'02.02',
// 	'02.03',
// 	'02.04',
// 	'02.05',
// 	'03.01',
// 	'03.02',
// 	'03.03',
// 	'04.01',
// 	'04.02',
// 	'04.03',
// 	'04.04',
// 	'05.01',
// 	'05.02',
// 	'05.03',
// 	'06.01',
// 	'06.02',
// ];
$array = range(9,25);

foreach ($array as $value) {
	$url = "http://audioknigi-online.site/audio/1/STALKER/Groshev/1Stalker/$value.mp3";
	echo 'start ' . $url;
    flush();
    ob_flush();
	file_put_contents("{$value}.mp3", fopen("$url", 'r'));
	echo ' done.<br>' . PHP_EOL;
    flush();
    ob_flush();
}
ob_end_clean();
