## Обзор php-fpm nginx

* С каждой установленной версией php устанавливается свой php-fpm, например,
если установить php56 из remi-репозитория, то конфигурацию php-fpm можно найти в
_/etc/opt/remi/php56/php-fpm.d/www.conf_ в этом файле можно настроить путь к
сокет-файлу; при это сервис будет называться _php56-php-fpm_. Много полезной
информации можно найти тут `php --info | grep ini`
* Можно донастроить дополнительные php-fpm к версии php, со своими переменными
окружения, настройками php или другими опциями и конечно со своим сокет-файлом.
* Nginx пробрасывает запросы к php файлам на сокет-файл php-fpm.
* В конфигурации php-fpm: `user = nginx`, `group = nginx`, `listen.acl_users =
apache,nginx`.
```
env[DB_HOST] = localhost
env[DB_PORT] = 3306
env[DB_FORUM] = forum
env[DB_USER] = forum
env[DB_PASS] = ...
```

## Установка

```sh
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
apt-cache search php5.6
sudo apt-get install php5.6 php5.6-fpm php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-xml php5.6-xsl php5.6-yaml php5.6-zip
```

### PHP 5.6 Centos 7

Репозиторий remirepo (https://rpms.remirepo.net/wizard/) предоставляет следующую инструкцию установки своей сборки:

```bash
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum install php56
# Дополнительные пакеты
yum install -y php56-php-devel.x86_64
yum install -y php56-php-fpm.x86_64
yum install -y php56-php-pdo.x86_64
yum install -y php56-php-mysqlnd.x86_64
yum install -y php56-php-mbstring.x86_64
yum install -y php56-php-mcrypt.x86_64
yum install -y php56-php-ldap.x86_64
# Сука непонятно почему этот модуль поставился именно так а не иначе.
yum install php-mysqli
yum-config-manager --enable remi-php56
# Проверка
php56 --version
php56 --modules
# Установка fpm
yum install php-fpm
systemctl start php-fpm
systemctl enable php-fpm
# Редактирование настройки сокета в файле /etc/php-fmp.d/www.conf
listen /var/run/php-fpm/php-fpm.sock
# Применим настройки
systemctl restart php-fpm.service
```

## Установка Xdebug ubuntu

```sh
# Установка пакета в sublime
Xdebug Client
# Установка расширения.
sudo apt-get install php-xdebug
# Поиск ini-файла установленного расширения.
php --info | grep ini
# Открытие ini-файла
sudo subl /etc/php/5.6/cli/conf.d/20-xdebug.ini
# Код настройки вставляемый в ini-файл
;;;;;;;;;;
; Xdebug ;
;;;;;;;;;;
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.remote_log="/var/log/xdebug/xdebug.log"
# А ещё эту строчку, чтоб без ?XDEBUG_SESSION_START=sublime.xdebug работало.
xdebug.remote_autostart=true
# Редактирование sublime-проекта (необязательно) для автоматического открывания
# страницы с параметром разрешающим дебаг ?XDEBUG_SESSION_START=sublime.xdebug
  "settings": {
    "xdebug": {
      "url": "http://lab.local",
    }
  }
```

## php.ini

```
upload_max_filesize = 10M
max_file_uploads = 20
post_max_size = 210M
```

посмотреть конкретные настройки php.ini пыхом:

```php
<?php
echo 'post_max_size = ' . ini_get('post_max_size') . "\n";
echo 'max_input_vars = ' . ini_get('max_input_vars') . "\n";
```

<pre class="prettyprint lang-sh">sudo service apache2 restart</pre>
<h3>Переменные окружения</h3>
<p>Если $_ENV пуст - проверить variables_order в php.ini (/etc/php5/apache2/php.ini) (Должно быть E в строке)</p>
<pre>;variables_order = "GPCS"
variables_order = "EGPCS"</pre>
<p>
    Sets the order of the EGPCS (<em>E</em>nvironment,
    <em>G</em>et, <em>P</em>ost,
    <em>C</em>ookie, and <em>S</em>erver) variable parsing. For example, if variables_order is set to <em>"SP"</em> then PHP will create the
    <a href="language.variables.predefined.php">superglobals</a>
    <var>
        <var><a href="reserved.variables.server.php">$_SERVER</a></var>
    </var> and
    <var>
        <var><a href="reserved.variables.post.php">$_POST</a></var>
    </var>, but not create
    <var>
        <var><a href="reserved.variables.environment.php">$_ENV</a></var>
    </var>,
    <var>
        <var><a href="reserved.variables.get.php">$_GET</a></var>
    </var>, and
    <var>
        <var><a href="reserved.variables.cookies.php">$_COOKIE</a></var>
    </var>. Setting to "" means no
    <a href="language.variables.predefined.php">superglobals</a> will be set.
</p>
<h4>Переменные окружения среды</h4>
<p>получить:</p>
<pre>getenv('PATH')</pre>
<h4>Переменные окружения apache (модуль mod_env)</h4>
<p><a href="http://httpd.apache.org/docs/current/mod/mod_env.html">http://httpd.apache.org/docs/current/mod/mod_env.html</a></p>
<p>Передать переменную окружения из shell (Passes environment variables from the shell):</p>
<pre>PassEnv LD_LIBRARY_PATH</pre>
<p>Установить переменную окружения (Sets environment variables)</p>
<pre>SetEnv SPECIAL_PATH /foo/bin
</pre>
<p>Получить переменную окружения apache:</p>
<pre>$var = apache_getenv("SPECIAL_PATH");</pre>

<h2>Функции</h2>
<h3>header()</h3>
<pre class="prettyprint lang-php">
header('Content-Type: text/html; charset=utf-8');
</pre>
<h3>iconv - изменение кодировки строки</h3>
<pre class="prettyprint lang-php">
$s = 'Р’РёРЅРёР»РѕРІР°СЏ Р°РїРїР»РёРєР°С†РёСЏ РІ РЅРѕС‡РЅРѕРј РєР»СѓР±Рµ - С„Р»СЋРѕСЂ';
$s = iconv('utf8', 'cp1251', $s);
echo &quot;&lt;pre&gt;&quot;;
var_dump($s);
echo &quot;&lt;/pre&gt;&quot;;

$s = 'Виниловая аппликация в ночном клубе - флюор';
$s = iconv('cp1251', 'utf8', $s);
echo &quot;&lt;pre&gt;&quot;;
var_dump($s);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<h2>Переменные</h2>
<h3>Типы</h3>
<p><code>gettype()</code> — Возвращает тип переменной</p>
<p>Возможные значения:</p>
<ul>
    <li><code>"boolean"</code></li>
    <li><code>"integer"</code></li>
    <li><code>"double"</code> (по историческим причинам в случае типа float возвращается "double", а не просто "float")</li>
    <li><code>"string"</code></li>
    <li><code>"array"</code></li>
    <li><code>"object"</code></li>
    <li><code>"resource"</code></li>
    <li><code>"NULL"</code></li>
    <li><code>"unknown type"</code></li>
</ul>
<h2>Константы</h2>
<pre class="prettyprint lang-php">if (!defined('COOKIE_ENABLED')) {
    define('COOKIE_ENABLED', false);
}</pre>

<h2>ООП</h2>
<h3>Инкапсуляция / полиморфизм / наследование</h3>
<p>Инкапсуляция — механизм который позволяет отнести свойства и методы к объекту и закрыть доступ к некоторым из них извне.</p>
<p>Полиморфизм — свойство метода совершать различные операции в зависимости от типа передаваемых ему данных.</p>
<p>Наследование — процесс при котором свойства и методы одного класса объектов передаются другому классу объектов.</p>
<h3>Public / private / protected</h3>
<p><code>public</code> — отовсюду.</p>
<p><code>private</code> — внутри класса, не наследуется.</p>
<p><code>protected</code> — внутри класса, наследуется.</p>

<h3>Интерфейс / класс / объект / свойство / метод</h3>
<pre class="prettyprint lang-php">[final] [abstract] class Имя_класса [{extends,implements} {Имя_класса,Имя_интерфейса[ Имя_интерфейса]} { // Класс
    [public/private/protected] [static] $Имя_свойства; // Свойство объекта
    [final] [public/private/protected] [static] function Имя_метода () { // Метод объекта
        self::$Имя_свойства; // Обращение к статическому свойству
        self::Имя_метода(); // Обращение к статическому методу
        parent::$Имя_свойства; // Обращение к статическому свойству родительского класса
        parent::Имя_метода(); // Обращение к статическому методу родительского класса
        static::$Имя_свойства; // Обращение к статическому свойству при переопределении свойства дочерним классом (позднее статическое связывание)
        static::Имя_метода(); // Обращение к статическому методу при переопределении метода дочерним классом (позднее статическое связывание)
        $this->Имя_свойства; // Обращение к свойству экземпляра
        $this->Имя_метода(); // Обращение к методу экземпляра
    }
}
Имя_класса::$Имя_свойства; // Обращение к свойству без создания объекта (свойство должно быть статическим)
Имя_класса::Имя_метода(); // Обращение к методу без создания объекта (метод должен быть статическим)
$Имя_объекта = new Имя_класса; // Создание экземпляра (объекта) класса
$Имя_объекта->Имя_свойства; // Обращение к свойству объекта
$Имя_объекта->Имя_метода(); // Обращение к методу объекта
</pre>
<p><code>interface</code> — указывает, какие методы и свойства должен включать класс.</p>
<p><code>implements</code> — наследование интерфейса классом.</p>
<p><code>abstract</code> — описательный класс, в отличии от интерфейса может содержать описанные методы.</p>
<p><code>extends</code> — наследование класса.</p>
<p><code>final</code> — не может быть унаследован.</p>
<h3>Функции для работы с классами</h3>
<h4>class_exists()</h4>
<pre class="prettyprint lang-php">
// Проверяем существование класса перед его использованием
if (class_exists('MyClass')) {
    $myclass = new MyClass();
}
</pre>
<h4>get_declared_classes()</h4>
<p>get_declared_classes — Возвращает массив с именами объявленных классов</p>
<pre class="prettyprint lang-php copyToClipboard">
echo &quot;&lt;pre&gt;&quot;;
print_r(get_declared_classes());
echo &quot;&lt;/pre&gt;&quot;;
die();
</pre>
<h4>get_class_methods()</h4>
<p>get_class_methods — Возвращает массив имен методов класса</p>
<pre class="prettyprint lang-php copyToClipboard">
echo &quot;&lt;pre&gt;&quot;;
print_r(get_class_methods($object));
echo &quot;&lt;/pre&gt;&quot;;
die();
</pre>

<h2>Консоль</h2>
<p>Вывести phpinfo можно так, но</p>
<pre class="prettyprint lang-sh">php -r "phpinfo();"</pre>
<p>но лучше так</p>
<pre class="prettyprint lang-sh copyToClipboard">php -i | grep ini</pre>
<p>выполнить строку пыха</p>
<pre class="prettyprint lang-sh">
php -r 'echo &quot;Hello&quot; . &quot; world&quot;;'
</pre>

<h2>Наработки</h2>
<h3>Парсим папку с файлами</h3>
<pre class="prettyprint lang-php">
$fileNames = [
    'old_dgi.json',
    'old_dilli.json',
    'old_epson.json',
    'old_vivid.json',
    'old_zeon_net.json',
];
$fileNames = [];
if ($handle = opendir(__DIR__)) {
    while (false !== ($entry = readdir($handle))) {
        if ($entry != &quot;.&quot; &amp;&amp; $entry != &quot;..&quot;) {
            $pathinfo = pathinfo(__DIR__ . '/' . $entry);
            if ($pathinfo['extension']==='json'&amp;&amp;$pathinfo['filename']!=='merged') {
                $fileNames[] = $entry;
            }
        }
    }
}
</pre>
<h3>Загрузка файла на сервер</h3>
<pre class="prettyprint lang-php">$ext = pathinfo($_FILES['name'], PATHINFO_EXTENSION); // Расширение файла</pre>
<h3>IP адрес пользователя</h3>
<p><code>$_SERVER['REMOTE_ADDR']</code>, остальное - фуфло. Все что начинается с <code>$_SERVER['HTML_...</code> - это заголовки, их можно подделать!</p>
<h3>Фильтрация данных пользователя</h3>
<p><strong>Коротко список используемых функций:</strong></p>
<ul>
    <li><a href="http://php.net/manual/ru/function.intval.php">intval</a></li>
    <li><a href="http://php.net/manual/ru/function.strip-tags.php">strip_tags</a></li>
    <li><a href="http://php.net/manual/ru/function.htmlspecialchars.php">htmlspecialchars</a></li>
</ul>
<h4>Интеджер</h4>
<pre class="prettyprint lang-php">$number = intval($_GET['input_number']);
if ($number)
{
... выполняем SQL запрос ...
}</pre>
<h4>Стринг</h4>
<p>Не предполагаем вхождение html тегов:</p>
<pre class="prettyprint lang-php">$input_text = strip_tags($_GET['input_text']);
$input_text = htmlspecialchars($input_text);
$input_text = mysql_escape_string($input_text);
</pre>
<p>Если сразу массив данных</p>
<pre class="prettyprint lang-php">$checkbox_arr = array_map('intval', $_POST['checkbox']);</pre>
<h3>"Запрет" повторной отправки формы по F5, переадресация перезагрузка</h3>
<pre class="prettyprint lang-php">header('Location: index.php');</pre>
<p>или проще:</p>
<pre class="prettyprint lang-php">header('Refresh:0');</pre>

<h2>PDO</h2>
<h3>Поддержка типа данных integer извлекаемых данных</h3>
<pre class="prettyprint lang-sh">sudo apt-get install php5-mysqlnd
sudo service apache2 restart</pre>
<p>Далее перед запросом</p>
<pre>
$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$pdo->setAttribute(PDO::ATTR_STRINGIFY_FETCHES, false);
</pre>
<p>или при соединении</p>
<pre>$dsn = "mysql:host=$host;dbname=$dbName;charset=$charset";
$opt = array(
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
    PDO::ATTR_STRINGIFY_FETCHES => false, // Преобразовывать числовые значения в строки во время выборки.
);
$pdo = new PDO($dsn, $user, $password, $opt);</pre>
<h3>Соединение</h3>
<pre class="prettyprint lang-php">
$user = 'user';
$password = 'password';
$host = 'localhost';
$dbName = 'test';
$charset = 'utf8';
$dsn = &quot;mysql:host=$host;dbname=$dbName;charset=$charset&quot;;
$opt = array(
    PDO::ATTR_ERRMODE            =&gt; PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE =&gt; PDO::FETCH_ASSOC
);
$pdo = new PDO($dsn, $user, $password, $opt);
</pre>
<p><code>PDO::ATTR_ERRMODE</code> - Режим сообщений об ошибках.</p>
<p><code>PDO::ERRMODE_EXCEPTION</code> - Выбрасывать исключения.</p>
<p><code>PDO::ATTR_DEFAULT_FETCH_MODE</code> - Задает режим выборки данных по умолчанию.</p>
<p><code>PDO::FETCH_ASSOC</code> - возвращает массив, индексированный именами столбцов результирующего набора.</p>
<p>Можно и без базы</p>
<pre class="prettyprint lang-php">
$pdo = new PDO("mysql:host=$host;charset=$charset", $user, $password, $opt);
</pre>
<p>Выбрать базу можно если она есть</p>
<pre class="prettyprint lang-php">
$stmt = $pdo->query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$dbName'");
$db = $stmt->fetchColumn();
if ($db) {
    $pdo->exec("USE $dbName");
}
</pre>
<h3>Кратко о функциях</h3>
<ol>
<li><code>$pdo->exec($sql);</code> - возвращает количество обработанных строк, она для INSERT, UPDATE, DELETE, CREATE TABLE, DROP DATABASE...;</li>
<li><code>$stt = $pdo->query($sql);</code> - возвращает объект stmt (результирующий набор).</li>
<li><code>$stt = $pdo->prepare($sql);</code> - подготавливает запрос (возможен множественный запуск запроса с разными аргументами).</li>
</ol>
<h3>Выполнение запросов</h3>
<pre class="prettyprint lang-php">
$stmt = $pdo-&gt;query('SELECT header FROM test');
while ($row = $stmt-&gt;fetch())
{
    echo $row['header'] . &quot;\n&quot;;
}
</pre>
<p>
    Кстати <code>DELIMITER ;;</code> в PDO не работает, поэтому, для разделения процедур создания хранимых процедур ;) (stored procedures) необходимо использовать обычный делимитр <code>;</code>
</p>
<h3>Подготовленные выражения</h3>
<p>Двумя сопособами (позиционные и именованные плейсхолдеры):</p>
<pre class="prettyprint lang-php">$sql = 'SELECT name FROM users WHERE email = ?';
$sql = 'SELECT name FROM users WHERE email = :email';</pre>
<p>prepare() - подготавливает запрос.</p>
<p>execute() - выполнить запрос.</p>
<p>Передать параметры в запрос можно двумя способами:</p>
<ol>
    <li>передать в execute() параметром;</li>
    <li>привязать к запросу с помощью bindValue() / bindParam().</li>
</ol>
<h4>Передать в execute()</h4>
<pre class="prettyprint lang-php">$id = 1;
$stmt = $pdo-&gt;prepare('SELECT header FROM test WHERE id = ?');
$stmt-&gt;execute(array($id));

$stmt = $pdo-&gt;prepare('SELECT header FROM test WHERE id = :id');
$stmt-&gt;execute(array('id' =&gt; $id));</pre>
<h4>С помощью bindValue() / bindParam()</h4>
<pre class="prettyprint lang-php">$id = 1;
$header = 'qwer';

$sth = $pdo-&gt;prepare('SELECT header FROM test WHERE id = ? AND header = ?');
$sth-&gt;bindValue(1, $id, PDO::PARAM_INT);
$sth-&gt;bindValue(2, $header, PDO::PARAM_STR);
$sth-&gt;execute();

$sth = $pdo-&gt;prepare('SELECT header FROM test WHERE id = :id AND header = :header');
$sth-&gt;bindValue(':id', $id, PDO::PARAM_INT);
$sth-&gt;bindValue(':header', $header, PDO::PARAM_STR);
$sth-&gt;execute();</pre>
<h3>Множественное выполнение подготовленного выражения</h3>
<pre class="prettyprint lang-php">$data = array(
1 =&gt; 'tyui',
5 =&gt; 'ghjk',
9 =&gt; 'bnm',
);

$stmt = $pdo-&gt;prepare('INSERT INTO test (header) VALUES (?);');
foreach ($data as $id =&gt; $header)
{
    $stmt-&gt;execute([$header]);
}
</pre>
<h3>Получение данных</h3>
<h4>fetch()</h4>
<pre class="prettyprint lang-php">
$stmt = $pdo-&gt;prepare('SELECT id, header FROM test WHERE id &gt; ?');
$stmt-&gt;execute([3]);
echo &quot;&lt;pre&gt;&quot;;
while ($row = $stmt-&gt;fetch(PDO::FETCH_LAZY))
{
    echo $row[0] . &quot; &quot;;
    echo $row['header'] . &quot; &quot;;
    echo $row-&gt;header . PHP_EOL;
}
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<p>В этом режиме (<code>PDO::FETCH_LAZY</code>) не тратится лишняя память, и к тому же к колонкам можно обращаться любым из трех способов - через индекс, имя, или свойство.</p>
<h4>fetchColumn()</h4>
<p>Одно поле</p>
<pre>
$id = 4;
$stmt = $pdo-&gt;prepare(&quot;SELECT header FROM test WHERE id=?&quot;);
$stmt-&gt;execute(array($id));
$header = $stmt-&gt;fetchColumn();
echo &quot;&lt;pre&gt;&quot;;
print_r($header);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<h4>fetchAll()</h4>
<p><strong>Одна колонка.</strong></p>
<pre class="prettyprint lang-php">
$data = $pdo-&gt;query('SELECT header FROM test')-&gt;fetchAll(PDO::FETCH_COLUMN);
echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<p><strong>Индексированная колонка.</strong></p>
<pre class="prettyprint lang-php">
$data = $pdo-&gt;query('SELECT id, header FROM test')-&gt;fetchAll(PDO::FETCH_KEY_PAIR);
echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<p><strong>Индексированный массив.</strong></p>
<pre class="prettyprint lang-php">
$data = $pdo-&gt;query('SELECT * FROM test')-&gt;fetchAll(PDO::FETCH_UNIQUE);
echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<h3>LIKE</h3>
<pre class="prettyprint lang-php">
$name = 'sd';
$name = &quot;%$name%&quot;;
$stm  = $pdo-&gt;prepare(&quot;SELECT * FROM test WHERE header LIKE ?&quot;);
$stm-&gt;execute(array($name));
$data = $stm-&gt;fetchAll();
echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<h3>LIMIT</h3>
<p><strong>Либо отключить режим эмуляции:</strong></p>
<pre class="prettyprint lang-php">
$pdo-&gt;setAttribute( PDO::ATTR_EMULATE_PREPARES, false );
$stm = $pdo-&gt;prepare('SELECT * FROM test LIMIT ?, ?');
$stm-&gt;bindValue(1, 0);
$stm-&gt;bindValue(2, 10);
$stm-&gt;execute();
$data = $stm-&gt;fetchAll();

echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<p><strong>или:</strong></p>
<pre class="prettyprint lang-php">
$stm = $pdo-&gt;prepare('SELECT * FROM test LIMIT ?, ?');
$stm-&gt;bindValue(1, 0, PDO::PARAM_INT);
$stm-&gt;bindValue(2, 10, PDO::PARAM_INT);
$stm-&gt;execute();
$data = $stm-&gt;fetchAll();

echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>
<h3>IN</h3>
<pre class="prettyprint lang-php">
echo &quot;&lt;h2&gt;IN&lt;/h2&gt;&quot;;
$arr = array(1,2,3);
$in  = str_repeat('?,', count($arr) - 1) . '?';
$sql = &quot;SELECT * FROM test WHERE id IN ($in)&quot;;
$stm = $pdo-&gt;prepare($sql);
$stm-&gt;execute($arr);
$data = $stm-&gt;fetchAll();
echo &quot;&lt;pre&gt;&quot;;
print_r($data);
echo &quot;&lt;/pre&gt;&quot;;
</pre>

<h2>Cookie</h2>
<h3>Установка и чтение cookie</h3>
<pre class="prettyprint lang-php">setcookie("voting", $cookieVoting, time()+60*60*24*7, "/");
if ( isset($_COOKIE) &amp;&amp; isset($_COOKIE['voting']) ) {
    $cookieVoting = $_COOKIE['voting'];</pre>
<h3>Удаление cookie</h3>
<p><code>unset($_COOKIE['voting'])</code> - удаляет переменную на сервере (
    <mark>не удаляет из браузера!</mark>)</p>
<p>Удалить из браузера пользователя:</p>
<pre class="prettyprint lang-php">setcookie("voting", null, time()-60*60*24*7, "/");</pre>
<h3>Проверка включены ли куки в браузере</h3>
<pre class="prettyprint lang-php">&lt;?php
// Recommended way for versions of PHP &gt;= 5.4.0
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
//For versions of PHP &lt; 5.4.0
// if(session_id() == '') {
//     session_start();
// }


// Если нет проверочного гет запроса,
// но нет флага от второго прохождения прохождения
// то запекаем печенье ()
// скармливаем браузеру (пересылаем header()-ом с проверочным гет запросом)
if ( !isset($_GET['checkCookie']) &amp;&amp; !isset($_SESSION['cookieIsChecked']) ) {
    // сохраняем ссылку в сессию, если печеньки работаю, то мы сможем восстановить ссылку позже
    $_SESSION['QUERY_STRING'] = $_SERVER['QUERY_STRING'];
    // запекаем
    setcookie('foo', 'bar', time() + 60*60*24);
    // redirecting to the same page to check 
    if (empty($_SERVER['QUERY_STRING'])) {
        header(&quot;location: {$_SERVER['PHP_SELF']}?checkCookie=true&quot;);
    } else {
        header(&quot;location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}&amp;checkCookie=true&quot;);
    }
}

// Если есть проверочный гет,
// и нет флага второго прохождения
// проверяем печеньки съедины или нет
// если печеньки работают, то восстанавливаем исходный урл методом header()-а (перед этим установив флаг второго прохождения)
// если печеньки не работаю
if ( isset($_GET['checkCookie']) &amp;&amp; ($_GET['checkCookie'] == true) &amp;&amp; !isset($_SESSION['cookieIsChecked']) ) {
    if (isset($_COOKIE['foo']) &amp;&amp; $_COOKIE['foo'] == 'bar') {
        setcookie('foo', 'bar', time() - 60*60*24);
        $_SESSION['cookieIsChecked'] = true;
        if (!isset($_SESSION['QUERY_STRING']) || empty($_SESSION['QUERY_STRING'])) {
            header(&quot;location: {$_SERVER['PHP_SELF']}&quot;);
        } else {
            header(&quot;location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}&quot;);
        }
    } else {
    }
}

if (isset($_SESSION['cookieIsChecked']) &amp;&amp; $_SESSION['cookieIsChecked'] === true) {
    define('COOKIE_ENABLED', true);
}
if (!defined('COOKIE_ENABLED')) {
    define('COOKIE_ENABLED', false);
}
</pre>

<h2>Комментирование</h2>
<pre class="prettyprint lang-php">&lt;!-- html  --&gt;&lt;?php // echo 'asd'; ?&gt;&lt;!--  html --&gt;
&lt;!-- html  --&gt;&lt;?php //= 'asd'; ?&gt;&lt;!--  html --&gt;</pre>
