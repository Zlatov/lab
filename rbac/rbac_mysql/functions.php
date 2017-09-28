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

function check_schema_select()
{
    global $pdo, $config;
    $db = $pdo->query('SELECT database();')->fetchColumn();
    if ($db===$config['dbName']) {
        return true;
    } else {
        return false;
    }
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

function connect_role() {
    global $pdo, $config;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->prepare('CALL connect_role(:did, :aid);');
        $stt->bindValue(':did', $_POST['did'], PDO::PARAM_INT);
        $stt->bindValue(':aid', $_POST['aid'], PDO::PARAM_INT);
        $stt->execute();
        $pdo->exec("COMMIT;");
        echo $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echoPDOException($e);
    }
}

function get_users() {
    global $pdo, $config;
    $stt = $pdo->query('CALL get_users();');
    $users = $stt->fetchAll();
    return $users;
}

function get_roles() {
    global $pdo, $config;
    $roles = $pdo->query('CALL get_roles();')->fetchAll();
    return $roles;
}

function get_edges() {
    global $pdo, $config;
    $edges = $pdo->query('CALL get_edges();')->fetchAll();
    return $edges;
}

function get_perm() {
    global $pdo, $config;
    $perm = $pdo->query('CALL get_perm();')->fetchAll();
    return $perm;
}

function get_users_tbale($users) {
    $table = '<table class="ib"><caption>Пользователи</caption><thead><tr><th>id</th><th>name</th></tr></thead><tbody>';
    foreach ($users as $user) {
        $table.= '<tr><td>';
        $table.= $user['id'];
        $table.= '</td><td>';
        $table.= $user['name'];
        $table.= '</td></tr>';
    }
    $table.= '</tbody></table>';
    return $table;
}

function get_edges_tbale($edges) {
    $table = '<table class="ib"><caption>Ребра</caption><thead><tr><th>aid</th><th>did</th></tr></thead><tbody>';
    foreach ($edges as $role) {
        $table.= '<tr><td>';
        $table.= $role['aid'];
        $table.= '</td><td>';
        $table.= $role['did'];
        $table.= '</td></tr>';
    }
    $table.= '</tbody></table>';
    return $table;
}

function get_roles_tbale($roles) {
    $table = '<table class="ib"><caption>Роли</caption><thead><tr><th>id</th><th>name</th></tr></thead><tbody>';
    foreach ($roles as $role) {
        $table.= '<tr><td>';
        $table.= $role['id'];
        $table.= '</td><td>';
        $table.= $role['name'];
        $table.= '</td></tr>';
    }
    $table.= '</tbody></table>';
    return $table;
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
    echo "<p>";
    echo $e->errorInfo[2];
    echo "</p>";
    echo '<pre>';
    echo $e->getTraceAsString();
    echo '</pre>';
}
