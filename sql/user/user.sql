CREATE USER 'lab'@'localhost' IDENTIFIED BY 'lab';
SELECT User, Host FROM mysql.user;
GRANT SELECT ON *.* TO 'lab'@'localhost';
GRANT ALL ON lab.* TO 'lab'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'lab'@'localhost';

-- REVOKE ALL ON lab.lab FROM 'lab'@'localhost';
-- SHOW GRANTS FOR 'lab'@'localhost';

mysqladmin -u root password NEWPASSWORD
