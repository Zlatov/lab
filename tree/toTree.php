<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style type="text/css">
        .tree { padding-left:25px; }
        .tree ul { margin:0; padding-left:6px; }
        .tree li { position:relative; list-style:none outside none; border-left:solid 1px #999; margin:0; padding:0 0 0 19px; line-height:23px; }
        .tree li:before { content:''; display:block; border-bottom:solid 1px #999; position:absolute; width:18px; height:11px; left:0; top:0; }
        .tree li:last-child { border-left:0 none; }
        .tree li:last-child:before { border-left:solid 1px #999; }      
    </style>
</head>
<body>

<?php

$array=[
    [
        'id'=>1,
        'pid'=>0,
    ],
    [
        'id'=>2,
        'pid'=>1,
    ],
    [
        'id'=>3,
        'pid'=>1,
    ],
    [
        'id'=>4,
        'pid'=>3,
    ],
    [
        'id'=>5,
        'pid'=>1,
    ],
    [
        'id'=>6,
        'pid'=>0,
    ],
    [
        'id'=>7,
        'pid'=>3,
    ],
    [
        'id'=>8,
        'pid'=>6,
    ],
    [
        'id'=>9,
        'pid'=>5,
    ],
];

function toMultidimensionalTree($array, $idOfTheRoot = 0, $nameOfTheParentKey = 'pid')
{
    $return = [];
    $cache = [];
    // Для каждого элемента
    foreach ($array as $key => $value) {
        // Если нет родителя элемента, и элемент не корневой,
        // тогда создаем родителя в возврат а ссылку в кэш
        if (!isset($cache[$value[$nameOfTheParentKey]]) && ($value[$nameOfTheParentKey] != $idOfTheRoot)) {
            $return[$value[$nameOfTheParentKey]] = [
                'id' => $value[$nameOfTheParentKey],
                $nameOfTheParentKey => null,
                'childrens' => [],
            ];
            $cache[$value[$nameOfTheParentKey]] = &$return[$value[$nameOfTheParentKey]];
        }
        // Если элемент уже был создан, значит он был чьим-то родителем, тогда
        // обновим в нем информацию о его родителе
        if (isset($cache[$value['id']])) {
            $cache[$value['id']][$nameOfTheParentKey] = $value[$nameOfTheParentKey];
            // Если этот элемент не корневой,
            // тогда переместим его в родителя, и обновим ссылку в кэш
            if ($value[$nameOfTheParentKey] != $idOfTheRoot) {
                $cache[$value[$nameOfTheParentKey]]['childrens'][$value['id']] = $return[$value['id']];
                unset($return[$value['id']]);
                $cache[$value['id']] = &$cache[$value[$nameOfTheParentKey]]['childrens'][$value['id']];
            }
        }
        // Иначе, элемент новый, родитель уже создан, добавим в родителя
        else {
            // Если элемент не корневой - вставляем в родителя беря его из кэш
            if ($value[$nameOfTheParentKey] != $idOfTheRoot) {
                // Берем родителя из кэш и вставляем в "детей"
                $cache[$value[$nameOfTheParentKey]]['childrens'][$value['id']] = [
                    'id' => $value['id'],
                    $nameOfTheParentKey => $value[$nameOfTheParentKey],
                    'childrens' => [],
                ];
                // Вставляем в кэш ссылку на элемент
                $cache[$value['id']] = &$cache[$value[$nameOfTheParentKey]]['childrens'][$value['id']];
            }
            // Если элемент кокренвой, вставляем сразу в return
            else {
                $return[$value['id']] = [
                    'id' => $value['id'],
                    $nameOfTheParentKey => $value[$nameOfTheParentKey],
                    'childrens' => [],
                ];
                // Вставляем в кэш ссылку на элемент
                $cache[$value['id']] = &$return[$value['id']];
            }
        }
    }
    return $return;
}

function echoMultidimensionalTree($array)
{
    $html = "<ul class='tree'>".PHP_EOL;
    $tplUlBegin = "<ul>".PHP_EOL;
    $tplUlEnd = "</ul>".PHP_EOL;
    $tplLiBegin = "<li>??header?? <small>#??id??</small>".PHP_EOL;
    $tplLiEnd = "</li>".PHP_EOL;

    $html = "&lt;ul class='tree'&gt;".PHP_EOL;
    $tplUlBegin = "&lt;ul&gt;".PHP_EOL;
    $tplUlEnd = "&lt;/ul&gt;".PHP_EOL;
    $tplLiBegin = "&lt;li&gt;??id??".PHP_EOL;
    $tplLiEnd = "&lt;/li&gt;".PHP_EOL;

    $level = 0;
    $parentArray[$level] = $array;
    while ($level >= 0) {
        $mode = each($parentArray[$level]);
        if ($mode !== false) {

            $replace["??id??"] = $mode[0];
            $html .= str_repeat("    ", $level*2 + 1) . str_replace(array_keys($replace),$replace,$tplLiBegin);

            echo "<pre>";
            echo str_repeat("   ", $level);
            echo $mode[1]['id'].PHP_EOL;
            echo "</pre>";
            if (count($mode[1]['childrens'])) {
                $level++;
                $parentArray[$level] = $mode[1]['childrens'];
                $html .= str_repeat("    ", $level*2) . "$tplUlBegin";
            } else {
                $html .= str_repeat("    ", $level*2 + 1) . "$tplLiEnd";
            }
        } else {
            $html .= ($level>0)?str_repeat("    ", ($level)*2) . "$tplUlEnd":"$tplUlEnd";
            $html .= ($level>0)?str_repeat("    ", ($level)*2 - 1) . "$tplLiEnd":'';
            $level--;
        }
    }

    echo "<pre>";
    print_r($html);
    echo "</pre>";
}

shuffle($array);
$result = toMultidimensionalTree($array);

echoMultidimensionalTree($result);
echo "<hr>";
echo "<pre>";
print_r($array);
echo "</pre>";
echo "<hr>";
echo "<pre>";
print_r($result);
echo "</pre>";

?>

</body>
</html>
