<?php
$array = [
    [
        'id' => 1,
        'parent_id' => null,
        'text' => 'H1',
    ],
    [
        'id' => 2,
        'parent_id' => 1,
        'text' => 'H2',
    ],
    [
        'id' => 3,
        'parent_id' => null,
        'text' => 'H3',
    ],
    [
        'id' => 4,
        'parent_id' => 1,
        'text' => 'H4',
    ],
    [
        'id' => 5,
        'parent_id' => 2,
        'text' => 'H5',
    ],
    [
        'id' => 6,
        'parent_id' => 3,
        'text' => 'H6',
    ],
    [
        'id' => 7,
        'parent_id' => 4,
        'text' => 'H7',
    ],
    [
        'id' => 8,
        'parent_id' => 5,
        'text' => 'H8',
    ],
    [
        'id' => 9,
        'parent_id' => 7,
        'text' => 'H9',
    ],
];
shuffle($array);
$_POST['json'] = json_encode($array, JSON_PRETTY_PRINT);

if ( isset($_POST['json']) ) {
    $array = json_decode($_POST['json'], true);
    $array = convertIntoMultidimensionalArray($array, null, ['id', 'parent_id', 'children', 'text'], false, true);
    // $array = marrayToArrayForAlternativeJson($array);
    // echo "<pre>";
    // print_r($array);
    // echo "</pre>";
    // die();
    $json = json_encode($array);
    returnJson($json);
}

