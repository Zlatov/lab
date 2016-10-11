<?php
include('../php/memoryUsage/memoryUsage.php');
if (!set_time_limit(30)) {
    die('set_time_limit(30)');
}

$aa = array();
for ($i=1; $i < 1000; $i++) {
    $aa[] = array('id'=>$i, 'parent_id'=>rand(0,$i-1));
}

$a=array(
    array(
        'id'=>1,
        'parent_id'=>0,
    ),
    array(
        'id'=>8,
        'parent_id'=>6,
    ),
    array(
        'id'=>9,
        'parent_id'=>5,
    ),
    array(
        'id'=>5,
        'parent_id'=>1,
    ),
    array(
        'id'=>2,
        'parent_id'=>1,
    ),
    array(
        'id'=>6,
        'parent_id'=>0,
    ),
    array(
        'id'=>4,
        'parent_id'=>3,
    ),
    array(
        'id'=>7,
        'parent_id'=>3,
    ),
    array(
        'id'=>3,
        'parent_id'=>1,
    ),
);


function ab2($a){
    $b = array();
    $c = array();
    foreach ($a as $key => $value) {
        if (isset($c[$value['parent_id']])) {
            if ($value['parent_id']===0) {
            }else{
            }
        }else{
            if ($value['parent_id']===0) {
            }else{
                // создаем родителя в Б
                $b[$value['parent_id']] = array('id'=>$value['parent_id'],'parent_id'=>'temp','childrens'=>array());
                // сохраняем ссылку на родителя в Ц
                $c[$value['parent_id']] = &$b[$value['parent_id']];
            }
        }
        if (isset($c[$value['id']])) {
            $c[$value['id']]['parent_id'] = $value['parent_id'];
        }else{
            if ($value['parent_id']===0) {
                $b[$value['id']] = array('id'=>$value['id'],'parent_id'=>$value['parent_id'],'childrens'=>array());//$value;
                $c[$value['id']] = &$b[$value['id']];
            }else{
                $c[$value['parent_id']]['childrens'][$value['id']] = array('id'=>$value['id'],'parent_id'=>$value['parent_id'],'childrens'=>array()); //$value;
                $c[$value['id']] = &$c[$value['parent_id']]['childrens'][$value['id']];
            }
        }
    }
    $d = array();
    foreach ($b as $key => $value) {
        if ($value['parent_id']!==0) {
            $c[$value['parent_id']]['childrens'][$value['id']] = $value;
            $d[$key] = $key;
        }
    }
    foreach ($d as $value) {
        unset($b[$value]);
    }
    return $b;
}

function ab($a){
    $b = array();
    $c = array();
    foreach ($a as $value) {
        if (!isset($c[$value['parent_id']])) {
            if ($value['parent_id']!==0) {
                $b[$value['parent_id']] = array('id'=>$value['parent_id'],'parent_id'=>'temp','childrens'=>array());
                $c[$value['parent_id']] = &$b[$value['parent_id']];
            }
        }
        if (isset($c[$value['id']])) {
            $c[$value['id']]['parent_id'] = $value['parent_id'];
        }else{
            if ($value['parent_id']===0) {
                $b[$value['id']] = array('id'=>$value['id'],'parent_id'=>$value['parent_id'],'childrens'=>array());//$value;
                $c[$value['id']] = &$b[$value['id']];
            }else{
                $c[$value['parent_id']]['childrens'][$value['id']] = array('id'=>$value['id'],'parent_id'=>$value['parent_id'],'childrens'=>array()); //$value;
                $c[$value['id']] = &$c[$value['parent_id']]['childrens'][$value['id']];
            }
        }
        memoryUsage(memory_get_usage(), 'in foreach1 ab', false);
    }
    $d = array();
    foreach ($b as $key => $value) {
        if ($value['parent_id']!==0) {
            $c[$value['parent_id']]['childrens'][$value['id']] = $value;
            $d[$key] = $key;
            //unset($b[$key]);
        }
    }
    foreach ($d as $value) {
        unset($b[$value]);
    }
    return $b;
}


function FunctionAB($aa)
{
    $goodTree = array();

    $level = 0;
    $parentid[$level] = 0;
    while ($level!==-1) {
        $mode = each($aa);
        if ( $mode!==false ) {
            if ( ($mode[1]['parent_id']==$parentid[$level]) ) {
                $mode[1]['level'] = $level;
                $mode[1]['childrens'] = array();
                $goodTree[] = $mode[1];
                unset($aa[$mode[0]]);
                $temp = $aa;
                foreach ($temp as $val) {
                    if ( ($val['parent_id']==$mode[1]['id']) ) {
                        $level++;
                        $parentid[$level] = $mode[1]['id'];
                        reset($aa);
                        break;
                    }
                }
            }
        } else {
            $level--;
            reset($aa);
        }
        // memoryUsage(memory_get_usage(), 'in while FunctionAB');
    }

    $badTree = $goodTree;
    $curLevel = 0;
    $parent[$curLevel] = 0;
    foreach ($badTree as $key => &$value) {
        if ($value['level']!==$curLevel) {
            if ($value['level'] === $curLevel + 1 ) {
                $parent[$value['level']] = &$temp;
            }
        }
        if ($value['level']!==0) {
            $parent[$value['level']]['childrens'][] = &$value;
        }
        $temp = &$value;
        $curLevel = $value['level'];
        memoryUsage(memory_get_usage(), 'in foreach1 FunctionAB', false);
    }

    foreach ($badTree as $key => &$value) {
        if ($value['level']!==0) {
            unset($badTree[$key]);
        }
        unset($value['level']);
        unset($value['parent_id']);
        memoryUsage(memory_get_usage(), 'in foreach2 FunctionAB', false);
    }

        // return array($goodTree,$badTree);
    return $badTree;
}

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
        memoryUsage(memory_get_usage(), 'in foreach Multi', false);
    }
    return $return;
}

// $start = microtime(true);
// for ($i=0; $i < 30; $i++) {
//     shuffle($aa);
//     $bb = ab($aa);
// }
// $time = microtime(true) - $start;
// printf('<br>Скрипт с ab($a); выполнялся %.4F сек.', $time);


// $start = microtime(true);
// for ($i=0; $i < 30; $i++) {
//     shuffle($aa);
//     $bb = FunctionAB($aa);
// }
// $time = microtime(true) - $start;
// printf('<br>Скрипт c FunctionAB($a); выполнялся %.4F сек.', $time);


// $start = microtime(true);
// for ($i=0; $i < 30; $i++) {
//     shuffle($aa);
//     $bb = toMultidimensionalTree($aa, 0, 'parent_id');
// }
// $time = microtime(true) - $start;
// printf('<br>Скрипт c toMultidimensionalTree($a); выполнялся %.4F сек.', $time);
    
shuffle($aa);
// echo '<hr>';
// echo "a:<pre>";
// print_r($a);
// echo "</pre>";

memoryUsage(memory_get_usage());
$r1 = ab($aa);
// echo '<hr>';
// echo "r1:<pre>";
// print_r($r1);
// echo "</pre>";
unset($r1);
memoryUsage(memory_get_usage(), 'ab()');

$r2 = FunctionAB($aa);
// echo '<hr>';
// echo "r2:<pre>";
// print_r($r2);
// echo "</pre>";
unset($r2);
memoryUsage(memory_get_usage(), 'FunctionAB()');

$r3 = toMultidimensionalTree($aa, 0, 'parent_id');
// echo "r3:<pre>";
// print_r($r3);
// echo "</pre>";
unset($r3);
memoryUsage(memory_get_usage(), 'toMultidimensionalTree()');


