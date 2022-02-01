# MYSQL

чтоб при рестарте не тупил использовать хинт `set global innodb_max_dirty_pages_pct = 0;`

## Установка/удаление/переустановка

__Бэкап__

```sh
mysqldump --lock-all-tables -u root -p --all-databases > dump.sql
```

Желательно снести каталоги - `sudo rm -rf /etc/mysql` и `sudo rm -rf /var/lib/mysql`

__Удаление:__

```bash
sudo apt-get remove --purge mysql-server mysql-client mysql-common
sudo apt-get autoremove
sudo apt-get autoclean
```

__Установка:__

```bash
sudo apt update && sudo apt install -y mysql-server
# с версией
sudo apt update && sudo apt install -y mysql-server-5.7

sudo apt install mysql-client-5.6 mysql-client-core-5.6
sudo apt install mysql-server-5.6
```

__Восстановление__

```sh
mysql -u root -p < dump.sql
```

### Установка необходимой версии на Centos 7

```bash
sudo yum update
# Тут https://dev.mysql.com/downloads/repo/yum/ узнать какой файл скачивать
wget http://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
# Проверить хеш сумму
md5sum mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
yum repolist all | grep mysql
sudo yum-config-manager --enable mysql56-community
sudo yum-config-manager --disable mysql80-community
yum repolist all | grep mysql
yum repolist enabled | grep mysql
sudo yum install mysql-server
sudo service mysqld status
sudo service mysqld start
sudo service mysqld status
mysql_secure_installation
# Поехали ставить пользователей
mysql -uroot -p
```


## Настройка

```bash
# Просмотр ...
mysql -uroot -p "password" -se "SHOW VARIABLES" | grep -e log
```

__/etc/my.cnf__

```
wait_timeout = 600
max_allowed_packet = 64M
```

### Настройка sql-mode без режима ONLY_FULL_GROUP_BY

Все рекомендуют добавить в конфигурацию подобные строки

```sh
[mysqld]
sql_mode= STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
sql_mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
sql-mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
sql-mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
```

Или прямо в настройки системного демона добавить параметр запуска:

```sh
# /lib/systemd/system/mysql.service
ExecStart=/usr/sbin/mysqld --sql-mode=NO_ENGINE_SUBSTITUTION.......
# systemctl daemon-reload
# systemctl restart mysql
```

Но НИЧЕГО не помогло убунту 20 mysql 8. Только обходной путь:

```sh
# touch /etc/mysql/mysqlmode.sql :
SET GLOBAL sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
# mcedit /etc/mysql/my.cnf
[mysqld]
init-file="/etc/mysql/mysqlmode.sql"
```

## Типы данных

### INT

`INT(11)` — сколько знаков будет при заполнении нулями (UNSIGNED). Если поле не UNSIGNED, то число ни на что не влияет, только доставляет неудобства при работе с внешними ключами. Диапазон со знаком от -2147483648 до 2147483647. Диапазон без знака от 0 до 4294967295.


### SMALLINT

Диапазон со знаком от -32768 до 32767. Диапазон без знака от 0 до 65535.


### TINYINT

Диапазон со знаком от -128 до 127. Диапазон без знака от 0 до 255.


### DECIMAL

DECIMAL(m,n) — лучшее для хранения цен.


### ENUM

— принимает значение из списка допустимых \*. ENUM("один", "два", "три").

\* — может принимать значение пустой строки если при INSERT было указано неверное. Если нет `NOT NULL`, то так же может принимать и NULL.

Можно сравнивать по номеру а не по значению `SELECT * FROM tbl_name WHERE enum_col=1` то же самое что и `SELECT * FROM tbl_name WHERE enum_col='один'`. Нумерация от 1, неверное значение (пустая строка) принимает номер 0, а NULL соответственно NULL.

### SET
Подобие много ко многим бес смежной таблицы: `SET("один", "два") NOT NULL` — поле может принимать значения "", "один", "два" и "один,два". Максимум 64 различных элемента.


## Параметры

### Просмотр какого ибо параметра

`SHOW VARIABLES LIKE 'sql_safe_updates'`

### Для удаления связных данны


`SET AUTOCOMMIT = 0; SET FOREIGN_KEY_CHECKS = 0; SET UNIQUE_CHECKS = 0;`


`truncate `table`;` или другое удаление.


`SET AUTOCOMMIT = 1; SET FOREIGN_KEY_CHECKS = 1; SET UNIQUE_CHECKS = 1;`


### Для удаления всей таблицы

`SET SQL_SAFE_UPDATES = 0;`


## Операторы

### Отрицание

НЕ ВЕРНАЯ ФРАЗА!!!: <q>! – второй вариант записи NOT.</q> Подтверждение:

```sql
select ( ! null<=>null ) <> ( not null<=>null);
  -> 1
```

У NOT приоритет ниже, сначало сравнение, потом отрицание (`select not null <=> null -- 0`).

У ! приоритет выше, сначало отрицание, потом сравнение (`select ! null <=> null -- 1`).

### NULL-безопасное сравнение <=> (равно)

```sql
set @a1 = 1000, @b1 = 2000;
set @a2 = null, @b2 = 2000;
set @a3 = null, @b3 = null;
set @a4 = 2000, @b4 = 2000;

select 'Равны? (не верное использование)' as `опреация`, @a1=@b1 as `@1`, @a2=@b2 as `@2`, @a3=@b3 as `@3`, @a4=@b4 as `@4`
union all
select 'Равны?' as `опреация`, @a1<=>@b1 as `@1`, @a2<=>@b2 as `@2`, @a3<=>@b3 as `@3`, @a4<=>@b4 as `@4`
union all
select 'Не равны? (не верное использование)' as `опреация`, !@a1<=>@b1 as `@1`, !@a2<=>@b2 as `@2`, !@a3<=>@b3 as `@3`, !@a4<=>@b4 as `@4`
union all
select 'Не равны?' as `опреация`, !(@a1<=>@b1) as `@1`, !(@a2<=>@b2) as `@2`, !(@a3<=>@b3) as `@3`, !(@a4<=>@b4) as `@4`
union all
select 'Не равны?' as `опреация`, @a1<=>@b1<>1 as `@1`, @a2<=>@b2<>1 as `@2`, @a3<=>@b3<>1 as `@3`, @a4<=>@b4<>1 as `@4`
union all
select 'Не равны?' as `опреация`, NOT @a1<=>@b1 as `@1`, NOT @a2<=>@b2 as `@2`, NOT @a3<=>@b3 as `@3`, NOT @a4<=>@b4 as `@4`
;
```


