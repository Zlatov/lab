DROP TABLE IF EXISTS `rbac_perm_role`;
DROP TABLE IF EXISTS `rbac_rolerel`;
DROP TABLE IF EXISTS `rbac_assignment`;
DROP TABLE IF EXISTS `rbac_perm`;
DROP TABLE IF EXISTS `rbac_role`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `rbac_objectrel`;
DROP TABLE IF EXISTS `rbac_object`;

CREATE TABLE `user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Таблица пользователей';

CREATE TABLE `rbac_object` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` INT UNSIGNED NULL DEFAULT NULL,
  `level` INT UNSIGNED NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `order` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_rbacobject_pid` FOREIGN KEY (`pid`) REFERENCES `rbac_object` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Объекты разрешений';

CREATE TABLE `rbac_objectrel` (
  `aid` INT UNSIGNED NOT NULL,
  `did` INT UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacobjectrel_adid` (`aid` ASC, `did` ASC),
  CONSTRAINT `fk_rbacobjectrel_aid` FOREIGN KEY (`aid`) REFERENCES `rbac_object` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_rbacobjectrel_did` FOREIGN KEY (`did`) REFERENCES `rbac_object` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)
ENGINE InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Объекты древовидны';

CREATE TABLE `rbac_role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rbacrole_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Роли';

CREATE TABLE `rbac_rolerel` (
  `aid` INT UNSIGNED NOT NULL,
  `did` INT UNSIGNED NOT NULL,
  `dif` INT UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacrolerel_adid` (`aid`,`did`),
  INDEX `ix_rbacrolerel_did` (`did`),
  INDEX `ix_rbacrolerel_aid` (`aid`),
  CONSTRAINT `fk_rbacrolerel_aid` FOREIGN KEY (`aid`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbacrolerel_did` FOREIGN KEY (`did`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Роли графовидны';

CREATE TABLE `rbac_perm` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `description` TEXT NOT NULL,
  `object_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  INDEX `ix_rbacperm_objectid` (`object_id`),
  CONSTRAINT `fk_rbacperm_objectid` FOREIGN KEY (`object_id`) REFERENCES `rbac_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Разрешения';

CREATE TABLE `rbac_perm_role` (
  `perm_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacpermrole_id` (`perm_id`,`role_id`),
  KEY `fk_rbacpermrole_roleid_idx` (`role_id`),
  CONSTRAINT `fk_rbacpermrole_permid` FOREIGN KEY (`perm_id`) REFERENCES `rbac_perm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbacpermrole_roleid` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COMMENT 'Связи разрешений к ролям';

CREATE TABLE `rbac_assignment` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacaasignment_id` (`user_id`,`role_id`),
  KEY `fk_rbac_assignment_roleid_idx` (`role_id`),
  CONSTRAINT `fk_rbacassignment_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbac_assignment_roleid` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COMMENT 'Связи пользователей к ролям';
