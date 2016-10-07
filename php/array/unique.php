<?php

$array = [
	1,
	2,
	1,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	9,
];

$array2 = [
	["1","1","1"],
	["2","2","2"],
	["1","1","1"],
	["3","3","3"],
	["4","4","4"],
	["5","5","5"],
	["6","6","6"],
	["7","7","7"],
	["8","8","8"],
	["9","9","9"],
	["9","9","9"],
];

function array_unique_multi($array, $key) {
    $temp_array = array();
    $i = 0;
    $key_array = array();
   
    foreach($array as $val) {
        if (!in_array($val[$key], $key_array)) {
            $key_array[$i] = $val[$key];
            $temp_array[$i] = $val;
        }
        $i++;
    }
    return $temp_array; 
}

$unique = array_keys(array_flip($array));
echo "<pre>";
print_r($unique);
echo "</pre>";
$unique = array_unique_multi($array2,0);
echo "<pre>";
print_r($unique);
echo "</pre>";

// It's marginally faster as: 
// $unique = array_merge(array_flip(array_flip($array))); 
// echo "<pre>";
// print_r($unique);
// echo "</pre>";

// And it's marginally slower as: 
// $unique array_flip(array_flip($array)); // leaves gaps 
// echo "<pre>";
// print_r($unique);
// echo "</pre>";