## Функции

### INSERT

```sql
INSERT [LOW_PRIORITY | DELAYED] [IGNORE]
        [INTO] tbl_name [(col_name,...)]
        VALUES (expression,...),(...),...
        [ ON DUPLICATE KEY UPDATE col_name=expression, ... ]
```

```sql
INSERT INTO
	`forum_advt` (`link`, `show`)
VALUES
	('/', '1'),
	('/', '1');
```

```sql
INSERT INTO table2
SELECT * FROM table1;
```

```sql
INSERT INTO table2
(column_name(s))
SELECT column_name(s)
FROM table1;
```

### DELETE

```sql
DELETE [LOW_PRIORITY] [QUICK] FROM table_name
	       [WHERE where_definition]
	       [ORDER BY ...]
	       [LIMIT rows]
```

или

```sql
DELETE [LOW_PRIORITY] [QUICK] table_name[.*] [, table_name[.*] ...]
	       FROM table-references
	       [WHERE where_definition]
```

или

```sql
DELETE [LOW_PRIORITY] [QUICK]
	       FROM table_name[.*] [, table_name[.*] ...]
	       USING table-references
	       [WHERE where_definition]
```

__Пример__

```sql
DELETE FROM
	`advt`
WHERE
	`id` = 1;
```

### UPDATE

```sql
UPDATE [LOW_PRIORITY] [IGNORE] tbl_name
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
    [ORDER BY ...]
    [LIMIT rows]
-- или
UPDATE [LOW_PRIORITY] [IGNORE] tbl_name [, tbl_name ...]
    SET col_name1=expr1 [, col_name2=expr2 ...]
    [WHERE where_definition]
```


### CREATE TABLE

```sql
CREATE TABLE `forum_advt` ()
CREATE TABLE IF NOT EXISTS `forum_advt`
```

__Примеры__

