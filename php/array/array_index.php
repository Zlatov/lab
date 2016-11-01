<?php

$array = [
	0 => [
		'id' => 1,
		'header' => '1',
	],
	1 => [
		'id' => 2,
		'header' => '2-1',
	],
	2 => [
		'id' => 2,
		'header' => '2-2',
	],
	3 => [
		'id' => 3,
		'header' => '3',
	],
];
$array2 = [
	0 => [
		'id' => 'one',
		'header' => '1',
	],
	1 => [
		'id' => 'two',
		'header' => '2-1',
	],
	2 => [
		'id' => 'two',
		'header' => '2-2',
	],
	3 => [
		'id' => 'three',
		'header' => '3',
	],
];

/**
 * Возвращает переиндексированный массив
 * @param  array $array минимум двумерный массив
 * @param  string $key  имя ключа по которому будет построен индекс
 * @return array
 */
function array_index($array, $key)
{
    $result = [];

    foreach ($array as $element) {
        $lastArray = &$result;
        $value = $element[$key];
        if ($value !== null) {
            if (is_float($value)) {
                $value = (string) $value;
            }
            $lastArray[$value] = $element;
        }
        unset($lastArray);
    }

    return $result;
}

$array = array_index($array, 'id');
$array2 = array_index($array2, 'id');

echo "<pre>";
print_r($array);
echo "</pre>";
echo "<pre>";
print_r($array2);
echo "</pre>";
