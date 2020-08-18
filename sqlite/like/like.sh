#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
pwd

sqlite3 temp <<-'EOF'
	DROP TABLE IF EXISTS `a`;

	CREATE TABLE `a` (
		id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		comment TEXT NULL
	);

	INSERT INTO `a` (`name`) VALUES
	('aab'),
	('ab');

	SELECT * FROM `a` WHERE name LIKE '%b';
	SELECT '---';
	SELECT * FROM `a` WHERE name LIKE '_b';
EOF