```sql
CREATE TABLE `pubsec` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(160) NOT NULL,
  `sid` VARCHAR(160) NOT NULL,
  `title` VARCHAR(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_pubsec_sid` (`sid` ASC),
  UNIQUE INDEX `uq_pubsec_header` (`header` ASC)
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE `tag` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(160) NOT NULL,
  `sid` VARCHAR(160) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_tag_sid` (`sid` ASC),
  UNIQUE INDEX `uq_tag_header` (`header` ASC)
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE `pub` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pubsec_id` INT UNSIGNED NOT NULL,
  `header` VARCHAR(160) NOT NULL,
  `sid` VARCHAR(160) NOT NULL,
  `show` ENUM('true', 'false') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'true',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `introtext` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `text` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `title` VARCHAR(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_pub_sid` (`sid` ASC),
  UNIQUE KEY `uq_pub_header` (`header` ASC),
  INDEX `ix_pub_pubsecid` (`pubsec_id`),
  CONSTRAINT `fk_pub_pubsecid` FOREIGN KEY (`pubsec_id`) REFERENCES `pubsec` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE `pub_tag` (
  `pub_id` INT UNSIGNED NOT NULL,
  `tag_id` INT UNSIGNED NOT NULL,
  INDEX `ix_pubtag_pubid` (`pub_id` ASC),
  INDEX `ix_pubtag_tagid` (`tag_id` ASC),
  -- UNIQUE KEY `uq_pubtag_pubtagid` (`pub_id` ASC, `tag_id` ASC),
  UNIQUE KEY `uq_pubtag_pubtagid` (`pub_id` ASC, `tag_id` ASC),
  -- KEY `ix_pubtag_pubid` (`pub_id`),
  CONSTRAINT `fk_pubtag_pubid` FOREIGN KEY (`pub_id`) REFERENCES `pub` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  -- KEY `ix_pubtag_tagid` (`tag_id`),
  CONSTRAINT `fk_pubtag_tagid` FOREIGN KEY (`tag_id`) REFERENCES `pubsec` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;
```

### TRUNCATE

— удаляет и воссоздает таблицу, операция является нетранзакционной, не возвращает количество удаленных строк.

```TRUNCATE TABLE table_name```

### DROP TABLE

```sql
DROP TABLE `ct_tree_rel`;
-- 
DROP TABLE IF EXISTS `ct_tree_rel`;
```


### COALESCE

Возвращает первый в списке элемент со значением, не равным NULL: `SELECT COALESCE(NULL,2,NULL,1) -> 2;`


### HAVING

HAVING – применяется для фильтрации функций и столбцов сгруппированных при помощи GROUP BY указанных в SELECT.

Другими словами применяется для агрегатных функций(COUNT(), MAX() …) и столбцов указанных в выражении SELECT и обработанных GROUP BY.

```sql
SELECT t.topic_id, t.topic_title, count(p.post_id) as countpost
FROM $dbName.forum_topics t
LEFT JOIN $dbName.forum_posts p ON p.topic_id = t.topic_id
GROUP BY t.topic_id
HAVING countpost = 0
```

### LAST_INSERT_ID()


Возвращает последний вставленный id

```
-- Только для скрипта:
SET @lastID := LAST_INSERT_ID();
-- или вывод результата:
select last_insert_id() as last_insert_id;
-- или и то и другое:
select @test := last_insert_id() as last_insert_id;
```

### Работа со строками

#### CHAR_LENGTH


`integer CHAR_LENGTH(str string)`возвращают длину строки. Поддерживает многобайтовые символы.


### if ifnull nullif

#### if


`IF(expr1,expr2,expr3)`. Если expr1 равно значению ИСТИНА (expr1 <> 0 и expr1 <> NULL), то функция IF() возвращает expr2, в противном случае - expr3.


```sql
  where
    `p`.`price` >= param_from
    and `p`.`price` <= param_to
    and if(param_dishtype <> 0, `d`.`dishtype_id` = param_dishtype, 1)
```
  
  Неправильное использование

```sql
  select
    if(null,'true','false') as nil, if(0,'true','false') as zero, if('','true','false') as emp_s,
    if(-1,'true','false') as mone, if(' ','true','false') as spa, if('  ','true','false') as tab;
```

#### if которого нет

```sql
SET @sql = (SELECT IF(
    (SELECT COUNT(*)
        FROM INFORMATION_SCHEMA.COLUMNS WHERE
        table_schema='newdb'
         and table_name='persons' and column_name='id'
    ) > 0,
    "SELECT 0",
    "alter table newdb.persons add id int;"
));

PREPARE stmt FROM @sql;
EXECUTE stmt;
```
#### ifnull


`IFNULL(expr1,expr2)`. Если expr1 не равно NULL, то функция IFNULL() возвращает значение expr1, в противном случае - expr2.

```
	where
		`p`.`price` >= param_from
		and `p`.`price` <= param_to
		and ifnull(`d`.`dishtype_id` = param_dishtype, 1)
```
#### nullif


`NULLIF(expr1,expr2)`. Если выражение expr1 = expr2 истинно, то возвращает NULL, в противном случае - expr1.


### `MATCH () AGAINST ()` - Natural Language Full-Text Searches / Полтонектовый поиск (для InnoDB начиная с версии mysql 5.6)


Тест (подробнее <a href="http://dev.mysql.com/doc/refman/5.7/en/fulltext-natural-language.html">тут</a>):

```
mysql> CREATE TABLE articles (
      id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
      title VARCHAR(200),
      body TEXT,
      FULLTEXT (title,body)
    ) ENGINE=InnoDB;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO articles (title,body) VALUES
    ('MySQL Tutorial','DBMS stands for DataBase ...'),
    ('How To Use MySQL Well','After you went through a ...'),
    ('Optimizing MySQL','In this tutorial we will show ...'),
    ('1001 MySQL Tricks','1. Never run mysqld as root. 2. ...'),
    ('MySQL vs. YourSQL','In the following database comparison ...'),
    ('MySQL Security','When configured properly, MySQL ...');
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM articles
    WHERE MATCH (title,body)
    AGAINST ('database' IN NATURAL LANGUAGE MODE);
+----+-------------------+------------------------------------------+
| id | title             | body                                     |
+----+-------------------+------------------------------------------+
|  1 | MySQL Tutorial    | DBMS stands for DataBase ...             |
|  5 | MySQL vs. YourSQL | In the following database comparison ... |
+----+-------------------+------------------------------------------+
2 rows in set (0.00 sec)
```

## Кодировка


CHARACTER SET — это некий набор символов, называемых кодировкой.


COLLATION — способ, с помощью которого следует упорядочивать и сравнивать данные в БД.


Для одного и того же CHARACTER SET существует как правило несколько COLLATION. Например: cp1251_general_ci — сравнение не чувствительное к регистру, cp1251_bin — чувствительное к регистру.


### Способы задания кодировок
 1) Для всего сервера при компиляции, определив параметры --with-charset и --with-collation:
<pre class="prettyprint lang-sh">./configure --with-charset=cp1251 --with-collation=cp1251_general_ci``` 2) Для всего сервера при запуске mysqld, определив параметры --character-set-server и --collation-server:
<pre class="prettyprint lang-sh">mysqld --character-set-server=cp1251 --collation-server=cp1251_bin``` 3) При создании БД:
```CREATE DATABASE dbname DEFAULT CHARACTER SET cp1251 COLLATE cp1251_bin;``` 4) При создании таблиц:
```CREATE TABLE tblname ( col INT ) DEFAULT CHARACTER SET cp1251 COLLATE cp1251_bin;``` 5) В определениях столбцов:
```
CREATE TABLE tblname (
	column1 varchar(255),
	column2 varchar(255) CHARACTER SET cp1251 COLLATE cp1251_general_ci
) DEFAULT CHARACTER SET cp1251 COLLATE cp1251_bin;
``` Для того чтобы посмотреть к какой кодировке привязана структура данных можно воспользоваться оператором SHOW CREATE:
```
mysql > SHOW CREATE TABLE tree_nodes;
| tree_nodes | CREATE TABLE `tree_nodes` (
	...
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin |
```



## Дата, время


### Способы хранения


### Преобразования




## Процедуры

<ul>
  <li>`show procedure status;`</li>
  <li>`show procedure status where name = 'set_seo';`</li>
</ul>



## Транзакции


Совсем всегда использовать транзакции - отключить режим autocommit:


`SET AUTOCOMMIT=0`


Если необходимо переключиться из режима AUTOCOMMIT только для выполнения одной последовательности команд (`BEGIN;` или `BEGIN WORK;`):

```BEGIN;
SELECT @A:=SUM(salary) FROM table1 WHERE type=1;
UPDATE table2 SET summmary=@A WHERE type=1;
COMMIT;```

В каком режиме работаем?:


`SHOW VARIABLES LIKE 'AUTOCOMMIT'`


Следующие команды автоматически завершают транзакцию (`COMMIT;`):



	`ALTER TABLE`, `BEGIN`, `CREATE INDEX`, `DROP DATABASE`, `DROP TABLE`, `RENAME TABLE`, `TRUNCATE`



