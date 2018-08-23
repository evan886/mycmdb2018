-- MySQL dump 10.13  Distrib 5.6.40, for Win64 (x86_64)
--
-- Host: localhost    Database: evatar_cmdb_dev
-- ------------------------------------------------------
-- Server version	5.6.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `equipmentid` char(32) NOT NULL,
  `relatedid` varchar(32) DEFAULT NULL,
  `relatedinfo` varchar(16) DEFAULT NULL,
  `sn` varchar(30) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `server` varchar(20) NOT NULL,
  `server_type` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `cpu` varchar(64) DEFAULT NULL,
  `hard_disk` varchar(128) DEFAULT NULL,
  `memory` varchar(128) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `ip1` varchar(32) DEFAULT NULL,
  `ip2` varchar(32) DEFAULT NULL,
  `ip3` varchar(32) DEFAULT NULL,
  `ip4` varchar(32) DEFAULT NULL,
  `ip5` varchar(32) DEFAULT NULL,
  `ip6` varchar(32) DEFAULT NULL,
  `ip7` varchar(32) DEFAULT NULL,
  `ip8` varchar(32) DEFAULT NULL,
  `ip9` varchar(32) DEFAULT NULL,
  `ilo` varchar(32) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  `group_id` char(32) NOT NULL,
  `hosted_id` char(32),
  PRIMARY KEY (`equipmentid`),
  UNIQUE KEY `asset_ip_3e2d09da_uniq` (`ip`,`availabity`),
  KEY `asset_0e939a4f` (`group_id`),
  KEY `asset_397582f8` (`hosted_id`),
  CONSTRAINT `asset_group_id_39151667_fk_cabinet_uuid` FOREIGN KEY (`group_id`) REFERENCES `cabinet` (`uuid`),
  CONSTRAINT `asset_hosted_id_6162cc4c_fk_asset_equipmentid` FOREIGN KEY (`hosted_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` VALUES ('02b3f106a8824813a1a5f6bc5ec74a0e','','','221','sw1','sw','交换机',1,'','','','2018-05-24 08:55:46.170000','1.1.1.1','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12.23.12.32',22,'',1,'64e2ddf2538d4898bf66a06960ab892d',NULL),('8bda7097ed3c4bf090b2be64a5b296b9','a47eee5b9cf24cdda33e931419501261','f0/1','','alone','xen','ALONE',1,'','','','2018-05-24 08:56:11.271000','1.1.1.2','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',22,'',1,'d52ec6c0dfae47b59fc2cf20fa787cb2',NULL),('a47eee5b9cf24cdda33e931419501261','','','','sw2','sw','交换机',1,'','','','2018-05-24 09:03:47.697000','1.1.1.11','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',22,'',1,'d52ec6c0dfae47b59fc2cf20fa787cb2',NULL),('b2fa70da1e864440a225e4901d7cd06f','','','','vm111','vm','VM',1,'','','','2018-05-24 08:57:18.825000','1.1.1.3','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',22,'',1,'64e2ddf2538d4898bf66a06960ab892d','8bda7097ed3c4bf090b2be64a5b296b9');
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetrecord`
--

DROP TABLE IF EXISTS `assetrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetrecord` (
  `uuid` char(32) NOT NULL,
  `user` varchar(30) DEFAULT NULL,
  `time` datetime(6) NOT NULL,
  `content` longtext,
  `comment` longtext,
  `asset_id` char(32) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `asset_assetrecord_asset_id_154f8fcc_fk_asset_equipmentid` (`asset_id`),
  CONSTRAINT `asset_assetrecord_asset_id_154f8fcc_fk_asset_equipmentid` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetrecord`
--

LOCK TABLES `assetrecord` WRITE;
/*!40000 ALTER TABLE `assetrecord` DISABLE KEYS */;
INSERT INTO `assetrecord` VALUES ('112973e4a9064872b0b780192536c751','cmdbAdmin','2018-05-24 17:30:52.243000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531 a47eee5b9cf24cdda33e931419501261 \\u66f4\\u6539\\u4e3a 02b3f106a8824813a1a5f6bc5ec74a0e\', u\'\\u6240\\u5c5e\\u673a\\u67dc\\u7531 \\u534e\\u5357\\u673a\\u623f -> hn0001 \\u66f4\\u6539\\u4e3a \\u4e2d\\u534e\\u673a\\u623f -> hz001\']',NULL,'8bda7097ed3c4bf090b2be64a5b296b9'),('7ceeeb993649449798074400a71d37b4','cmdbAdmin','2018-05-24 17:32:15.017000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531 sw1(1.1.1.1) \\u66f4\\u6539\\u4e3a sw2(1.1.1.11)\', u\'\\u6240\\u5c5e\\u673a\\u67dc\\u7531 \\u4e2d\\u534e\\u673a\\u623f -> hz001 \\u66f4\\u6539\\u4e3a \\u534e\\u5357\\u673a\\u623f -> hn0001\']',NULL,'8bda7097ed3c4bf090b2be64a5b296b9'),('93cd0611414d444aa082e5b7331b7682','cmdbAdmin','2018-05-24 17:29:57.119000','[u\'\\u6240\\u5c5e\\u673a\\u67dc\\u7531 \\u4e2d\\u534e\\u673a\\u623f -> hz001 \\u66f4\\u6539\\u4e3a \\u534e\\u5357\\u673a\\u623f -> hn0001\']',NULL,'a47eee5b9cf24cdda33e931419501261'),('93cdfb71405b4e43a8464eca9506bbe3','cmdbAdmin','2018-05-24 17:07:54.031000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531 02b3f106a8824813a1a5f6bc5ec74a0e \\u66f4\\u6539\\u4e3a \']',NULL,'8bda7097ed3c4bf090b2be64a5b296b9'),('965b654565914a69aee67b21bef3da34','cmdbAdmin','2018-05-24 17:13:41.063000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531  \\u66f4\\u6539\\u4e3a 02b3f106a8824813a1a5f6bc5ec74a0e\']',NULL,'02b3f106a8824813a1a5f6bc5ec74a0e'),('b3fc142f865c4a348dbddb05db36167c','cmdbAdmin','2018-05-24 17:35:23.832000','[u\'\\u5bbf\\u4e3b\\u673a\\u7531  \\u66f4\\u6539\\u4e3a alone(1.1.1.2)\']',NULL,'b2fa70da1e864440a225e4901d7cd06f'),('bfffda6f54114a13bc97d9156ef60bd5','cmdbAdmin','2018-05-24 17:35:03.314000','[u\'\\u5bbf\\u4e3b\\u673a\\u7531 alone(1.1.1.2) \\u66f4\\u6539\\u4e3a \']',NULL,'b2fa70da1e864440a225e4901d7cd06f'),('c828537eb81040b3bc3899b5cee3f42b','cmdbAdmin','2018-05-24 17:30:35.380000','[u\'\\u6240\\u5c5e\\u673a\\u67dc\\u7531 \\u4e2d\\u534e\\u673a\\u623f -> hz001 \\u66f4\\u6539\\u4e3a \\u534e\\u5357\\u673a\\u623f -> hn0001\']',NULL,'8bda7097ed3c4bf090b2be64a5b296b9'),('c977c7162559462d82bf8b0860c8377d','cmdbAdmin','2018-05-24 16:54:13.106000','[u\'\\u4e3b\\u673a\\u540d\\u7531 sw \\u66f4\\u6539\\u4e3a sw1\']',NULL,'02b3f106a8824813a1a5f6bc5ec74a0e'),('e6327280f53f4e248d14b3858ad91780','cmdbAdmin','2018-05-24 17:20:45.964000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531 02b3f106a8824813a1a5f6bc5ec74a0e \\u66f4\\u6539\\u4e3a \', u\'\\u6240\\u5c5e\\u673a\\u67dc\\u7531 d52ec6c0dfae47b59fc2cf20fa787cb2 \\u66f4\\u6539\\u4e3a 64e2ddf2538d4898bf66a06960ab892d\']',NULL,'02b3f106a8824813a1a5f6bc5ec74a0e'),('e7391bfd1df14e4b81759a80c77e9219','cmdbAdmin','2018-05-24 17:10:25.172000','[u\'\\u4e0a\\u8054\\u8bbe\\u5907\\u7531  \\u66f4\\u6539\\u4e3a a47eee5b9cf24cdda33e931419501261\']',NULL,'8bda7097ed3c4bf090b2be64a5b296b9');
/*!40000 ALTER TABLE `assetrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add department',6,'add_department'),(17,'Can change department',6,'change_department'),(18,'Can delete department',6,'delete_department'),(19,'Can add my user',7,'add_myuser'),(20,'Can change my user',7,'change_myuser'),(21,'Can delete my user',7,'delete_myuser'),(22,'Can add data center',8,'add_datacenter'),(23,'Can change data center',8,'change_datacenter'),(24,'Can delete data center',8,'delete_datacenter'),(25,'Can add cabinet',9,'add_cabinet'),(26,'Can change cabinet',9,'change_cabinet'),(27,'Can delete cabinet',9,'delete_cabinet'),(28,'Can add asset',10,'add_asset'),(29,'Can change asset',10,'change_asset'),(30,'Can delete asset',10,'delete_asset'),(31,'Can add service',11,'add_service'),(32,'Can change service',11,'change_service'),(33,'Can delete service',11,'delete_service'),(37,'Can add asset record',13,'add_assetrecord'),(38,'Can change asset record',13,'change_assetrecord'),(39,'Can delete asset record',13,'delete_assetrecord'),(40,'Can add menu',14,'add_menu'),(41,'Can change menu',14,'change_menu'),(42,'Can delete menu',14,'delete_menu'),(43,'Can add asset',11,'add_asset'),(44,'Can change asset',11,'change_asset'),(45,'Can delete asset',11,'delete_asset'),(46,'Can add service',10,'add_service'),(47,'Can change service',10,'change_service'),(48,'Can delete service',10,'delete_service'),(49,'Can add asset record',14,'add_assetrecord'),(50,'Can change asset record',14,'change_assetrecord'),(51,'Can delete asset record',14,'delete_assetrecord'),(52,'Can add menu',13,'add_menu'),(53,'Can change menu',13,'change_menu'),(54,'Can delete menu',13,'delete_menu');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabinet`
--

DROP TABLE IF EXISTS `cabinet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cabinet` (
  `uuid` char(32) NOT NULL,
  `name` varchar(20) NOT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  `dataCenter_id` char(32) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `cabinet_name_2426d281_uniq` (`name`,`dataCenter_id`,`availabity`),
  KEY `cabinet_e6ef45ae` (`dataCenter_id`),
  CONSTRAINT `cabinet_dataCenter_id_9863b3c_fk_dataCenter_uuid` FOREIGN KEY (`dataCenter_id`) REFERENCES `datacenter` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabinet`
--

LOCK TABLES `cabinet` WRITE;
/*!40000 ALTER TABLE `cabinet` DISABLE KEYS */;
INSERT INTO `cabinet` VALUES ('64e2ddf2538d4898bf66a06960ab892d','hz001','',1,'ca8d0cf0b70647dd93b6c02225dbbfa0'),('d52ec6c0dfae47b59fc2cf20fa787cb2','hn0001','',1,'70585f0239bb4650a86b3ff0a0aeb002');
/*!40000 ALTER TABLE `cabinet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datacenter`
--

DROP TABLE IF EXISTS `datacenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datacenter` (
  `uuid` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `area` varchar(100) NOT NULL,
  `bandwidth` varchar(64) DEFAULT NULL,
  `phone` varchar(32) NOT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `create_time` date NOT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `dataCenter_name_311ba65e_uniq` (`name`,`area`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datacenter`
--

LOCK TABLES `datacenter` WRITE;
/*!40000 ALTER TABLE `datacenter` DISABLE KEYS */;
INSERT INTO `datacenter` VALUES ('70585f0239bb4650a86b3ff0a0aeb002','华南机房','广州','100000','13800013800130','Matt','','2018-05-25','',1),('ca8d0cf0b70647dd93b6c02225dbbfa0','中华机房','北京','1000','13800013800130','Matt','','2018-05-24','',1);
/*!40000 ALTER TABLE `datacenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(64) NOT NULL,
  `description` longtext,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_departmentName_26aae1504634ab6d_uniq` (`departmentName`,`availabity`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'运维部','',1);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_menu_auth`
--

DROP TABLE IF EXISTS `department_menu_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_menu_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_id` (`department_id`,`menu_id`),
  KEY `department_menu_auth_menu_id_28e752e6_fk_menu_id` (`menu_id`),
  CONSTRAINT `department_menu_auth_department_id_2bc946f3_fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_menu_auth_menu_id_28e752e6_fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_menu_auth`
--

LOCK TABLES `department_menu_auth` WRITE;
/*!40000 ALTER TABLE `department_menu_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_menu_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_5151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_1c5f563_fk_myUser_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_myUser_id` FOREIGN KEY (`user_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'accounts','department'),(7,'accounts','myuser'),(1,'admin','logentry'),(11,'asset','asset'),(14,'asset','assetrecord'),(9,'asset','cabinet'),(8,'asset','datacenter'),(10,'asset','service'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(13,'menuAuth','menu'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'menuAuth','0001_initial','2018-05-17 07:30:03.416757'),(2,'contenttypes','0001_initial','2018-05-17 07:30:03.572771'),(3,'contenttypes','0002_remove_content_type_name','2018-05-17 07:30:03.877274'),(4,'auth','0001_initial','2018-05-17 07:30:04.689186'),(5,'auth','0002_alter_permission_name_max_length','2018-05-17 07:30:04.866067'),(6,'auth','0003_alter_user_email_max_length','2018-05-17 07:30:04.890232'),(7,'auth','0004_alter_user_username_opts','2018-05-17 07:30:04.914444'),(8,'auth','0005_alter_user_last_login_null','2018-05-17 07:30:04.940181'),(9,'auth','0006_require_contenttypes_0002','2018-05-17 07:30:04.951215'),(10,'accounts','0001_initial','2018-05-17 07:30:07.408182'),(11,'admin','0001_initial','2018-05-17 07:30:07.808885'),(12,'asset','0001_initial','2018-05-17 07:30:09.870923'),(13,'sessions','0001_initial','2018-05-17 07:30:10.020647'),(14,'asset','0002_cabinet_comment','2018-05-17 15:21:12.360888'),(15,'asset','0002_auto_20180525_0048','2018-05-24 16:48:57.598000');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3iqv056pr6yr59jnfl5450y7er4fbk6f','YjQ5MTljZTk1NGU3M2IyNjA0ZDI5Y2VmMzFhYmNhMDlmNDA4Yzc0Njp7Il9hdXRoX3VzZXJfaGFzaCI6IjMyZDY0YjEwMDlmYzdmYTY4NzI0NTY3NzA4MWRhNWE1MDE1NTkwM2UiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOlt7ImZpZWxkcyI6eyJuYW1lIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXQiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOjAsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0IiwiaWNvbiI6ImZhLWRlc2t0b3AifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjF9LHsiZmllbGRzIjp7Im5hbWUiOiJcdThiYmVcdTU5MDdcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhc3NldExpc3QiLCJ1cmwiOiIvYXNzZXQvYXNzZXRMaXN0LyIsImZhdGhlcklEIjoxLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhc3NldExpc3QgYXNzZXRBZGQiLCJpY29uIjoiYXJyb3cifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjJ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdThiYmVcdTU5MDciLCJodG1sSUQiOiJhc3NldEFkZCIsInVybCI6Ii9hc3NldC9hc3NldEFkZC8iLCJmYXRoZXJJRCI6MiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXNzZXRMaXN0IGFzc2V0QWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6M30seyJmaWVsZHMiOnsibmFtZSI6Ilx1NjczYVx1NjIzZlx1N2JhMVx1NzQwNiIsImh0bWxJRCI6ImlkY0xpc3QiLCJ1cmwiOiIvYXNzZXQvaWRjTGlzdC8iLCJmYXRoZXJJRCI6MSwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaWRjTGlzdCBpZGNBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU2NzNhXHU2MjNmIiwiaHRtbElEIjoiaWRjQWRkIiwidXJsIjoiL2Fzc2V0L2lkY0FkZC8iLCJmYXRoZXJJRCI6NCwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaWRjTGlzdCBpZGNBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo1fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU3NTI4XHU2MjM3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYWNjb3VudHMiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOjAsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFjY291bnRzIiwiaWNvbiI6ImZhLXVzZXIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjZ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJodG1sSUQiOiJ1c2VyTGlzdCIsInVybCI6Ii9hY2NvdW50cy91c2VyTGlzdC8iLCJmYXRoZXJJRCI6NiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoidXNlckxpc3QgdXNlckFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjd9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyQWRkIiwidXJsIjoiL2FjY291bnRzL3VzZXJBZGQvIiwiZmF0aGVySUQiOjcsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJMaXN0IHVzZXJBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo4fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2NzQzXHU5NjUwXHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXV0aCIsInVybCI6IiMiLCJmYXRoZXJJRCI6MCwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXV0aCIsImljb24iOiJmYS1iYW4ifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjl9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJodG1sSUQiOiJtZW51QWRtaW5MaXN0IiwidXJsIjoiL2F1dGgvbWVudUFkbWluTGlzdC8iLCJmYXRoZXJJRCI6OSwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoibWVudUFkbWluTGlzdCBtZW51QWRtaW5BZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxMH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1ODNkY1x1NTM1NSIsImh0bWxJRCI6Im1lbnVBZG1pbkFkZCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkFkZC8iLCJmYXRoZXJJRCI6MTAsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkxpc3QgbWVudUFkbWluQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTF9XX0=','2018-05-31 10:01:29.990422'),('43dzob70fgke3p6dibozqhqc0mjgzizq','ODMyNmZhYzdkOTE1ZjMzOGExMzZlMzBlMzBhM2RkZmMzMTc0MGZiOTp7Il9hdXRoX3VzZXJfaGFzaCI6IjMyZDY0YjEwMDlmYzdmYTY4NzI0NTY3NzA4MWRhNWE1MDE1NTkwM2UiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOlt7ImZpZWxkcyI6eyJuYW1lIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXQiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOjAsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0IiwiaWNvbiI6ImZhLWRlc2t0b3AifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjF9LHsiZmllbGRzIjp7Im5hbWUiOiJcdThiYmVcdTU5MDdcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhc3NldExpc3QiLCJ1cmwiOiIvYXNzZXQvYXNzZXRMaXN0LyIsImZhdGhlcklEIjoxLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhc3NldExpc3QgYXNzZXRBZGQgYXNzZXRFZGl0IGFzc2V0RGV0YWlsIiwiaWNvbiI6ImFycm93In0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoyfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU4YmJlXHU1OTA3IiwiaHRtbElEIjoiYXNzZXRBZGQiLCJ1cmwiOiIvYXNzZXQvYXNzZXRBZGQvIiwiZmF0aGVySUQiOjIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0TGlzdCBhc3NldEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTY3M2FcdTYyM2ZcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJpZGNMaXN0IiwidXJsIjoiL2Fzc2V0L2lkY0xpc3QvIiwiZmF0aGVySUQiOjEsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0xpc3QgaWRjQWRkIGlkY0VkaXQgaWRjRGV0YWlsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1NjczYVx1NjIzZiIsImh0bWxJRCI6ImlkY0FkZCIsInVybCI6Ii9hc3NldC9pZGNBZGQvIiwiZmF0aGVySUQiOjQsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0xpc3QgaWRjQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NzUyOFx1NjIzN1x1N2JhMVx1NzQwNiIsImh0bWxJRCI6ImFjY291bnRzIiwidXJsIjoiIyIsImZhdGhlcklEIjowLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhY2NvdW50cyIsImljb24iOiJmYS11c2VyIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo2fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU3NTI4XHU2MjM3XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoidXNlckxpc3QiLCJ1cmwiOiIvYWNjb3VudHMvdXNlckxpc3QvIiwiZmF0aGVySUQiOjYsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJMaXN0IHVzZXJBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo3fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU3NTI4XHU2MjM3IiwiaHRtbElEIjoidXNlckFkZCIsInVybCI6Ii9hY2NvdW50cy91c2VyQWRkLyIsImZhdGhlcklEIjo3LCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJ1c2VyTGlzdCB1c2VyQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6OH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1Njc0M1x1OTY1MFx1N2JhMVx1NzQwNiIsImh0bWxJRCI6ImF1dGgiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOjAsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImF1dGgiLCJpY29uIjoiZmEtYmFuIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo5fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoibWVudUFkbWluTGlzdCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkxpc3QvIiwiZmF0aGVySUQiOjksImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkxpc3QgbWVudUFkbWluQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTB9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTgzZGNcdTUzNTUiLCJodG1sSUQiOiJtZW51QWRtaW5BZGQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5BZGQvIiwiZmF0aGVySUQiOjEwLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJtZW51QWRtaW5MaXN0IG1lbnVBZG1pbkFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjExfV19','2018-06-07 09:24:36.819000');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `htmlID` varchar(30) NOT NULL,
  `fatherID` int(11) NOT NULL,
  `icon` varchar(30) DEFAULT NULL,
  `htmlClass` varchar(50) DEFAULT NULL,
  `url` varchar(200) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_htmlID_66f80517ea65b18b_uniq` (`htmlID`,`availabity`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'资产管理','asset',0,'fa-desktop','asset','#',1),(2,'设备管理','assetList',1,'arrow','assetList assetAdd assetEdit assetDetail','/asset/assetList/',1),(3,'添加设备','assetAdd',2,'','assetList assetAdd','/asset/assetAdd/',1),(4,'机房管理','idcList',1,'','idcList idcAdd idcEdit idcDetail','/asset/idcList/',1),(5,'添加机房','idcAdd',4,'','idcList idcAdd','/asset/idcAdd/',1),(6,'用户管理','accounts',0,'fa-user','accounts','#',1),(7,'用户列表','userList',6,'','userList userAdd','/accounts/userList/',1),(8,'添加用户','userAdd',7,'','userList userAdd','/accounts/userAdd/',1),(9,'权限管理','auth',0,'fa-ban','auth','#',1),(10,'菜单列表','menuAdminList',9,'','menuAdminList menuAdminAdd','/auth/menuAdminList/',1),(11,'添加菜单','menuAdminAdd',10,'','menuAdminList menuAdminAdd','/auth/menuAdminAdd/',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myuser`
--

DROP TABLE IF EXISTS `myuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `qq` varchar(50) DEFAULT NULL,
  `availabity` bigint(20) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `myUser_username_1843759df7e4cea3_uniq` (`username`,`availabity`),
  KEY `myUser_bf691be4` (`department_id`),
  CONSTRAINT `myUser_department_id_a7765a27b8235a9_fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myuser`
--

LOCK TABLES `myuser` WRITE;
/*!40000 ALTER TABLE `myuser` DISABLE KEYS */;
INSERT INTO `myuser` VALUES (1,'pbkdf2_sha256$20000$DYS1J412ozE5$8jxicCjxDxS7SO+nD0nv5pZAbn4kwIsgHECLtfK2h/0=','2018-05-24 09:24:36.719000',1,'cmdbAdmin','系统管理员','','',1,1,'2017-03-28 08:12:00.000000','','','',1,1);
/*!40000 ALTER TABLE `myuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myuser_groups`
--

DROP TABLE IF EXISTS `myuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`group_id`),
  KEY `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` (`group_id`),
  CONSTRAINT `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `myUser_groups_myuser_id_346042a381ba62c4_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myuser_groups`
--

LOCK TABLES `myuser_groups` WRITE;
/*!40000 ALTER TABLE `myuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `myuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myuser_menu_auth`
--

DROP TABLE IF EXISTS `myuser_menu_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myuser_menu_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`menu_id`),
  KEY `myUser_menu_auth_menu_id_6db6edf0df5d3085_fk_menu_id` (`menu_id`),
  CONSTRAINT `myUser_menu_auth_menu_id_6db6edf0df5d3085_fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`),
  CONSTRAINT `myUser_menu_auth_myuser_id_53e95b1a16a5abb5_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myuser_menu_auth`
--

LOCK TABLES `myuser_menu_auth` WRITE;
/*!40000 ALTER TABLE `myuser_menu_auth` DISABLE KEYS */;
INSERT INTO `myuser_menu_auth` VALUES (23,1,1),(24,1,2),(25,1,3),(26,1,4),(27,1,5),(28,1,6),(29,1,7),(30,1,8),(31,1,9),(32,1,10),(33,1,11);
/*!40000 ALTER TABLE `myuser_menu_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myuser_user_permissions`
--

DROP TABLE IF EXISTS `myuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`permission_id`),
  KEY `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `myUser_user_permissions_myuser_id_27f715bec9c2e9d6_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myuser_user_permissions`
--

LOCK TABLES `myuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `myuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `myuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `serviceid` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `install` varchar(100) DEFAULT NULL,
  `config` varchar(200) DEFAULT NULL,
  `start` varchar(100) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `protocol` varchar(3) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `comment` longtext,
  `equipmentid_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `service_equipmentid_id_3261767e_uniq` (`equipmentid_id`,`port`),
  UNIQUE KEY `service_equipmentid_id_11c61be0_uniq` (`equipmentid_id`,`name`,`port`),
  CONSTRAINT `service_equipmentid_id_7496cfc4_fk_asset_equipmentid` FOREIGN KEY (`equipmentid_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-25 11:04:36
