DROP TABLE IF EXISTS `ct_tree_rel`;
DROP TABLE IF EXISTS `ct_tree`;

CREATE TABLE IF NOT EXISTS `ct_tree` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `header` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `ct_tree_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL,
  `cid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cttreerel_pcid` (`pid`,`cid`) USING BTREE,
  KEY `fk_cttreerel_cid_idx` (`cid`),
  CONSTRAINT `fk_cttreerel_cid` FOREIGN KEY (`cid`) REFERENCES `ct_tree` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cttreerel_pid` FOREIGN KEY (`pid`) REFERENCES `ct_tree` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