### Уровни изоляции транзакций InnoDB


можно настроить в `my.cnf`:

```transaction-isolation = {READ-UNCOMMITTED | READ-COMMITTED | REPEATABLE-READ | SERIALIZABLE}```

или задать командой:

```SET [SESSION | GLOBAL] TRANSACTION ISOLATION LEVEL {READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE}```

узнать текущий уровень изоляции

```SELECT @@global.tx_isolation;
SELECT @@tx_isolation;```

__READ UNCOMMITTED__ (самый слабый уровень)


Внутри транзакции, после INSERT (или ...) данные сразу-же станут доступны для чтения (Грязное, грязное чтение).


Все запросы SELECT читают в неблокирующей манере. Изменения незавершенной транзакции могут быть прочитаны в других транзакциях, а изменения эти могут быть еще и впоследствии откачены. Это так называемое «грязное чтение» (несогласованное).


В остальном все так же, как и при READ COMMITED.


__READ COMMTITED__


Прочитать данные возможно только после вызова COMMIT. Внутри транзакции данные тоже будут еще не доступны.


Согласованное чтение ничего не блокирует, но каждый раз происходит из свежего снэпшота.


Блокирующее чтение (SELECT… FOR UPDATE/LOCK IN SHARE MODE), UPDATE и DELETE блокирует только искомые индексные записи (record lock). Таким образом возможна вставка параллельным потоком записей в промежутки между индексами. Промежутки блокируются (gap lock) только при проверках внешних ключей и дублирующихся ключей. Также блокировки просканированных строк (record lock), не удовлетворяющих WHERE, снимаются сразу же после обработки WHERE.


__REPEATABLE READ__ (значение по умолчанию)


Добавленные данные уже будут доступны внутри транзакции, но не будут доступны до подтверждения извне.


Проблема «фантомного чтения»: когда внутри одной транзакции происходит чтение данных, другая транзакция в этот момент вставляет новые данные, а первая транзакция снова читает те-же самые данные.


Согласованное чтение (SELECT) ничего не блокирует, читает строки из снэпшота, который создается при первом чтении в транзакции. Одинаковые запросы всегда вернут одинаковый результат.


Для блокирующего чтения (SELECT… FOR UPDATE/LOCK IN SHARE MODE), UPDATE и DELETE блокировка будет зависит от типа условия. Если условие уникально (WHERE id=42), то блокируется только найденная индексная запись (record lock). Если условие с диапазоном (WHERE id > 42), то блокируются весь диапазон (gap lock или next-key lock).


__SERIALIZABLE__ (самый строгий уровень)


На данном уровне MySQL блокирует каждую строку над которой происходит какое либо действие, это исключает появление проблемы «фантомов».


Аналогичен REPEATABLE READ, за исключением одного момента. Если autocommit выключен (а при явном старте транзакции он выключен), то все простые запросы SELECT неявно превращаются в SELECT… LOCK IN SHARE MODE, если включен — каждый SELECT идет в отдельной транзакции. Используется, как правило, для того чтобы превратить все запросы чтения в SELECT… LOCK IN SHARE MODE, если этого нельзя сделать в коде приложения.


### Блокировки


`SELECT… LOCK IN SHARE MODE` — блокирует считываемые строки на запись.


Другие сессии могут читать, но ждут окончания транзакции для изменения затронутых строк. Если же в момент такого SELECT'а строка уже изменена другой транзакцией, но еще не зафиксирована, то запрос ждет окончания транзакции и затем читает свежие данные. Данная конструкция нужна, как правило, для того чтобы получить свежайшие данные (независимо от времени жизни транзакции) и заодно убедиться в том, что их никто не изменит.


`SELECT… FOR UPDATE` — блокирует считываемые строки на чтение. Точно такую же блокировку ставит обычный UPDATE, когда считывает данные для обновления.


### Примеры

```
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;
  START TRANSACTION;
  INSERT ...
  INSERT ...
  COMMIT;
END;
```

## Консоль


### mysql

<pre lang="prettyprint lang-sh">
# Полные имена параметров
mysql --host=localhost --port=3306 --database=webhobru_yii --user=root --password --execute="select * from user"```
<pre lang="prettyprint lang-sh">
# Краткие имена параметров
mysql -hlocalhost -P3306 -Dwebhobru_yii -uroot -p -e "select * from user"```
<pre lang="prettyprint lang-sh">
# Вывести базы данных (доступные указанному пользователю!)
mysql -uroot -p -e "show databases"```
<pre lang="prettyprint lang-sh">mysql -uroot --password="" -Dwebhobru_yii -e "call buy_list(1)"```
<pre lang="prettyprint lang-sh">
# Не выводить имена полей (параметр -s):
mysql --host=$DBHOST --port=3306 --user="$DBUSER" --password="$DBPASS" -s --execute="SELECT concat(\`1\`, '.', \`2\`, '.', \`3\`) as version FROM newzlatov.sqlversion LIMIT 1;"```

Прям выполнить sql файл

```mysql --database="$database" --user="$user" --password="$password" < ./procedures.sql;```

__Параметры__


`-t` — форматировать в таблицы


`-s` — без сетки таблицы


`-N` — без заголовка таблицы (без имён полей)



### Резервное копирование и восстановление (дамп dump)

#### Создание резервной копии



__Параметры:__

<ul>
  <li>
    
    `--opt`

    
    Параметр предназначен для оптимизации скорости резервирования данных и является сокращением, включающим следующие опции: --quick --add-drop-table --add-locks --create-options --disable-keys --extended-insert --lock-tables --set-charset. Начиная с MySQL 4.1, параметр --opt используется по умолчанию, т.е. все вышеперечисленные параметры включаются по умолчанию, даже если они не указываются. Для того чтобы исключить такое поведение, необходимо воспользоваться параметров --skip-opt

  </li>
  <li>
    
    `--extended-insert`

    
    создаст мультистроковые вставки в INSERT

    
    вопрос - какой величины, если таблица очень большая то размер запроса может превысить параметр:

    
    `SHOW VARIABLES LIKE 'max_allowed_packet';`

  </li>
  <li>
    
    `--routines` (FALSE by default)

    
    при котором в дамп пишутся __stored procedures/functions__.

  </li>
  <li>
    
    `--triggers` (TRUE by default)

  </li>
  <li>
    
    `--no-data, -d`

    
    Подавляет создание операторов INSERT в дампе, что может быть полезно при создании дампа структуры базы данных без самих данных.

  </li>
  <li>
    
    `--ignore-table=db_name.tbl_name`

    
    Позволяет игнорировать таблицу tbl_name базы данных db_name при создании дампа. Если из дампа необходимо исключить несколько таблиц, необходимо использовать несколько параметров "--ignore-table", указывая по одной таблице в каждом из параметров.

  </li>
  <li>
    
    `--replace`

    
    Добавляет ключевое слово REPLACE в оператор INSERT. Данный параметр впервые появился в MySQL 5.1.3.

  </li>
</ul>


Проверить !!! mysqldump --skip-extended-insert --net_buffer_length=50000 myschema > gigantic_file.sql



<em>`config.sh`</em>

<pre class="prettyprint lang-sh">
#!/bin/bash
DBHOST=localhost
DBUSER=qsllogin
DBPASS=qslpassword
DBNAME=sqldbname
```