function convertIntoMultidimensionalArray($array, $idOfTheRoot, $fields, $addLevel = false, $forAlternativeJson = false)
{
    $return = [];
    $cache = [];
    // Для каждого элемента
    foreach ($array as $key => $value) {
        // Если нет родителя элемента, и элемент не корневой,
        // тогда создаем родителя в возврат а ссылку в кэш
        if (!isset($cache[$value[$fields[1]]]) && ($value[$fields[1]] != $idOfTheRoot)) {
            $arrayIntoReturn = [];
            foreach ($fields as $fieldKey => $fieldName) {
                switch (true) {
                    case $fieldKey === 0:
                        $arrayIntoReturn[$fieldName] = $value[$fields[1]];
                        break;
                    case $fieldKey === 1:
                        $arrayIntoReturn[$fieldName] = null;
                        break;
                    case $fieldKey === 2:
                        $arrayIntoReturn[$fieldName] = [];
                        break;
                    default:
                        $arrayIntoReturn[$fieldName] = null;
                        break;
                }
            }
            $return[$value[$fields[1]]] = $arrayIntoReturn;
            $cache[$value[$fields[1]]] = &$return[$value[$fields[1]]];
        }
        // Если элемент уже был создан, значит он был чьим-то родителем, тогда
        // обновим в нем информацию о его родителе
        if (isset($cache[$value[$fields[0]]])) {
            $cache[$value[$fields[0]]][$fields[1]] = $value[$fields[1]];
            foreach ($fields as $fieldKey => $fieldName) {
                switch (true) {
                    case $fieldKey === 0:
                        break;
                    case $fieldKey === 1:
                        $cache[$value[$fields[0]]][$fieldName] = $value[$fieldName];
                        break;
                    case $fieldKey === 2:
                        break;
                    default:
                        $cache[$value[$fields[0]]][$fieldName] = $value[$fieldName];
                        // $arrayIntoReturn[$fieldName] = $value[$fieldName];
                        break;
                }
            }
            // Если этот элемент не корневой,
            // тогда переместим его в родителя, и обновим ссылку в кэш
            if ($value[$fields[1]] != $idOfTheRoot) {
                $cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]] = $return[$value[$fields[0]]];
                unset($return[$value[$fields[0]]]);
                $cache[$value[$fields[0]]] = &$cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]];
            }
        }
        // Иначе, элемент новый, родитель уже создан, добавим в родителя
        else {
            // Если элемент не корневой - вставляем в родителя беря его из кэш
            if ($value[$fields[1]] != $idOfTheRoot) {
                $arrayIntoReturn = [];
                foreach ($fields as $fieldKey => $fieldName) {
                    switch (true) {
                        case $fieldKey === 0:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                        case $fieldKey === 1:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                        case $fieldKey === 2:
                            $arrayIntoReturn[$fieldName] = [];
                            break;
                        default:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                    }
                }
                // Берем родителя из кэш и вставляем в "детей"
                $cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]] = $arrayIntoReturn;
                // Вставляем в кэш ссылку на элемент
                $cache[$value[$fields[0]]] = &$cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]];
            }
            // Если элемент кокренвой, вставляем сразу в return
            else {
                $arrayIntoReturn = [];
                foreach ($fields as $fieldKey => $fieldName) {
                    switch (true) {
                        case $fieldKey === 0:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                        case $fieldKey === 1:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                        case $fieldKey === 2:
                            $arrayIntoReturn[$fieldName] = [];
                            break;
                        default:
                            $arrayIntoReturn[$fieldName] = $value[$fieldName];
                            break;
                    }
                }
                $return[$value[$fields[0]]] = $arrayIntoReturn;
                // Вставляем в кэш ссылку на элемент
                $cache[$value[$fields[0]]] = &$return[$value[$fields[0]]];
            }
        }
    }
    if ( $addLevel ) {
        $level = 1;
        $parentArray[$level] = $return;
        while ($level >= 1) {
            $mode = each($parentArray[$level]);
            if ($mode !== false) {
                $parentArray[$level][$mode[0]]['level'] = $level;
                if (count($mode[1][$fields[2]])) {
                    $level++;
                    $parentArray[$level] = $mode[1][$fields[2]];
                }
            } else {
                $level--;
            }
        }
    }
    if ( $forAlternativeJson ) {
        reset($return);
        $alternativeArray = [];
        $level = 1;
        $parentAlternativeArray[$level] = &$alternativeArray;
        $parentArray[$level] = $return;
        while ($level >= 1) {
            $mode = each($parentArray[$level]);
            if ($mode !== false) {
                $tempArray = [];
                foreach ($fields as $fieldKey => $fieldName) {
                    switch (true) {
                        case $fieldKey === 2:
                            $tempArray[$fieldName] = [];
                            break;
                        default:
                            $tempArray[$fieldName] = $mode[1][$fieldName];
                            break;
                    }
                }
                $parentAlternativeArray[$level][] = $tempArray;
                if (count($mode[1][$fields[2]])) {
                    end($parentAlternativeArray[$level]);
                    $key = key($parentAlternativeArray[$level]);
                    $level++;
                    $parentArray[$level] = $mode[1][$fields[2]];
                    $parentAlternativeArray[$level] = &$parentAlternativeArray[$level-1][$key][$fields[2]];
                }
            } else {
                $level--;
            }
        }
        $return = $alternativeArray;
    }
    return $return;
}

function multidimensionalArrayToString($array = [], $fields)
{
    $return = '';
    if (!count($array)) {
        return $return;
    }
    $level = 1;
    $parentArray[$level] = $array;
    while ($level >= 1) {
        $mode = each($parentArray[$level]);
        if ($mode !== false) {
            $return .= str_repeat("\t", $level-1) . $mode[1][$fields[0]] . PHP_EOL;
            if (count($mode[1][$fields[2]])) {
                $level++;
                $parentArray[$level] = $mode[1][$fields[2]];
            }
        } else {
            $level--;
        }
    }
    return $return;
}

function returnJson($return)
{
    header('Content-Type: application/json; charset=utf-8');
    echo $return;
    exit;
}

/*

tree_clear();

tree('tree_site', [{"id":1,"parent_id":"#","children":[{"id":4,"parent_id":1,"children":[{"id":7,"parent_id":4,"children":[{"id":9,"parent_id":7,"children":[],"text":"H9"}],"text":"H7"}],"text":"H4"},{"id":2,"parent_id":1,"children":[{"id":5,"parent_id":2,"children":[{"id":8,"parent_id":5,"children":[],"text":"H8"}],"text":"H5"}],"text":"H2"}],"text":"H1"},{"id":3,"parent_id":"#","children":[{"id":6,"parent_id":3,"children":[],"text":"H6"}],"text":"H3"}]);

*/
