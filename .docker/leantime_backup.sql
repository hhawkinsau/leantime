-- MySQL dump 10.13  Distrib 8.4.6, for Linux (x86_64)
--
-- Host: localhost    Database: leantime
-- ------------------------------------------------------
-- Server version	8.4.6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_access_tokens`
--

DROP TABLE IF EXISTS `zp_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_access_tokens`
--

LOCK TABLES `zp_access_tokens` WRITE;
/*!40000 ALTER TABLE `zp_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_approvals`
--

DROP TABLE IF EXISTS `zp_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_approvals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entityId` int DEFAULT NULL,
  `requestorId` int DEFAULT NULL,
  `approverId` int DEFAULT NULL,
  `approvalStatus` int DEFAULT NULL,
  `requestedOn` datetime DEFAULT NULL,
  `lastStatusChange` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_approvals`
--

LOCK TABLES `zp_approvals` WRITE;
/*!40000 ALTER TABLE `zp_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_audit`
--

DROP TABLE IF EXISTS `zp_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  `action` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entityId` int DEFAULT NULL,
  `values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  KEY `projectAction` (`projectId`,`action`),
  KEY `projectEntityEntityId` (`projectId`,`entity`,`entityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_audit`
--

LOCK TABLES `zp_audit` WRITE;
/*!40000 ALTER TABLE `zp_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_calendar`
--

DROP TABLE IF EXISTS `zp_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_calendar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `kind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allDay` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_calendar_userId_dateFrom_dateTo` (`userId`,`dateFrom`,`dateTo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_calendar`
--

LOCK TABLES `zp_calendar` WRITE;
/*!40000 ALTER TABLE `zp_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_canvas`
--

DROP TABLE IF EXISTS `zp_canvas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_canvas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectIdType` (`projectId`,`type`),
  KEY `idx_canvas_type_id` (`type`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_canvas`
--

LOCK TABLES `zp_canvas` WRITE;
/*!40000 ALTER TABLE `zp_canvas` DISABLE KEYS */;
INSERT INTO `zp_canvas` VALUES (1,'My Goals',1,'2025-09-08 15:10:29',1,'goalcanvas','',NULL),(2,'Board',1,'2025-09-08 15:40:47',4,'goalcanvas','',NULL),(3,'Board',1,'2025-09-08 15:45:51',5,'goalcanvas','',NULL),(4,'Board',1,'2025-09-08 15:45:52',5,'retroscanvas','',NULL),(5,'Default',1,'2025-09-09 00:00:00',5,'wiki',NULL,NULL),(6,'Board',1,'2025-09-08 15:51:19',6,'goalcanvas','',NULL),(7,'Board',1,'2025-09-08 15:53:58',2,'goalcanvas','',NULL),(8,'Board',1,'2025-09-09 06:23:12',2,'idea',NULL,NULL),(9,'Board',1,'2025-09-09 06:23:35',2,'retroscanvas','',NULL),(10,'Default',1,'2025-09-09 00:00:00',2,'wiki',NULL,NULL),(11,'My Goals',2,'2025-09-09 10:01:22',8,'goalcanvas','',NULL);
/*!40000 ALTER TABLE `zp_canvas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_canvas_items`
--

DROP TABLE IF EXISTS `zp_canvas_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_canvas_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `assumptions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `conclusion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `box` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `canvasId` int DEFAULT NULL,
  `sortindex` int DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relates` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `milestoneId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `featured` int DEFAULT NULL,
  `tags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `kpi` int DEFAULT NULL,
  `data1` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data2` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data3` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data4` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data5` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `metricType` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `startValue` double(10,2) DEFAULT NULL,
  `currentValue` double(10,2) DEFAULT NULL,
  `endValue` double(10,2) DEFAULT NULL,
  `impact` int DEFAULT NULL,
  `effort` int DEFAULT NULL,
  `probability` int DEFAULT NULL,
  `action` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `assignedTo` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CanvasLookUp` (`canvasId`,`box`),
  KEY `idx_canvas_items_box_milestoneId` (`box`,`milestoneId`),
  KEY `idx_canvas_items_box_status_author` (`box`,`status`,`author`),
  KEY `idx_canvas_items_parent_title` (`parent`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_canvas_items`
--

LOCK TABLES `zp_canvas_items` WRITE;
/*!40000 ALTER TABLE `zp_canvas_items` DISABLE KEYS */;
INSERT INTO `zp_canvas_items` VALUES (1,'Tasks completed on time','','','','goal',1,'2025-09-08 15:10:29','2025-09-08 15:10:29',1,NULL,'','','1','Build My Productivity System',0,NULL,'',0,'',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','percent',0.00,0.00,80.00,0,0,0,'',1),(2,'Tasks completed on time','','','','goal',2,'2025-09-09 10:01:22','2025-09-09 10:01:22',11,NULL,'','','43','Build My Productivity System',0,NULL,'',0,'',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','percent',0.00,0.00,80.00,0,0,0,'',2);
/*!40000 ALTER TABLE `zp_canvas_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_clients`
--

DROP TABLE IF EXISTS `zp_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` int DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internet` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_clients`
--

LOCK TABLES `zp_clients` WRITE;
/*!40000 ALTER TABLE `zp_clients` DISABLE KEYS */;
INSERT INTO `zp_clients` VALUES (1,'Global Vision Media','',0,'','','','','',NULL,NULL,'',NULL),(2,'Hudson Personal','',0,'','','','','',NULL,NULL,'',NULL),(3,'Both','',0,'','','','','',NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `zp_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_comment`
--

DROP TABLE IF EXISTS `zp_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_comment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `commentParent` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `moduleId` int DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_comment_moduleId_module_commentParent` (`moduleId`,`module`,`commentParent`),
  KEY `idx_comment_userId_module` (`userId`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_comment`
--

LOCK TABLES `zp_comment` WRITE;
/*!40000 ALTER TABLE `zp_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_entity_relationship`
--

DROP TABLE IF EXISTS `zp_entity_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_entity_relationship` (
  `id` int NOT NULL AUTO_INCREMENT,
  `enitityA` int DEFAULT NULL,
  `entityAType` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entityB` int DEFAULT NULL,
  `entityBType` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relationship` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `meta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `entityA` (`enitityA`,`entityAType`,`relationship`),
  KEY `entityB` (`entityB`,`entityBType`,`relationship`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_entity_relationship`
--

LOCK TABLES `zp_entity_relationship` WRITE;
/*!40000 ALTER TABLE `zp_entity_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_entity_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_file`
--

DROP TABLE IF EXISTS `zp_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_file` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module` enum('project','ticket','client','user','lead','export','private') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moduleId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `extension` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `realName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_file_module_moduleId_userId` (`module`,`moduleId`,`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_file`
--

LOCK TABLES `zp_file` WRITE;
/*!40000 ALTER TABLE `zp_file` DISABLE KEYS */;
INSERT INTO `zp_file` VALUES (1,'user',1,1,'png','cddc3e350c2a2345fcc7f3de3db5a472','userPicture.png','2025-09-08 15:21:46');
/*!40000 ALTER TABLE `zp_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_gcallinks`
--

DROP TABLE IF EXISTS `zp_gcallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_gcallinks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colorClass` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_gcallinks_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_gcallinks`
--

LOCK TABLES `zp_gcallinks` WRITE;
/*!40000 ALTER TABLE `zp_gcallinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_gcallinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_integration`
--

DROP TABLE IF EXISTS `zp_integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_integration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `providerId` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `schedule` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `lastSync` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_integration`
--

LOCK TABLES `zp_integration` WRITE;
/*!40000 ALTER TABLE `zp_integration` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_integration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_jobs`
--

DROP TABLE IF EXISTS `zp_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zp_jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_jobs`
--

LOCK TABLES `zp_jobs` WRITE;
/*!40000 ALTER TABLE `zp_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_note`
--

DROP TABLE IF EXISTS `zp_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_note` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_note`
--

LOCK TABLES `zp_note` WRITE;
/*!40000 ALTER TABLE `zp_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_notifications`
--

DROP TABLE IF EXISTS `zp_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `read` int DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moduleId` int DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorId` int DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `userId,datetime` (`userId`,`datetime` DESC),
  KEY `userId,read` (`userId`,`read` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_notifications`
--

LOCK TABLES `zp_notifications` WRITE;
/*!40000 ALTER TABLE `zp_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_plugins`
--

DROP TABLE IF EXISTS `zp_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installdate` datetime DEFAULT NULL,
  `foldername` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homepage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authors` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `format` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_plugins`
--

LOCK TABLES `zp_plugins` WRITE;
/*!40000 ALTER TABLE `zp_plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_projects`
--

DROP TABLE IF EXISTS `zp_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientId` int DEFAULT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `state` int DEFAULT NULL,
  `hourBudget` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dollarBudget` int DEFAULT NULL,
  `active` int DEFAULT NULL,
  `menuType` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `psettings` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `parent` int DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `avatar` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cover` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sortIndex` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_projects`
--

LOCK TABLES `zp_projects` WRITE;
/*!40000 ALTER TABLE `zp_projects` DISABLE KEYS */;
INSERT INTO `zp_projects` VALUES (2,'Blueprint',1,'',NULL,'0',0,NULL,'default','restricted',0,'project',NULL,NULL,'2025-09-09 01:39:23','2025-09-09 01:39:23',NULL,NULL,NULL),(3,'X2',1,'',NULL,'0',0,NULL,'default','restricted',0,'project',NULL,NULL,'2025-09-09 01:40:21','2025-09-09 01:40:21',NULL,NULL,NULL),(4,'Transworld',1,'',NULL,'0',0,NULL,'default','restricted',0,'project',NULL,NULL,'2025-09-09 01:40:38','2025-09-09 01:40:38',NULL,NULL,NULL),(5,'My own projects',2,'',0,'0',0,NULL,'default','restricted',0,'project',NULL,NULL,'2025-09-09 01:41:06','2025-09-09 02:01:30',NULL,NULL,NULL),(6,'General GVM',1,'',NULL,'0',0,NULL,'default','restricted',0,'project',NULL,NULL,'2025-09-09 01:51:07','2025-09-09 01:51:07',NULL,NULL,NULL),(8,'My Project',0,'Welcome to your first project in Leantime!<br />This is your space to organize tasks, track goals, and plan your work. Feel free to modify anything here or create additional projects as you grow. This project is just for you to get started',NULL,'0',0,NULL,'','restricted',NULL,'project',NULL,NULL,'2025-09-09 20:01:22','2025-09-09 20:01:22',NULL,NULL,NULL);
/*!40000 ALTER TABLE `zp_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_punch_clock`
--

DROP TABLE IF EXISTS `zp_punch_clock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_punch_clock` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `minutes` int DEFAULT NULL,
  `hours` int DEFAULT NULL,
  `punchIn` int DEFAULT NULL,
  PRIMARY KEY (`id`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_punch_clock`
--

LOCK TABLES `zp_punch_clock` WRITE;
/*!40000 ALTER TABLE `zp_punch_clock` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_punch_clock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_queue`
--

DROP TABLE IF EXISTS `zp_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_queue` (
  `msghash` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userId` int NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thedate` datetime NOT NULL,
  `projectId` int NOT NULL,
  PRIMARY KEY (`msghash`),
  KEY `projectId` (`projectId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_queue`
--

LOCK TABLES `zp_queue` WRITE;
/*!40000 ALTER TABLE `zp_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_reactions`
--

DROP TABLE IF EXISTS `zp_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_reactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `moduleId` int DEFAULT NULL,
  `module` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reaction` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entity` (`moduleId`,`module`,`reaction`),
  KEY `user` (`userId`,`moduleId`,`module`,`reaction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_reactions`
--

LOCK TABLES `zp_reactions` WRITE;
/*!40000 ALTER TABLE `zp_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_read`
--

DROP TABLE IF EXISTS `zp_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_read` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module` enum('ticket','message') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moduleId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_read`
--

LOCK TABLES `zp_read` WRITE;
/*!40000 ALTER TABLE `zp_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_recurring_patterns`
--

DROP TABLE IF EXISTS `zp_recurring_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_recurring_patterns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entityId` int NOT NULL,
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` int NOT NULL DEFAULT '1',
  `weekDays` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `monthDay` int DEFAULT NULL,
  `months` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'reset',
  `lastProcessed` datetime DEFAULT NULL,
  `nextProcessingDate` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `entityId` (`entityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_recurring_patterns`
--

LOCK TABLES `zp_recurring_patterns` WRITE;
/*!40000 ALTER TABLE `zp_recurring_patterns` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_recurring_patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_relationuserproject`
--

DROP TABLE IF EXISTS `zp_relationuserproject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_relationuserproject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  `wage` int DEFAULT NULL,
  `projectRole` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zp_relationuserproject_projectId_index` (`projectId`),
  KEY `zp_relationuserproject_userId_index` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_relationuserproject`
--

LOCK TABLES `zp_relationuserproject` WRITE;
/*!40000 ALTER TABLE `zp_relationuserproject` DISABLE KEYS */;
INSERT INTO `zp_relationuserproject` VALUES (3,1,2,NULL,''),(4,1,3,NULL,''),(5,1,4,NULL,''),(6,1,5,NULL,''),(7,1,6,NULL,''),(9,2,8,NULL,''),(10,2,8,NULL,''),(11,2,6,NULL,'');
/*!40000 ALTER TABLE `zp_relationuserproject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_settings`
--

DROP TABLE IF EXISTS `zp_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_settings` (
  `key` varchar(175) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`),
  KEY `idx_settings_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_settings`
--

LOCK TABLES `zp_settings` WRITE;
/*!40000 ALTER TABLE `zp_settings` DISABLE KEYS */;
INSERT INTO `zp_settings` VALUES ('companysettings.description','Leantime Project Management'),('companysettings.language','en-US'),('companysettings.messageFrequency','0'),('companysettings.pagetitle','Leantime Project Management'),('companysettings.sitename','Leantime Hudson'),('companysettings.telemetry.active',''),('companysettings.telemetry.anonymousId','068074ea-a823-408c-bef5-2b584f4c5ed4'),('companysettings.telemetry.lastUpdate','2025-09-09'),('db-version','3.4.9'),('user.1.firstLoginCompleted','1'),('user.1.myTodosSorting','[{\"id\":24,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":10,\"groupKey\":\"later\"},{\"id\":40,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":11,\"groupKey\":\"later\"},{\"id\":39,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":12,\"groupKey\":\"later\"},{\"id\":38,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":13,\"groupKey\":\"later\"},{\"id\":37,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":14,\"groupKey\":\"later\"},{\"id\":36,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":15,\"groupKey\":\"later\"},{\"id\":35,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":16,\"groupKey\":\"later\"},{\"id\":34,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":17,\"groupKey\":\"later\"},{\"id\":33,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":18,\"groupKey\":\"later\"},{\"id\":32,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":19,\"groupKey\":\"later\"},{\"id\":31,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":20,\"groupKey\":\"later\"},{\"id\":30,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":21,\"groupKey\":\"later\"},{\"id\":29,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":22,\"groupKey\":\"later\"},{\"id\":28,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":23,\"groupKey\":\"later\"},{\"id\":27,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":24,\"groupKey\":\"later\"},{\"id\":26,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":25,\"groupKey\":\"later\"},{\"id\":25,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":26,\"groupKey\":\"later\"},{\"id\":23,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":27,\"groupKey\":\"later\"},{\"id\":22,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":28,\"groupKey\":\"later\"},{\"id\":20,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":29,\"groupKey\":\"later\"},{\"id\":21,\"parentId\":20,\"parentType\":\"task\",\"level\":1,\"order\":10,\"groupKey\":\"later\"},{\"id\":19,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":30,\"groupKey\":\"later\"},{\"id\":18,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":31,\"groupKey\":\"later\"},{\"id\":17,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":32,\"groupKey\":\"later\"},{\"id\":16,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":33,\"groupKey\":\"later\"},{\"id\":15,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":34,\"groupKey\":\"later\"},{\"id\":14,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":35,\"groupKey\":\"later\"},{\"id\":11,\"parentId\":null,\"parentType\":\"section\",\"level\":0,\"order\":36,\"groupKey\":\"later\"},{\"id\":13,\"parentId\":11,\"parentType\":\"task\",\"level\":1,\"order\":10,\"groupKey\":\"later\"},{\"id\":12,\"parentId\":11,\"parentType\":\"task\",\"level\":1,\"order\":11,\"groupKey\":\"later\"}]'),('user.2.firstLoginCompleted','1'),('usersetting.1.submenuToggle','a:8:{s:41:\"accordion_content-task-children-thisWeek1\";s:6:\"closed\";s:11:\"materialize\";s:4:\"open\";s:10:\"understand\";s:4:\"open\";s:8:\"dataroom\";s:4:\"open\";s:8:\"mainMenu\";s:4:\"open\";s:39:\"accordion_content-ticketBox1-thisWeek-0\";s:4:\"open\";s:10:\"Management\";s:4:\"open\";s:14:\"administration\";s:4:\"open\";}'),('usersetting.2.submenuToggle','a:5:{s:42:\"accordion_content-task-children-thisWeek43\";s:6:\"closed\";s:11:\"materialize\";s:4:\"open\";s:10:\"understand\";s:4:\"open\";s:8:\"dataroom\";s:4:\"open\";s:8:\"mainMenu\";s:4:\"open\";}'),('usersettings.1.colorMode','dark'),('usersettings.1.colorScheme','grayscale2'),('usersettings.1.dashboardGrid','a:4:{i:0;a:14:{s:1:\"x\";s:1:\"0\";s:1:\"y\";s:1:\"0\";s:1:\"w\";s:2:\"12\";s:4:\"minW\";s:1:\"6\";s:4:\"minH\";s:1:\"7\";s:7:\"content\";N;s:2:\"id\";s:7:\"welcome\";s:9:\"widgetUrl\";s:49:\"https://leantime.hhawkins.dev/widgets/welcome/get\";s:13:\"widgetTrigger\";s:8:\"revealed\";s:5:\"gridX\";s:1:\"0\";s:5:\"gridY\";s:1:\"0\";s:9:\"gridWidth\";s:2:\"12\";s:1:\"h\";s:1:\"1\";s:10:\"gridHeight\";s:1:\"1\";}i:1;a:14:{s:1:\"x\";s:1:\"0\";s:1:\"y\";s:1:\"7\";s:1:\"w\";s:1:\"8\";s:1:\"h\";s:2:\"30\";s:4:\"minW\";s:1:\"3\";s:4:\"minH\";s:2:\"16\";s:7:\"content\";N;s:2:\"id\";s:5:\"todos\";s:9:\"widgetUrl\";s:49:\"https://leantime.hhawkins.dev/widgets/myToDos/get\";s:13:\"widgetTrigger\";s:8:\"revealed\";s:5:\"gridX\";s:1:\"0\";s:5:\"gridY\";s:1:\"7\";s:9:\"gridWidth\";s:1:\"8\";s:10:\"gridHeight\";s:2:\"30\";}i:2;a:14:{s:1:\"x\";s:1:\"8\";s:1:\"y\";s:1:\"7\";s:1:\"w\";s:1:\"4\";s:1:\"h\";s:2:\"30\";s:4:\"minW\";s:1:\"3\";s:4:\"minH\";s:2:\"12\";s:7:\"content\";N;s:2:\"id\";s:8:\"calendar\";s:9:\"widgetUrl\";s:50:\"https://leantime.hhawkins.dev/widgets/calendar/get\";s:13:\"widgetTrigger\";s:8:\"revealed\";s:5:\"gridX\";s:1:\"8\";s:5:\"gridY\";s:1:\"7\";s:9:\"gridWidth\";s:1:\"4\";s:10:\"gridHeight\";s:2:\"30\";}i:3;a:14:{s:1:\"x\";s:1:\"0\";s:1:\"y\";s:2:\"43\";s:1:\"w\";s:1:\"8\";s:1:\"h\";s:2:\"22\";s:4:\"minW\";s:1:\"2\";s:4:\"minH\";s:2:\"10\";s:7:\"content\";N;s:2:\"id\";s:10:\"myprojects\";s:9:\"widgetUrl\";s:52:\"https://leantime.hhawkins.dev/widgets/myProjects/get\";s:13:\"widgetTrigger\";s:8:\"revealed\";s:5:\"gridX\";s:1:\"0\";s:5:\"gridY\";s:2:\"43\";s:9:\"gridWidth\";s:1:\"8\";s:10:\"gridHeight\";s:2:\"22\";}}'),('usersettings.1.daySchedule','a:5:{s:6:\"wakeup\";s:0:\"\";s:9:\"workStart\";s:1:\"8\";s:5:\"lunch\";s:2:\"12\";s:7:\"workEnd\";s:2:\"16\";s:3:\"bed\";s:0:\"\";}'),('usersettings.1.lastNewsGuid','https://leantime.io/?p=24566'),('usersettings.1.lastProject','6'),('usersettings.1.messageFrequency','3600'),('usersettings.1.recentProjects','a:7:{i:0;i:6;i:1;i:2;i:2;i:5;i:3;i:7;i:4;i:4;i:5;i:3;i:6;i:1;}'),('usersettings.1.theme','default'),('usersettings.1.themeFont','Shantell Sans'),('usersettings.1.widgetHistory','a:2:{s:5:\"todos\";i:1757381246;s:10:\"myprojects\";i:1757381248;}'),('usersettings.2.colorMode','light'),('usersettings.2.colorScheme','companyColors'),('usersettings.2.daySchedule','a:5:{s:6:\"wakeup\";s:0:\"\";s:9:\"workStart\";s:1:\"8\";s:5:\"lunch\";s:1:\"0\";s:7:\"workEnd\";s:2:\"18\";s:3:\"bed\";s:0:\"\";}'),('usersettings.2.lastNewsGuid','https://leantime.io/?p=24566'),('usersettings.2.lastProject','6'),('usersettings.2.recentProjects','a:2:{i:0;i:6;i:1;i:8;}'),('usersettings.2.theme','default'),('usersettings.2.themeFont','Roboto');
/*!40000 ALTER TABLE `zp_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_sprints`
--

DROP TABLE IF EXISTS `zp_sprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_sprints` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sprints_projectId_startDate_endDate` (`projectId`,`startDate`,`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_sprints`
--

LOCK TABLES `zp_sprints` WRITE;
/*!40000 ALTER TABLE `zp_sprints` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_sprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_stats`
--

DROP TABLE IF EXISTS `zp_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_stats` (
  `sprintId` int DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `sum_todos` int DEFAULT NULL,
  `sum_open_todos` int DEFAULT NULL,
  `sum_progres_todos` int DEFAULT NULL,
  `sum_closed_todos` int DEFAULT NULL,
  `sum_planned_hours` float DEFAULT NULL,
  `sum_estremaining_hours` float DEFAULT NULL,
  `sum_logged_hours` float DEFAULT NULL,
  `sum_points` int DEFAULT NULL,
  `sum_points_done` int DEFAULT NULL,
  `sum_points_progress` int DEFAULT NULL,
  `sum_points_open` int DEFAULT NULL,
  `sum_todos_xs` int DEFAULT NULL,
  `sum_todos_s` int DEFAULT NULL,
  `sum_todos_m` int DEFAULT NULL,
  `sum_todos_l` int DEFAULT NULL,
  `sum_todos_xl` int DEFAULT NULL,
  `sum_todos_xxl` int DEFAULT NULL,
  `sum_todos_none` int DEFAULT NULL,
  `tickets` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `daily_avg_hours_booked_todo` float DEFAULT NULL,
  `daily_avg_hours_booked_point` float DEFAULT NULL,
  `daily_avg_hours_planned_todo` float DEFAULT NULL,
  `daily_avg_hours_planned_point` float DEFAULT NULL,
  `daily_avg_hours_remaining_point` float DEFAULT NULL,
  `daily_avg_hours_remaining_todo` float DEFAULT NULL,
  `sum_teammembers` int DEFAULT NULL,
  KEY `projectId` (`projectId`,`sprintId`),
  KEY `idx_stats_projectId_sprintId_date` (`projectId`,`sprintId`,`date`),
  KEY `idx_stats_sprintId_date` (`sprintId`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_stats`
--

LOCK TABLES `zp_stats` WRITE;
/*!40000 ALTER TABLE `zp_stats` DISABLE KEYS */;
INSERT INTO `zp_stats` VALUES (-1,1,'2025-09-07 00:00:00',8,7,0,1,0,0,NULL,0,0,0,0,0,0,0,0,0,0,8,'2,3,4,5,6,7,8,9',NULL,NULL,0,NULL,NULL,0,1),(-1,5,'2025-09-07 00:00:00',1,1,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,1,'11',NULL,NULL,0,NULL,NULL,0,1),(-1,6,'2025-09-07 00:00:00',1,1,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,1,'14',NULL,NULL,0,NULL,NULL,0,1),(-1,2,'2025-09-07 00:00:00',1,1,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,1,'16',NULL,NULL,0,NULL,NULL,0,1),(-1,3,'2025-09-07 00:00:00',1,1,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,1,'31',NULL,NULL,0,NULL,NULL,0,1),(-1,4,'2025-09-07 00:00:00',1,1,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,1,'32',NULL,NULL,0,NULL,NULL,0,1),(-1,2,'2025-09-08 00:00:00',5,5,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,5,'16,17,18,19,20',NULL,NULL,0,NULL,NULL,0,1),(-1,6,'2025-09-08 00:00:00',12,12,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,12,'14,15,25,26,27,28,29,30,36,37,38,39',NULL,NULL,0,NULL,NULL,0,1),(-1,4,'2025-09-08 00:00:00',3,3,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,3,'32,34,35',NULL,NULL,0,NULL,NULL,0,1),(-1,3,'2025-09-08 00:00:00',2,2,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,2,'31,33',NULL,NULL,0,NULL,NULL,0,1),(-1,5,'2025-09-08 00:00:00',5,5,0,0,0,0,NULL,0,0,0,0,0,0,0,0,0,0,5,'11,22,23,24,40',NULL,NULL,0,NULL,NULL,0,1),(-1,8,'2025-09-08 00:00:00',8,7,0,1,0,0,NULL,0,0,0,0,0,0,0,0,0,0,8,'44,45,46,47,48,49,50,51',NULL,NULL,0,NULL,NULL,0,1);
/*!40000 ALTER TABLE `zp_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_tickethistory`
--

DROP TABLE IF EXISTS `zp_tickethistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_tickethistory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `ticketId` int DEFAULT NULL,
  `changeType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changeValue` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_tickethistory`
--

LOCK TABLES `zp_tickethistory` WRITE;
/*!40000 ALTER TABLE `zp_tickethistory` DISABLE KEYS */;
INSERT INTO `zp_tickethistory` VALUES (1,1,16,'description','<p>https://trello.com/c/C5iOUYoV/54-qr-code-based-attendance-marking</p>','2025-09-09 01:54:51'),(2,1,17,'description','<p>https://trello.com/c/pQMurCp2/149-ability-to-send-email-templates-to-managers?filter=member%3Ahudsonhawkins</p>','2025-09-09 01:55:39'),(3,1,18,'description','<p>https://trello.com/c/vlSzzziY/51-add-a-better-interface-for-upgrade-script-including-patches-this-should-use-the-db-version</p>','2025-09-09 01:56:28'),(4,1,19,'headline','email templates for specific course','2025-09-09 01:57:15'),(5,1,19,'description','<p>https://trello.com/c/g3tQmgNF/53-email-templates-for-specific-course</p>','2025-09-09 01:57:15'),(6,1,21,'priority','5','2025-09-09 01:58:21'),(7,1,16,'priority','5','2025-09-09 01:58:31'),(8,1,17,'priority','3','2025-09-09 01:58:33'),(9,1,18,'priority','3','2025-09-09 01:58:36'),(10,1,19,'priority','3','2025-09-09 01:58:40'),(11,1,20,'priority','2','2025-09-09 01:58:50'),(12,1,21,'priority','1','2025-09-09 01:58:54'),(13,1,32,'description','<p>https://trello.com/c/wghGWjcH/23-review-create-deal-style</p>','2025-09-09 02:05:11'),(14,1,35,'description','<p>https://trello.com/c/NrG4NqIS/6-saving-of-sold-deal-taking-a-very-long-time</p>','2025-09-09 02:07:02'),(15,1,22,'description','<p>Get connected to wifi? guess ill have to edit the thing unless itsn BP</p>','2025-09-09 02:23:36'),(16,1,38,'description','<p>Zapier or N8N for example</p>','2025-09-09 02:25:02'),(17,1,38,'project','6','2025-09-09 02:25:25'),(18,1,40,'description','<pre class=\"language-php\"><code>&lt;?php\r\n// ===== CONFIG =====\r\n$username = \'hhawkins\';   // &lt;-- change for different users\r\n\r\n// ===== DB CONNECT','2025-09-09 02:29:06'),(19,1,25,'description','<p>agentic coder:</p>\r\n<ul>\r\n<li>Github Copilot &mdash; tried</li>\r\n<li>Cursor &mdash; tried</li>\r\n<li>Claude &mdash; needs more</li>\r\n<li>Windsurf &m','2025-09-09 02:34:54'),(20,1,25,'status','4','2025-09-09 17:14:17'),(21,1,28,'status','4','2025-09-09 17:14:36'),(22,1,27,'status','4','2025-09-09 17:16:29'),(23,1,25,'description','<p>Big concerns:<br />Developer Atrophy. Many have noted that their development skills have significantly decreased since introducing AI. Learning cod','2025-09-09 18:01:51'),(24,1,25,'description','<p style=\"text-align: left;\">Big concerns:<br />Developer Atrophy. Many have noted that their development skills have significantly decreased since in','2025-09-09 19:48:53');
/*!40000 ALTER TABLE `zp_tickethistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_tickets`
--

DROP TABLE IF EXISTS `zp_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `acceptanceCriteria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date` datetime DEFAULT NULL,
  `dateToFinish` datetime DEFAULT NULL,
  `priority` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `os` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolution` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dependingTicketId` int DEFAULT NULL,
  `editFrom` datetime DEFAULT NULL,
  `editTo` datetime DEFAULT NULL,
  `editorId` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planHours` float DEFAULT NULL,
  `hourRemaining` float DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production` int DEFAULT '0',
  `staging` int DEFAULT '0',
  `storypoints` float DEFAULT NULL,
  `sprint` int DEFAULT NULL,
  `sortindex` bigint DEFAULT NULL,
  `kanbanSortIndex` bigint DEFAULT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `milestoneid` int DEFAULT NULL,
  `leancanvasitemid` int DEFAULT NULL,
  `retrospectiveid` int DEFAULT NULL,
  `ideaid` int DEFAULT NULL,
  `zp_ticketscol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectUserId` (`projectId`,`userId`),
  KEY `StatusSprint` (`status`,`sprint`),
  KEY `Sorting` (`sortindex`),
  KEY `idx_tickets_editorId` (`editorId`),
  KEY `idx_tickets_milestoneid` (`milestoneid`),
  KEY `idx_tickets_editFrom` (`editFrom`),
  KEY `idx_tickets_editTo` (`editTo`),
  KEY `idx_tickets_dateToFinish` (`dateToFinish`),
  KEY `idx_tickets_modified` (`modified`),
  KEY `idx_tickets_projectId_status` (`projectId`,`status`),
  KEY `idx_tickets_projectId_type` (`projectId`,`type`),
  KEY `idx_tickets_status_type` (`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_tickets`
--

LOCK TABLES `zp_tickets` WRITE;
/*!40000 ALTER TABLE `zp_tickets` DISABLE KEYS */;
INSERT INTO `zp_tickets` VALUES (11,5,'Test OpenVINO Models','','','2025-09-09 01:46:30','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(12,5,'Test Downloader','','','2025-09-08 15:47:54','0000-00-00 00:00:00','3',3,1,NULL,NULL,NULL,NULL,NULL,NULL,11,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'subtask',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(13,5,'Test WebUI','','','2025-09-08 15:48:16','0000-00-00 00:00:00','3',3,1,NULL,NULL,NULL,NULL,NULL,NULL,11,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'subtask',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(14,6,'Make Training Session for Docker','','','2025-09-09 01:52:04','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,1000,'',0,NULL,NULL,NULL,NULL,NULL),(15,6,'Make a Training session for GitLab','','','2025-09-08 15:52:55','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,900,'',0,NULL,NULL,NULL,NULL,NULL),(16,2,'QR Code based attendance marking','<p>https://trello.com/c/C5iOUYoV/54-qr-code-based-attendance-marking</p>','','2025-09-08 15:54:51','0000-00-00 00:00:00','5',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(17,2,'Ability to send email templates to managers','<p>https://trello.com/c/pQMurCp2/149-ability-to-send-email-templates-to-managers?filter=member%3Ahudsonhawkins</p>','','2025-09-08 15:55:39','0000-00-00 00:00:00','3',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(18,2,'add a better interface for upgrade script including patches. This should use the DB version.','<p>https://trello.com/c/vlSzzziY/51-add-a-better-interface-for-upgrade-script-including-patches-this-should-use-the-db-version</p>','','2025-09-08 15:56:28','0000-00-00 00:00:00','3',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(19,2,'email templates for specific course','<p>https://trello.com/c/g3tQmgNF/53-email-templates-for-specific-course</p>','','2025-09-08 15:57:15','0000-00-00 00:00:00','3',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(20,2,'Connect the AI tool to Aleppo, have the AI course builder and the CR tool implemented there the same as on TW and be capable to generate a json file what adapt can read','','','2025-09-09 01:57:47','0000-00-00 00:00:00','2',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(21,2,'Finish AICOURSEGEN','','','2025-09-08 15:58:08','0000-00-00 00:00:00','1',3,1,NULL,NULL,NULL,NULL,NULL,NULL,20,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'subtask',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(22,5,'Setup Raspberry PI','<p>Get connected to wifi? guess ill have to edit the thing unless itsn BP</p>','','2025-09-08 16:23:36','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(23,5,'Setup Immich','','','2025-09-08 16:02:23','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(24,5,'Look at other OSS management tools (like leantime)','','','2025-09-08 16:28:23','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(25,6,'Investigate AI tools for coding','<p style=\"text-align: left;\">Big concerns:<br />Developer Atrophy. Many have noted that their development skills have significantly decreased since introducing AI. Learning code knowledge isnt as core anymore, and while thats just a result of systems changing, many newer devs, or even long time devs dare struggling with issues they previously wouldve been able to handle easily.<br /><br />I myself notice this in myself too, and I think its important we do regular check ins, and keep some goals in mind to keep us in the date coding wise, so we dont get too lost to the point where we are making deals to do stuff assuming AI can do it without having the true knowledge of if its possibble. We need to understand the systems were using. AI should be a supplimentary tool and if youre building something completely new with it, The chances of introducing security issues, breaking other things, removing code thats necessary, adding \'return true\' to a function and then not noticing thats why, and not that it actually got fixed.<br /><br />Many times AI will do things like if you have a test function, instead of fixing the issue it \'fixes\' the test to return true. While you can try to be specific with the AI, the longer you talk, the more context it loses, and the more likely you are to end up with these issues.</p>\r\n<p style=\"text-align: left;\">&nbsp;</p>\r\n<p style=\"text-align: left;\">Data usage:</p>\r\n<p style=\"text-align: left;\">Many AI services automatically use your prompts for training, usually to offset costs, some will only let you use free tier if you do, some even in the lower tiers. I beleive Windsurf is one.</p>\r\n<p style=\"text-align: left;\">&nbsp;</p>\r\n<p style=\"text-align: left;\"><br /><br />Vibe coding:<br />Vibe coding is the concept of building code without touching the code yourself, generally the idea is for people who dont know how to code, they can use these agentic tools to build systems. Some people are quite good at driving this, even without a great core understanding, but thats limited.&nbsp;<br /><br />Differences in services:</p>\r\n<ol>\r\n<li style=\"text-align: left;\">Agentic coder\r\n<ol style=\"list-style-type: lower-alpha;\">\r\n<li style=\"text-align: left;\">Full IDE &mdash; provide their own complete IDE (Often a fork of existing IDE) &mdash; Cursor, Windsurf</li>\r\n<li style=\"text-align: left;\">Extension &mdash; add on to existing IDEs, many full ide also have an option for use on others &mdash; GH Copilot, Continue.dev</li>\r\n<li style=\"text-align: left;\">CLI &mdash; A command line tool that doesnt require the need for an IDE, often works by showing you what its doing live, but you dont have an IDE to move around on, some people swear by this and suggest that it makes it go faster. Claude Code, Gemeni CLI</li>\r\n<li style=\"text-align: left;\">Web Service &mdash; Some connect to a Git repo and will initiate a container and work within that itself, often without letting you edit as you go, but then mnakes a git commit with your changes. Codex, Github Copilot (not codespaces, but assign to agent)</li>\r\n<li style=\"text-align: left;\">Undefined &mdash; Some do things in their own way, such as Warp, or Replit, which also spin up their own env, and work on that</li>\r\n</ol>\r\n</li>\r\n<li style=\"text-align: left;\">Chat Service &mdash; Service that you chat to, can provide you code, or code blocks, but doesnt have your work as context.&nbsp;</li>\r\n</ol>\r\n<p style=\"text-align: left;\">Its also important to note that in general, What you are paying for is Add ons, Premium requests, or the AI itself. Many allow BYO key, meaning if you enter an API key, you dont have to pay them. However, in almost all use cases, BYO API calls will be more expensive.</p>\r\n<p style=\"text-align: left;\">&nbsp;</p>\r\n<p style=\"text-align: left;\">Agents often Index your codebase, basically build its own links between sections such that its much easier for the AI to try to get the correct context. Usually this can be seen in the settings.</p>\r\n<p style=\"text-align: left;\"><br /><br />agentic coder:</p>\r\n<ul style=\"text-align: left;\">\r\n<li>Github Copilot &mdash; tried</li>\r\n<li style=\"text-align: left;\">Cursor &mdash; tried</li>\r\n<li>Claude &mdash; needs more</li>\r\n<li>Windsurf &mdash; needs more</li>\r\n<li>Jebrains &mdash; Unlikely (too different)</li>\r\n<li>Duo</li>\r\n<li>Warp</li>\r\n<li>Amazon Q</li>\r\n<li>Amazon Kiro</li>\r\n<li>Gemeni Cli</li>\r\n<li>Continue.dev</li>\r\n<li>Devin</li>\r\n<li>Junie</li>\r\n</ul>\r\n<p style=\"text-align: left;\">agent name? seems interesting</p>\r\n<ul style=\"text-align: left;\">\r\n<li>https://www.mozilla.ai/any-agent</li>\r\n</ul>\r\n<p style=\"text-align: left;\">Extenitions:</p>\r\n<ul style=\"text-align: left;\">\r\n<li>MCP</li>\r\n<li>Spec Kit</li>\r\n<li><a href=\"https://www.mozilla.ai/lumigator\" target=\"_blank\" rel=\"noopener\">https://www.mozilla.ai/lumigator</a></li>\r\n</ul>\r\n<p style=\"text-align: left;\">Some tools allow secrets like cursor, which allows you to hide files from it, however, if it has terminal access, it can still go cat &gt; secretfile.txt So be careful. Ideally secrets shouldnt be in your development environment. AI shouldnt be used in prod, unless its a GVM hosted AI (not in the pipeline, though not entirely impossible we may intigrate something at some point, at least for code completions possibly.)<br /><br />Others, like VSCode have a workaround, where you can hide the entire file from vscode in the settings.json, hoever that means you cant see it in your IDE either.<br /><br />MCP (Model Context Protocol):<br />AIs in general can do some tasks normally, this is handled on the providers side. you send a request and it decides \'the user wants to search this, run a search, then add that to the AI prompt\'<br /><br />In the case of MCP when you make a prompt, it also sends your defined MCP tools. so it tells the AI \'youre allowed to use these tools\' where the tools can be \'browser open url\' or \'search for boards on Trello\' or even \'store memory\' which come along with deeper descriptions.<br /><br />When the AI recieves your prompt and also its allowed tools and description on what they are, it can make the decisions \'use x tool\' It then can do that task, and the response gets sent back to the AI, which can then respond back ect.<br /><br />There is an MCP called Sequential thinking, which allows the AI to go back and forth with itself to figure things out. Its one of the most popular.<br /><br />The MCP itself runs as a small server on your machine, its not AI itself, but its like a little node server that has a defined structure that Copilot knows how to append to your prompt.<br /><br /><br />AI is developing incredibly fast. There is new products every few days, often groundbreaking.<br /><br />Unfortunately theres also a lot of crap. Companies have found that AI inflates stock prices. You introduce a company, get a lot of investors and then just dump. Businesses are vastly out of their own depth, and are using it as a cash grab. We need to be incredibly careful in this space, and need to keep our eyes on the ball. AI is a supplimentary tool, it is not a replacement for knowledge. Otherwise, if we are just using AI, we arent doing anything that 10 million others minimum could do. What we have is knowledgable staff in ishti and peter on core systems, as well as a fair general understanding of web code in general. Dont let AI make us complacent, even as it gets better, and doesnt make as many mistakes, you need to keep learning about the core, so when you need to know how to do a project you can.<br /><br /></p>','','2025-09-09 09:48:53','0000-00-00 00:00:00','',4,1,NULL,NULL,NULL,NULL,NULL,NULL,41,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(26,6,'Build Security Standards','','','2025-09-09 02:03:21','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,800,'',0,NULL,NULL,NULL,NULL,NULL),(27,6,'Learn Docker','','','2025-09-09 07:17:23','0000-00-00 00:00:00','',4,1,NULL,NULL,NULL,NULL,NULL,NULL,14,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,200,'',0,NULL,NULL,NULL,NULL,NULL),(28,6,'Learn Github','','','2025-09-09 07:16:59','0000-00-00 00:00:00','',4,1,NULL,NULL,NULL,NULL,NULL,NULL,15,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,100,'',0,NULL,NULL,NULL,NULL,NULL),(29,6,'Learn Kubernetes/k8/k3/gitpod','','','2025-09-09 02:03:54','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,700,'',0,NULL,NULL,NULL,NULL,NULL),(30,6,'Learn ByteBase','','','2025-09-09 02:04:01','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,600,'',0,NULL,NULL,NULL,NULL,NULL),(31,3,'Propperly set up external users for Gitlab','','','2025-09-09 02:04:36','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(32,4,'Review Create deal style','<p>https://trello.com/c/wghGWjcH/23-review-create-deal-style</p>','','2025-09-08 16:05:11','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(33,3,'Discuss propper git workflow','','','2025-09-09 02:05:44','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(34,4,'Deal Team Missing Agent Notification','','','2025-09-09 02:06:29','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(35,4,'Saving of Sold Deal taking a very long time','<p>https://trello.com/c/NrG4NqIS/6-saving-of-sold-deal-taking-a-very-long-time</p>','','2025-09-08 16:07:02','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(36,6,'Gitlab CI/CD setup','','','2025-09-09 02:07:51','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,500,'',0,NULL,NULL,NULL,NULL,NULL),(37,6,'Investigate Custom SSO','<p>Like Keycloak</p>','','2025-09-08 16:22:05','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,400,'',0,NULL,NULL,NULL,NULL,NULL),(38,6,'Create Middleman between GVM Instances','<p>Zapier or N8N for example</p>','','2025-09-08 16:25:06','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,300,'',0,NULL,NULL,NULL,NULL,NULL),(39,6,'Update Bookstack on BP/Docker/Adapt/AI/MCP ect','','','2025-09-09 02:26:11','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,200,'',0,NULL,NULL,NULL,NULL,NULL),(40,5,'Use tool to intigrate with Timesheets ect','<pre class=\"language-php\"><code>&lt;?php\r\n// ===== CONFIG =====\r\n$username = \'hhawkins\';   // &lt;-- change for different users\r\n\r\n// ===== DB CONNECTION =====\r\n$pdo = new PDO(\r\n    \'mysql:host=localhost;dbname=x2engine;charset=utf8\',\r\n    \'your_db_user\',\r\n    \'your_db_pass\',\r\n    [PDO::ATTR_ERRMODE =&gt; PDO::ERRMODE_EXCEPTION]\r\n);\r\n\r\n// ===== STEP 1: Get c_user ID from employees =====\r\n$stmt = $pdo-&gt;prepare(\"SELECT id FROM x2_employees WHERE c_user = :username LIMIT 1\");\r\n$stmt-&gt;execute([\':username\' =&gt; $username]);\r\n$employee = $stmt-&gt;fetch(PDO::FETCH_ASSOC);\r\n\r\nif (!$employee) {\r\n    die(\"No employee found for username $username\");\r\n}\r\n$cUserId = $employee[\'id\'];\r\n\r\n// ===== STEP 2: Pull ALL active projects + their tasks in one call =====\r\n$sql = \"\r\n    SELECT \r\n        p.id AS project_id,\r\n        p.name AS project_name,\r\n        CONCAT(p.name, \'_\', p.id) AS project_string,\r\n        t.id AS task_id,\r\n        t.name AS task_name,\r\n        CONCAT(t.name, \'_\', t.id) AS task_string\r\n    FROM x2_project p\r\n    JOIN x2_task t ON t.c_Project = p.nameId\r\n    JOIN x2_allocations a ON t.nameId = a.c_task\r\n    WHERE a.c_user = :cuser\r\n      AND p.c_status = \'Active\'\r\n    ORDER BY p.name, t.name\r\n\";\r\n\r\n$stmt = $pdo-&gt;prepare($sql);\r\n$stmt-&gt;execute([\':cuser\' =&gt; $cUserId]);\r\n$rows = $stmt-&gt;fetchAll(PDO::FETCH_ASSOC);\r\n\r\n// ===== STEP 3: Group tasks under projects in PHP =====\r\n$projects = [];\r\nforeach ($rows as $row) {\r\n    $pid = $row[\'project_id\'];\r\n    if (!isset($projects[$pid])) {\r\n        $projects[$pid] = [\r\n            \'project_id\'     =&gt; $row[\'project_id\'],\r\n            \'project_name\'   =&gt; $row[\'project_name\'],\r\n            \'project_string\' =&gt; $row[\'project_string\'],\r\n            \'tasks\'          =&gt; []\r\n        ];\r\n    }\r\n    $projects[$pid][\'tasks\'][] = [\r\n        \'task_id\'     =&gt; $row[\'task_id\'],\r\n        \'task_name\'   =&gt; $row[\'task_name\'],\r\n        \'task_string\' =&gt; $row[\'task_string\']\r\n    ];\r\n}\r\n\r\n// ===== STEP 4: Output =====\r\necho \"&lt;h1&gt;Projects + Tasks for $username (c_user=$cUserId)&lt;/h1&gt;\";\r\n\r\necho \"&lt;form&gt;\";\r\necho \"&lt;select name=\'project\'&gt;\";\r\nforeach ($projects as $project) {\r\n    echo \"&lt;optgroup label=\'\" . htmlspecialchars($project[\'project_name\']) . \"\'&gt;\";\r\n    foreach ($project[\'tasks\'] as $task) {\r\n        $value = $project[\'project_string\'] . \'|\' . $task[\'task_string\'];\r\n        echo \"&lt;option value=\'\" . htmlspecialchars($value) . \"\'&gt;\"\r\n            . htmlspecialchars($project[\'project_name\'] . \' &rarr; \' . $task[\'task_name\'])\r\n            . \"&lt;/option&gt;\";\r\n    }\r\n    echo \"&lt;/optgroup&gt;\";\r\n}\r\necho \"&lt;/select&gt;\";\r\necho \"&lt;/form&gt;\";\r\n</code></pre>','','2025-09-08 16:29:10','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(41,6,'Demonstrate and get feedback on AI tools','','','2025-09-09 17:13:16','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,100,'',0,NULL,NULL,NULL,NULL,NULL),(42,6,'Improve Systems','','','2025-09-09 17:15:06','0000-00-00 00:00:00','',3,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','1',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL),(43,8,'🚀 Getting Started','','','2025-09-09 10:01:22','0000-00-00 00:00:00','3',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-09-09 00:01:22','2025-09-23 00:01:22','2',0,0,'milestone',0,0,0,0,0,0,'#124F7D',0,NULL,NULL,NULL,NULL,NULL),(44,8,'💬 Join our community chat','Our community chat is a great resource to ask questions and get feedback on project set up. <a href=\"https://discord.gg/4zMzJtAq9z\" target=\"_blank\">Community Chat</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(45,8,'👥 Invite your team mates','Whether you are working with someone or just need an accountability buddy. Using Leantime as a group helps to stay on track and motivated <a href=\"https://leantime.hhawkins.dev/users/showAll\">User Management</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(46,8,'🎯 Learn More about Leantime\'s Project Structure','We have a lot of additional resources on our help documentation. To learn more about project structure in Leantime and best practices visit: <a href=\"https://support.leantime.io/en/article/getting-started-in-leantime-an-introduction-to-setting-structure-to-the-work-14t1qip/\" target=\"_blank\">https://help.leantime.io</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(47,8,'🎯 Create a Goal','Goals are used to track and measure long term objectives. They should be measurable using metrics you can update on a regular basis. Goals and Milestones can be connected to view the execution progress while viewing the metric progress <a href=\"https://leantime.hhawkins.dev/goalcanvas/dashboard\">Project Goals</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(48,8,'🚩 Create a Milestone','Milestones allow you to categorize phases of your projects into discrete outcomes. Each milestone has a start and end date and should deliver some output <a href=\"https://leantime.hhawkins.dev/tickets/roadmap/\">Project Milestone</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(49,8,'🗺️ Explore your Personal Project','Your personal project is a space where you can organize your tasks, goals and work. You can access it via the project selector on the top or by clicking this link here: <a href=\"https://leantime.hhawkins.dev/projects/changeCurrentProject/8/\">My Project</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(50,8,'🖼️ Complete my Leantime profile','Update profile picture and complete work preferences to personalize my experience. <a href=\"https://leantime.hhawkins.dev/users/editOwn/\">My Profile</a>','','2025-09-09 20:01:22','2025-09-10 13:59:59','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(51,8,'📌 Create your first task','','','2025-09-09 20:01:22','2025-09-09 10:01:22','',0,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',43,NULL,NULL,NULL,NULL,NULL),(52,8,'eat dinner','','','2025-09-09 20:01:41','0000-00-00 00:00:00','',3,2,NULL,NULL,NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2',0,0,'task',0,0,0,0,0,0,'',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `zp_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_timesheets`
--

DROP TABLE IF EXISTS `zp_timesheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_timesheets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `ticketId` int DEFAULT NULL,
  `workDate` datetime DEFAULT NULL,
  `hours` float DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `kind` varchar(175) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoicedEmpl` int DEFAULT NULL,
  `invoicedComp` int DEFAULT NULL,
  `invoicedEmplDate` datetime DEFAULT NULL,
  `invoicedCompDate` datetime DEFAULT NULL,
  `rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` int DEFAULT NULL,
  `paidDate` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique` (`userId`,`ticketId`,`workDate`,`kind`),
  KEY `idx_timesheets_ticketId` (`ticketId`),
  KEY `idx_timesheets_userId_workDate` (`userId`,`workDate`),
  KEY `idx_timesheets_ticketId_workDate` (`ticketId`,`workDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_timesheets`
--

LOCK TABLES `zp_timesheets` WRITE;
/*!40000 ALTER TABLE `zp_timesheets` DISABLE KEYS */;
/*!40000 ALTER TABLE `zp_timesheets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zp_user`
--

DROP TABLE IF EXISTS `zp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zp_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(175) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `profileId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `lastlogin` datetime DEFAULT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A',
  `expires` datetime DEFAULT NULL,
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sessiontime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wage` int DEFAULT NULL,
  `hours` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `clientId` int DEFAULT NULL,
  `notifications` int DEFAULT NULL,
  `pwReset` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pwResetExpiration` datetime DEFAULT NULL,
  `pwResetCount` int DEFAULT NULL,
  `forcePwReset` tinyint DEFAULT NULL,
  `lastpwd_change` datetime DEFAULT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `twoFAEnabled` tinyint(1) DEFAULT '0',
  `twoFASecret` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `source` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jobTitle` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jobLevel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_user_clientId` (`clientId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zp_user`
--

LOCK TABLES `zp_user` WRITE;
/*!40000 ALTER TABLE `zp_user` DISABLE KEYS */;
INSERT INTO `zp_user` VALUES (1,'hhawkins97@proton.me','$2y$10$RdnCcILflq8sLY6wS/pII.mUTNelWAjaTFAENfh6Q1WUsbyf1Zu/O','Hudson','Hawkins','0487745091','1','2025-09-09 07:12:06','A',NULL,'50','yoCPHSQkqtfib9oDZTGU6PYDyC5pHhySRUzkAMlM','1757401926',0,0,NULL,0,0,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','a:11:{s:8:\"language\";s:5:\"en-US\";s:8:\"timezone\";s:19:\"Australia/Melbourne\";s:11:\"date_format\";s:5:\"m/d/Y\";s:11:\"time_format\";s:5:\"h:i A\";s:6:\"modals\";a:7:{s:17:\"homeDashboardTour\";i:1;s:4:\"home\";s:1:\"1\";s:10:\"newProject\";i:1;s:7:\"roadmap\";i:1;s:20:\"projectDashboardTour\";i:1;s:16:\"projectDashboard\";s:1:\"1\";s:6:\"kanban\";s:1:\"1\";}s:13:\"submenuToggle\";a:8:{s:41:\"accordion_content-task-children-thisWeek1\";s:6:\"closed\";s:11:\"materialize\";s:4:\"open\";s:10:\"understand\";s:4:\"open\";s:8:\"dataroom\";s:4:\"open\";s:8:\"mainMenu\";s:4:\"open\";s:39:\"accordion_content-ticketBox1-thisWeek-0\";s:4:\"open\";s:10:\"Management\";s:4:\"open\";s:14:\"administration\";s:4:\"open\";}s:6:\"colors\";a:2:{s:14:\"secondaryColor\";s:7:\"#000000\";s:12:\"primaryColor\";s:7:\"#d1d1d1\";}s:5:\"theme\";s:7:\"default\";s:9:\"colorMode\";s:4:\"dark\";s:11:\"colorScheme\";s:10:\"grayscale2\";s:9:\"themeFont\";s:13:\"Shantell Sans\";}',0,NULL,'2025-09-08 15:08:41',NULL,'Senior Developer','','','2025-09-09 17:12:11'),(2,'phawkins@gvmedia.com.au','$2y$10$fxylH4aLRnQspyRIQ74MQ.CJmeiXwfFjEiX9K3F1kkB1wQ9tW8XhG','Peter','','','','2025-09-09 10:01:22','a',NULL,'40','B40XFrJ62i6SAwug7LgrLK32gHIf795g2DtuTSNw','1757412082',0,0,NULL,0,1,NULL,NULL,NULL,NULL,NULL,'a:11:{s:8:\"language\";s:5:\"en-US\";s:8:\"timezone\";s:19:\"Australia/Melbourne\";s:11:\"date_format\";s:5:\"m/d/Y\";s:11:\"time_format\";s:5:\"h:i A\";s:6:\"modals\";a:3:{s:17:\"homeDashboardTour\";i:1;s:4:\"home\";i:1;s:15:\"myWorkDashboard\";s:1:\"1\";}s:13:\"submenuToggle\";a:0:{}s:5:\"theme\";s:7:\"default\";s:9:\"colorMode\";s:5:\"light\";s:11:\"colorScheme\";s:13:\"companyColors\";s:6:\"colors\";a:2:{s:12:\"primaryColor\";s:7:\"#006d9f\";s:14:\"secondaryColor\";s:7:\"#00a886\";}s:9:\"themeFont\";s:6:\"Roboto\";}',0,NULL,'2025-09-09 19:57:56','','Dad','','','2025-09-09 20:03:35');
/*!40000 ALTER TABLE `zp_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-09 10:32:17
