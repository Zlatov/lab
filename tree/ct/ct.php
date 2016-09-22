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
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
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
			selectChildrens();
			break;
	}
}

// Вывод дерева
$tree = fullTree();

function selectChildrens()
{
	global $pdo;
	$sql = file_get_contents('./sql/s_childrens.sql');
	$stmt = $pdo->prepare($sql);
	$stmt->bindValue(':id', $_POST['id'], PDO::PARAM_INT);
	$stmt->execute();
	$array = $stmt->fetchAll();
	echo "<pre>";
	print_r($array);
	echo "</pre>";
	$tree = transformToTree($array,(integer)$_POST['id']);
	$html = treeForPrint($tree);
	echo $html;
}

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
	$tree = [];
	while ($row = $stmt->fetch(PDO::FETCH_LAZY))
	{
		$tree[] = [
			'id'     => $row->id,
			'pid'    => $row->pid,
			'header' => $row->header,
		];
	}
	echo "<pre>";
	print_r($tree);
	echo "</pre>";
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
	$tplLiBegin = "<li>??header?? #??id??";
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
