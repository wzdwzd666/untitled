-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: canteen_design
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `canteen_id` int DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  KEY `canteen_id_idx` (`canteen_id`),
  CONSTRAINT `ac` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','lbw','123',NULL),(2,'666','华哥','123',1),(17,'777','刘翔','123',2),(18,'888','小叮咚','123',5),(20,'555','五五开','123',4),(21,'999','刘十六','123',22);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canteen`
--

DROP TABLE IF EXISTS `canteen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canteen` (
  `canteen_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `start_time` varchar(45) DEFAULT NULL,
  `end_time` varchar(45) DEFAULT NULL,
  `info` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`canteen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canteen`
--

LOCK TABLES `canteen` WRITE;
/*!40000 ALTER TABLE `canteen` DISABLE KEYS */;
INSERT INTO `canteen` VALUES (1,'一食堂','07:00','22:00','位于四宿舍之后，主要有自选套餐和面包房'),(2,'二食堂','08:00','19:00','两层楼，分为学生食堂和教师食堂'),(4,'五食堂','07:05','21:05','靠近三公一'),(5,'思餐厅','07:08','19:08','位于南校区'),(22,'四食堂','06:36','21:36','基础学院');
/*!40000 ALTER TABLE `canteen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canteen_evaluate`
--

DROP TABLE IF EXISTS `canteen_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canteen_evaluate` (
  `canteen_evaluate_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `canteen_id` int DEFAULT NULL,
  `content` varchar(45) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `reply_admin_id` int DEFAULT NULL,
  `reply_content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`canteen_evaluate_id`),
  KEY `canteen_id_idx` (`canteen_id`),
  KEY `ceu_idx` (`user_id`),
  KEY `cea_idx` (`reply_admin_id`),
  CONSTRAINT `cea` FOREIGN KEY (`reply_admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cec` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ceu` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canteen_evaluate`
--

LOCK TABLES `canteen_evaluate` WRITE;
/*!40000 ALTER TABLE `canteen_evaluate` DISABLE KEYS */;
INSERT INTO `canteen_evaluate` VALUES (1,1,1,'哈哈哈哈哈哈',6,1,'777'),(2,2,2,'eeeeee',NULL,17,'1234235'),(3,2,1,'ffffff',NULL,2,'谢谢'),(6,4,1,'fffffff',4,NULL,NULL),(7,3,1,'888888',5,NULL,NULL),(11,3,22,'8688',3,NULL,NULL);
/*!40000 ALTER TABLE `canteen_evaluate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaint` (
  `complaint_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `canteen_id` int DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `reply_content` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`complaint_id`),
  KEY `cc_idx` (`canteen_id`),
  KEY `ca_idx` (`admin_id`),
  CONSTRAINT `ca` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cu` FOREIGN KEY (`complaint_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (1,1,1,'2023-12-23 12:24:30','不行不行',2,'gggggg');
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuisine`
--

DROP TABLE IF EXISTS `cuisine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuisine` (
  `cuisine_name` varchar(50) NOT NULL,
  PRIMARY KEY (`cuisine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuisine`
--

LOCK TABLES `cuisine` WRITE;
/*!40000 ALTER TABLE `cuisine` DISABLE KEYS */;
INSERT INTO `cuisine` VALUES ('小吃'),('水果'),('素菜'),('荤菜'),('面点'),('面食');
/*!40000 ALTER TABLE `cuisine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `canteen_id` int DEFAULT NULL,
  `cuisine` varchar(45) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `recommend` varchar(45) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `fca_idx` (`canteen_id`),
  KEY `fcu_idx` (`cuisine`),
  CONSTRAINT `fca` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fcu` FOREIGN KEY (`cuisine`) REFERENCES `cuisine` (`cuisine_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'煎饼果子',1,'小吃','/untitled_war_exploded/assets/image/food/R.png','10','推荐','2023-12-25 12:30:30'),(7,'炒青菜',1,'素菜','/untitled_war_exploded/assets/image/food/R.jfif\r\n','2','推荐','2023-12-31 00:18:31'),(9,'5555',2,'面食','/untitled_war_exploded/assets/image/food/R.png\r\n','5',NULL,NULL),(11,'香蕉',2,'水果','/untitled_war_exploded/assets/image/food/R-C.jfif\r\n','7','推荐','2024-01-02 13:19:04');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_evaluate`
--

DROP TABLE IF EXISTS `food_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_evaluate` (
  `food_evaluate_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `reply_admin_id` int DEFAULT NULL,
  `reply_content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`food_evaluate_id`),
  KEY `feu_idx` (`user_id`),
  KEY `fef_idx` (`food_id`),
  KEY `fea_idx` (`reply_admin_id`),
  CONSTRAINT `fea` FOREIGN KEY (`reply_admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fef` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feu` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_evaluate`
--

LOCK TABLES `food_evaluate` WRITE;
/*!40000 ALTER TABLE `food_evaluate` DISABLE KEYS */;
/*!40000 ALTER TABLE `food_evaluate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_info`
--

DROP TABLE IF EXISTS `like_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_info` (
  `like_info_id` int NOT NULL AUTO_INCREMENT,
  `topic_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`like_info_id`),
  KEY `lit_idx` (`topic_id`),
  KEY `liu_idx` (`user_id`),
  CONSTRAINT `lit` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`topic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `liu` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_info`
--

LOCK TABLES `like_info` WRITE;
/*!40000 ALTER TABLE `like_info` DISABLE KEYS */;
INSERT INTO `like_info` VALUES (1,1,1),(46,1,3),(48,4,3),(49,NULL,3),(50,NULL,3),(51,NULL,3),(52,NULL,3),(53,18,3);
/*!40000 ALTER TABLE `like_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`notice_id`),
  KEY `na_idx` (`admin_id`),
  CONSTRAINT `na` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,2,'打折','2023-12-23 12:30:30','打七折');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic` (
  `topic_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `image` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `tu_idx` (`user_id`),
  CONSTRAINT `tu` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,1,'2023-12-23 12:30:30','哈哈哈','/untitled_war_exploded/assets/image/topic/topic1.webp'),(4,3,'2024-01-01 16:34:53','66666666','/untitled_war_exploded/assets/image/topic/32563269_164251689102_2.jpg\r\n'),(5,3,'2024-01-01 16:57:54','222','/untitled_war_exploded/assets/image/topic/topic2.jpg'),(18,3,'2024-01-02 01:58:54','9999999',NULL);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_evaluate`
--

DROP TABLE IF EXISTS `topic_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic_evaluate` (
  `topic_evaluate_id` int NOT NULL AUTO_INCREMENT,
  `topic_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`topic_evaluate_id`),
  KEY `tpt_idx` (`topic_id`),
  KEY `tpu_idx` (`user_id`),
  CONSTRAINT `tpt` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`topic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tpu` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_evaluate`
--

LOCK TABLES `topic_evaluate` WRITE;
/*!40000 ALTER TABLE `topic_evaluate` DISABLE KEYS */;
INSERT INTO `topic_evaluate` VALUES (1,1,1,'2023-12-28 16:30:27','好好好'),(3,1,3,'2024-01-01 03:28:13','777777'),(4,4,3,'2024-01-01 16:45:01','1111111');
/*!40000 ALTER TABLE `topic_evaluate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'123','张三','123','学生'),(2,'1','李四','123','学生'),(3,'111','张三丰','123','老师'),(4,'12','小叮当','123','老师'),(6,'121','王五','123','学生');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'canteen_design'
--

--
-- Dumping routines for database 'canteen_design'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-02 13:31:28
