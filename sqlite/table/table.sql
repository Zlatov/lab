DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NULL
);

SELECT name FROM sqlite_master WHERE type = "table";

-- .tables;
