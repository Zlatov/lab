<?php

require_once '../../../php/_libs/tree/src/Tree.php';
require_once '../../../php/_libs/lab/LabPDO.php';

use zlatov\tree\Tree;
use Lab\LabPDO;

$pdo = LabPDO::connect();

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

$sql = file_get_contents('./init/tables.sql');
$sql.= file_get_contents('./init/triggers.sql');
$sql.= file_get_contents('./init/procedures.sql');
$pdo->exec($sql);
$sql = file_get_contents('./');