<em>`backup.sh`</em>

<pre class="prettyprint lang-sh">
#!/bin/bash
. ../config.sh
echo &quot;Confg included successfully.&quot;

DBDATE=`date +%Y-%m-%d-%H-%M-%S`

mysqldump --opt -u$DBUSER -h$DBHOST -p$DBPASS $DBNAME > $DBNAME-$DBDATE.sql
tar -czf $DBNAME-$DBDATE.tar.gz $DBNAME-$DBDATE.sql
rm ./$DBNAME-$DBDATE.sql

echo &quot;End of the script.&quot;
```
#### Удалить/Создать базу данных


(перед восстановлением)

```
#!/bin/bash
. ../config.sh
echo &quot;Config included successfully.&quot;

mysql --user=$DBUSER --password=&quot;$DBPASS&quot; --execute=&quot;DROP DATABASE $DBNAME;&quot;
mysql --user=$DBUSER --password=&quot;$DBPASS&quot; --execute=&quot;CREATE SCHEMA $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;&quot;

echo &quot;End of the script.&quot;
```
#### Восстановление из резервной копии

<h5>С помощью заготовленного скрипта</h5>

Использовать так:


`./restoreFromArchive.sh newforum-2016-09-15-09-43-10.tar.gz`


restoreFromArchive.sh

<pre class="prettyprint lang-sh">
#!/bin/bash
. ../config.sh
echo &quot;Config included successfully.&quot;

tar -xzOf &quot;$1&quot; | mysql -u&quot;$DBUSER&quot; -p&quot;$DBPASS&quot; &quot;$DBNAME&quot;

echo &quot;End of the script.&quot;
```
<h5>С помощью <var>pipe viewer</var> с просмотром прогресса</h5>

`pv forumsql-mysql.sql | mysql -u"$DB_USER" -p"$DB_PASS" "$DB_FORUM"`



## Администирование


### Настроить mysql поможет


<a href="http://mysqltuner.com/">http://mysqltuner.com/</a>


### Version of mysql

<pre class="prettyprint lang-sh">
mysql -V
## not: mysql -<mark>v</mark>
```

### Start Stop Restart Status

<pre class="prettyprint lang-sh">sudo service mysql <mark>start</mark>
sudo service mysql <mark>stop</mark>
sudo service mysql <mark>restart</mark>
sudo service mysql <mark>status</mark>
# or mysqld, or su<kbd>Enter</kbd> password<kbd>Enter</kbd> service mysql start
```

### Просмотр пользователей mysql

```SELECT User, Host FROM mysql.user;```

### Добавление/создание пользователя

```CREATE USER 'userLogin'@'localhost' IDENTIFIED BY 'userPassword';```

### Удаление пользователя

```DROP USER 'userLogin'@'localhost';```

### Установка прав пользователям mysql

```GRANT permission ON database.table TO 'userLogin'@'localhost';
GRANT CREATE ON *.* TO 'userLogin'@'localhost';
GRANT DROP ON testdatabase.* TO 'userLogin'@'localhost';
```

Краткий список часто используемых прав (permissions list):

<ul>
    <li>ALL – Allow complete access to a specific database. If a database is not specified, then allow complete access to the entirety of MySQL.</li>
    <li>CREATE – Allow a user to create databases and tables.</li>
    <li>DELETE – Allow a user to delete rows from a table.</li>
    <li>DROP – Allow a user to drop databases and tables.</li>
    <li>EXECUTE – Allow a user to execute stored routines.</li>
    <li>GRANT OPTION – Allow a user to grant or remove another user’s privileges.</li>
    <li>INSERT – Allow a user to insert rows from a table.</li>
    <li>SELECT – Allow a user to select data from a database.</li>
    <li>SHOW DATABASES- Allow a user to view a list of all databases.</li>
    <li>UPDATE – Allow a user to update rows in a table.</li>
</ul>

### Перезагрузить (применить) разрешения


Когда мы закончили изменять разрешения, хорошей практикой является перезагрузка всех привилегий с помощью команды flush.

```FLUSH PRIVILEGES;```

### Просотр разрешений

```
-- для залогиненного пользователя:
SHOW GRANTS;
-- и для указанного пользователя:
SHOW GRANTS FOR 'userLogin'@'localhost';
```

### Удаление разрешений

```REVOKE <mark>permission</mark> ON database.table FROM 'user'@'localhost';```
```REVOKE CREATE ON <mark>*.*</mark> FROM 'testuser'@'localhost';```
```REVOKE DROP ON <mark>tutorial_database.*</mark> FROM 'testuser'@'localhost';```

