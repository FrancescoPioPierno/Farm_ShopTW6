-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: flask_db
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `addproduct`
--

DROP TABLE IF EXISTS `addproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addproduct` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` int DEFAULT NULL,
  `stock` int NOT NULL,
  `desc` text NOT NULL,
  `pub_date` datetime NOT NULL,
  `brand_id` int NOT NULL,
  `category_id` int NOT NULL,
  `image_1` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `addproduct_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`),
  CONSTRAINT `addproduct_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addproduct`
--

LOCK TABLES `addproduct` WRITE;
/*!40000 ALTER TABLE `addproduct` DISABLE KEYS */;
INSERT INTO `addproduct` VALUES (2,'Pesto genovese',5.50,2,30,'Basilico, pinoli, aglio, parmigiano, sale e olio extra vergine di oliva: è questa la ricetta della salsa verde più famosa al mondo. Il pesto alla genovese, con i suoi ingredienti semplici e genuini, è senza dubbio uno dei prodotti che ha contributo alla diffusione e alla conoscenza delle tipicità liguri nel mondo. ','2021-05-29 09:47:11',2,3,'2ec9416042e88d855b51.jpg'),(3,'Orecchiette',3.00,5,15,'Altra prova','2021-05-29 10:34:50',2,1,'b5c369f22d223a6c9c1d.jpg'),(6,'Miele castagno',5.00,0,15,'prova miele','2021-05-30 12:01:30',5,4,'6d93649be3e0f8868687.jpg'),(7,'Pesto genovese',4.00,10,30,'Prova pesto','2021-05-30 12:03:53',1,3,'2a63ab7fe6cd25252bdd.jpg'),(9,'Pesto pistacchio',4.00,0,15,'Prova pesto','2021-05-30 16:51:45',5,3,'c65df8e46964533b3431.jpg'),(10,'Miele Acacia',4.00,0,15,'Prova miele','2021-05-31 15:26:37',5,4,'8b95ceef7b41fbf9e013.jpg'),(11,'Olio d\'oliva',3.00,0,15,'Prova olio','2021-05-31 15:29:47',2,7,'8c807d4b8b7488b74b34.jpg'),(12,'Olio di semi',3.00,0,40,'Prova olio','2021-05-31 15:31:40',5,7,'6b5c484c1bdf421121b9.jpg'),(15,'Miele di Girasole',5.00,0,15,'Prova miele','2021-06-09 08:30:40',5,4,'630ebf4d4f3e9f14cc5a.jpg');
/*!40000 ALTER TABLE `addproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Barilla'),(2,'Garofalo'),(5,'Natural');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (4,'Miele'),(7,'Olio'),(1,'Pasta'),(3,'Pesto');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `customer_id` int NOT NULL,
  `date_created` datetime NOT NULL,
  `orders` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice` (`invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` VALUES (1,'3becfc81dd','In pagamento',1,'2021-06-03 18:52:46','{\'3\': {\'discount\': 5, \'image\': \'b5c369f22d223a6c9c1d.jpg\', \'name\': \'Orecchiette\', \'price\': 3.0, \'quantity\': 1}, \'6\': {\'discount\': 0, \'image\': \'6d93649be3e0f8868687.jpg\', \'name\': \'Miele castagno\', \'price\': 5.0, \'quantity\': 1}, \'7\': {\'discount\': 0, \'image\': \'2a63ab7fe6cd25252bdd.jpg\', \'name\': \'Pesto genovese\', \'price\': 4.0, \'quantity\': 1}}'),(2,'2a6b87f105','In pagamento',1,'2021-06-03 18:58:02','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"11\": {\"discount\": 0, \"image\": \"8c807d4b8b7488b74b34.jpg\", \"name\": \"Olio d\'oliva\", \"price\": 3.0, \"quantity\": 1}, \"12\": {\"discount\": 0, \"image\": \"6b5c484c1bdf421121b9.jpg\", \"name\": \"Olio di semi\", \"price\": 3.0, \"quantity\": 1}}'),(3,'d9d7d09a95','In pagamento',4,'2021-06-03 18:59:05','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(4,'b9e4e69675','In pagamento',1,'2021-06-03 19:12:35','{\"2\": {\"discount\": 2, \"image\": \"2ec9416042e88d855b51.jpg\", \"name\": \"Pesto genovese\", \"price\": 5.0, \"quantity\": 3}, \"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}}'),(5,'71d8a9ed7e','In pagamento',1,'2021-06-03 19:54:37','{\"11\": {\"discount\": 0, \"image\": \"8c807d4b8b7488b74b34.jpg\", \"name\": \"Olio d\'oliva\", \"price\": 3.0, \"quantity\": 1}, \"12\": {\"discount\": 0, \"image\": \"6b5c484c1bdf421121b9.jpg\", \"name\": \"Olio di semi\", \"price\": 3.0, \"quantity\": 1}}'),(6,'eee07e610c','In pagamento',1,'2021-06-04 07:56:33','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(7,'2c272c3283','In pagamento',1,'2021-06-04 07:56:38','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(8,'4ad96355d0','In pagamento',1,'2021-06-04 07:57:41','{\"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(9,'08adfc3bb4','In pagamento',1,'2021-06-04 08:09:19','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(10,'3f27232d1e','In pagamento',1,'2021-06-04 08:11:26','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(11,'a702ee4b31','In pagamento',1,'2021-06-04 08:12:01','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(12,'7a7002f017','In pagamento',1,'2021-06-04 08:12:08','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"11\": {\"discount\": 0, \"image\": \"8c807d4b8b7488b74b34.jpg\", \"name\": \"Olio d\'oliva\", \"price\": 3.0, \"quantity\": 1}}'),(13,'41731b3875','In pagamento',1,'2021-06-04 08:17:31','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"13\": {\"discount\": 0, \"image\": \"56f12ddd8ef3f5663652.jpg\", \"name\": \"Miele di Girasole\", \"price\": 4.0, \"quantity\": 1}}'),(14,'e7c18e748b','In pagamento',1,'2021-06-04 08:23:28','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}}'),(15,'517f920cd4','In pagamento',1,'2021-06-04 08:27:22','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(16,'ededf0a962','In pagamento',6,'2021-06-04 08:31:39','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(17,'989b3c8941','In pagamento',6,'2021-06-04 08:35:08','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(18,'d5496291d8','In pagamento',6,'2021-06-04 08:49:04','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": \"3\"}}'),(19,'8b3d398eab','In pagamento',8,'2021-06-04 09:50:19','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": \"2\"}}'),(20,'a822ae7a61','In pagamento',6,'2021-06-04 11:29:05','{\"11\": {\"discount\": 0, \"image\": \"8c807d4b8b7488b74b34.jpg\", \"name\": \"Olio d\'oliva\", \"price\": 3.0, \"quantity\": 1}, \"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"7\": {\"discount\": 0, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(21,'d35d24b113','In pagamento',6,'2021-06-04 11:42:35','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 2}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 3}}'),(22,'97783d1e3e','In pagamento',6,'2021-06-04 14:21:58','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(23,'edb550d8f8','In pagamento',9,'2021-06-05 14:11:55','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": \"4\"}, \"7\": {\"discount\": 10, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(24,'3259f4cda4','In pagamento',9,'2021-06-05 14:13:43','{\"2\": {\"discount\": 2, \"image\": \"2ec9416042e88d855b51.jpg\", \"name\": \"Pesto genovese\", \"price\": 5.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(25,'7b635e8b76','In pagamento',1,'2021-06-07 17:56:37','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(26,'03d5642113','In pagamento',1,'2021-06-07 18:18:57','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"11\": {\"discount\": 0, \"image\": \"8c807d4b8b7488b74b34.jpg\", \"name\": \"Olio d\'oliva\", \"price\": 3.0, \"quantity\": 1}}'),(27,'2fba1836eb','In pagamento',1,'2021-06-08 11:49:26','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 2}}'),(28,'8896365e12','In pagamento',1,'2021-06-08 11:51:59','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}}'),(29,'42d6d06108','In pagamento',1,'2021-06-08 13:07:55','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(30,'6859fb535d','In pagamento',1,'2021-06-08 14:05:17','{\"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}}'),(31,'6e65f0c73e','In pagamento',1,'2021-06-08 14:58:43','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 10, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(32,'0cb5c5a8b3','In pagamento',1,'2021-06-08 18:42:58','{\"14\": {\"discount\": 0, \"image\": \"0dd477db396a0fe1e71a.jpg\", \"name\": \"Miele di girasole\", \"price\": 5.0, \"quantity\": 3}}'),(33,'ec60b12591','In pagamento',10,'2021-06-09 08:42:00','{\"10\": {\"discount\": 0, \"image\": \"8b95ceef7b41fbf9e013.jpg\", \"name\": \"Miele Acacia\", \"price\": 4.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 10, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(34,'c8f96bcb83','In pagamento',12,'2021-06-09 15:07:57','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 1}, \"7\": {\"discount\": 10, \"image\": \"2a63ab7fe6cd25252bdd.jpg\", \"name\": \"Pesto genovese\", \"price\": 4.0, \"quantity\": 1}}'),(35,'5f33a30d45','In pagamento',14,'2021-06-09 15:59:56','{\"3\": {\"discount\": 5, \"image\": \"b5c369f22d223a6c9c1d.jpg\", \"name\": \"Orecchiette\", \"price\": 3.0, \"quantity\": 1}, \"6\": {\"discount\": 0, \"image\": \"6d93649be3e0f8868687.jpg\", \"name\": \"Miele castagno\", \"price\": 5.0, \"quantity\": 2}}');
/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `register`
--

DROP TABLE IF EXISTS `register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `register` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `profile` varchar(200) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `register`
--

