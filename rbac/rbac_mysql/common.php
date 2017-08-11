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

function recreate()
{
    global $pdo, $config;
    try {
        $sql = file_get_contents(__DIR__ . '/sql/recreate_tables.sql');
        $pdo->exec($sql);
        $sql = file_get_contents(__DIR__ . '/../sql/procedures.sql');
        $pdo->exec($sql);
        echo "<p>Таблицы и процедуры созданы.</p>";
    } catch (PDOException $e) {
        echo "<p>{$e->errorInfo[2]}</p>";
        echo "<p>";
        echo $e->errorInfo[2];
        echo "</p>";
        echo '<pre>';
        echo $e->getTraceAsString();
        echo '</pre>';
    }
}

function add_user() {
    global $pdo, $config;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->preapre('CALL add_user(:name);');
        $stt->bindValue(':name', $_POST['name'], PDO::PARAM_STR);
        $stt->execute();
        $pdo->exec("COMMIT;");
        echo $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echo "<p>";
        echo $e->errorInfo[2];
        echo "</p>";
        echo '<pre>';
        echo $e->getTraceAsString();
        echo '</pre>';
    }
}
