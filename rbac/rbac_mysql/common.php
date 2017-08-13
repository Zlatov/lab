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

function check_schema_exist()
{
    global $pdo, $config;
    $sql = sprintf(
        "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '%s';",
        $config['dbName']
    );
    $stmt = $pdo->query($sql);
    $db = $stmt->fetchColumn();
    if ($db) {
        return true;
    } else {
        return false;
    }
}

function schema_select()
{
    global $pdo, $config;
    $sql = sprintf("USE %s;", $config['dbName']);
    $pdo->exec($sql);
}

function recreate_schema()
{
    global $pdo, $config;
    try {
        $sql = sprintf(
            file_get_contents(__DIR__ . '/sql/recreate_schema.sql'),
            $config['dbName']
        );
        $pdo->exec($sql);
        echo "<p>База данных пересоздана.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function recreate_tables()
{
    global $pdo, $config;
    try {
        $sql = file_get_contents(__DIR__ . '/sql/recreate_tables.sql');
        $pdo->exec($sql);
        $sql = file_get_contents(__DIR__ . '/sql/recreate_triggers.sql');
        $pdo->exec($sql);
        echo "<p>Таблицы и триггеры созданы.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function recreate_procedures()
{
    global $pdo, $config;
    try {
        $sql = file_get_contents(__DIR__ . '/sql/recreate_procedures.sql');
        $pdo->exec($sql);
        echo "<p>Процедуры созданы.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function add_user() {
    global $pdo, $config;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->prepare('CALL add_user(:name);');
        $stt->bindValue(':name', $_POST['name'], PDO::PARAM_STR);
        $stt->execute();
        $pdo->exec("COMMIT;");
        echo $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echoPDOException($e);
    }
}

function add_role() {
    global $pdo, $config;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->prepare('CALL add_role(:name);');
        $stt->bindValue(':name', $_POST['name'], PDO::PARAM_STR);
        $stt->execute();
        $pdo->exec("COMMIT;");
        echo $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echoPDOException($e);
    }
}

function add_perm() {
    global $pdo, $config;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->prepare('CALL add_perm(:name, :description);');
        $stt->bindValue(':name', $_POST['name'], PDO::PARAM_STR);
        $stt->bindValue(':description', $_POST['description'], PDO::PARAM_STR);
        $stt->execute();
        $pdo->exec("COMMIT;");
        echo $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echoPDOException($e);
    }
}

function echoPDOException($e) {
    echo "<p>";
    echo $e->errorInfo[2];
    echo "</p>";
    echo '<pre>';
    echo $e->getTraceAsString();
    echo '</pre>';
}
