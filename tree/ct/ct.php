<form method="post">
	<fieldset>
		<legend>Добавление</legend>
		<input type="text" name="header">
		<input type="hidden" name="action" value="add">
		<input type="submit" name="submitForm" value="Добавить">
	</fieldset>
	<fieldset>
		<legend>Выбор предков</legend>
		<input type="text" name="id">
		<input type="hidden" name="action" value="selectParents">
		<input type="submit" name="submitForm" value="Выбрать">
	</fieldset>
	<fieldset>
		<legend>Выбор потомков</legend>
		<input type="text" name="id">
		<input type="hidden" name="action" value="selectChildrens">
		<input type="submit" name="submitForm" value="Выбрать">
	</fieldset>
</form>

<?php

// Конфиг
include_once 'config.php';

// Коннект
$dsn = "mysql:host=$host;dbname=$dbName;charset=$charset";
$opt = array(
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
);
$pdo = new PDO($dsn, $user, $password, $opt);

// Логика
if (isset($_POST['submitForm'])) {
	switch ($_POST['action']) {
		case 'add':
			break;
		
		case 'selectParents':
			break;
		
		case 'selectChildrens':
			break;
	}
}

// Вывод дерева
$tree = fullTree();

function fullTree()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_all.sql');
	$stmt = $pdo->query($sql);
	while ($row = $stmt->fetch(PDO::FETCH_LAZY))
	{
	    echo $row->id . " ";
	    echo $row->header . " ";
	    echo $row->pid . " ";
	    echo $row->cid . " ";
	    echo '<br>';
	}
}
