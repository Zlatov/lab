<?php

function roles() {
	$roles = get_roles();
	$edges = get_edges();
	include 'view/model/role/roles.php';
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
