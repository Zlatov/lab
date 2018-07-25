DROP TABLE IF EXISTS `a`;
DROP TABLE IF EXISTS `b`;

CREATE TABLE `a` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  `string` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
);

CREATE TABLE `b` (
  `string` VARCHAR(255) NOT NULL DEFAULT ''
);

INSERT INTO `a` (`string`) VALUES ('1'), ('2');
INSERT INTO `a` VALUES (3, '1'), (4, '2');
INSERT INTO `a` VALUES (5, '1'), (6, '2');

insert into `b` (`string`) values ('a'), ('b'), ('c');

-- INSERT ... SELECT
insert into `a` (`string`)
select `string` from `b`;

select * from a;
select * from b;
