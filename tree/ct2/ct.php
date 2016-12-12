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
<h2>добавить ордер</h2>
<h2>желательно добавить level</h2>
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
		<legend>Добавить рандомное дерево</legend>
		<button type="submit" name="submitForm" value="addRandValues">Добавить</button>
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
$stmt = $pdo->query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$dbName';");
$db = $stmt->fetchColumn();
if ($db) {
	$pdo->exec("USE $dbName;");
    echo "<p>При создании PDO подключения выбрана база данных $dbName</p>";
} else {
    echo "<p>При создании PDO подключения небыла найдена база $dbName</p>";
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

		case 'addRandValues':
			addRandValues();
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
if (!$db) {
    echo "База данных не выбрана";
    die();
} else {
    echo "<p>Выбрана база данных: $db</p>";
}
$dbTable1 = $pdo->query("SHOW TABLES LIKE 'tree'")->fetchColumn();
$dbTable2 = $pdo->query("SHOW TABLES LIKE 'treerel'")->fetchColumn();
if (!$dbTable1||!$dbTable2) {
    echo "Нет таблиц.";
    die();
}
$tree = fullTree();

function add()
{
	global $pdo;
	$stmt = $pdo->prepare('CALL tree_add(:pid, :header)');
	$stmt->bindValue(':header', $_POST['header'], PDO::PARAM_STR);
	$stmt->bindValue(':pid', $_POST['pid'], PDO::PARAM_INT);
	$stmt->execute();
	header('Refresh:0');
}

function del()
{
	global $pdo;
	// $stmt = $pdo->prepare('CALL tree_del(:delid, :recursively)');
	$stmt = $pdo->prepare('CALL tree_del(:delid)');
	$stmt->bindValue(':delid', $_POST['delid'], PDO::PARAM_INT);
	// $stmt->bindValue(':recursively', $_POST['recursively'], PDO::PARAM_BOOL);
	$stmt->execute();
	header('Refresh:0');
}

function move()
{
	global $pdo;
	$stmt = $pdo->prepare('call tree_move(:eid, :tid)');
	$stmt->bindValue(':eid', $_POST['eid'], PDO::PARAM_INT);
	$stmt->bindValue(':tid', $_POST['tid'], PDO::PARAM_INT);
	$stmt->execute();
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
    try {
	   $pdo->exec($sql);
       $pdo->exec("USE $dbName;");
    } catch (PDOException $e) {
        die($e->getMessage());
    }
    echo "<p>База данных $dbName создана.</p>";
}

function createTables()
{
    global $pdo;
    // $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
    try {
        $pdo->exec(file_get_contents('./sql/c_tables.sql'));
        $pdo->exec(file_get_contents('./sql/triggers.sql'));
        echo "<p>Таблицы, процедуры и триггреы созданы.</p>";
    } catch (PDOException $e) {
        echo "<p>{$e->getMessage()}</p>";
        die();
    }
}

function addTestValues()
{
    global $pdo;
    $sql = file_get_contents('./sql/i_test.sql');
    try {
        $pdo->exec($sql);
        echo "<p>Тестовые данные вставлены.</p>";
	    // header('Refresh:0');
    } catch (PDOException $e) {
        die("<p>" . $e->getMessage() . "</p>");
    }
}

function addRandValues()
{
	global $pdo;
	$stmt = $pdo->prepare('CALL tree_add(:pid, :header)');
	// 5 = 5
	// 5 + 5*2 = 15
	// 5 + 5*2 + 5*2*2 = 35
	// 5 + 5*2 + 5*2*2 + 5*2*2*2 = 75
	// 5 + 5*2 + 5*2*2 + 5*2*2*2 + 5*2*2*2*1 = 115
	for ($i=1; $i <= 115; $i++) {
		switch (true) {
			case $i<=5:
				$pid = 0;
				break;
			case $i<=15:
				$pid = mt_rand(1,5);
				break;
			case $i<=35:
				$pid = mt_rand(6,15);
				break;
			case $i<=75:
				$pid = mt_rand(16,35);
				break;
			default:
				$pid = mt_rand(36,75);
				break;
		}
		$stmt->bindValue(':header', 'e'.$i, PDO::PARAM_STR);
		$stmt->bindValue(':pid', $pid, PDO::PARAM_INT);
		$stmt->execute();
	}
}

function fullTree()
{
	global $pdo;
	// $sql = file_get_contents('./sql/s_all.sql');
	$stmt = $pdo->query('select * from `tree`;');
	// $tree = [];
	// while ($row = $stmt->fetch(PDO::FETCH_LAZY))
	// {
	// 	$tree[] = [
	// 		'id'     => $row->id,
	// 		'pid'    => $row->pid,
	// 		'header' => $row->header,
	// 	];
	// }
    $tree = $stmt->fetchAll();
	shuffle($tree);
	$a = toMultidimensionalTree($tree);
	$html2 = echoMultidimensionalTree($a);
	echo $html2;
}

// Преобразование массива в упорядоченное дерево с помощью рекурсивного обхода
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

// Преобразование массива в упорядоченное дерево за 1 проход
function toMultidimensionalTree($array, $rootId = null)
{
    $return = [];
    $cache = [];
    // Для каждого элемента
    foreach ($array as $key => $value) {
        // Если нет родителя элемента, и элемент не корневой,
        // тогда создаем родителя в возврат а ссылку в кэш
        if (!isset($cache[$value['pid']]) && ($value['pid'] != $rootId)) {
            $return[$value['pid']] = [
                'id' => $value['pid'],
                'header' => null,
                'pid' => null,
                'childrens' => [],
            ];
            $cache[$value['pid']] = &$return[$value['pid']];
        }
        // Если элемент уже был создан, значит он был чьим-то родителем, тогда
        // обновим в нем информацию о его родителе
        if (isset($cache[$value['id']])) {
            $cache[$value['id']]['pid'] = $value['pid'];
            $cache[$value['id']]['header'] = $value['header'];
            // Если этот элемент не корневой,
            // тогда переместим его в родителя, и обновим ссылку в кэш
            if ($value['pid'] != $rootId) {
                $cache[$value['pid']]['childrens'][$value['id']] = $return[$value['id']];
                unset($return[$value['id']]);
                $cache[$value['id']] = &$cache[$value['pid']]['childrens'][$value['id']];
            }
        }
        // Иначе, элемент новый, родитель уже создан, добавим в родителя
        else {
            // Если элемент не корневой - вставляем в родителя беря его из кэш
            if ($value['pid'] != $rootId) {
                // Берем родителя из кэш и вставляем в "детей"
                $cache[$value['pid']]['childrens'][$value['id']] = [
                    'id' => $value['id'],
                    'header' => $value['header'],
                    'pid' => $value['pid'],
                    'childrens' => [],
                ];
                // Вставляем в кэш ссылку на элемент
                $cache[$value['id']] = &$cache[$value['pid']]['childrens'][$value['id']];
            }
            // Если элемент кокренвой, вставляем сразу в return
            else {
                $return[$value['id']] = [
                    'id' => $value['id'],
                    'header' => $value['header'],
                    'pid' => $value['pid'],
                    'childrens' => [],
                ];
                // Вставляем в кэш ссылку на элемент
                $cache[$value['id']] = &$return[$value['id']];
            }
        }
    }
    return $return;
}

function echoMultidimensionalTree($array)
{
    $html = "<ul class='tree'>".PHP_EOL;
	$tplUlBegin = "<ul>".PHP_EOL;
	$tplUlEnd   = "</ul>".PHP_EOL;
	$tplLiBegin = "<li>??header?? <small>#??id??</small>".PHP_EOL;
	$tplLiEnd   = "</li>".PHP_EOL;

    // $html = "&lt;ul class='tree'&gt;".PHP_EOL;
    // $tplUlBegin = "&lt;ul&gt;".PHP_EOL;
    // $tplUlEnd = "&lt;/ul&gt;".PHP_EOL;
    // $tplLiBegin = "&lt;li&gt;??id??".PHP_EOL;
    // $tplLiEnd = "&lt;/li&gt;".PHP_EOL;

    $level = 0;
    $parentArray[$level] = $array;
    while ($level >= 0) {
        $mode = each($parentArray[$level]);
        if ($mode !== false) {

            $replace["??id??"] = $mode[0];
            $replace["??header??"] = $mode[1]['header'];
            $html .= str_repeat("    ", $level*2 + 1) . str_replace(array_keys($replace),$replace,$tplLiBegin);

            // echo "<pre>";
            // echo str_repeat("   ", $level);
            // echo $mode[1]['id'].PHP_EOL;
            // echo "</pre>";
            if (count($mode[1]['childrens'])) {
                $level++;
                $parentArray[$level] = $mode[1]['childrens'];
                $html .= str_repeat("    ", $level*2) . "$tplUlBegin";
            } else {
                $html .= str_repeat("    ", $level*2 + 1) . "$tplLiEnd";
            }
        } else {
            $html .= ($level>0)?str_repeat("    ", ($level)*2) . "$tplUlEnd":"$tplUlEnd";
            $html .= ($level>0)?str_repeat("    ", ($level)*2 - 1) . "$tplLiEnd":'';
            $level--;
        }
    }

    return $html;

    // echo "<pre>";
    // print_r($html);
    // echo "</pre>";
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
