<?php

$array1[0] = "zero";
$array1[1] = "one1";

$array2[1] = "one1";
$array2[2] = "two";
$array2[3] = "three";

$array3 = $array1 + $array2;
$array4 = array_merge($array1, $array2);
$array1 = array_merge($array1, $array2);

echo "<pre>";
print_r($array3);
echo "</pre>";
echo "<pre>";
print_r($array4);
echo "</pre>";
echo "<pre>";
print_r($array1);
echo "</pre>";
die();