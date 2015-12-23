CREATE DATABASE  IF NOT EXISTS `testjoin` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `testjoin`;

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'dep1'),(2,'dep2'),(3,'dep3'),(4,'dep4'),(5,'dep5');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `department_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_depid_idx` (`department_id`),
  CONSTRAINT `fk_depid` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'fn1','ln1',90,1),(2,'fn2','ln2',100,1),(3,'fn3','ln3',120,1),(4,'fn4','ln4',120,2),(5,'fn5','ln5',140,2),(6,'fn6','ln6',300,3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

