<?php
header('Content-Type: text/html; charset=utf-8');

$array = [
	'text',
	100,
	'int' => 123,
	'text' => '123456',
	'cyr' => 'Русский Ёж',
];

$json = json_encode($array);
$json2 = json_encode($array, JSON_PRETTY_PRINT);
$json3 = json_encode($array, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

$array2 = json_decode($json2);
$array3 = json_decode($json2, true);

echo "<h2>Исходный php массив</h2>";
echo "<pre>";
var_dump($array);
echo "</pre>";

echo "<h2>Json текст</h2>";
echo "<pre>";
var_dump($json);
echo "</pre>";

echo "<h2>Json текст c «PRETTY»</h2>";
echo "<pre>";
var_dump($json2);
echo "</pre>";

echo "<h2>Json текст с &#8222;PRETTY&#8220; и «Неэскейпованным юникодом» (\u2832\u2432...)</h2>";
echo "<pre>";
var_dump($json3);
echo "</pre>";

echo "<h2>PHP объект получ из json строки</h2>";
echo "<pre>";
var_dump($array2);
echo "</pre>";

echo "<h2>PHP массив получ из json строки</h2>";
echo "<pre>";
var_dump($array3);
echo "</pre>";
