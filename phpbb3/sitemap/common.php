<?php

$opt = [
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_SILENT,
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_WARNING,
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
    PDO::ATTR_STRINGIFY_FETCHES => false, // Преобразовывать числовые значения в строки во время выборки.
];

$link = sprintf('mysql:host=%1$s;charset=%2$s', $config['host'], $config['charset']);
$pdo = new PDO($link, $config['user'], $config['password'], $opt);
$sql = sprintf("USE %s;", $config['dbName']);
$pdo->exec($sql);

function select_forums() {
	global $pdo;
	$sql = 'SELECT * FROM `forum_forums` WHERE `forum_id` <> 510 ORDER BY left_id ASC;';
	$stmt = $pdo->query($sql);
	$forums = $stmt->fetchAll();
	return $forums;
}
