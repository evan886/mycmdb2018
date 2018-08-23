-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: mycmdb
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `app`
--

DROP TABLE IF EXISTS `app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app` (
  `uuid` char(32) NOT NULL,
  `name` varchar(30) NOT NULL,
  `another_name` varchar(30) DEFAULT NULL,
  `domain_name` varchar(128) DEFAULT NULL,
  `online_time` varchar(10) DEFAULT NULL,
  `yunwei` varchar(128) DEFAULT NULL,
  `developer` varchar(128) DEFAULT NULL,
  `parentid` varchar(32) DEFAULT NULL,
  `tree` longtext,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app`
--

LOCK TABLES `app` WRITE;
/*!40000 ALTER TABLE `app` DISABLE KEYS */;
/*!40000 ALTER TABLE `app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_association_app`
--

DROP TABLE IF EXISTS `app_association_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_association_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id_id` char(32) NOT NULL,
  `association_id_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_association_app_app_id_id_65be41852f4626d0_uniq` (`app_id_id`,`association_id_id`),
  KEY `app_association_a_association_id_id_438f5434a72f114d_fk_app_uuid` (`association_id_id`),
  CONSTRAINT `app_association_a_association_id_id_438f5434a72f114d_fk_app_uuid` FOREIGN KEY (`association_id_id`) REFERENCES `app` (`uuid`),
  CONSTRAINT `app_association_app_app_id_id_1e7e69080622f327_fk_app_uuid` FOREIGN KEY (`app_id_id`) REFERENCES `app` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_association_app`
--

LOCK TABLES `app_association_app` WRITE;
/*!40000 ALTER TABLE `app_association_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_association_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `equipmentid` char(32) NOT NULL,
  `group_place` int(11) DEFAULT NULL,
  `relatedid` varchar(32) DEFAULT NULL,
  `relatedinfo` varchar(16) DEFAULT NULL,
  `sn` varchar(30) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `server` varchar(20) NOT NULL,
  `server_type` varchar(30) NOT NULL,
  `status` int(11) NOT NULL,
  `cpu` varchar(64) DEFAULT NULL,
  `hard_disk` varchar(128) DEFAULT NULL,
  `memory` varchar(128) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `ip` varchar(32) DEFAULT NULL,
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
  `use` varchar(32) DEFAULT NULL,
  `brand` varchar(32) DEFAULT NULL,
  `buy` int(11) DEFAULT NULL,
  `contract_start_time` varchar(18) DEFAULT NULL,
  `contract_end_time` varchar(18) DEFAULT NULL,
  `server_code` varchar(32) DEFAULT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  `group_id` char(32) NOT NULL,
  `hosted_id` char(32),
  PRIMARY KEY (`equipmentid`),
  UNIQUE KEY `asset_group_id_629e356c6b87fc93_uniq` (`group_id`,`group_place`,`sn`,`name`,`availabity`),
  KEY `asset_0e939a4f` (`group_id`),
  KEY `asset_397582f8` (`hosted_id`),
  CONSTRAINT `asset_group_id_ad53d32c6eae999_fk_cabinet_uuid` FOREIGN KEY (`group_id`) REFERENCES `cabinet` (`uuid`),
  CONSTRAINT `asset_hosted_id_1986b9a96162cc4c_fk_asset_equipmentid` FOREIGN KEY (`hosted_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetRecord`
--

DROP TABLE IF EXISTS `assetRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetRecord` (
  `uuid` char(32) NOT NULL,
  `user` varchar(30) DEFAULT NULL,
  `time` datetime(6) NOT NULL,
  `content` longtext,
  `comment` longtext,
  `asset_id` char(32) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `assetRecord_asset_id_25da7ef92f221c47_fk_asset_equipmentid` (`asset_id`),
  CONSTRAINT `assetRecord_asset_id_25da7ef92f221c47_fk_asset_equipmentid` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetRecord`
--

LOCK TABLES `assetRecord` WRITE;
/*!40000 ALTER TABLE `assetRecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetRecord` ENABLE KEYS */;
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
  KEY `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
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
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add api access',6,'add_apiaccess'),(17,'Can change api access',6,'change_apiaccess'),(18,'Can delete api access',6,'delete_apiaccess'),(19,'Can add api key',7,'add_apikey'),(20,'Can change api key',7,'change_apikey'),(21,'Can delete api key',7,'delete_apikey'),(22,'Can add department',8,'add_department'),(23,'Can change department',8,'change_department'),(24,'Can delete department',8,'delete_department'),(25,'Can add my user',9,'add_myuser'),(26,'Can change my user',9,'change_myuser'),(27,'Can delete my user',9,'delete_myuser'),(28,'Can add on_duty',10,'add_on_duty'),(29,'Can change on_duty',10,'change_on_duty'),(30,'Can delete on_duty',10,'delete_on_duty'),(31,'Can add data center',11,'add_datacenter'),(32,'Can change data center',11,'change_datacenter'),(33,'Can delete data center',11,'delete_datacenter'),(34,'Can add cabinet',12,'add_cabinet'),(35,'Can change cabinet',12,'change_cabinet'),(36,'Can delete cabinet',12,'delete_cabinet'),(37,'Can add asset',13,'add_asset'),(38,'Can change asset',13,'change_asset'),(39,'Can delete asset',13,'delete_asset'),(40,'Can add service',14,'add_service'),(41,'Can change service',14,'change_service'),(42,'Can delete service',14,'delete_service'),(43,'Can add asset record',15,'add_assetrecord'),(44,'Can change asset record',15,'change_assetrecord'),(45,'Can delete asset record',15,'delete_assetrecord'),(46,'Can add network_segment',16,'add_network_segment'),(47,'Can change network_segment',16,'change_network_segment'),(48,'Can delete network_segment',16,'delete_network_segment'),(49,'Can add ip_list',17,'add_ip_list'),(50,'Can change ip_list',17,'change_ip_list'),(51,'Can delete ip_list',17,'delete_ip_list'),(52,'Can add menu',18,'add_menu'),(53,'Can change menu',18,'change_menu'),(54,'Can delete menu',18,'delete_menu'),(55,'Can add app',19,'add_app'),(56,'Can change app',19,'change_app'),(57,'Can delete app',19,'delete_app'),(58,'Can add app_association_app',20,'add_app_association_app'),(59,'Can change app_association_app',20,'change_app_association_app'),(60,'Can delete app_association_app',20,'delete_app_association_app'),(61,'Can add classify',21,'add_classify'),(62,'Can change classify',21,'change_classify'),(63,'Can delete classify',21,'delete_classify');
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
  UNIQUE KEY `cabinet_name_2135ffdbdbd92d7f_uniq` (`name`,`dataCenter_id`,`availabity`),
  KEY `cabinet_e6ef45ae` (`dataCenter_id`),
  CONSTRAINT `cabinet_dataCenter_id_40b2e1e7f679c4c4_fk_dataCenter_uuid` FOREIGN KEY (`dataCenter_id`) REFERENCES `dataCenter` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabinet`
--

LOCK TABLES `cabinet` WRITE;
/*!40000 ALTER TABLE `cabinet` DISABLE KEYS */;
/*!40000 ALTER TABLE `cabinet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classify`
--

DROP TABLE IF EXISTS `classify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classify` (
  `uuid` char(32) NOT NULL,
  `name` varchar(30) NOT NULL,
  `monitoring` tinyint(1) NOT NULL,
  `virtual_host` varchar(128) DEFAULT NULL,
  `database_name` varchar(128) DEFAULT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  `app_id` char(32) NOT NULL,
  `service_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `classify_app_id_1dc67d8351cbebbe_fk_app_uuid` (`app_id`),
  KEY `classify_service_id_40a4215901694526_fk_service_serviceid` (`service_id`),
  CONSTRAINT `classify_app_id_1dc67d8351cbebbe_fk_app_uuid` FOREIGN KEY (`app_id`) REFERENCES `app` (`uuid`),
  CONSTRAINT `classify_service_id_40a4215901694526_fk_service_serviceid` FOREIGN KEY (`service_id`) REFERENCES `service` (`serviceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classify`
--

LOCK TABLES `classify` WRITE;
/*!40000 ALTER TABLE `classify` DISABLE KEYS */;
/*!40000 ALTER TABLE `classify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataCenter`
--

DROP TABLE IF EXISTS `dataCenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataCenter` (
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
  UNIQUE KEY `dataCenter_name_39b099e1311ba65e_uniq` (`name`,`area`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataCenter`
--

LOCK TABLES `dataCenter` WRITE;
/*!40000 ALTER TABLE `dataCenter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataCenter` ENABLE KEYS */;
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
INSERT INTO `department` VALUES (1,'ops','',1);
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
  KEY `department_menu_auth_menu_id_696c626728e752e6_fk_menu_id` (`menu_id`),
  CONSTRAINT `department_menu_a_department_id_69151562bc946f3_fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_menu_auth_menu_id_696c626728e752e6_fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
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
  KEY `djang_content_type_id_697914295151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_52fdd58701c5f563_fk_myUser_id` (`user_id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_myUser_id` FOREIGN KEY (`user_id`) REFERENCES `myUser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-08-23 07:56:39.226930','1','ops',1,'',8,1),(2,'2018-08-23 07:56:45.648222','1','evan',2,'已修改 last_login，department 和 menu_auth 。',9,1),(3,'2018-08-23 07:58:22.278241','1','evan',2,'没有字段被修改。',9,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'accounts','department'),(9,'accounts','myuser'),(10,'accounts','on_duty'),(1,'admin','logentry'),(19,'app','app'),(20,'app','app_association_app'),(21,'app','classify'),(13,'asset','asset'),(15,'asset','assetrecord'),(12,'asset','cabinet'),(11,'asset','datacenter'),(17,'asset','ip_list'),(16,'asset','network_segment'),(14,'asset','service'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(18,'menuAuth','menu'),(5,'sessions','session'),(6,'tastypie','apiaccess'),(7,'tastypie','apikey');
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
INSERT INTO `django_migrations` VALUES (1,'menuAuth','0001_initial','2018-08-23 04:01:12.352413'),(2,'contenttypes','0001_initial','2018-08-23 04:01:12.727566'),(3,'contenttypes','0002_remove_content_type_name','2018-08-23 04:01:13.186173'),(4,'auth','0001_initial','2018-08-23 04:01:14.903424'),(5,'auth','0002_alter_permission_name_max_length','2018-08-23 04:01:15.295247'),(6,'auth','0003_alter_user_email_max_length','2018-08-23 04:01:15.341858'),(7,'auth','0004_alter_user_username_opts','2018-08-23 04:01:15.366624'),(8,'auth','0005_alter_user_last_login_null','2018-08-23 04:01:15.391663'),(9,'auth','0006_require_contenttypes_0002','2018-08-23 04:01:15.411828'),(10,'accounts','0001_initial','2018-08-23 04:01:20.773499'),(11,'admin','0001_initial','2018-08-23 04:01:21.817116'),(12,'asset','0001_initial','2018-08-23 04:01:30.680182'),(13,'app','0001_initial','2018-08-23 04:01:33.174263'),(14,'sessions','0001_initial','2018-08-23 04:01:33.465681'),(15,'tastypie','0001_initial','2018-08-23 04:01:34.341184');
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
INSERT INTO `django_session` VALUES ('cdmm0b3wtr3jdhdzuak1y5sceiwr0zda','OTAzYjk1OGJhYmE1OTAwNTMyMzc4Nzg5YjQ5MWM5YmU3NDgzODIwNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1ODdhNWZiNDU2MjUyYmFhNWM5NjEwNjcyMWYxZDI4MDQyYWJhNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOlt7ImZpZWxkcyI6eyJuYW1lIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXQiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOiIwIiwibWlkIjoiMDEiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhc3NldCIsImljb24iOiJmYS1kZXNrdG9wIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4YmJlXHU1OTA3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXRMaXN0IiwidXJsIjoiL2Fzc2V0L2Fzc2V0TGlzdC8iLCJmYXRoZXJJRCI6IjAxIiwibWlkIjoiMDExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXNzZXRMaXN0IGFzc2V0QWRkIGFzc2V0RWRpdCBhc3NldERldGFpbCIsImljb24iOiJhcnJvdyJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1OGJiZVx1NTkwNyIsImh0bWxJRCI6ImFzc2V0QWRkIiwidXJsIjoiL2Fzc2V0L2Fzc2V0QWRkLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0TGlzdCBhc3NldEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdThiYmVcdTU5MDciLCJodG1sSUQiOiJhc3NldEVkaXQiLCJ1cmwiOiIvYXNzZXQvYXNzZXRFZGl0LyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0RWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjIxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1MjIwXHU5NjY0XHU4YmJlXHU1OTA3IiwiaHRtbElEIjoiYXNzZXRFZGl0IiwidXJsIjoiL2Fzc2V0L2Fzc2V0RGVsLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MjJ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRlMGFcdTRmMjBcdThiYmVcdTU5MDciLCJodG1sSUQiOiJ1cGRhdGVGcm9tRXhjZWwiLCJ1cmwiOiIvYXNzZXQvdXBkYXRlRnJvbUV4Y2VsLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6IiIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQ0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2NzNhXHU2MjNmXHU3YmExXHU3NDA2IiwiaHRtbElEIjoiaWRjTGlzdCIsInVybCI6Ii9hc3NldC9pZGNMaXN0LyIsImZhdGhlcklEIjoiMDEiLCJtaWQiOiIwMTIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpZGNMaXN0IGlkY0FkZCBpZGNFZGl0IGlkY0RldGFpbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjR9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTY3M2FcdTYyM2YiLCJodG1sSUQiOiJpZGNBZGQiLCJ1cmwiOiIvYXNzZXQvaWRjQWRkLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0xpc3QgaWRjQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1NjczYVx1NjIzZiIsImh0bWxJRCI6ImlkY0VkaXQiLCJ1cmwiOiIvYXNzZXQvaWRjRWRpdC8iLCJmYXRoZXJJRCI6IjAxMiIsIm1pZCI6IjAxMjMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpZGNFZGl0IiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MjN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUyMjBcdTk2NjRcdTY3M2FcdTYyM2YiLCJodG1sSUQiOiJpZGNEZWwiLCJ1cmwiOiIvYXNzZXQvaWRjRGVsLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0RlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU2NzNhXHU2N2RjIiwiaHRtbElEIjoiY2FiaW5ldEFkZCIsInVybCI6Ii9hc3NldC9jYWJpbmV0QWRkLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImNhYmluZXRBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozN30seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1NjczYVx1NjdkYyIsImh0bWxJRCI6ImNhYmluZXRFZGl0IiwidXJsIjoiL2Fzc2V0L2NhYmluZXRFZGl0LyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImNhYmluZXRFZGl0IiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mzh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUyMjBcdTk2NjRcdTY3M2FcdTY3ZGMiLCJodG1sSUQiOiJjYWJpbmV0RGVsIiwidXJsIjoiL2Fzc2V0L2NhYmluZXREZWwvIiwiZmF0aGVySUQiOiIwMTIiLCJtaWQiOiIwMTI3IiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiY2FiaW5ldERlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM5fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJpcExpc3QiLCJ1cmwiOiIvYXNzZXQvaXBMaXN0LyIsImZhdGhlcklEIjoiMDEiLCJtaWQiOiIwMTMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcExpc3QgaXBBZGQgaXBFZGl0IGlwRGV0YWlsIG5ldHdvcmtTZWdtZW50TGlzdCBuZXR3b3JrU2VnbWVudEFkZCBuZXR3b3JrU2VnbWVudEVkaXQgbmV0d29ya1NlZ21lbnREZXRhaWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxNX0seyJmaWVsZHMiOnsibmFtZSI6IklQXHU2ZGZiXHU1MmEwIiwiaHRtbElEIjoiaXBBZGQiLCJ1cmwiOiIvYXNzZXQvaXBBZGQvIiwiZmF0aGVySUQiOiIwMTMiLCJtaWQiOiIwMTMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaXBMaXN0IGlwQWRkIGlwRWRpdCBpcERldGFpbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjE2fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTRmZWVcdTY1MzkiLCJodG1sSUQiOiJpcEVkaXQiLCJ1cmwiOiIvYXNzZXQvaXBFZGl0LyIsImZhdGhlcklEIjoiMDEzIiwibWlkIjoiMDEzMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlwRWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI1fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTUyMjBcdTk2NjQiLCJodG1sSUQiOiJpcERlbCIsInVybCI6Ii9hc3NldC9pcERlbC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcERlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI2fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2Mjc5XHU5MWNmXHU1MjIwXHU5NjY0SVAiLCJodG1sSUQiOiJpcERlbEJhdGNoIiwidXJsIjoiL2Fzc2V0L2lwRGVsQmF0Y2gvIiwiZmF0aGVySUQiOiIwMTMiLCJtaWQiOiIwMTM0IiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaXBEZWxCYXRjaCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQwfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2Mjc5XHU5MWNmXHU0ZmVlXHU2NTM5SVAiLCJodG1sSUQiOiJpcEVkaXRCYXRjaCIsInVybCI6Ii9hc3NldC9pcEVkaXRCYXRjaC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzUiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcEVkaXRCYXRjaCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZmVlXHU2NTM5XHU3ZjUxXHU2YmI1IiwiaHRtbElEIjoibmV0d29ya1NlZ21lbnRFZGl0IiwidXJsIjoiL2Fzc2V0L25ldHdvcmtTZWdtZW50RWRpdC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzYiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJuZXR3b3JrU2VnbWVudEVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo0Mn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1N2Y1MVx1NmJiNSIsImh0bWxJRCI6Im5ldHdvcmtTZWdtZW50RGVsIiwidXJsIjoiL2Fzc2V0L25ldHdvcmtTZWdtZW50RGVsLyIsImZhdGhlcklEIjoiMDEzIiwibWlkIjoiMDEzNyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im5ldHdvcmtTZWdtZW50RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NDN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTVlOTRcdTc1MjhcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhcHAiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOiIwIiwibWlkIjoiMDIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhcHAiLCJpY29uIjoiZmEtbW9uZXkifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjE3fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1ZTk0XHU3NTI4XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoiYXBwTGlzdCIsInVybCI6Ii9hcHAvYXBwTGlzdC8iLCJmYXRoZXJJRCI6IjAyIiwibWlkIjoiMDIxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXBwTGlzdCBhcHBBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxOH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NWU5NFx1NzUyOFx1NmRmYlx1NTJhMCIsImh0bWxJRCI6ImFwcEFkZCIsInVybCI6Ii9hcHAvYXBwQWRkLyIsImZhdGhlcklEIjoiMDIxIiwibWlkIjoiMDIxMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFwcExpc3QgYXBwQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTl9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhY2NvdW50cyIsInVybCI6IiMiLCJmYXRoZXJJRCI6IjAiLCJtaWQiOiIwMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFjY291bnRzIiwiaWNvbiI6ImZhLXVzZXIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjZ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJodG1sSUQiOiJ1c2VyTGlzdCIsInVybCI6Ii9hY2NvdW50cy91c2VyTGlzdC8iLCJmYXRoZXJJRCI6IjAzIiwibWlkIjoiMDMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoidXNlckxpc3QgdXNlckFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjd9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyQWRkIiwidXJsIjoiL2FjY291bnRzL3VzZXJBZGQvIiwiZmF0aGVySUQiOiIwMzEiLCJtaWQiOiIwMzExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoidXNlckxpc3QgdXNlckFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyRWRpdCIsInVybCI6Ii9hY2NvdW50cy91c2VyRWRpdC8iLCJmYXRoZXJJRCI6IjAzMSIsIm1pZCI6IjAzMTIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJ1c2VyRWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI5fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1MjIwXHU5NjY0XHU3NTI4XHU2MjM3IiwiaHRtbElEIjoidXNlckRlbCIsInVybCI6Ii9hY2NvdW50cy91c2VyRGVsLyIsImZhdGhlcklEIjoiMDMxIiwibWlkIjoiMDMxMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJEZWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NzUyOFx1NjIzNy9cdTkwZThcdTk1ZThcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhdXRoTWVudSIsInVybCI6Ii9hY2NvdW50cy9hdXRoTWVudS8iLCJmYXRoZXJJRCI6IjAzMSIsIm1pZCI6IjAzMTQiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhdXRoTWVudSIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM1fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU3NTI4XHU2MjM3XHU3MmI2XHU2MDAxXHU3YmExXHU3NDA2IiwiaHRtbElEIjoidXNlclN0YXR1cyIsInVybCI6Ii9hY2NvdW50cy91c2VyU3RhdHVzLyIsImZhdGhlcklEIjoiMDMxIiwibWlkIjoiMDMxNSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJTdGF0dXMiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozNn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsImh0bWxJRCI6ImRlcGFydG1lbnRMaXN0IiwidXJsIjoiL2FjY291bnRzL2RlcGFydG1lbnRMaXN0LyIsImZhdGhlcklEIjoiMDMiLCJtaWQiOiIwMzIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJkZXBhcnRtZW50TGlzdCBkZXBhcnRtZW50QWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTJ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTkwZThcdTk1ZTgiLCJodG1sSUQiOiJkZXBhcnRtZW50QWRkIiwidXJsIjoiL2FjY291bnRzL2RlcGFydG1lbnRBZGQvIiwiZmF0aGVySUQiOiIwMzIiLCJtaWQiOiIwMzIxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudExpc3QgZGVwYXJ0bWVudEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjEzfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZmVlXHU2NTM5XHU5MGU4XHU5NWU4IiwiaHRtbElEIjoiZGVwYXJ0bWVudEVkaXQiLCJ1cmwiOiIvYWNjb3VudHMvZGVwYXJ0bWVudEVkaXQvIiwiZmF0aGVySUQiOiIwMzIiLCJtaWQiOiIwMzIyIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudEVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoyN30seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1OTBlOFx1OTVlOCIsImh0bWxJRCI6ImRlcGFydG1lbnREZWwiLCJ1cmwiOiIvYWNjb3VudHMvZGVwYXJ0bWVudERlbC8iLCJmYXRoZXJJRCI6IjAzMiIsIm1pZCI6IjAzMjMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJkZXBhcnRtZW50RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mjh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUwM2NcdTczZWRcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJvbkR1dHkiLCJ1cmwiOiIvYWNjb3VudHMvb25EdXR5LyIsImZhdGhlcklEIjoiMDMiLCJtaWQiOiIwMzMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJvbkR1dHkiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxNH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1NTAzY1x1NzNlZCIsImh0bWxJRCI6Im9uRHV0eUFkZCIsInVybCI6Ii9hY2NvdW50cy9vbkR1dHlBZGQvIiwiZmF0aGVySUQiOiIwMzMiLCJtaWQiOiIwMzMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoib25EdXR5QWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MzN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdTUwM2NcdTczZWQiLCJodG1sSUQiOiJvbkR1dHlFZGl0IiwidXJsIjoiL2FjY291bnRzL29uRHV0eUVkaXQvIiwiZmF0aGVySUQiOiIwMzMiLCJtaWQiOiIwMzMyIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoib25EdXR5RWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2NzQzXHU5NjUwXHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXV0aCIsInVybCI6IiMiLCJmYXRoZXJJRCI6IjAiLCJtaWQiOiIwNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImF1dGgiLCJpY29uIjoiZmEtYmFuIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo5fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoibWVudUFkbWluTGlzdCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkxpc3QvIiwiZmF0aGVySUQiOiIwNCIsIm1pZCI6IjA0MSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkxpc3QgbWVudUFkbWluQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTB9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTgzZGNcdTUzNTUiLCJodG1sSUQiOiJtZW51QWRtaW5BZGQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5BZGQvIiwiZmF0aGVySUQiOiIwNDEiLCJtaWQiOiIwNDExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoibWVudUFkbWluTGlzdCBtZW51QWRtaW5BZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxMX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1ODNkY1x1NTM1NSIsImh0bWxJRCI6Im1lbnVBZG1pbkVkaXQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5FZGl0LyIsImZhdGhlcklEIjoiMDQxIiwibWlkIjoiMDQxMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1ODNkY1x1NTM1NSIsImh0bWxJRCI6Im1lbnVBZG1pbkRlbCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkRlbC8iLCJmYXRoZXJJRCI6IjA0MSIsIm1pZCI6IjA0MTMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJtZW51QWRtaW5EZWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMn1dfQ==','2018-08-23 20:01:13.334267'),('fjl65kmz0ekoqqb9ruby6kys7tyc94ne','MjJjM2JmMDI1NzNkODE0OGJhNDZmNzhiMjY5YWRmMTRlNjhhY2M3YTp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1ODdhNWZiNDU2MjUyYmFhNWM5NjEwNjcyMWYxZDI4MDQyYWJhNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-08-23 19:59:17.289843'),('tfumw9tn3w8c0of7hok6lass5r9gtvz8','MjJlZTc4NGJjYmE5MjgzNzc4ZTFjYWI4ZjFmMGQxMzBkMjhiMDQ2YTp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1ODdhNWZiNDU2MjUyYmFhNWM5NjEwNjcyMWYxZDI4MDQyYWJhNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOm51bGx9','2018-08-23 19:49:45.176689'),('yxdemiqu40dkbex3bnzwsgpq43xbjeak','OTAzYjk1OGJhYmE1OTAwNTMyMzc4Nzg5YjQ5MWM5YmU3NDgzODIwNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1ODdhNWZiNDU2MjUyYmFhNWM5NjEwNjcyMWYxZDI4MDQyYWJhNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOlt7ImZpZWxkcyI6eyJuYW1lIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXQiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOiIwIiwibWlkIjoiMDEiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhc3NldCIsImljb24iOiJmYS1kZXNrdG9wIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4YmJlXHU1OTA3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXRMaXN0IiwidXJsIjoiL2Fzc2V0L2Fzc2V0TGlzdC8iLCJmYXRoZXJJRCI6IjAxIiwibWlkIjoiMDExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXNzZXRMaXN0IGFzc2V0QWRkIGFzc2V0RWRpdCBhc3NldERldGFpbCIsImljb24iOiJhcnJvdyJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1OGJiZVx1NTkwNyIsImh0bWxJRCI6ImFzc2V0QWRkIiwidXJsIjoiL2Fzc2V0L2Fzc2V0QWRkLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0TGlzdCBhc3NldEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdThiYmVcdTU5MDciLCJodG1sSUQiOiJhc3NldEVkaXQiLCJ1cmwiOiIvYXNzZXQvYXNzZXRFZGl0LyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0RWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjIxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1MjIwXHU5NjY0XHU4YmJlXHU1OTA3IiwiaHRtbElEIjoiYXNzZXRFZGl0IiwidXJsIjoiL2Fzc2V0L2Fzc2V0RGVsLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFzc2V0RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MjJ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRlMGFcdTRmMjBcdThiYmVcdTU5MDciLCJodG1sSUQiOiJ1cGRhdGVGcm9tRXhjZWwiLCJ1cmwiOiIvYXNzZXQvdXBkYXRlRnJvbUV4Y2VsLyIsImZhdGhlcklEIjoiMDExIiwibWlkIjoiMDExNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6IiIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQ0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2NzNhXHU2MjNmXHU3YmExXHU3NDA2IiwiaHRtbElEIjoiaWRjTGlzdCIsInVybCI6Ii9hc3NldC9pZGNMaXN0LyIsImZhdGhlcklEIjoiMDEiLCJtaWQiOiIwMTIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpZGNMaXN0IGlkY0FkZCBpZGNFZGl0IGlkY0RldGFpbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjR9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTY3M2FcdTYyM2YiLCJodG1sSUQiOiJpZGNBZGQiLCJ1cmwiOiIvYXNzZXQvaWRjQWRkLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0xpc3QgaWRjQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1NjczYVx1NjIzZiIsImh0bWxJRCI6ImlkY0VkaXQiLCJ1cmwiOiIvYXNzZXQvaWRjRWRpdC8iLCJmYXRoZXJJRCI6IjAxMiIsIm1pZCI6IjAxMjMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpZGNFZGl0IiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MjN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUyMjBcdTk2NjRcdTY3M2FcdTYyM2YiLCJodG1sSUQiOiJpZGNEZWwiLCJ1cmwiOiIvYXNzZXQvaWRjRGVsLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlkY0RlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU2NzNhXHU2N2RjIiwiaHRtbElEIjoiY2FiaW5ldEFkZCIsInVybCI6Ii9hc3NldC9jYWJpbmV0QWRkLyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImNhYmluZXRBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozN30seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1NjczYVx1NjdkYyIsImh0bWxJRCI6ImNhYmluZXRFZGl0IiwidXJsIjoiL2Fzc2V0L2NhYmluZXRFZGl0LyIsImZhdGhlcklEIjoiMDEyIiwibWlkIjoiMDEyNiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImNhYmluZXRFZGl0IiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mzh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUyMjBcdTk2NjRcdTY3M2FcdTY3ZGMiLCJodG1sSUQiOiJjYWJpbmV0RGVsIiwidXJsIjoiL2Fzc2V0L2NhYmluZXREZWwvIiwiZmF0aGVySUQiOiIwMTIiLCJtaWQiOiIwMTI3IiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiY2FiaW5ldERlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM5fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJpcExpc3QiLCJ1cmwiOiIvYXNzZXQvaXBMaXN0LyIsImZhdGhlcklEIjoiMDEiLCJtaWQiOiIwMTMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcExpc3QgaXBBZGQgaXBFZGl0IGlwRGV0YWlsIG5ldHdvcmtTZWdtZW50TGlzdCBuZXR3b3JrU2VnbWVudEFkZCBuZXR3b3JrU2VnbWVudEVkaXQgbmV0d29ya1NlZ21lbnREZXRhaWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxNX0seyJmaWVsZHMiOnsibmFtZSI6IklQXHU2ZGZiXHU1MmEwIiwiaHRtbElEIjoiaXBBZGQiLCJ1cmwiOiIvYXNzZXQvaXBBZGQvIiwiZmF0aGVySUQiOiIwMTMiLCJtaWQiOiIwMTMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaXBMaXN0IGlwQWRkIGlwRWRpdCBpcERldGFpbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjE2fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTRmZWVcdTY1MzkiLCJodG1sSUQiOiJpcEVkaXQiLCJ1cmwiOiIvYXNzZXQvaXBFZGl0LyIsImZhdGhlcklEIjoiMDEzIiwibWlkIjoiMDEzMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImlwRWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI1fSx7ImZpZWxkcyI6eyJuYW1lIjoiSVBcdTUyMjBcdTk2NjQiLCJodG1sSUQiOiJpcERlbCIsInVybCI6Ii9hc3NldC9pcERlbC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcERlbCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI2fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2Mjc5XHU5MWNmXHU1MjIwXHU5NjY0SVAiLCJodG1sSUQiOiJpcERlbEJhdGNoIiwidXJsIjoiL2Fzc2V0L2lwRGVsQmF0Y2gvIiwiZmF0aGVySUQiOiIwMTMiLCJtaWQiOiIwMTM0IiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiaXBEZWxCYXRjaCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQwfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2Mjc5XHU5MWNmXHU0ZmVlXHU2NTM5SVAiLCJodG1sSUQiOiJpcEVkaXRCYXRjaCIsInVybCI6Ii9hc3NldC9pcEVkaXRCYXRjaC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzUiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJpcEVkaXRCYXRjaCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjQxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZmVlXHU2NTM5XHU3ZjUxXHU2YmI1IiwiaHRtbElEIjoibmV0d29ya1NlZ21lbnRFZGl0IiwidXJsIjoiL2Fzc2V0L25ldHdvcmtTZWdtZW50RWRpdC8iLCJmYXRoZXJJRCI6IjAxMyIsIm1pZCI6IjAxMzYiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJuZXR3b3JrU2VnbWVudEVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo0Mn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1N2Y1MVx1NmJiNSIsImh0bWxJRCI6Im5ldHdvcmtTZWdtZW50RGVsIiwidXJsIjoiL2Fzc2V0L25ldHdvcmtTZWdtZW50RGVsLyIsImZhdGhlcklEIjoiMDEzIiwibWlkIjoiMDEzNyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im5ldHdvcmtTZWdtZW50RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6NDN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTVlOTRcdTc1MjhcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhcHAiLCJ1cmwiOiIjIiwiZmF0aGVySUQiOiIwIiwibWlkIjoiMDIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhcHAiLCJpY29uIjoiZmEtbW9uZXkifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjE3fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1ZTk0XHU3NTI4XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoiYXBwTGlzdCIsInVybCI6Ii9hcHAvYXBwTGlzdC8iLCJmYXRoZXJJRCI6IjAyIiwibWlkIjoiMDIxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiYXBwTGlzdCBhcHBBZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxOH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NWU5NFx1NzUyOFx1NmRmYlx1NTJhMCIsImh0bWxJRCI6ImFwcEFkZCIsInVybCI6Ii9hcHAvYXBwQWRkLyIsImZhdGhlcklEIjoiMDIxIiwibWlkIjoiMDIxMSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFwcExpc3QgYXBwQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTl9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhY2NvdW50cyIsInVybCI6IiMiLCJmYXRoZXJJRCI6IjAiLCJtaWQiOiIwMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImFjY291bnRzIiwiaWNvbiI6ImZhLXVzZXIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjZ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJodG1sSUQiOiJ1c2VyTGlzdCIsInVybCI6Ii9hY2NvdW50cy91c2VyTGlzdC8iLCJmYXRoZXJJRCI6IjAzIiwibWlkIjoiMDMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoidXNlckxpc3QgdXNlckFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjd9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyQWRkIiwidXJsIjoiL2FjY291bnRzL3VzZXJBZGQvIiwiZmF0aGVySUQiOiIwMzEiLCJtaWQiOiIwMzExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoidXNlckxpc3QgdXNlckFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyRWRpdCIsInVybCI6Ii9hY2NvdW50cy91c2VyRWRpdC8iLCJmYXRoZXJJRCI6IjAzMSIsIm1pZCI6IjAzMTIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJ1c2VyRWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI5fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU1MjIwXHU5NjY0XHU3NTI4XHU2MjM3IiwiaHRtbElEIjoidXNlckRlbCIsInVybCI6Ii9hY2NvdW50cy91c2VyRGVsLyIsImZhdGhlcklEIjoiMDMxIiwibWlkIjoiMDMxMyIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJEZWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NzUyOFx1NjIzNy9cdTkwZThcdTk1ZThcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhdXRoTWVudSIsInVybCI6Ii9hY2NvdW50cy9hdXRoTWVudS8iLCJmYXRoZXJJRCI6IjAzMSIsIm1pZCI6IjAzMTQiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhdXRoTWVudSIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM1fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU3NTI4XHU2MjM3XHU3MmI2XHU2MDAxXHU3YmExXHU3NDA2IiwiaHRtbElEIjoidXNlclN0YXR1cyIsInVybCI6Ii9hY2NvdW50cy91c2VyU3RhdHVzLyIsImZhdGhlcklEIjoiMDMxIiwibWlkIjoiMDMxNSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6InVzZXJTdGF0dXMiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozNn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsImh0bWxJRCI6ImRlcGFydG1lbnRMaXN0IiwidXJsIjoiL2FjY291bnRzL2RlcGFydG1lbnRMaXN0LyIsImZhdGhlcklEIjoiMDMiLCJtaWQiOiIwMzIiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJkZXBhcnRtZW50TGlzdCBkZXBhcnRtZW50QWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTJ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTkwZThcdTk1ZTgiLCJodG1sSUQiOiJkZXBhcnRtZW50QWRkIiwidXJsIjoiL2FjY291bnRzL2RlcGFydG1lbnRBZGQvIiwiZmF0aGVySUQiOiIwMzIiLCJtaWQiOiIwMzIxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudExpc3QgZGVwYXJ0bWVudEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjEzfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZmVlXHU2NTM5XHU5MGU4XHU5NWU4IiwiaHRtbElEIjoiZGVwYXJ0bWVudEVkaXQiLCJ1cmwiOiIvYWNjb3VudHMvZGVwYXJ0bWVudEVkaXQvIiwiZmF0aGVySUQiOiIwMzIiLCJtaWQiOiIwMzIyIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudEVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoyN30seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1OTBlOFx1OTVlOCIsImh0bWxJRCI6ImRlcGFydG1lbnREZWwiLCJ1cmwiOiIvYWNjb3VudHMvZGVwYXJ0bWVudERlbC8iLCJmYXRoZXJJRCI6IjAzMiIsIm1pZCI6IjAzMjMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJkZXBhcnRtZW50RGVsIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mjh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTUwM2NcdTczZWRcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJvbkR1dHkiLCJ1cmwiOiIvYWNjb3VudHMvb25EdXR5LyIsImZhdGhlcklEIjoiMDMiLCJtaWQiOiIwMzMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJvbkR1dHkiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxNH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmRmYlx1NTJhMFx1NTAzY1x1NzNlZCIsImh0bWxJRCI6Im9uRHV0eUFkZCIsInVybCI6Ii9hY2NvdW50cy9vbkR1dHlBZGQvIiwiZmF0aGVySUQiOiIwMzMiLCJtaWQiOiIwMzMxIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoib25EdXR5QWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MzN9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTRmZWVcdTY1MzlcdTUwM2NcdTczZWQiLCJodG1sSUQiOiJvbkR1dHlFZGl0IiwidXJsIjoiL2FjY291bnRzL29uRHV0eUVkaXQvIiwiZmF0aGVySUQiOiIwMzMiLCJtaWQiOiIwMzMyIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoib25EdXR5RWRpdCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjM0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2NzQzXHU5NjUwXHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXV0aCIsInVybCI6IiMiLCJmYXRoZXJJRCI6IjAiLCJtaWQiOiIwNCIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImF1dGgiLCJpY29uIjoiZmEtYmFuIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjo5fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoibWVudUFkbWluTGlzdCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkxpc3QvIiwiZmF0aGVySUQiOiIwNCIsIm1pZCI6IjA0MSIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkxpc3QgbWVudUFkbWluQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MTB9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTgzZGNcdTUzNTUiLCJodG1sSUQiOiJtZW51QWRtaW5BZGQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5BZGQvIiwiZmF0aGVySUQiOiIwNDEiLCJtaWQiOiIwNDExIiwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoibWVudUFkbWluTGlzdCBtZW51QWRtaW5BZGQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxMX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NGZlZVx1NjUzOVx1ODNkY1x1NTM1NSIsImh0bWxJRCI6Im1lbnVBZG1pbkVkaXQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5FZGl0LyIsImZhdGhlcklEIjoiMDQxIiwibWlkIjoiMDQxMiIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkVkaXQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMX0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NTIyMFx1OTY2NFx1ODNkY1x1NTM1NSIsImh0bWxJRCI6Im1lbnVBZG1pbkRlbCIsInVybCI6Ii9hdXRoL21lbnVBZG1pbkRlbC8iLCJmYXRoZXJJRCI6IjA0MSIsIm1pZCI6IjA0MTMiLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJtZW51QWRtaW5EZWwiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozMn1dfQ==','2018-08-23 19:59:49.609959');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_list`
--

DROP TABLE IF EXISTS `ip_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_list` (
  `uuid` char(32) NOT NULL,
  `ip` char(39) NOT NULL,
  `netmask` char(39) NOT NULL,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  `group_id` char(32) DEFAULT NULL,
  `host_id` char(32) DEFAULT NULL,
  `idc_id` char(32) DEFAULT NULL,
  `segment_id` char(32) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `ip_list_ip_4af2c4b06643002f_uniq` (`ip`,`idc_id`,`availabity`),
  KEY `ip_list_group_id_2c16e3298abb3509_fk_cabinet_uuid` (`group_id`),
  KEY `ip_list_host_id_73324de626b11291_fk_asset_equipmentid` (`host_id`),
  KEY `ip_list_idc_id_42c3b33ac01033a6_fk_dataCenter_uuid` (`idc_id`),
  KEY `ip_list_3e8e3332` (`segment_id`),
  CONSTRAINT `ip_list_group_id_2c16e3298abb3509_fk_cabinet_uuid` FOREIGN KEY (`group_id`) REFERENCES `cabinet` (`uuid`),
  CONSTRAINT `ip_list_host_id_73324de626b11291_fk_asset_equipmentid` FOREIGN KEY (`host_id`) REFERENCES `asset` (`equipmentid`),
  CONSTRAINT `ip_list_idc_id_42c3b33ac01033a6_fk_dataCenter_uuid` FOREIGN KEY (`idc_id`) REFERENCES `dataCenter` (`uuid`),
  CONSTRAINT `ip_list_segment_id_51aa5af4f109bd6b_fk_network_segment_uuid` FOREIGN KEY (`segment_id`) REFERENCES `network_segment` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_list`
--

LOCK TABLES `ip_list` WRITE;
/*!40000 ALTER TABLE `ip_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `htmlID` varchar(30) NOT NULL,
  `fatherID` varchar(10) NOT NULL,
  `icon` varchar(30) DEFAULT NULL,
  `htmlClass` varchar(200) DEFAULT NULL,
  `url` varchar(200) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_mid_2e7c5ef471be35d0_uniq` (`mid`,`htmlID`,`htmlClass`,`availabity`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'01','资产管理','asset','0','fa-desktop','asset','#',1),(2,'011','设备管理','assetList','01','arrow','assetList assetAdd assetEdit assetDetail','/asset/assetList/',1),(3,'0111','添加设备','assetAdd','011','','assetList assetAdd','/asset/assetAdd/',1),(4,'012','机房管理','idcList','01','','idcList idcAdd idcEdit idcDetail','/asset/idcList/',1),(5,'0121','添加机房','idcAdd','012','','idcList idcAdd','/asset/idcAdd/',1),(6,'03','用户管理','accounts','0','fa-user','accounts','#',1),(7,'031','用户列表','userList','03','','userList userAdd','/accounts/userList/',1),(8,'0311','添加用户','userAdd','031','','userList userAdd','/accounts/userAdd/',1),(9,'04','权限管理','auth','0','fa-ban','auth','#',1),(10,'041','菜单列表','menuAdminList','04','','menuAdminList menuAdminAdd','/auth/menuAdminList/',1),(11,'0411','添加菜单','menuAdminAdd','041','','menuAdminList menuAdminAdd','/auth/menuAdminAdd/',1),(12,'032','部门列表','departmentList','03','','departmentList departmentAdd','/accounts/departmentList/',1),(13,'0321','添加部门','departmentAdd','032','','departmentList departmentAdd','/accounts/departmentAdd/',1),(14,'033','值班管理','onDuty','03','','onDuty','/accounts/onDuty/',1),(15,'013','IP管理','ipList','01','','ipList ipAdd ipEdit ipDetail networkSegmentList networkSegmentAdd networkSegmentEdit networkSegmentDetail','/asset/ipList/',1),(16,'0131','IP添加','ipAdd','013','','ipList ipAdd ipEdit ipDetail','/asset/ipAdd/',1),(17,'02','应用管理','app','0','fa-money','app','#',1),(18,'021','应用列表','appList','02','','appList appAdd','/app/appList/',1),(19,'0211','应用添加','appAdd','021','','appList appAdd','/app/appAdd/',1),(21,'0112','修改设备','assetEdit','011','','assetEdit','/asset/assetEdit/',1),(22,'0113','删除设备','assetEdit','011','','assetDel','/asset/assetDel/',1),(23,'0123','修改机房','idcEdit','012','','idcEdit','/asset/idcEdit/',1),(24,'0124','删除机房','idcDel','012','','idcDel','/asset/idcDel/',1),(25,'0132','IP修改','ipEdit','013','','ipEdit','/asset/ipEdit/',1),(26,'0133','IP删除','ipDel','013','','ipDel','/asset/ipDel/',1),(27,'0322','修改部门','departmentEdit','032','','departmentEdit','/accounts/departmentEdit/',1),(28,'0323','删除部门','departmentDel','032','','departmentDel','/accounts/departmentDel/',1),(29,'0312','修改用户','userEdit','031','','userEdit','/accounts/userEdit/',1),(30,'0313','删除用户','userDel','031','','userDel','/accounts/userDel/',1),(31,'0412','修改菜单','menuAdminEdit','041','','menuAdminEdit','/auth/menuAdminEdit/',1),(32,'0413','删除菜单','menuAdminDel','041','','menuAdminDel','/auth/menuAdminDel/',1),(33,'0331','添加值班','onDutyAdd','033','','onDutyAdd','/accounts/onDutyAdd/',1),(34,'0332','修改值班','onDutyEdit','033','','onDutyEdit','/accounts/onDutyEdit/',1),(35,'0314','用户/部门权限管理','authMenu','031','','authMenu','/accounts/authMenu/',1),(36,'0315','用户状态管理','userStatus','031','','userStatus','/accounts/userStatus/',1),(37,'0125','添加机柜','cabinetAdd','012','','cabinetAdd','/asset/cabinetAdd/',1),(38,'0126','修改机柜','cabinetEdit','012','','cabinetEdit','/asset/cabinetEdit/',1),(39,'0127','删除机柜','cabinetDel','012','','cabinetDel','/asset/cabinetDel/',1),(40,'0134','批量删除IP','ipDelBatch','013','','ipDelBatch','/asset/ipDelBatch/',1),(41,'0135','批量修改IP','ipEditBatch','013','','ipEditBatch','/asset/ipEditBatch/',1),(42,'0136','修改网段','networkSegmentEdit','013','','networkSegmentEdit','/asset/networkSegmentEdit/',1),(43,'0137','删除网段','networkSegmentDel','013','','networkSegmentDel','/asset/networkSegmentDel/',1),(44,'0114','上传设备','updateFromExcel','011','','','/asset/updateFromExcel/',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myUser`
--

DROP TABLE IF EXISTS `myUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myUser` (
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
  `department_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `myUser_username_1843759df7e4cea3_uniq` (`username`,`availabity`),
  KEY `myUser_bf691be4` (`department_id`),
  CONSTRAINT `myUser_department_id_a7765a27b8235a9_fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myUser`
--

LOCK TABLES `myUser` WRITE;
/*!40000 ALTER TABLE `myUser` DISABLE KEYS */;
INSERT INTO `myUser` VALUES (1,'pbkdf2_sha256$20000$8awN5kfxzTL3$QCU4WQXitLBDYqvNquH95k1PDPPOA3QXZrkq+Y4aw8c=','2018-08-23 08:01:13.301011',1,'evan','','','evan886@gmail.com',1,1,'2018-08-23 04:34:00.000000','','','',1,1);
/*!40000 ALTER TABLE `myUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myUser_groups`
--

DROP TABLE IF EXISTS `myUser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myUser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`group_id`),
  KEY `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` (`group_id`),
  CONSTRAINT `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `myUser_groups_myuser_id_346042a381ba62c4_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myUser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myUser_groups`
--

LOCK TABLES `myUser_groups` WRITE;
/*!40000 ALTER TABLE `myUser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `myUser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myUser_menu_auth`
--

DROP TABLE IF EXISTS `myUser_menu_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myUser_menu_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`menu_id`),
  KEY `myUser_menu_auth_menu_id_6db6edf0df5d3085_fk_menu_id` (`menu_id`),
  CONSTRAINT `myUser_menu_auth_menu_id_6db6edf0df5d3085_fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`),
  CONSTRAINT `myUser_menu_auth_myuser_id_53e95b1a16a5abb5_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myUser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myUser_menu_auth`
--

LOCK TABLES `myUser_menu_auth` WRITE;
/*!40000 ALTER TABLE `myUser_menu_auth` DISABLE KEYS */;
INSERT INTO `myUser_menu_auth` VALUES (44,1,1),(45,1,2),(46,1,3),(47,1,4),(48,1,5),(49,1,6),(50,1,7),(51,1,8),(52,1,9),(53,1,10),(54,1,11),(55,1,12),(56,1,13),(57,1,14),(58,1,15),(59,1,16),(60,1,17),(61,1,18),(62,1,19),(63,1,21),(64,1,22),(65,1,23),(66,1,24),(67,1,25),(68,1,26),(69,1,27),(70,1,28),(71,1,29),(72,1,30),(73,1,31),(74,1,32),(75,1,33),(76,1,34),(77,1,35),(78,1,36),(79,1,37),(80,1,38),(81,1,39),(82,1,40),(83,1,41),(84,1,42),(85,1,43),(86,1,44);
/*!40000 ALTER TABLE `myUser_menu_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myUser_user_permissions`
--

DROP TABLE IF EXISTS `myUser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myUser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`permission_id`),
  KEY `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `myUser_user_permissions_myuser_id_27f715bec9c2e9d6_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myUser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myUser_user_permissions`
--

LOCK TABLES `myUser_user_permissions` WRITE;
/*!40000 ALTER TABLE `myUser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `myUser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_segment`
--

DROP TABLE IF EXISTS `network_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_segment` (
  `uuid` char(32) NOT NULL,
  `type` int(11) NOT NULL,
  `segment` varchar(18) NOT NULL,
  `status` int(11) NOT NULL,
  `auto` tinyint(1) NOT NULL,
  `comment` longtext,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `network_segment_segment_3869fc5bcdaa1f3f_uniq` (`segment`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_segment`
--

LOCK TABLES `network_segment` WRITE;
/*!40000 ALTER TABLE `network_segment` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_segment_idc`
--

DROP TABLE IF EXISTS `network_segment_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_segment_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_segment_id` char(32) NOT NULL,
  `datacenter_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_segment_id` (`network_segment_id`,`datacenter_id`),
  KEY `network_segmen_datacenter_id_4e7be3e324c8ee01_fk_dataCenter_uuid` (`datacenter_id`),
  CONSTRAINT `netw_network_segment_id_13ae7cf814a99393_fk_network_segment_uuid` FOREIGN KEY (`network_segment_id`) REFERENCES `network_segment` (`uuid`),
  CONSTRAINT `network_segmen_datacenter_id_4e7be3e324c8ee01_fk_dataCenter_uuid` FOREIGN KEY (`datacenter_id`) REFERENCES `dataCenter` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_segment_idc`
--

LOCK TABLES `network_segment_idc` WRITE;
/*!40000 ALTER TABLE `network_segment_idc` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_segment_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `on_duty`
--

DROP TABLE IF EXISTS `on_duty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `on_duty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `on_duty`
--

LOCK TABLES `on_duty` WRITE;
/*!40000 ALTER TABLE `on_duty` DISABLE KEYS */;
/*!40000 ALTER TABLE `on_duty` ENABLE KEYS */;
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
  `availabity` bigint(20) NOT NULL,
  `equipmentid_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `service_equipmentid_id_7ec4314ccffda381_uniq` (`equipmentid_id`,`name`,`port`,`availabity`),
  UNIQUE KEY `service_equipmentid_id_61fea3faea8b5aeb_uniq` (`equipmentid_id`,`port`,`availabity`),
  CONSTRAINT `service_equipmentid_id_a7f5e097496cfc4_fk_asset_equipmentid` FOREIGN KEY (`equipmentid_id`) REFERENCES `asset` (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apiaccess`
--

DROP TABLE IF EXISTS `tastypie_apiaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apiaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `request_method` varchar(10) NOT NULL,
  `accessed` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apiaccess`
--

LOCK TABLES `tastypie_apiaccess` WRITE;
/*!40000 ALTER TABLE `tastypie_apiaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apiaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apikey`
--

DROP TABLE IF EXISTS `tastypie_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apikey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `tastypie_apikey_3c6e0b8a` (`key`),
  CONSTRAINT `tastypie_apikey_user_id_ffeb4840e0b406b_fk_myUser_id` FOREIGN KEY (`user_id`) REFERENCES `myUser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apikey`
--

LOCK TABLES `tastypie_apikey` WRITE;
/*!40000 ALTER TABLE `tastypie_apikey` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apikey` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-23  4:21:37