LOCK TABLES `register` WRITE;
/*!40000 ALTER TABLE `register` DISABLE KEYS */;
INSERT INTO `register` VALUES (1,'Pasquale','Paki','capasso96@gmail.com','$2b$12$4R7cx7k/NgAVtsUqjFmpwe0NptGprnyZKbNO9tkRyaSrX4mA1hy4G','Italia','','Frattamaggiore',NULL,'Via Dante 25','80025','profile.jpg','2021-06-03 14:39:36'),(3,'Vittorio','Vik','Vittorio89@gmail.com','$2b$12$Yf54XL3f/LEBUPFXt3Qw/.SEnGowkvrm2NFwV5VGI7lhv1rg1yIhq','Italia','','Milano',NULL,'Via Capasso 29','80020','profile.jpg','2021-06-03 14:49:28'),(4,'Luigi','gigi','gigi96@gmail.com','$2b$12$KmVM3.dqGf4bW9j07trgd.BH94490P9EvHogCwwSJdZyAq0BFl8Ee','Italia','','Firenze','556762132','Via Palumbo 19','80020','profile.jpg','2021-06-03 14:53:06'),(5,'Vittorio','Vik85','prova@gmail.com','$2b$12$P/hglw7Cd4woThdAjE9dZO3k921PNlzk8qhuJSsQ396I.BvYqIefG','Italia',NULL,'Firenze','234721472','Via Prova','457475','profile.jpg','2021-06-03 15:19:07'),(6,'Vittorino','Vitty','vik96@gmail.com','$2b$12$NDld7lOfHFt8FwgGt5kaVuO4VfqXqJyN.Kz9OblBpKClghHrtMPiy','Italia',NULL,'Palermo','343437565','Via piazza 25','34343','profile.jpg','2021-06-03 15:20:37'),(7,'Francesco Pio','Francy','francesco96@gmail.com','$2b$12$u4/MuGqqvIn1plOJorXAX.D8HDvVxNOKNt3WaqTaC6oje6SN9I8Sm','Italia',NULL,'Frattamaggiore','339567475','Via Quasimodo 25','80020','profile.jpg','2021-06-04 09:47:14'),(8,'Francesco','Franc96','francy96@gmail.com','$2b$12$yDb7lHhQLmpltZIJRWzn7.aX05FZbSj62/NBjW90BDeKZU0Q4nr9y','Italia',NULL,'Frattamaggiore','2323545','Via Quasimodo 25','80020','profile.jpg','2021-06-04 09:48:58'),(9,'Domenico','Capasso','domenico95@gmail.com','$2b$12$OTwRnUPiEYTv/efNfxvv9urWiZ.BTKAzYoN31WLGocGE2BbMqYiby','Italia',NULL,'Aversa','33954754','Via Dante 30','33333','profile.jpg','2021-06-05 14:10:58'),(10,'Carlo','Carlo95','carlo@gmail.com','$2b$12$w09QrvctuvilRkHAuCMPeusFnyfHP5KKBzPbXS7xKS/thaFC13o8u','Italia',NULL,'Napoli','334252525','Via della Piazza 25','25252','profile.jpg','2021-06-09 08:34:59'),(11,'Dario','Dario96','dario@gmail.com','$2b$12$NGCsV8y2JUfEN4MyzEMxqOLrFr8u6EwowrBVVTu19Jf1kMOCVoc/2','Italia',NULL,'Mondragone','335252525','Via delle Palme 25','25251','profile.jpg','2021-06-09 15:04:57'),(12,'Luca','Luca996','luca@gmail.com','$2b$12$gbZz39S3yAU7JUOxRYVSU.9E.t0lF1lL4MyFRWrq/PfVofamibDlG','Italia',NULL,'Mondragone','335252525','Via delle Palme 25','25251','profile.jpg','2021-06-09 15:05:50'),(13,'Vincenzo','Vincy','vinc@gmail.com','$2b$12$rovKWegn2cXJhGDSeMVYKuVc/GiMtvGpi3arI4uFwhMmpEctnImkC','Italia',NULL,'Napoli','336259898','Via delle Palme 25','90905','profile.jpg','2021-06-09 15:20:41'),(14,'Franco','franco94','franco@gmail.com','$2b$12$s4H3ayUKOphOfth2Z45jludajuYXnstUZ8u1C1FRpb6lpFoMKT7Fi','Italia',NULL,'Aversa','334285858','Via Dante 90','25900','profile.jpg','2021-06-09 15:59:37');
/*!40000 ALTER TABLE `register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(180) NOT NULL,
  `profile` varchar(180) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Domenico','prova','provolino@gmail.com','$2b$12$DvDwaI0gUz6A27gf2JhBi.c0AkGxmptlzphw4jXfJf/.WuB6S.UKm','profile.jpg'),(3,'Ugoo','Ugo95','ugo95@gmail.com','$2b$12$3fN9WjFr36A5V1DoRul3iusJm/sXLh19OOPYtiE5JEgdMVd4qTrEi','profile.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-09 19:54:43
