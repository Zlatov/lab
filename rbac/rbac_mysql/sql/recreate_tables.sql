DROP TABLE IF EXISTS `rbac_user_role`;     -- Назначенные пользователю роли

DROP TABLE IF EXISTS `rbac_role_perm_obj`; -- Назначенные роли разрешения на объект
DROP TABLE IF EXISTS `rbac_rolerel`;       -- Связи ролей графовидны
DROP TABLE IF EXISTS `rbac_objrel`;        -- Связи объектов древовидны

DROP TABLE IF EXISTS `rbac_perm`;          -- Разрешения
DROP TABLE IF EXISTS `rbac_role`;          -- Роли
DROP TABLE IF EXISTS `rbac_obj`;           -- Объекты
DROP TABLE IF EXISTS `user`;               -- Пользователи


-- Пользователи
CREATE TABLE `user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Пользователи';


-- Объекты
CREATE TABLE `rbac_obj` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` INT UNSIGNED NULL DEFAULT NULL,
  `level` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `sid` VARCHAR(255) NOT NULL COMMENT 'Используется для проверки права.',
  `order` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rbacobject_code` (`sid`),
  CONSTRAINT `fk_rbacobject_pid` FOREIGN KEY (`pid`) REFERENCES `rbac_obj` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Объекты';


-- Роли
CREATE TABLE `rbac_role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rbacrole_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Роли';


-- Разрешения
CREATE TABLE `rbac_perm` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sid` VARCHAR(255) NOT NULL COMMENT 'Используется для проверки права.',
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_rbacpermtype_type` (`sid`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Разрешения';


-- Связи объектов древовидны
CREATE TABLE `rbac_objrel` (
  `aid` INT UNSIGNED NOT NULL,
  `did` INT UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacobjectrel_adid` (`aid` ASC, `did` ASC),
  CONSTRAINT `fk_rbacobjectrel_aid` FOREIGN KEY (`aid`) REFERENCES `rbac_obj` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_rbacobjectrel_did` FOREIGN KEY (`did`) REFERENCES `rbac_obj` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)
ENGINE InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Связи объектов древовидны';


-- Связи ролей графовидны
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
COMMENT 'Связи ролей графовидны';


-- Назначенные роли разрешения на объект
CREATE TABLE `rbac_role_perm_obj` (
  `role_id` INT UNSIGNED NOT NULL,
  `perm_id` SMALLINT UNSIGNED NOT NULL,
  `obj_id` INT UNSIGNED NOT NULL,
  INDEX `ix_rolepermobj_roleid` (`role_id`),
  INDEX `ix_rolepermobj_objid` (`obj_id`),
  UNIQUE KEY `uq_rolepermobj_rolepermobjid` (`role_id`, `perm_id`, `obj_id`),
  CONSTRAINT `fk_rolepermobj_roleid` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rolepermobj_permid` FOREIGN KEY (`perm_id`) REFERENCES `rbac_perm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rolepermobj_objid` FOREIGN KEY (`obj_id`) REFERENCES `rbac_obj` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Назначенные роли разрешения на объект';


-- Назначенные пользователю роли
CREATE TABLE `rbac_user_role` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `uq_rbacaasignment_id` (`user_id`,`role_id`),
  KEY `fk_rbac_assignment_roleid_idx` (`role_id`),
  CONSTRAINT `fk_rbacassignment_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rbac_assignment_roleid` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COMMENT 'Назначенные пользователю роли';
