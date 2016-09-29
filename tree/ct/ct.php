<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>CT</title>
	<style type="text/css">
		.tree { padding-left:25px; }
		.tree ul { margin:0; padding-left:6px; }
		.tree li { position:relative; list-style:none outside none; border-left:solid 1px #999; margin:0; padding:0 0 0 19px; line-height:23px; }
		.tree li:before { content:''; display:block; border-bottom:solid 1px #999; position:absolute; width:18px; height:11px; left:0; top:0; }
		.tree li:last-child { border-left:0 none; }
		.tree li:last-child:before { border-left:solid 1px #999; }		
	</style>
</head>
<body>
<h1><a href="">ct</a></h1>
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
		<button type="submit" name="submitForm" value="addTestValues">Добавить</button>
	</fieldset>
	<fieldset>
		<legend>Добавление</legend>
		в id: <input type="text" name="pid" placeholder="pid (0|1|..)" value="5">
		header: <input type="text" name="header" placeholder="header" value=")))">
		<button type="submit" name="submitForm" value="add">Добавить</button>
	</fieldset>
	<fieldset>
		<legend>Выбор предков</legend>
		<input type="text" name="did">
		<button type="submit" name="submitForm" value="selectParents">Выбрать</button>
	</fieldset>
	<fieldset>
		<legend>Выбор потомков</legend>
		<input type="text" name="id">
		<button type="submit" name="submitForm" value="selectChildrens">Выбрать</button>
	</fieldset>
	<fieldset>
		<legend>Переместить элемент</legend>
		id: <input type="text" name="eid">
		в id: <input type="text" name="tid">
		<button type="submit" name="submitForm" value="move">Переместить</button>
	</fieldset>
	<fieldset>
		<legend>Удалить элемент</legend>
		id: <input type="text" name="delid" placeholder="pid (0|1|..)" value="5">
		рекурсивно: <input type="hidden" name="recursively" value="0"><input type="checkbox" name="recursively" value="1">
		<button type="submit" name="submitForm" value="del">Удалить</button>
	</fieldset>
</form>

<?php

// Конфиг
include_once 'config.php';

// Коннект
$opt = [
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_SILENT,
    // PDO::ATTR_ERRMODE            => PDO::ERRMODE_WARNING,
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
    PDO::ATTR_STRINGIFY_FETCHES => false, // Преобразовывать числовые значения в строки во время выборки.
];
// $pdo = new PDO('mysql:host=$host;dbname=$dbName;charset=$charset', $user, $password, $opt);
$pdo = new PDO("mysql:host=$host;charset=$charset", $user, $password, $opt);
$stmt = $pdo->query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$dbName'");
$db = $stmt->fetchColumn();
if ($db) {
	$pdo->exec("USE $dbName");
}

// Логика
if (isset($_POST['submitForm'])) {
	switch ($_POST['submitForm']) {
		case 'createDb':
			createDb();
			break;

		case 'createTables':
			createTables();
			break;

		case 'addTestValues':
			addTestValues();
			break;

		case 'add':
			add();
			break;

		case 'del':
			del();
			break;

		case 'move':
			move();
			break;

		case 'selectParents':
			selectParents();
			break;

		case 'selectChildrens':
			selectChildrens();
			break;
	}
}

$db = $pdo->query('select database()')->fetchColumn();
if ($db) {
	$dbTable1 = $pdo->query("SHOW TABLES LIKE 'ct_tree'")->fetchColumn();
	$dbTable2 = $pdo->query("SHOW TABLES LIKE 'ct_tree_rel'")->fetchColumn();
	if ($dbTable1&&$dbTable2) {
		// Вывод дерева
		$tree = fullTree();
	}
}

function add()
{
	global $pdo;
	$stmt = $pdo->prepare('CALL tree_ct_add(:pid, :header)');
	$stmt->bindValue(':header', $_POST['header'], PDO::PARAM_STR);
	$stmt->bindValue(':pid', $_POST['pid'], PDO::PARAM_INT);
	$stmt->execute();
	header('Refresh:0');
}

function del()
{
	global $pdo;
	$stmt = $pdo->prepare('CALL tree_ct_del(:delid, :recursively)');
	$stmt->bindValue(':delid', $_POST['delid'], PDO::PARAM_INT);
	$stmt->bindValue(':recursively', $_POST['recursively'], PDO::PARAM_BOOL);
	$stmt->execute();
	header('Refresh:0');
}

function move()
{
	global $pdo;
	$stmt = $pdo->prepare('call tree_ct_move(:eid, :tid)');
	$stmt->bindValue(':eid', $_POST['eid'], PDO::PARAM_INT);
	$stmt->bindValue(':tid', $_POST['tid'], PDO::PARAM_INT);
	$stmt->execute();
	$array = $stmt->fetchAll();
	echo "<pre>";
	print_r($array);
	echo "</pre>";
}

function selectParents()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_parents.sql');
	$stmt = $pdo->prepare($sql);
	$stmt->bindValue(':did', $_POST['did'], PDO::PARAM_INT);
	$stmt->execute();
	$array = $stmt->fetchAll();
	$tree = transformToTree($array);
	$html = treeForPrint($tree);
	echo $html;
}

function selectChildrens()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_childrens.sql');
	$stmt = $pdo->prepare($sql);
	$stmt->bindValue(':id', $_POST['id'], PDO::PARAM_INT);
	$stmt->execute();
	$array = $stmt->fetchAll();
	$tree = transformToTree($array,(integer)$_POST['id']);
	$html = treeForPrint($tree);
	echo $html;
}

function createDb()
{
	global $pdo, $dbName;
	$sql = file_get_contents('./sql/c_db.sql');
	eval("\$sql = \"$sql\";");
	$pdo->exec($sql);
}

function createTables()
{
	global $pdo;
	$sql = file_get_contents('./sql/c_tables.sql');
	$intOrFalse = $pdo->exec($sql);
	$sql = file_get_contents('./sql/procedures.sql');
	// $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
	try {
		$intOrFalse = $pdo->exec($sql);
		echo "<pre>";
		var_dump($pdo->query("SHOW WARNINGS")->fetch());
		echo "</pre>";
	} catch (PDOException $e) {
		echo "PDOException: <pre>";
		echo $e->getMessage();
		echo "</pre>";
		die();
	}
	if ($intOrFalse === false) {
		die(
			"Errors: " . 
			print_r($pdo->errorInfo(), true) . 
			"Warnings: " . 
			print_r($pdo->query("SHOW WARNINGS")->fetch(), true)
		);
	}
}

function addTestValues()
{
	global $pdo;
	$sql = file_get_contents('./sql/i_test.sql');
	$stmt = $pdo->exec($sql);
	header('Refresh:0');
}
function fullTree()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_all.sql');
	$stmt = $pdo->query($sql);
	$tree = [];
	while ($row = $stmt->fetch(PDO::FETCH_LAZY))
	{
		$tree[] = [
			'id'     => $row->id,
			'pid'    => $row->pid,
			'header' => $row->header,
		];
	}
	$tree = transformToTree($tree);
	$html = treeForPrint($tree);
	echo $html;
}

