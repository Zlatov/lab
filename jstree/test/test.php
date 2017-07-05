<?php

function ok($message, $status=true)
{
	header('Content-Type: application/json');
	echo json_encode([$message, $status], JSON_UNESCAPED_UNICODE);
}

// header('Content-Type: text/plain');
// echo "<pre>";
// print_r($_POST['data']);
// echo "</pre>";
// die();

if (!isset($_POST['data'])) {
	ok('нет данных.', false);
	die();
}

$data = $_POST['data'];
// $data = json_encode($_POST['data'], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
// header('Content-Type: text/plain');
// echo "<pre>";
// print_r($json);
// echo "</pre>";
// die();
file_put_contents('data/data.json', $data);
ok('сохранено');
