<?php
$array=[
    [
        'id'=>1,
        'pid'=>0,
    ],
    [
        'id'=>8,
        'pid'=>6,
    ],
    [
        'id'=>9,
        'pid'=>5,
    ],
    [
        'id'=>5,
        'pid'=>1,
    ],
    [
        'id'=>2,
        'pid'=>1,
    ],
    [
        'id'=>6,
        'pid'=>0,
    ],
    [
        'id'=>4,
        'pid'=>3,
    ],
    [
        'id'=>7,
        'pid'=>3,
    ],
    [
        'id'=>3,
        'pid'=>1,
    ],
];

function toMultidimensionalTree($array)
{
    $return = [];
    $cache = [];
    // Для каждого элемента
    foreach ($array as $key => $value) {
        // Если нет родителя элемента, то создаем родителя если элемент не в корне
        if (!isset($cache[$value['pid']]) && $value['pid'] != 0) {
            // В результирующем массиве
            $return[$value['pid']] = [
                'id' => $value['pid'],
                'pid' => null,
                'childrens' => [],
            ];
            // В кэш ссылку на элемент-родитель
            $cache[$value['pid']] = &$return[$value['pid']];
        }
        // Если элемент уже был создан, значит он был чьим-то родителем - обновим в нем информацию о его родителе
        if (isset($cache[$value['id']])) {
            $cache[$value['id']]['pid'] = $value['pid'];
            // Если этот родитель не корневой, удалим его из возврата
            if ($value['pid'] != 0) {
                unset($return[$value['id']]);
            }
        }
        // Иначе, элемент новый, родитель уже создан, добавим в родителя
        else {
            // Если элемент не корневой - вставляем в родителя беря из кэш
            if ($value['pid'] != 0) {
                // Берем родителя из кэш и вставляем в "детей"
                $cache[$value['pid']]['childrens'][$value['id']] = [
                    'id' => $value['id'],
                    'pid' => $value['pid'],
                    'childrens' => [],
                ];
                // И вставляем в кэш
                $cache[$value['id']] = &$c[$value['pid']]['childrens'][$value['id']];
            }
            // Если элемент в кокренвой, вставляем сразу в return
            else {
                $return[$value['id']] = [
                    'id' => $value['id'],
                    'pid' => $value['pid'],
                    'childrens' => [],
                ];
                // В кэш ссылку на элемент
                $c[$value['id']] = &$b[$value['id']];
            }
        }
    }
    return $return;
}

$result = toMultidimensionalTree($array);

echo "<pre>";
print_r($array);
echo "</pre>";
echo "<pre>";
print_r($result);
echo "</pre>";
