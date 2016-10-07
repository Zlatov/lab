<?php
if (set_time_limit (30)) {
    echo '30';
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
    }
        
    foreach ($badTree as $key => &$value) {
        if ($value['level']!==0) {
            unset($badTree[$key]);
        }
        unset($value['level']);
        unset($value['parent_id']);
    }
                
    // return array($goodTree,$badTree);
    return $badTree;
}

$start = microtime(true);
for ($i=0; $i < 30; $i++) {
    $bb = ab($aa);
}
$time = microtime(true) - $start;
printf('<br>Скрипт с ab($a); выполнялся %.4F сек.', $time);
    
    
$start = microtime(true);
for ($i=0; $i < 30; $i++) {
    $bb = FunctionAB($aa);
}
$time = microtime(true) - $start;
printf('<br>Скрипт c FunctionAB($a); выполнялся %.4F сек.', $time);
        
// echo "<pre>";
// print_r($bb);
// echo "</pre>";
$b = ab($a);
echo '<hr>';
echo '<hr>';
echo '<hr>';


echo "<pre>";
print_r($a);
echo "</pre>";

echo '<hr>';

echo "<pre>";
print_r($b);
echo "</pre>";
            
