<?php

require_once '../../../../php/_libs/tree/src/Tree.php';
require_once '../../../../php/_libs/tree/src/TraitTree.php';
require_once '../../../../php/_libs/lab/LabPDO.php';

use Zlatov\Tree\Tree;
use Zlatov\Tree\TraitTree;
use Lab\LabPDO;

$pdo = LabPDO::connect();

class Categories {
  use TraitTree;
  private static $tree_options = [
    'table_name' => 'categories',
    'pdo' => 'pdo',
  ];
}

// !!! !!! !!!
// $pdo = LabPDO::connect();
// $categories = new Tree($pdo, 'categories');
// $categories->all()->to_nested()->to_s();
// $categories->descendants(3)->to_nested()->to_s();
// !!! !!! !!!

// $stmt = $pdo->query('select * from categories;');
// while ($row = $stmt->fetch(PDO::FETCH_LAZY))
// {
//   echo $row[0] . ' ';
//   echo $row['name'] . ' ';
//   echo $row->name . PHP_EOL;
// }

$sql = file_get_contents('../tables.sql');
$sql.= file_get_contents('../triggers.sql');
$sql.= file_get_contents('../procedures.sql');
$pdo->exec($sql);
$sql = file_get_contents('./data/1.sql');
$pdo->exec($sql);

$categories = Categories::tree_all();
$nested = Categories::to_nested($categories);
$html = Categories::to_html($nested);
print_r($html);

// $categories = Categories::descendants(1);        // |+++++++…
// $categories = Categories::descendants(1, 3);     // |--+++++…
// $categories = Categories::descendants(1, -3);    // |+++----…
// $categories = Categories::descendants(1, 3, 2);  // |--++---…
// $categories = Categories::descendants(1, 3, -2); // |-++----…

// $categories = Categories::ancestors();
// $categories = Categories::childrens();
// $categories = Categories::parent();

// print_r($categories);
