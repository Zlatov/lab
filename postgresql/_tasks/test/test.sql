\c lab

DROP TABLE IF EXISTS Servers;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  UserId SERIAL PRIMARY KEY,
  Email VARCHAR NOT NULL UNIQUE
);
CREATE TABLE Servers (
  ServerId SERIAL PRIMARY KEY,
  UserId INT NULL REFERENCES Users (UserId) ON DELETE SET NULL ON UPDATE CASCADE,
  ServerName VARCHAR NULL
);

INSERT INTO Users (Email) VALUES
('address1'),
('address2'),
('address3');

INSERT INTO Servers (UserId, ServerName) VALUES
(1, 'server1'),
(2, 'server2'),
(2, 'server3');

SELECT * FROM Users;
SELECT * FROM Servers;

SELECT u.Email, COUNT(s.ServerId)
FROM Users u
LEFT OUTER JOIN Servers s ON s.UserId = u.UserId
GROUP BY u.Email
;
