<?php
// list_products.php
require_once "../../test.php";
require_once "../model/Product.php";

$productRepository = $entityManager->getRepository('Product');
$products = $productRepository->findAll();

foreach ($products as $product) {
    echo sprintf("-%s\n", $product->getName());
}
