#!/usr/bin/env bash
set -eu
cd "`dirname "$0"`"

sqlite3 test.sqlite3 <<!

DROP TABLE IF EXISTS a;
CREATE TABLE "a" (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);

DROP TABLE IF EXISTS b;

CREATE TABLE "b" (
	a_id INTEGER,
	c_name TEXT
);

INSERT INTO a (name) VALUES ('only with qwerty'), ('every');
INSERT INTO b (a_id, c_name) VALUES (1, 'qwerty');

SELECT  a.*
FROM a
LEFT OUTER JOIN b ON b.a_id = a.id
WHERE b.c_name = 'asdfgh' or b.c_name is null
ORDER BY a.id DESC
LIMIT 4;

!
