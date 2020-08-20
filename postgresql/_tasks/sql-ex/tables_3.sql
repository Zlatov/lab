DROP TABLE IF EXISTS outcomes;
DROP TABLE IF EXISTS battles;
DROP TABLE IF EXISTS ships;
DROP TABLE IF EXISTS classes;

-- 1. Classes (class, type, country, numGuns, bore, displacement)
CREATE TABLE classes (
  class VARCHAR(50) PRIMARY KEY,
  type VARCHAR(2) NOT NULL,
  country VARCHAR(20) NOT NULL,
  numGuns SMALLINT,
  bore REAL,
  displacement INTEGER
);
CREATE INDEX ON classes (class);
CREATE INDEX ON classes (type);

-- 2. Ships (name, class, launched)
CREATE TABLE ships (
  name VARCHAR(50) PRIMARY KEY,
  class VARCHAR(50) NOT NULL REFERENCES classes ON DELETE CASCADE ON UPDATE CASCADE,
  launched SMALLINT
);
CREATE INDEX ON ships (class);

-- 3. Battles (name, date)
CREATE TABLE battles (
  name VARCHAR(20) PRIMARY KEY,
  date timestamp NOT NULL
);

-- 4. Outcomes (ship, battle, result)
CREATE TABLE outcomes (
  ship VARCHAR(50) PRIMARY KEY,
  battle VARCHAR(20) REFERENCES battles (name) ON DELETE CASCADE ON UPDATE CASCADE,
  result varchar(10) NOT NULL
);
CREATE INDEX ON outcomes (result);


insert into classes (class, type, country, numGuns, bore, displacement) values
('Bismarck',       'bb', 'Germany',    8,  15.0, 42000),
('Iowa',           'bb', 'USA',        9,  16.0, 46000),
('Kongo',          'bc', 'Japan',      8,  14.0, 32000),
('North Carolina', 'bb', 'USA',        12, 16.0, 37000),
('Renown',         'bc', 'Gt.Britain', 6,  15.0, 32000),
('Revenge',        'bb', 'Gt.Britain', 8,  15.0, 29000),
('Tennessee',      'bb', 'USA',        12, 14.0, 32000),
('Yamato',         'bb', 'Japan',      9,  18.0, 65000);

insert into ships (name, class, launched) values
('California',      'Tennessee',     1921),
('Haruna',          'Kongo',         1916),
('Hiei',            'Kongo',         1914),
('Iowa',            'Iowa',          1943),
('Kirishima',       'Kongo',         1915),
('Kongo',           'Kongo',         1913),
('Missouri',        'Iowa',          1944),
('Musashi',         'Yamato',        1942),
('New Jersey',      'Iowa',          1943),
('North Carolina',  'North Carolina',1941),
('Ramillies',       'Revenge',       1917),
('Renown',          'Renown',        1916),
('Repulse',         'Renown',        1916),
('Resolution',      'Renown',        1916),
('Revenge',         'Revenge',       1916),
('Royal Oak',       'Revenge',       1916),
('Royal Sovereign', 'Revenge',       1916),
('South Dakota',    'North Carolina',1941),
('Tennessee',       'Tennessee',     1920),
('Washington',      'North Carolina',1941),
('Wisconsin',       'Iowa',          1944),
('Yamato',          'Yamato',        1941);

insert into battles (name, date) values
('#Cuba62a',       '1962-10-20 00:00:00.000'),
('#Cuba62b',       '1962-10-25 00:00:00.000'),
('Guadalcanal',    '1942-11-15 00:00:00.000'),
('North Atlantic', '1941-05-25 00:00:00.000'),
('North Cape',     '1943-12-26 00:00:00.000'),
('Surigao Strait', '1944-10-25 00:00:00.000');

insert into outcomes (ship, battle, result) values
('Bismarck',        'North Atlantic', 'sunk'),
('California',      'Guadalcanal',    'damaged'),
('CAlifornia',      'Surigao Strait', 'ok'),
('Duke of York',    'North Cape',     'ok'),
('Fuso',            'Surigao Strait', 'sunk'),
('Hood',            'North Atlantic', 'sunk'),
('King George V',   'North Atlantic', 'ok'),
('Kirishima',       'Guadalcanal',    'sunk'),
('Prince of Wales', 'North Atlantic', 'damaged'),
('Rodney',          'North Atlantic', 'OK'),
('Schamhorst',      'North Cape',     'sunk'),
('South Dakota',    'Guadalcanal',    'damaged'),
('Tennessee',       'Surigao Strait', 'ok'),
('Washington',      'Guadalcanal',    'ok'),
('West Virginia',   'Surigao Strait', 'ok'),
('Yamashiro',       'Surigao Strait', 'sunk');
