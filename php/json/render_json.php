<?php
$data = ['a' => 1];
header('Content-Type: application/json');
echo json_encode($data);