Не забываем перезагрузить разрешения!

```FLUSH PRIVILEGES;```

### Восстановление root (прав и пароля пользователя)


1. Добавим в файл <var class="copyToClipboard prettyprint lang-sh">subl /etc/mysql/my.cnf</var> строку `skip-grant-tables` в раздел <var>[mysqld]</var>:

<pre class="prettyprint lang-sh">[mysqld]
#
# * Basic Settings
#
skip-grant-tables
```

2. Перезагрузим mysql: <code class="copyToClipboard prettyprint lang-sh">sudo service mysql restart`


3. Назначим права пользователю root:

<pre class="copyToClipboard lang-sh">mysql -uroot```
<pre class="copyToClipboard lang-sql">flush privileges;```
<pre class="copyToClipboard lang-sql">grant all ON *.* TO `root`@`localhost` identified by 'mypassword' with grant option;```

4. Удалим <var>skip-grant-tables</var>, перезагрузим mysql.




## Тестирование



### Ошибки, предупреждения и их количество

```
SHOW COUNT(*) ERRORS;
SHOW COUNT(*) WARNINGS;
SELECT @@error_count;
SELECT @@session.error_count;
SELECT @@warning_count;
SELECT @@session.warning_count;
SHOW ERRORS;
SHOW WARNINGS;
```

### Полное логирование всех запросов


Эта операция затратна по объему создаваемого лога, так что предназначена скорее для тестирования на локальной машине. Для начала найдем настройки отвечающие за логирование ВСЕХ запросов (это переменные <var>general_log_file</var> и <var>general_log_file</var>):

```SHOW VARIABLES LIKE '%log%';```

Чтобы включить логирование нужно выполнить `SET GLOBAL ...` так как настройка глобальная

```SET GLOBAL GENERAL_LOG = 1;```

Далее потыкаем в приложение и пойдем посмотрим лог:

<pre class="prettyprint lang-sh">
sudo cp /var/lib/mysql/iadfeshchm-pc.log ~
sudo chown iadfeshchm:iadfeshchm iadfeshchm-pc.log
subl iadfeshchm-pc.log
```

Не забываем отключить логирование, а то распухнет!

```SET GLOBAL GENERAL_LOG = 0;```


### Отключить кеширование для определения времени

```SELECT SQL_NO_CACHE ...```


### Статус таблиц БД

Сколько дискового пространства занимаю данные таблиц, ключи и другое...
```SHOW TABLE STATUS;
SHOW TABLE STATUS FROM signforum_new;```


### EXPLAIN

```EXPLAIN table_name; -- ключи...
EXPLAIN SELECT ...; -- план выполнения запроса```

<ul>
<li><b>id</b> – порядковый номер для каждого SELECT’а внутри запроса (когда имеется несколько подзапросов)</li>
<li><b>select_type</b> – тип запроса SELECT.<br>
<br>
<ul>
<li><b>SIMPLE</b> — Простой запрос SELECT без подзапросов или UNION’ов</li>
<li><b>PRIMARY</b> – данный SELECT – самый внешний запрос в JOIN’е</li>
<li><b>DERIVED</b> – данный SELECT является частью подзапроса внутри FROM </li>
<li><b>SUBQUERY</b> – первый SELECT в подзапросе</li>
<li><b>DEPENDENT SUBQUERY</b> – подзапрос, который зависит от внешнего запроса</li>
<li><b>UNCACHABLE SUBQUERY</b> – не кешируемый подзапрос (существуют определенные условия для того, чтобы запрос кешировался)</li>
<li><b>UNION</b> – второй или последующий SELECT в UNION’е</li>
<li><b>DEPENDENT UNION</b> – второй или последующий SELECT в UNION’е, зависимый от внешнего запроса</li>
<li><b>UNION RESULT</b> – результат UNION’а</li>
</ul><br>
</li>
<li><b>Table</b> – таблица, к которой относится выводимая строка</li>
<li><b>Type </b> — указывает на то, как MySQL связывает используемые таблицы. Это одно из наиболее полезных полей в выводе потому, что может сообщать об отсутствующих индексах или почему написанный запрос должен быть пересмотрен и переписан. <br>
Возможные значения:<br>
<br>
<ul>
<li><b>System</b> – таблица имеет только одну строку</li>
<li><b>Const</b> – таблица имеет только одну соответствующую строку, которая проиндексирована. Это наиболее быстрый тип соединения потому, что таблица читается только один раз и значение строки может восприниматься при дальнейших соединениях как константа.</li>
<li><b>Eq_ref</b> – все части индекса используются для связывания. Используемые индексы: PRIMARY KEY или UNIQUE NOT NULL. Это еще один наилучший возможный тип связывания.</li>
<li><b>Ref</b> – все соответствующие строки индексного столбца считываются для каждой комбинации строк из предыдущей таблицы. Этот тип соединения для индексированных столбцов выглядит как использование операторов = или < = ></li>
<li><b>Fulltext</b> – соединение использует полнотекстовый индекс таблицы</li>
<li><b>Ref_or_null</b> – то же самое, что и ref, но также содержит строки со значением null для столбца</li>
<li><b>Index_merge</b> – соединение использует список индексов для получения результирующего набора. Столбец key вывода команды EXPLAIN будет содержать список использованных индексов.</li>
<li><b>Unique_subquery</b> – подзапрос IN возвращает только один результат из таблицы и использует первичный ключ.</li>
<li><b>Index_subquery</b> – тоже, что и предыдущий, но возвращает более одного результата.</li>
<li><b>Range</b> – индекс, использованный для нахождения соответствующей строки в определенном диапазоне, обычно, когда ключевой столбец сравнивается с константой, используя операторы вроде: BETWEEN, IN, >, >=, etc.</li>
<li><b>Index</b> – сканируется все дерево индексов для нахождения соответствующих строк.</li>
<li><b>All</b> – Для нахождения соответствующих строк используются сканирование всей таблицы. Это наихудший тип соединения и обычно указывает на отсутствие подходящих индексов в таблице.</li>
</ul><br>
</li>
<li><b>Possible_keys</b> – показывает индексы, которые могут быть использованы для нахождения строк в таблице. На практике они могут использоваться, а могут и не использоваться. Фактически, этот столбец может сослужить добрую службу в деле оптимизации запросов, т.к значение NULL указывает на то, что не найдено ни одного подходящего индекса .</li>
<li><b>Key</b>– указывает на использованный индекс. Этот столбец может содержать индекс, не указанный в столбце possible_keys. В процессе соединения таблиц оптимизатор ищет наилучшие варианты и может найти ключи, которые не отображены в possible_keys, но являются более оптимальными для использования.</li>
<li><b>Key_len</b> – длина индекса, которую оптимизатор MySQL выбрал для использования. Например, значение key_len, равное 4, означает, что памяти требуется для хранения 4 знаков. На эту тему вот <a href="http://dev.mysql.com/doc/refman/5.0/en/storage-requirements.html">cсылка</a></li>
<li><b>Ref</b> – указываются столбцы или константы, которые сравниваются с индексом, указанным в поле key. MySQL выберет либо значение константы для сравнения, либо само поле, основываясь на плане выполнения запроса.</li>
<li><b>Rows</b> – отображает число записей, обработанных для получения выходных данных. Это еще одно очень важное поле, которое дает повод оптимизировать запросы, особенно те, которые используют JOIN’ы и подзапросы.</li>
<li><b>Extra</b> – содержит дополнительную информацию, относящуюся к плану выполнения запроса. Такие значения как “Using temporary”, “Using filesort” и т.д могут быть индикатором проблемного запроса. С полным списком возможных значений вы можете ознакомиться <a href="http://dev.mysql.com/doc/refman/5.6/en/explain-output.html#explain-extra-information">здесь</a></li>
</ul>



