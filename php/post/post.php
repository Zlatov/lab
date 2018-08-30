<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

  $data = [
    'request_method' => 'post',
    'a' => 1,
    'max' => isset($_POST['max']) ? true : false
  ];
} else {
  $data = [
    'a' => 1
  ];
}
// header('Content-Type: application/json');
// echo json_encode($data);

echo '$_POST: ' . var_export($_POST, true) . PHP_EOL;
foreach (getallheaders() as $name => $value) {
  echo "$name: $value\n";
}
