<?php

function users() {
    global $pdo, $config;
    if (!check_schema_select()) {
    	return null;
    }
    $users_page = isset($_POST['users_page'])?intval($_POST['users_page']):1;
    $users = get_users($users_page);
    $users_count = $pdo->query('SELECT FOUND_ROWS();')->fetchColumn();
	include 'view/model/user/users.php';
}

function add_user() {
    global $pdo, $config, $response;
    try {
        $pdo->exec("START TRANSACTION;");
        $stt = $pdo->prepare('CALL add_user(:name);');
        $stt->bindValue(':name', $_POST['name'], PDO::PARAM_STR);
        $stt->execute();
        $pdo->exec("COMMIT;");
        $response = $stt->rowCount();
    } catch (PDOException $e) {
        $pdo->exec("ROLLBACK;");
        echoPDOException($e);
    }
}

function get_users($users_page) {
    global $pdo, $config;
    $limit = $config['user']['limit'];
    $from = ($users_page-1)*$limit;
    $stt = $pdo->prepare('CALL get_users(:from,:limit);');
    $stt->bindValue(':from', $from, PDO::PARAM_INT);
    $stt->bindValue(':limit', $limit, PDO::PARAM_INT);
    $stt->execute();
    $users = $stt->fetchAll();
    return $users;
}
