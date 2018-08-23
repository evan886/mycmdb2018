DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `htmlID` varchar(30) NOT NULL,
  `fatherID` varchar(10) NOT NULL,
  `icon` varchar(30) DEFAULT NULL,
  `htmlClass` varchar(200) DEFAULT NULL,
  `url` varchar(200) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  `mid` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_mid_71be35d0_uniq` (`mid`,`htmlID`,`htmlClass`,`availabity`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'资产管理','asset','0','fa-desktop','asset','#',1,'01'),(2,'设备管理','assetList','01','arrow','assetList assetAdd assetEdit assetDetail','/asset/assetList/',1,'011'),(3,'添加设备','assetAdd','011','','assetList assetAdd','/asset/assetAdd/',1,'0111'),(4,'机房管理','idcList','01','','idcList idcAdd idcEdit idcDetail','/asset/idcList/',1,'012'),(5,'添加机房','idcAdd','012','','idcList idcAdd','/asset/idcAdd/',1,'0121'),(6,'用户管理','accounts','0','fa-user','accounts','#',1,'03'),(7,'用户列表','userList','03','','userList userAdd','/accounts/userList/',1,'031'),(8,'添加用户','userAdd','031','','userList userAdd','/accounts/userAdd/',1,'0311'),(9,'权限管理','auth','0','fa-ban','auth','#',1,'04'),(10,'菜单列表','menuAdminList','04','','menuAdminList menuAdminAdd','/auth/menuAdminList/',1,'041'),(11,'添加菜单','menuAdminAdd','041','','menuAdminList menuAdminAdd','/auth/menuAdminAdd/',1,'0411'),(12,'部门列表','departmentList','03','','departmentList departmentAdd','/accounts/departmentList/',1,'032'),(13,'添加部门','departmentAdd','032','','departmentList departmentAdd','/accounts/departmentAdd/',1,'0321'),(14,'值班管理','onDuty','03','','onDuty','/accounts/onDuty/',1,'033'),(15,'IP管理','ipList','01','','ipList ipAdd ipEdit ipDetail networkSegmentList networkSegmentAdd networkSegmentEdit networkSegmentDetail','/asset/ipList/',1,'013'),(16,'IP添加','ipAdd','013','','ipList ipAdd ipEdit ipDetail','/asset/ipAdd/',1,'0131'),(17,'应用管理','app','0','fa-money','app','#',1,'02'),(18,'应用列表','appList','02','','appList appAdd','/app/appList/',1,'021'),(19,'应用添加','appAdd','021','','appList appAdd','/app/appAdd/',1,'0211'),(21,'修改设备','assetEdit','011','','assetEdit','/asset/assetEdit/',1,'0112'),(22,'删除设备','assetEdit','011','','assetDel','/asset/assetDel/',1,'0113'),(23,'修改机房','idcEdit','012','','idcEdit','/asset/idcEdit/',1,'0123'),(24,'删除机房','idcDel','012','','idcDel','/asset/idcDel/',1,'0124'),(25,'IP修改','ipEdit','013','','ipEdit','/asset/ipEdit/',1,'0132'),(26,'IP删除','ipDel','013','','ipDel','/asset/ipDel/',1,'0133'),(27,'修改部门','departmentEdit','032','','departmentEdit','/accounts/departmentEdit/',1,'0322'),(28,'删除部门','departmentDel','032','','departmentDel','/accounts/departmentDel/',1,'0323'),(29,'修改用户','userEdit','031','','userEdit','/accounts/userEdit/',1,'0312'),(30,'删除用户','userDel','031','','userDel','/accounts/userDel/',1,'0313'),(31,'修改菜单','menuAdminEdit','041','','menuAdminEdit','/auth/menuAdminEdit/',1,'0412'),(32,'删除菜单','menuAdminDel','041','','menuAdminDel','/auth/menuAdminDel/',1,'0413'),(33,'添加值班','onDutyAdd','033','','onDutyAdd','/accounts/onDutyAdd/',1,'0331'),(34,'修改值班','onDutyEdit','033','','onDutyEdit','/accounts/onDutyEdit/',1,'0332'),(35,'用户/部门权限管理','authMenu','031','','authMenu','/accounts/authMenu/',1,'0314'),(36,'用户状态管理','userStatus','031','','userStatus','/accounts/userStatus/',1,'0315'),(37,'添加机柜','cabinetAdd','012','','cabinetAdd','/asset/cabinetAdd/',1,'0125'),(38,'修改机柜','cabinetEdit','012','','cabinetEdit','/asset/cabinetEdit/',1,'0126'),(39,'删除机柜','cabinetDel','012','','cabinetDel','/asset/cabinetDel/',1,'0127'),(40,'批量删除IP','ipDelBatch','013','','ipDelBatch','/asset/ipDelBatch/',1,'0134'),(41,'批量修改IP','ipEditBatch','013','','ipEditBatch','/asset/ipEditBatch/',1,'0135'),(42,'修改网段','networkSegmentEdit','013','','networkSegmentEdit','/asset/networkSegmentEdit/',1,'0136'),(43,'删除网段','networkSegmentDel','013','','networkSegmentDel','/asset/networkSegmentDel/',1,'0137'),(44,'上传设备','updateFromExcel','011','','','/asset/updateFromExcel/',1,'0114');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;
