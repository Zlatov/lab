<style type="text/css">
  * {
    font-size: 19px;
    line-height: 19px;
    font-family: monospace;
  }
</style>
<?php


$array = array();
$array[] = array('id'=>1, 'pid'=>0, 'header'=>'Abvgd 1');
$array[] = array('id'=>2, 'pid'=>0, 'header'=>'Bcdeg 2');
$array[] = array('id'=>3, 'pid'=>0, 'header'=>'Cdklm 3');
$array[] = array('id'=>4, 'pid'=>0, 'header'=>'Dejkm 4');
$array[] = array('id'=>5, 'pid'=>1, 'header'=>'Efjkm 1.1');
$array[] = array('id'=>6, 'pid'=>1, 'header'=>'Flmkr 1.2');
$array[] = array('id'=>7, 'pid'=>3, 'header'=>'Ghklm 3.1');
$array[] = array('id'=>8, 'pid'=>4, 'header'=>'Hstrp 4.1');
$array[] = array('id'=>9, 'pid'=>5, 'header'=>'Klmns 1.1.1');
$array[] = array('id'=>10,  'pid'=>5, 'header'=>'Lmrpt 1.1.2');
$array[] = array('id'=>11,  'pid'=>10,  'header'=>'Mnstr 1.1.2.1');
$array[] = array('id'=>12,  'pid'=>9, 'header'=>'Nklns 1.1.1.1');

$a2 = $array;


// Рекурсия с оформлением для выпадающего списка select
echo '<br>';
$pid = 0;
$level = 0;
$e = array();
function find2($a2,$pid,$level)
{
  global $e;
  $j = 0;
  $c = 0;
  foreach ($a2 as $key => $value) {
    if ($value['pid']===$pid)
    {
      $c++;
    }
  }
  $level++;

  foreach ($a2 as $key => $val)
  {
    if ($val['pid']===$pid)
    {
      for ($i=1; $i < $level; $i++)
      {
        echo ($e[$i]===1)?"┃":"  ";
        //echo " ";
      }
      if ($j===($c-1))
      {
        echo "┗";
        $e[$level] = 0;
      }
      else
      {
        echo "┣";
        $e[$level] = 1;
      }
      $j++;
      echo "╸ ".$val['header']."<br>";
      find2($a2,$val['id'],$level);
    }
  }
}
find2($a2,$pid,$level);