## Ошибки



### 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column To disable safe mode, toggle the option in Preferences

```
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;
```


### mysql: [Warning] Using a password on the command line interface can be insecure.


__Способ 1__: в начале скрипта в переменные окружения добавить переменную <var>MYSQL_PWD</var>:

<pre class="prettyprint lang-sh">
# Вместо использования --password="$DBPASS" в утилите mysql выполните:
export MYSQL_PWD="$DBPASS" 
```



## Наработки



### Обновить колонку таблицы из другой таблицы

```
SET SQL_SAFE_UPDATES = 0; -- Только для mysqlWorkbench

UPDATE
	newforum.forum_users
INNER JOIN
	forumoldutf8.forum_users ON forumoldutf8.forum_users.user_id = newforum.forum_users.user_id
SET newforum.forum_users.user_reputation = forumoldutf8.forum_users.user_reputation
WHERE
	forumoldutf8.forum_users.user_reputation <> 0;

SET SQL_SAFE_UPDATES = 1; -- Только для mysqlWorkbench
```

### Выбрать одну случайную запись

```SELECT
	r1.id
FROM
	forum_advt AS r1
JOIN
	(
		SELECT CEIL( 
			RAND()
			*
			(
				SELECT MAX(id) FROM forum_advt
			) 
		) AS id
	) AS r2
WHERE
	r1.id >= r2.id
	and `show` <> 0
ORDER BY
	r1.id ASC
LIMIT 1;```
Для получения определенного количества уникальных записей: будем выполнять запрос
<pre class="prettyprint lang-php">$advt_ids = [];
while (count($advt_ids) <= 5) {
	$result = $db->sql_query($sql);
	$row = $db->sql_fetchrow($result);
	$db->sql_freeresult($result);
	if ($row['id']) {
		if (in_array($row['id'], $advt_ids)) {
			continue;
		}
		$advt_ids[] = $row['id'];
		$advt_row = array(
			'ID'        => $row['id'],
			'LINK'      => $row['link'],
			'FILE_NAME' => $row['file_name'],
	    );
		$template->assign_block_vars('advts', $advt_row);
	}
}
```


## Метопрограммирование


### Найти таблицы зная имя поля

```
SELECT TABLE_NAME
FROM information_schema.`COLUMNS`
WHERE TABLE_SCHEMA="auctionru_2013" AND COLUMN_NAME LIKE 'access%'
```

## Примеры процедур ага

