#!/usr/bin/env php
<?php
// use Product;

// create_product.php <name>
require_once "../../test.php";
require_once "../model/Product.php";

$newProductName = $argv[1];

$product = new Product();
$product->setName($newProductName);

$entityManager->persist($product);
$entityManager->flush();

echo "Created Product with ID " . $product->getId() . "\n";
