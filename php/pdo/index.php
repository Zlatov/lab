<?php
// Prepared Statement  - подготовленное выражение (оператор)
// Statement Handle - указатель на выражение (оператор)
// Отсюда и сокращения в роде $stmt, $sth

include_once 'config.php';
$host = 'localhost';
$dbName = 'tree';
$charset = 'utf8';
$dsn = "mysql:host=$host;dbname=$dbName;charset=$charset";


// Соединение
$opt = array(
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
	// PDO::ATTR_ERRMODE - Режим сообщений об ошибках.
	// PDO::ERRMODE_EXCEPTION - Выбрасывать исключения.
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
	// PDO::ATTR_DEFAULT_FETCH_MODE - Задает режим выборки данных по умолчанию.
	// PDO::FETCH_ASSOC: возвращает массив, индексированный именами столбцов результирующего набора

    // PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
    // PDO::ATTR_STRINGIFY_FETCHES => false, // Преобразовывать числовые значения в строки во время выборки.

);
$pdo = new PDO($dsn, $user, $password, $opt);

// Выполнение запросов
$stmt = $pdo->query('SELECT header FROM test');
while ($row = $stmt->fetch())
{
    echo $row['header'] . "\n";
}

// Подготовленные выражения
$sql = 'SELECT name FROM users WHERE email = ?';
$sql = 'SELECT name FROM users WHERE email = :email';

$id = 1;
$stmt = $pdo->prepare('SELECT header FROM test WHERE id = ?');
$stmt->execute(array($id));

$stmt = $pdo->prepare('SELECT header FROM test WHERE id = :id');
$stmt->execute(array('id' => $id));


$id = 1;
$header = 'qwer';

$sth = $pdo->prepare('SELECT header FROM test WHERE id = ? AND header = ?');
$sth->bindValue(1, $id, PDO::PARAM_INT);
$sth->bindValue(2, $header, PDO::PARAM_STR);
$sth->execute();

$sth = $pdo->prepare('SELECT header FROM test WHERE id = :id AND header = :header');
$sth->bindValue(':id', $id, PDO::PARAM_INT);
$sth->bindValue(':header', $header, PDO::PARAM_STR);
$sth->execute();


// Множественное выполнение подготовленного выражения
$data = array(
1 => 'tyui',
5 => 'ghjk',
9 => 'bnm',
);

// $stmt = $pdo->prepare('INSERT INTO test (header) VALUES (?);');
// foreach ($data as $id => $header)
// {
//     $stmt->execute([$header]);
// }

// Получение данных.
// fetch()
$stmt = $pdo->prepare('SELECT id, header FROM test WHERE id > ?');
$stmt->execute([3]);
echo "<pre>";
while ($row = $stmt->fetch(PDO::FETCH_LAZY))
{
    echo $row[0] . " ";
    echo $row['header'] . " ";
    echo $row->header . PHP_EOL;
}
echo "</pre>";
// В этом режиме не тратится лишняя память, и к тому же к колонкам можно 
// обращаться любым из трех способов - через индекс, имя, или свойство.


// fetchColumn()

// Также у PDO statement есть функция-хелпер для получения значения единственной колонки. Очень удобно, если мы запрашиваем только одно поле - в этом случае значительно сокращается количество писанины:
$id = 4;
$stmt = $pdo->prepare("SELECT header FROM test WHERE id=?");
$stmt->execute(array($id));
$header = $stmt->fetchColumn();
echo "<pre>";
print_r($header);
echo "</pre>";

// fetchAll()
// одна колонка
$data = $pdo->query('SELECT header FROM test')->fetchAll(PDO::FETCH_COLUMN);
echo "<pre>";
print_r($data);
echo "</pre>";


// Индексированная колонка
$data = $pdo->query('SELECT id, header FROM test')->fetchAll(PDO::FETCH_KEY_PAIR);
echo "<pre>";
print_r($data);
echo "</pre>";

// Индексированный массив
$data = $pdo->query('SELECT * FROM test')->fetchAll(PDO::FETCH_UNIQUE);
echo "<pre>";
print_r($data);
echo "</pre>";

// LIKE
$name = 'sd';
$name = "%$name%";
$stm  = $pdo->prepare("SELECT * FROM test WHERE header LIKE ?");
$stm->execute(array($name));
$data = $stm->fetchAll();
echo "<pre>";
print_r($data);
echo "</pre>";


// LIMIT
echo "<h2>LIMIT</h2>";

// либо отключить режим эмуляции:
// $pdo->setAttribute( PDO::ATTR_EMULATE_PREPARES, false );
// $stm = $pdo->prepare('SELECT * FROM test LIMIT ?, ?');
// $stm->bindValue(1, 0);
// $stm->bindValue(2, 10);
// $stm->execute();
// $data = $stm->fetchAll();

// или:
$stm = $pdo->prepare('SELECT * FROM test LIMIT ?, ?');
$stm->bindValue(1, 0, PDO::PARAM_INT);
$stm->bindValue(2, 10, PDO::PARAM_INT);
$stm->execute();
$data = $stm->fetchAll();


echo "<pre>";
print_r($data);
echo "</pre>";


// IN
echo "<h2>IN</h2>";
$arr = array(1,2,3);
$in  = str_repeat('?,', count($arr) - 1) . '?';
$sql = "SELECT * FROM test WHERE id IN ($in)";
$stm = $pdo->prepare($sql);
$stm->execute($arr);
$data = $stm->fetchAll();
echo "<pre>";
print_r($data);
echo "</pre>";


