<?php

$array = [
	'text',
	100,
	'text' => 123,
	'text2' => '123456',
];

$json = json_encode($array);
$json2 = json_encode($array, JSON_PRETTY_PRINT);

$array2 = json_decode($json2);
$array3 = json_decode($json2, true);

echo "<pre>";
var_dump($array);
echo "</pre>";
echo "<pre>";
var_dump($json);
echo "</pre>";
echo "<pre>";
var_dump($json2);
echo "</pre>";
echo "<pre>";
var_dump($array2);
echo "</pre>";
echo "<pre>";
var_dump($array3);
echo "</pre>";