// Преобразование
function transformToTree($array, $parentIdOfZeroLevel = 0) {
	$result = [];
	$level = 0;
	$pid[$level] = $parentIdOfZeroLevel;
	while ($level >= 0) {
		if ( $e = each($array) ) {
			if ($e[1]['pid'] === $pid[$level]) {
				$e[1]['level'] = $level;
				$result[] = $e[1];
				unset($array[$e[0]]);
				foreach ($t = $array as $val) {
					if ( $val['pid'] === $e[1]['id'] ) {
						$pid[++$level] = $e[1]['id'];
						reset($array);
						break;
					}
				}
			}
		} else {
			$level--;
			reset($array);
		}
	}
	return $result;
}

function treeForPrint($tree)
{
	$html = "<ul class='tree'>";
	$tplUlBegin = "<ul>";
	$tplUlEnd = "</ul>";
	$tplLiBegin = "<li>??header?? <small>#??id??</small>";
	$tplLiEnd = "</li>";

	foreach ($tree as $key => $val) {
		$replace = [];
		foreach ($val as $key2 => $val2 ) { $replace["??$key2??"] = $val2; }
		$html .= str_replace(array_keys($replace),$replace,$tplLiBegin);
		if ( isset($tree[$key+1]) ) {
			if ($tree[$key+1]['level']>$val['level']) { $html .= $tplUlBegin; }
			if ($tree[$key+1]['level']==$val['level']) { $html .= $tplLiEnd; }
			if ($tree[$key+1]['level']<$val['level']) {
				$k = $val['level'] - $tree[$key+1]['level'];
				for ( $i=0; $i<$k; $i++ ) {
					$html .= $tplLiEnd.$tplUlEnd;
				}
			}
		} else {
			$html .= $tplLiEnd;
			$k = $val['level'];
			for ( $i=0; $i<$k; $i++ )
			{
				$html .= $tplUlEnd.$tplLiEnd;
			}
		}
	}
	$html .= $tplUlEnd;
	return $html;
}
?>
</body>
</html>
