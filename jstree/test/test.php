<?php

function ok($message, $status=true) {
	header('Content-Type: application/json');
	echo json_encode([$message, $status], JSON_UNESCAPED_UNICODE);
}

if (!isset($_POST['data'])) {
	ok('Нет данных.', false);
	die();
}

$data = $_POST['data'];
file_put_contents('data/data.json', $data);
ok('сохранено');
