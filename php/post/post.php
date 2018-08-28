<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $data = [
    'request_method' => 'post',
    'a' => 1
  ];
} else {
  $data = [
    'a' => 1
  ];
}
header('Content-Type: application/json');
echo json_encode($data);
