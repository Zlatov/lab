<?php

require_once '../../../php/_libs/tree/src/Tree.php';
require_once '../../../php/_libs/lab/PDOL.php';

use zlatov\tree\Tree;
use Lab\PDOL;

$pdo = PDOL::connect();

// !!! !!! !!!
// $pdo = PDOL::connect();
// $categories = new Tree($pdo, 'categories');
// $categories->all()->to_nested()->to_s();
// $categories->descendants(3)->to_nested()->to_s();
// !!! !!! !!!

$stmt = $pdo->query('select * from categories;');

while ($row = $stmt->fetch(PDO::FETCH_LAZY))
{
  echo $row[0] . ' ';
  echo $row['name'] . ' ';
  echo $row->name . PHP_EOL;
}
