<pre class="prettyprint lang-php">
<?php

echo '// Обычная строка:' . PHP_EOL;
echo '$datetime = \'2016-02-28 22:48:55\';' . PHP_EOL;
echo 'var_dump($datetime);' . PHP_EOL;
echo PHP_EOL;
echo '// Результат:' . PHP_EOL;
echo PHP_EOL;

$datetime = '2016-02-28 22:48:55';
var_dump($datetime);

echo PHP_EOL;
echo PHP_EOL;

echo '// Преобразуем в `TimeStamp`:' . PHP_EOL;
echo '$timestamp = strtotime($datetime);' . PHP_EOL;
echo 'var_dump($timestamp);' . PHP_EOL;
echo PHP_EOL;
echo '// Результат:' . PHP_EOL;
echo PHP_EOL;

$timestamp = strtotime($datetime);
var_dump($timestamp);

echo PHP_EOL;
echo PHP_EOL;

echo '// Выведем пользователю `TimeStamp`:' . PHP_EOL;
echo '$str = strftime(\'%Y-%m-%d %H:%M:%S\'); // Форматирует дату/время с учетом текущих настроек локали' . PHP_EOL;
echo 'var_dump($str);' . PHP_EOL;
echo '$str = strftime(\'%Y-%m-%d %H:%M:%S\', $timestamp);' . PHP_EOL;
echo 'var_dump($str);' . PHP_EOL;
echo PHP_EOL;
echo '// Результат:' . PHP_EOL;
echo PHP_EOL;

$str = strftime('%Y-%m-%d %H:%M:%S'); // Форматирует дату/время с учетом текущих настроек локали
var_dump($str);
$str = strftime('%Y-%m-%d %H:%M:%S', $timestamp);
var_dump($str);

echo PHP_EOL;
echo PHP_EOL;

echo '// Распарсить строку (зная формат) в массив:' . PHP_EOL;
echo '$array = strptime($str, \'%Y-%m-%d %H:%M:%S\'); // Функция не реализована в Windows!' . PHP_EOL;
echo 'var_dump($array);' . PHP_EOL;
echo PHP_EOL;
echo '// Результат:' . PHP_EOL;
echo PHP_EOL;

$array = strptime($str, '%Y-%m-%d %H:%M:%S'); // Функция не реализована в Windows!
var_dump($array);

echo PHP_EOL;
echo PHP_EOL;

echo '// Сравним функции `date` и `strftime`:' . PHP_EOL;
echo '$strDt = date($timestamp);' . PHP_EOL;
echo '$strFt = strftime($timestamp);' . PHP_EOL;
echo '$strDft = date(\'Y\', $timestamp);' . PHP_EOL;
echo '$strFft = strftime(\'%Y\', $timestamp);' . PHP_EOL;
echo '$strDf = date(\'Y\');' . PHP_EOL;
echo '$strFf = strftime(\'%Y\');' . PHP_EOL;
echo 'var_dump($strDt) . PHP_EOL;' . PHP_EOL;
echo 'var_dump($strFt) . PHP_EOL;' . PHP_EOL;
echo 'var_dump($strDft) . PHP_EOL;' . PHP_EOL;
echo 'var_dump($strFft) . PHP_EOL;' . PHP_EOL;
echo 'var_dump($strDf) . PHP_EOL;' . PHP_EOL;
echo 'var_dump($strFf) . PHP_EOL;' . PHP_EOL;
echo PHP_EOL;
echo '// Результат:' . PHP_EOL;
echo PHP_EOL;


$strDt = date($timestamp);
$strFt = strftime($timestamp);
$strDft = date('Y', $timestamp);
$strFft = strftime('%Y', $timestamp);
$strDf = date('Y');
$strFf = strftime('%Y');
var_dump($strDt) . PHP_EOL;
var_dump($strFt) . PHP_EOL;
var_dump($strDft) . PHP_EOL;
var_dump($strFft) . PHP_EOL;
var_dump($strDf) . PHP_EOL;
var_dump($strFf) . PHP_EOL;


?>
</pre>

<!-- Подсветка синтаксиса кода -->
<script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>