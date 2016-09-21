DROP TABLE IF EXISTS `ct_tree_rel`;

DROP TABLE IF EXISTS `ct_tree`;

CREATE TABLE IF NOT EXISTS `ct_tree` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT 0,
  `header` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ct_tree_rel` (
  `aid` int(11) unsigned NOT NULL,
  `did` int(11) unsigned NOT NULL,
  UNIQUE KEY `uq_cttreerel_adid` (`aid`,`did`) USING BTREE,
  CONSTRAINT `fk_cttreerel_aid` FOREIGN KEY (`aid`) REFERENCES `ct_tree` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cttreerel_did` FOREIGN KEY (`did`) REFERENCES `ct_tree` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
