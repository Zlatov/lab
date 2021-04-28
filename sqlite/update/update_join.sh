#!/usr/bin/env bash

rm -f temp.sqlite3

echo -e "\e[92mПопытается обновить незатронутые строки в NULL, но выдаст ошибку, так как поле 'NOT NULL'\e[0m"
sqlite3 temp.sqlite3 <<SQL
  DROP TABLE IF EXISTS table_a;
  DROP TABLE IF EXISTS table_a;
  CREATE TABLE table_a (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  CREATE TABLE table_b (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  INSERT INTO table_a VALUES (1, '0'), (2, '0');
  INSERT INTO table_b VALUES (1, '1');

  UPDATE table_a
  SET name = (
    SELECT name
    FROM table_b
    WHERE table_b.id = table_a.id
  );

  SELECT * FROM table_a;
SQL

echo -e "\e[92mОСТОРОЖНО!: Обновит незатронутые строки в NULL\e[0m"
sqlite3 temp.sqlite3 <<SQL
  DROP TABLE IF EXISTS a;
  DROP TABLE IF EXISTS b;
  CREATE TABLE a (id INTEGER, updatable INTEGER);
  CREATE TABLE b (id INTEGER);
  INSERT INTO a VALUES (1, 0), (2, 0);
  INSERT INTO b VALUES (2);

  UPDATE a
  SET updatable = (
    SELECT 1
    FROM b
    WHERE b.id = a.id
  )
  ;

  SELECT * FROM a;
SQL

echo -e "\e[92mОбновит игнорируя незатронутые строки\e[0m"
sqlite3 temp.sqlite3 <<SQL
  DROP TABLE IF EXISTS a;
  DROP TABLE IF EXISTS b;
  CREATE TABLE a (id INTEGER, updatable INTEGER);
  CREATE TABLE b (id INTEGER);
  INSERT INTO a VALUES (1, 0), (2, 0);
  INSERT INTO b VALUES (2);

  UPDATE a
  SET updatable = (
    SELECT 1
    FROM b
    WHERE b.id = a.id
  )
  WHERE EXISTS (
    SELECT 1
    FROM b
    WHERE id = a.id
  )
  ;

  SELECT * FROM a;
SQL
