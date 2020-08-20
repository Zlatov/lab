DROP TABLE IF EXISTS pc;
DROP TABLE IF EXISTS laptop;
DROP TABLE IF EXISTS printer;
DROP TABLE IF EXISTS product;
DROP TYPE IF EXISTS product_type;


CREATE TYPE PRODUCT_TYPE AS ENUM ('pc', 'laptop', 'printer');

-- 1. Product (maker, model, type)
CREATE TABLE product (
  maker VARCHAR NOT NULL,
  model SERIAL PRIMARY KEY,
  type product_type NOT NULL
);
CREATE INDEX ON product (maker);
CREATE INDEX ON product (type);

-- 2. PC      (code, model, speed, ram, hd, cd, price)
CREATE TABLE pc (
  code SERIAL PRIMARY KEY,
  model INT REFERENCES product ON DELETE CASCADE ON UPDATE CASCADE,
  speed INT NOT NULL,
  ram INT NOT NULL,
  hd NUMERIC(9,2) NOT NULL,
  cd VARCHAR NOT NULL,
  price MONEY
);
CREATE INDEX ON pc (speed);
CREATE INDEX ON pc (ram);
CREATE INDEX ON pc (hd);
CREATE INDEX ON pc (cd);

-- 3. Laptop  (code, model, speed, ram, hd, price, screen)
CREATE TABLE laptop (
  code SERIAL PRIMARY KEY,
  model INT REFERENCES product ON DELETE CASCADE ON UPDATE CASCADE,
  speed INT NOT NULL,
  ram INT NOT NULL,
  hd NUMERIC(9,2) NOT NULL,
  price MONEY,
  screen smallint NOT NULL
);
CREATE INDEX ON laptop (speed);
CREATE INDEX ON laptop (ram);
CREATE INDEX ON laptop (hd);
CREATE INDEX ON laptop (screen);

-- 4. Printer (code, model, color, type, price)
CREATE TABLE printer (
  code SERIAL PRIMARY KEY,
  model INT REFERENCES product ON DELETE CASCADE ON UPDATE CASCADE,
  color char(1) NOT NULL,
  type varchar(10) NOT NULL,
  price MONEY
);
CREATE INDEX ON printer (color);
CREATE INDEX ON printer (type);


INSERT INTO product (maker, model, type) VALUES
('B', 1121, 'pc'),
('A', 1232, 'pc'),
('A', 1233, 'pc'),
('E', 1260, 'pc'),
('A', 1276, 'printer'),
('D', 1288, 'printer'),
('A', 1298, 'laptop'),
('C', 1321, 'laptop'),
('A', 1401, 'printer'),
('A', 1408, 'printer'),
('D', 1433, 'printer'),
('E', 1434, 'printer'),
('B', 1750, 'laptop'),
('A', 1752, 'laptop'),
('E', 2112, 'pc'),
('E', 2113, 'pc');

INSERT INTO pc (code, model, speed, ram, hd, cd, price) VALUES
(1,  1232, 500, 64,  5.0,  '12x', 600.0000),
(2,  1121, 750, 128, 14.0, '40x', 850.0000),
(3,  1233, 500, 64,  5.0,  '12x', 600.0000),
(4,  1121, 600, 128, 14.0, '40x', 850.0000),
(5,  1121, 600, 128, 8.0,  '40x', 850.0000),
(6,  1233, 750, 128, 20.0, '50x', 950.0000),
(7,  1232, 500, 32,  10.0, '12x', 400.0000),
(8,  1232, 450, 64,  8.0,  '24x', 350.0000),
(9,  1232, 450, 32,  10.0, '24x', 350.0000),
(10, 1260, 500, 32,  10.0, '12x', 350.0000),
(11, 1233, 900, 128, 40.0, '40x', 980.0000),
(12, 1233, 800, 128, 20.0, '50x', 970.0000);

INSERT INTO laptop (code, model, speed, ram, hd, price, screen) VALUES
(1, 1298, 350, 32,  4.0,  700.0000,  11),
(2, 1321, 500, 64,  8.0,  970.0000,  12),
(3, 1750, 750, 128, 12.0, 1200.0000, 14),
(4, 1298, 600, 64,  10.0, 1050.0000, 15),
(5, 1752, 750, 128, 10.0, 1150.0000, 14),
(6, 1298, 450, 64,  10.0, 950.0000,  12);

INSERT INTO printer (code, model, color, type, price) VALUES
(6, 1288, 'n', 'Laser',  400.0000),
(5, 1408, 'n', 'Matrix', 270.0000),
(4, 1401, 'n', 'Matrix', 150.0000),
(3, 1434, 'y', 'Jet',    290.0000),
(2, 1433, 'y', 'Jet',    270.0000),
(1, 1276, 'n', 'Laser',  400.0000);
