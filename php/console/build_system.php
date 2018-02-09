<?php
echo 'hi!';

require_once "../_libs/tree/src/Tree.php";

echo "<pre>";
print_r(get_declared_classes());
echo "</pre>";

use zlatov\tree\Tree;

$tests = [
  'flat_empty' => 'Преобразование пустого массива',
  'childrens' => 'Создан [] childrens',
  'tohtml' => 'Создан html',
];

foreach ($tests as $test => $header) {
  echo $test() . ' - ' . $header . PHP_EOL;
}

function flat_empty()
{
  $flat = [];
  $nested = Tree::to_nested($flat);
  if (is_array($nested)&&empty($nested)) {
    return true;
  }
  return false;
}

function childrens()
{
  $flat = [
    [
      'id' => 2,
      'pid' => 1,
      'header' => '2',
    ],
    [
      'id' => 10,
      'pid' => 0,
      'header' => '10',
    ],
  ];
  $nested = Tree::to_nested($flat);
  // print_r($nested);
  if (isset($nested[10]['childrens'])) {
    return true;
  }
  return false;
}

function tohtml()
{
  $flat = [
    [
      'id' => 2,
      'pid' => 10,
      'header' => '2',
    ],
    [
      'id' => 10,
      'pid' => 0,
      'header' => '10',
    ],
  ];
  $nested = Tree::to_nested($flat);
  $html = Tree::to_html($nested);
  if (is_string($html)&&!empty($html)) {
    // echo $html;
    return true;
  }
  return false;
}

