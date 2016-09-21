<a href="">ct</a>
<form method="post">
	<fieldset>
		<legend>Пересоздать базу</legend>
		<button type="submit" name="submitForm" value="createDb">Пересоздать</button>
	</fieldset>
	<fieldset>
		<legend>Пересоздать таблицы</legend>
		<button type="submit" name="submitForm" value="createTables">Пересоздать</button>
	</fieldset>
	<fieldset>
		<legend>Добавить тестовые данные</legend>
		<button type="submit" name="submitForm" value="addTest">Добавить</button>
	</fieldset>
	<fieldset>
		<legend>Добавление</legend>
		<input type="text" name="header">
		<button type="submit" name="submitForm" value="add">Добавить</button>
	</fieldset>
	<fieldset>
		<legend>Выбор предков</legend>
		<input type="text" name="id">
		<button type="submit" name="submitForm" value="selectParents">Выбрать</button>
	</fieldset>
	<fieldset>
		<legend>Выбор потомков</legend>
		<input type="text" name="id">
		<button type="submit" name="submitForm" value="selectChildrens">Выбрать</button>
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
	switch ($_POST['submitForm']) {
		case 'createDb':
			createDb();
			break;

		case 'createTables':
			createTables();
			break;

		case 'addTest':
			addTest();
			break;

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

function createDb()
{
	global $pdo, $dbName;
	$sql = file_get_contents('./sql/c_db.sql');
	eval("\$sql = \"$sql\";");
	$stmt = $pdo->query($sql);
	// $stmt = $pdo->prepare($sql);
	// $stmt->execute(['dbName' => $dbName]);
}

function createTables()
{
	global $pdo;
	$sql = file_get_contents('./sql/c_tables.sql');
	$stmt = $pdo->query($sql);
}

function addTest()
{
	global $pdo;
	$sql = file_get_contents('./sql/i_test.sql');
	$stmt = $pdo->query($sql);
}
function fullTree()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_all.sql');
	$stmt = $pdo->query($sql);
	while ($row = $stmt->fetch(PDO::FETCH_LAZY))
	{
	    echo $row->id . " ";
	    echo $row->pid . " ";
	    echo $row->header . " ";
	    echo $row->aid . " ";
	    echo $row->did . " ";
	    echo '<br>';
	}
}
