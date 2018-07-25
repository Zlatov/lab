#!/bin/bash
rm temp.sqlite3
sqlite3 temp.sqlite3 <<SQL
  drop table if exists table_a;
  drop table if exists table_a;

  create table table_a (
    id integer not null primary key autoincrement,
    name text not null
  );

  create table table_b (
    id integer not null primary key autoincrement,
    name text not null
  );

  insert into table_a values (1, ''), (2, '');
  insert into table_b values (1, '1'), (2, '2');

  UPDATE table_a
  SET name = (
    SELECT name
    FROM table_b
    WHERE table_b.id = table_a.id
  );

  select * from table_a;
SQL
