<?php

$array1[0] = "zero";
$array1[1] = "equal key";

$array2[1] = "equal key";
$array2[2] = "two";
$array2[3] = "three";

$array3 = $array1 + $array2;
$array4 = array_merge($array1, $array2);
$array1 = array_merge($array1, $array2);

print_r($array3);
print_r($array4);
print_r($array1);