```
use `food`;
drop procedure if exists `cook_menu_all`;
drop procedure if exists `current_menu`;
drop procedure if exists `cook_kitchens`;
drop procedure if exists `product_filters`;
drop procedure if exists `search_dish`;
drop procedure if exists `search_cook`;
delimiter ;;

create procedure `cook_menu_all`(in param_user_id int(11))
begin
	select *
	from product p 
	left join dish d
		on d.product_id = p.id
	left join `set` s
		on s.product_id = p.id
	left join `set_dish` sd
		on sd.set_id = s.product_id
	left join `dish` dd
		on dd.product_id = sd.dish_id
	left join `dish_kitchen` dk
		on dk.dish_id = d.product_id
	left join `dish_kitchen` dks
		on dks.dish_id = dd.product_id
	where p.user_id = param_user_id
	group by p.id;
end;;

create procedure `current_menu`(in param_sid varchar(80))
begin
	(
	select
		`c`.`id`,
		`c`.`pid`,
		`c`.`sid`,
		`c`.`header`,
		`c`.`order`
	from
		`page` `p`
	left join
		`page` `r` on `r`.`id` = `p`.`pid`
	left join
		`page` `c` on if(`r`.`id`, `c`.`pid` = `r`.`id`, `c`.`pid` is null)
	where
		`p`.`sid` = param_sid
	)
	union all
	(
	select
		`c2`.`id`,
		`c2`.`pid`,
		`c2`.`sid`,
		`c2`.`header`,
		`c2`.`order`
	from
		`page` `p`
	left join
		`page` `r` on `r`.`id` = `p`.`pid`
	left join
		`page` `c` on if(`r`.`id`, `c`.`pid` = `r`.`id`, `c`.`pid` is null)
	inner join
		`page` `c2` on `c2`.`pid` = `c`.`id`
	where
		`p`.`sid` = param_sid
	)
	order by
		`order` asc,
		`id` asc;
end ;;

create procedure `cook_kitchens`(in param_user_id int(11))
begin
	select
		distinct k.kitchen_id as id,
		kh.header as header
	from food.product p
	left join dish d on d.product_id = p.id
	left join dish_kitchen k on k.dish_id = d.product_id
	left join kitchen kh on kh.id = k.kitchen_id
	where p.user_id = param_user_id;
end;;

create procedure `product_filters`()
begin
	select
		min(`p`.`pricesale`) as `price_min`,
		max(`p`.`price`) as `price_max`
	from
		`product` `p`;
end;;

create procedure `search_dish`(
	in param_offset int,
	in param_rows int,
	in param_dishordiet varchar(255),
	in param_from decimal(8,2),
	in param_to decimal(8,2),
	in param_dishtype int,
	in param_kitchen varchar(180),
	in param_q varchar(32),
	in param_pickup int,
	in param_workhome int,
	in param_costdeliveryfrom decimal(8,2),
	in param_costdeliveryto decimal(8,2)
)
begin
	select SQL_CALC_FOUND_ROWS
		`p`.`id`
	from
		`product` `p`
		left join `dish` `d` on `d`.`product_id` = `p`.`id`
		left join `diet` `di` on `di`.`id` = `d`.`diet_id`
		left join `dish_kitchen` `dk` on `dk`.`dish_id` = `d`.`product_id`
		left join `kitchen` `k` on `k`.`id` = `dk`.`kitchen_id`
		left join `user` `u` on `u`.`id` = `p`.`user_id`
		left join `profile_cook` `pc` on `pc`.`user_id` = `u`.`id`
	where
		case
			when param_dishordiet = 'dish' then `d`.`diet_id` is null
			when param_dishordiet = 'diet' then `d`.`diet_id` is not null
			else 1 end
		and `p`.`price` >= param_from
		and `p`.`price` <= param_to
		and ifnull(`d`.`dishtype_id` = param_dishtype, 1)
		and
			case
				when param_dishordiet = 'dish' then ifnull(`k`.`sid` = param_kitchen, 1)
				when param_dishordiet = 'diet' then ifnull(`di`.`sid` = param_kitchen, 1)
			end
		and if(param_q=param_q, `p`.`header` like concat('%',param_q,'%'), 1)
		and ifnull(`pc`.`pickup` = param_pickup, 1)
		and if(param_workhome is not null, `pc`.`workhome` = 1, 1)
		and ifnull(`pc`.`costdelivery` >= param_costdeliveryfrom, 1)
		and ifnull(`pc`.`costdelivery` <= param_costdeliveryto, 1)
		and if(param_costdeliveryfrom is not null or param_costdeliveryto is not null, `pc`.`costdelivery` is not null, 1)
		and `u`.`usertype` = 'cook'
		and `u`.`role` = 10
		and `u`.`status` = 10
	group by `p`.`id`
	limit param_offset, param_rows;
end;;

create procedure `search_cook`(
	in param_offset int,
	in param_rows int,
	in param_dishordiet varchar(255),
	in param_from decimal(8,2),
	in param_to decimal(8,2),
	in param_dishtype int,
	in param_kitchen varchar(180),
	in param_q varchar(32),
	in param_pickup int,
	in param_workhome int,
	in param_costdeliveryfrom decimal(8,2),
	in param_costdeliveryto decimal(8,2)
)
begin
	select SQL_CALC_FOUND_ROWS
		`u`.`id` as `u_id`,
		GROUP_CONCAT(DISTINCT `p`.`id` SEPARATOR ',') AS `p_id`
	from
		`user` `u`
		left join `product` `p` on `p`.`user_id` = `u`.`id`
		left join `dish` `d` on `d`.`product_id` = `p`.`id`
		left join `diet` `di` on `di`.`id` = `d`.`diet_id`
		left join `dish_kitchen` `dk` on `dk`.`dish_id` = `d`.`product_id`
		left join `kitchen` `k` on `k`.`id` = `dk`.`kitchen_id`
		left join `profile_cook` `pc` on `pc`.`user_id` = `u`.`id`
	where
		`u`.`usertype` = 'cook'
		and `u`.`role` = 10
		and `u`.`status` = 10
		and
			case
				when param_dishordiet = 'dish' then `d`.`diet_id` is null
				when param_dishordiet = 'diet' then `d`.`diet_id` is not null
				else 1
			end
		and `p`.`price` >= param_from
		and `p`.`price` <= param_to
		and ifnull(`d`.`dishtype_id` = param_dishtype, 1)
		and
			case
				when param_dishordiet = 'dish' then ifnull(`k`.`sid` = param_kitchen, 1)
				when param_dishordiet = 'diet' then ifnull(`di`.`sid` = param_kitchen, 1)
			end
		and if(param_q=param_q, `p`.`header` like concat('%',param_q,'%'), 1)
		and ifnull(`pc`.`pickup` = param_pickup, 1)
		and if(param_workhome is not null, `pc`.`workhome` = 1, 1)
		and ifnull(`pc`.`costdelivery` >= param_costdeliveryfrom, 1)
		and ifnull(`pc`.`costdelivery` <= param_costdeliveryto, 1)
		and if(param_costdeliveryfrom is not null or param_costdeliveryto is not null, `pc`.`costdelivery` is not null, 1)
	group by `u`.`id`
	limit param_offset, param_rows;
end;;
```
