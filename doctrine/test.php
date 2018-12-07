<?php
header('Content-Type: text/html; charset=utf-8');
ini_set("error_log", __DIR__ . "/error.log");
error_reporting(32767);

require_once __DIR__ . "/../vendor/autoload.php";
require_once "test/model/Product.php";

// print_r(get_declared_classes());
// print PHP_EOL;
// print_r(class_exists('Doctrine\ORM\EntityManager'));
// print PHP_EOL;

use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;

$paths = [
    __DIR__ . "/test",
];
$isDevMode = true;

// the connection configuration
$dbParams = array(
    'driver'   => 'pdo_mysql',
    'user'     => 'lab',
    'password' => 'lab',
    'dbname'   => 'lab',
);
// $dbParams = [
//     'driver' => 'pdo_sqlite',
//     'path' => __DIR__ . '/db.sqlite',
// ];

$config = Setup::createAnnotationMetadataConfiguration($paths, $isDevMode);
$entityManager = EntityManager::create($dbParams, $config);
