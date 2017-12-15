-- Просмотр пользователей mysql
-- SELECT User, Host FROM mysql.user;

-- Добавление/создание пользователя
-- CREATE USER 'userLogin'@'localhost' IDENTIFIED BY 'userPassword';

-- Удаление пользователя
-- DROP USER 'userLogin'@'localhost';

-- Установка прав пользователям mysql
-- GRANT permission ON database.table TO 'userLogin'@'localhost';
-- GRANT CREATE ON *.* TO 'userLogin'@'localhost';
-- GRANT DROP ON testdatabase.* TO 'userLogin'@'localhost';

-- Краткий список часто используемых прав (permissions list):
-- ALL – Allow complete access to a specific database. If a database is not specified, then allow complete access to the entirety of MySQL.
-- CREATE – Allow a user to create databases and tables.
-- DELETE – Allow a user to delete rows from a table.
-- DROP – Allow a user to drop databases and tables.
-- EXECUTE – Allow a user to execute stored routines.
-- GRANT OPTION – Allow a user to grant or remove another user’s privileges.
-- INSERT – Allow a user to insert rows from a table.
-- SELECT – Allow a user to select data from a database.
-- SHOW DATABASES- Allow a user to view a list of all databases.
-- UPDATE – Allow a user to update rows in a table.

-- Перезагрузить (применить) разрешения
-- Когда мы закончили изменять разрешения, хорошей практикой является перезагрузка всех привилегий с помощью команды flush.
-- FLUSH PRIVILEGES;

-- Просотр разрешений
-- -- для залогиненного пользователя:
-- SHOW GRANTS;
-- -- и для указанного пользователя:
-- SHOW GRANTS FOR 'userLogin'@'localhost';

-- Удаление разрешений
-- REVOKE permission ON database.table FROM 'user'@'localhost';
-- REVOKE CREATE ON *.* FROM 'testuser'@'localhost';
-- REVOKE DROP ON tutorial_database.* FROM 'testuser'@'localhost';
-- Не забываем перезагрузить разрешения!
-- FLUSH PRIVILEGES;


SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'lab'@'localhost';

-- Измениьт пароль консольной утилитой
-- mysqladmin -u root password NEWPASSWORD
