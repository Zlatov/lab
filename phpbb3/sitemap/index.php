<?php
require_once 'config.php';
require_once 'common.php';

$forums = select_forums();
// echo '$forums: <pre>';
// print_r($forums);
// echo '</pre>';

// Определяем уровни форумов
$right = 0;
$level = 0;
$level_store = ["0" => 0];
$store_prev = null;
foreach ($forums as $id => $forum) {
    if ($forum['left_id'] < $right) {
        $level++;
        $level_store[$forum['parent_id']] = $level;
    } else if ($forum['left_id'] > $right + 1) {
        $level = (isset($level_store[$forum['parent_id']]))?$level_store[$forum['parent_id']]:0;
    }
    if ($store_prev) {
        if ($store_prev['forum_id'] == $forum['parent_id']) {
            $forums[$store_prev['forum_id']]['has_children'] = true;
        }
        if ($store_prev['level'] > $level) {
            $forums[$store_prev['forum_id']]['last_children'] = true;
            $parent_id = $store_prev['parent_id'];
            $d = $store_prev['level'] - $level;
            for ($l=0; $l < $d - 1; $l++) {
                $forums[$parent_id]['last_children'] = true;
                $parent_id = $forums[$parent_id]['parent_id'];
            }
        }
    }
    $forums[$id]['level'] = $level;
    $forums[$id]['has_children'] = false;
    $forums[$id]['last_children'] = false;
    $right = $forum['right_id'];
    $store_prev = $forums[$id];
}
unset($level_store);

foreach ($forums as $forum_id => $forum) {
	echo "<pre>";
	echo "\t"*$forum[''];
	echo "</pre>";
}
