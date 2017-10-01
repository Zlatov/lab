<?php

$opt = [
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_SILENT,
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_WARNING,
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
    PDO::ATTR_STRINGIFY_FETCHES => false, // Преобразовывать числовые значения в строки во время выборки.
];

$link = sprintf('mysql:host=%1$s;charset=%2$s', $config['db']['host'], $config['db']['charset']);
$pdo = new PDO($link, $config['db']['user'], $config['db']['password'], $opt);

function check_schema_exist()
{
    global $pdo, $config;
    $sql = sprintf(
        "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '%s';",
        $config['db']['dbName']
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
    $sql = sprintf("USE %s;", $config['db']['dbName']);
    $pdo->exec($sql);
}

function check_schema_select()
{
    global $pdo, $config;
    $db = $pdo->query('SELECT database();')->fetchColumn();
    if ($db===$config['db']['dbName']) {
        return true;
    } else {
        return false;
    }
}

function recreate_schema()
{
    global $pdo, $config, $response;
    try {
        $sql = sprintf(
            file_get_contents(__DIR__ . '/sql/recreate_schema.sql'),
            $config['db']['dbName']
        );
        $pdo->exec($sql);
        $response = "<p>База данных пересоздана.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function recreate_tables_triggers_procedures()
{
    global $pdo, $config, $response;
    try {
        $sql = file_get_contents(__DIR__ . '/sql/recreate_tables.sql');
        $pdo->exec($sql);
        $sql = str_replace([';;', 'DELIMITER ;;', 'DELIMITER ;'], [';'], file_get_contents(__DIR__ . '/sql/recreate_triggers.sql'));
        $pdo->exec($sql);
        $sql = str_replace([';;', 'DELIMITER ;;', 'DELIMITER ;'], [';'], file_get_contents(__DIR__ . '/sql/recreate_procedures.sql'));
        $pdo->exec($sql);
        $response = "<p>Таблицы, триггеры и процедуры созданы.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function recreate_procedures()
{
    global $pdo, $config, $response;
    if (!check_schema_exist()) {
        $response = '<p>База данных не существует.</p>';
        return null;
    } else {
        schema_select();
    }
    try {
        $sql = str_replace([';;', 'DELIMITER ;;', 'DELIMITER ;'], [';'], file_get_contents(__DIR__ . '/sql/recreate_procedures.sql'));
        $pdo->exec($sql);
        $response = "<p>Процедуры созданы.</p>";
    } catch (PDOException $e) {
        echoPDOException($e);
    }
}

function insert_test_data_with_api()
{
    global $pdo, $config, $response;
    try {
        $sql = file_get_contents(__DIR__ . '/sql/insert_test_data_with_api.sql');
        $pdo->exec($sql);
        $response = "<p>Данные вставлены.</p>";
    } catch (PDOException $e) {
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

function get_perm() {
    global $pdo, $config;
    $perm = $pdo->query('CALL get_perm();')->fetchAll();
    return $perm;
}

function get_perm_tbale($perms) {
    $table = '<table class="ib"><caption>Разрешения</caption><thead><tr><th>id</th><th>name</th></tr></thead><tbody>';
    foreach ($perms as $perm) {
        $table.= '<tr><td>';
        $table.= $perm['id'];
        $table.= '</td><td>';
        $table.= $perm['name'];
        $table.= '</td></tr>';
    }
    $table.= '</tbody></table>';
    return $table;
}

function echoPDOException($e) {
    global $response;
    $response = <<<HTML
        <p>{$e->errorInfo[2]}</p>
        <pre>{$e->getTraceAsString()}</pre>
HTML;
}
