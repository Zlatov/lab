DROP TABLE IF EXISTS `user_role_rels`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `roles`;

CREATE TABLE `users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(160) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Пользователи';

CREATE TABLE `roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(160) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Роли';

CREATE TABLE `user_role_rels` (
  `user_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacaasignment_id` (`user_id`, `role_id`),
  INDEX `ix_userrolerels_userid` (`user_id`),
  INDEX `ix_userrolerels_roleid` (`role_id`),
  CONSTRAINT `fk_userrolerels_userid` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userrolerels_roleid` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Отношения ролей и пользователей';

INSERT INTO `roles`
  (`name`)
VALUES
  ('Главный менеджер'),
  ('Администратор'),
  ('Сео специалист'),
  ('Контент менеджер'),
  ('Программист'),
  ('Верстальщик');

INSERT INTO `users`
  (`name`)
VALUES
  ('Коля'),
  ('Вася'),
  ('Петя'),
  ('Рома'),
  ('Ваня'),
  ('Женя');

INSERT INTO `user_role_rels`
  (`user_id`, `role_id`)
VALUES
  (1, 1),
  (1, 2),
  (2, 1),
  (2, 2),
  (1, 3),
  (3, 1);

SELECT
  u.id as uid,
  u.name as uname,
  ur.user_id as uruser_id,
  ur.role_id as urrole_id,
  r.id as rid,
  r.name as rname 
FROM users u
LEFT JOIN user_role_rels ur ON ur.user_id = u.id
LEFT JOIN roles r ON r.id = ur.role_id;
