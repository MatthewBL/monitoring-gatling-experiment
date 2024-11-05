
CREATE DATABASE IF NOT EXISTS `petclinic`;

USE `petclinic`;

DROP TABLE IF EXISTS `visits`;
DROP TABLE IF EXISTS `vet_specialties`;
DROP TABLE IF EXISTS `consultation_tickets`;
DROP TABLE IF EXISTS `consultations`;
DROP TABLE IF EXISTS `entity_sequence`;
DROP TABLE IF EXISTS `vets`;
DROP TABLE IF EXISTS `pets`;
DROP TABLE IF EXISTS `owners`;
DROP TABLE IF EXISTS `clinics`;
DROP TABLE IF EXISTS `clinic_owners`;
DROP TABLE IF EXISTS `appusers`;
DROP TABLE IF EXISTS `authorities`;
DROP TABLE IF EXISTS `specialties`;
DROP TABLE IF EXISTS `types`;


CREATE TABLE `authorities` (
  `id` int NOT NULL,
  `authority` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `authorities` WRITE;
INSERT INTO `authorities` VALUES
(1,'ADMIN'),
(2,'CLINIC_OWNER'),
(3,'OWNER'),
(4,'VET');
UNLOCK TABLES;


CREATE TABLE `specialties` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `specialties` WRITE;
INSERT INTO `specialties` VALUES
(1,'radiology'),
(2,'surgery'),
(3,'dentistry');
UNLOCK TABLES;


CREATE TABLE `types` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `types` WRITE;
INSERT INTO `types` VALUES
(1,'cat'),
(2,'dog'),
(3,'lizard'),
(4,'snake'),
(5,'bird'),
(6,'hamster'),
(7,'turtle');
UNLOCK TABLES;


CREATE TABLE `appusers` (
  `authority` int NOT NULL,
  `id` int NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_fxfryr8xvwd9tgo3e2gk58pxv` (`username`),
  KEY `FKgqebgjja4fdf7rww08icgsqmh` (`authority`),
  CONSTRAINT `FKgqebgjja4fdf7rww08icgsqmh` FOREIGN KEY (`authority`) REFERENCES `authorities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `appusers` WRITE;
INSERT INTO `appusers` VALUES
(1,1,'$2a$10$nMmTWAhPTqXqLDJTag3prumFrAJpsYtroxf0ojesFYq0k4PmcbWUS','admin1'),
(2,2,'$2a$10$t.I/C4cjUdUWzqlFlSddLeh9SbZ6d8wR7mdbeIRghT355/KRKZPAi','clinicOwner1'),
(2,3,'$2a$10$t.I/C4cjUdUWzqlFlSddLeh9SbZ6d8wR7mdbeIRghT355/KRKZPAi','clinicOwner2'),
(3,4,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner1'),
(3,5,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner2'),
(3,6,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner3'),
(3,7,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner4'),
(3,8,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner5'),
(3,9,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner6'),
(3,10,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner7'),
(3,11,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner8'),
(3,12,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner9'),
(3,13,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner10'),
(4,14,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet1'),
(4,15,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet2'),
(4,16,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet3'),
(4,17,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet4'),
(4,18,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet5'),
(4,19,'$2a$10$aeypcHWSf4YEkDAF0d.vjOLu94aS40MBUb4rOtDncFxZdo2wpkt8.','vet6'),
(3,20,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner11'),
(3,21,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner12'),
(3,22,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner13'),
(3,23,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner14'),
(3,24,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner15'),
(3,25,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner16'),
(3,26,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner17'),
(3,27,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner18'),
(3,28,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner19'),
(3,29,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner20'),
(3,30,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner21'),
(3,31,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner22'),
(3,32,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner23'),
(3,33,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner24'),
(3,34,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner25'),
(3,35,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner26'),
(3,36,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner27'),
(3,37,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner28'),
(3,38,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner29'),
(3,39,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner30'),
(3,40,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner31'),
(3,41,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner32'),
(3,42,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner33'),
(3,43,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner34'),
(3,44,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner35'),
(3,45,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner36'),
(3,46,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner37'),
(3,47,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner38'),
(3,48,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner39'),
(3,49,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner40'),
(3,50,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner41'),
(3,51,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner42'),
(3,52,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner43'),
(3,53,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner44'),
(3,54,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner45'),
(3,55,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner46'),
(3,56,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner47'),
(3,57,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner48'),
(3,58,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner49'),
(3,59,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner50'),
(3,60,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner51'),
(3,61,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner52'),
(3,62,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner53'),
(3,63,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner54'),
(3,64,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner55'),
(3,65,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner56'),
(3,66,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner57'),
(3,67,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner58'),
(3,68,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner59'),
(3,69,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner60'),
(3,70,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner61'),
(3,71,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner62'),
(3,72,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner63'),
(3,73,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner64'),
(3,74,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner65'),
(3,75,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner66'),
(3,76,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner67'),
(3,77,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner68'),
(3,78,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner69'),
(3,79,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner70'),
(3,80,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner71'),
(3,81,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner72'),
(3,82,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner73'),
(3,83,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner74'),
(3,84,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner75'),
(3,85,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner76'),
(3,86,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner77'),
(3,87,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner78'),
(3,88,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner79'),
(3,89,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner80'),
(3,90,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner81'),
(3,91,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner82'),
(3,92,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner83'),
(3,93,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner84'),
(3,94,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner85'),
(3,95,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner86'),
(3,96,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner87'),
(3,97,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner88'),
(3,98,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner89'),
(3,99,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner90'),
(3,100,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner91'),
(3,101,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner92'),
(3,102,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner93'),
(3,103,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner94'),
(3,104,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner95'),
(3,105,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner96'),
(3,106,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner97'),
(3,107,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner98'),
(3,108,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner99'),
(3,109,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner100'),
(3,110,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner101'),
(3,111,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner102'),
(3,112,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner103'),
(3,113,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner104'),
(3,114,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner105'),
(3,115,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner106'),
(3,116,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner107'),
(3,117,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner108'),
(3,118,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner109'),
(3,119,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner110'),
(3,120,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner111'),
(3,121,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner112'),
(3,122,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner113'),
(3,123,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner114'),
(3,124,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner115'),
(3,125,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner116'),
(3,126,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner117'),
(3,127,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner118'),
(3,128,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner119'),
(3,129,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner120'),
(3,130,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner121'),
(3,131,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner122'),
(3,132,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner123'),
(3,133,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner124'),
(3,134,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner125'),
(3,135,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner126'),
(3,136,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner127'),
(3,137,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner128'),
(3,138,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner129'),
(3,139,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner130'),
(3,140,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner131'),
(3,141,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner132'),
(3,142,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner133'),
(3,143,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner134'),
(3,144,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner135'),
(3,145,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner136'),
(3,146,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner137'),
(3,147,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner138'),
(3,148,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner139'),
(3,149,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner140'),
(3,150,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner141'),
(3,151,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner142'),
(3,152,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner143'),
(3,153,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner144'),
(3,154,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner145'),
(3,155,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner146'),
(3,156,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner147'),
(3,157,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner148'),
(3,158,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner149'),
(3,159,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner150'),
(3,160,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner151'),
(3,161,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner152'),
(3,162,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner153'),
(3,163,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner154'),
(3,164,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner155'),
(3,165,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner156'),
(3,166,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner157'),
(3,167,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner158'),
(3,168,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner159'),
(3,169,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner160'),
(3,170,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner161'),
(3,171,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner162'),
(3,172,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner163'),
(3,173,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner164'),
(3,174,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner165'),
(3,175,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner166'),
(3,176,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner167'),
(3,177,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner168'),
(3,178,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner169'),
(3,179,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner170'),
(3,180,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner171'),
(3,181,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner172'),
(3,182,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner173'),
(3,183,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner174'),
(3,184,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner175'),
(3,185,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner176'),
(3,186,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner177'),
(3,187,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner178'),
(3,188,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner179'),
(3,189,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner180'),
(3,190,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner181'),
(3,191,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner182'),
(3,192,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner183'),
(3,193,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner184'),
(3,194,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner185'),
(3,195,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner186'),
(3,196,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner187'),
(3,197,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner188'),
(3,198,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner189'),
(3,199,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner190'),
(3,200,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner191'),
(3,201,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner192'),
(3,202,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner193'),
(3,203,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner194'),
(3,204,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner195'),
(3,205,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner196'),
(3,206,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner197'),
(3,207,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner198'),
(3,208,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner199'),
(3,209,'$2a$10$DaS6KIEfF5CRTFrxIoGc7emY3BpZZ0.fVjwA3NiJ.BjpGNmocaS3e','owner200');
UNLOCK TABLES;



CREATE TABLE `clinic_owners` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_appbkgostmknve28hwva63h18` (`user_id`),
  CONSTRAINT `FKcbs34rs1txgav9j71q7lr14wr` FOREIGN KEY (`user_id`) REFERENCES `appusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `clinic_owners` WRITE;
INSERT INTO `clinic_owners` VALUES
(1,2,'John','Doe'),
(2,3,'Jane','Doe');
UNLOCK TABLES;


CREATE TABLE `clinics` (
  `clinic_owner` int DEFAULT NULL,
  `id` int NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `plan` enum('BASIC','GOLD','PLATINUM') NOT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfo6i4owjm1gqfwal98nwgt7ne` (`clinic_owner`),
  CONSTRAINT `FKfo6i4owjm1gqfwal98nwgt7ne` FOREIGN KEY (`clinic_owner`) REFERENCES `clinic_owners` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `clinics` WRITE;
INSERT INTO `clinics` VALUES
(1,1,'Av. Palmera, 26','Clinic 1','PLATINUM','955684230'),
(2,2,'Av. Torneo, 52','Clinic 2','GOLD','955634232'),
(2,3,'Av. Reina Mercedes, 70','Clinic 3','BASIC','955382238');
UNLOCK TABLES;


CREATE TABLE `owners` (
  `clinic` int DEFAULT NULL,
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_f5l871r0yr9dyilb3ls5p48os` (`user_id`),
  KEY `FK3tegy5hpqm07u36bpi70uqvrl` (`clinic`),
  CONSTRAINT `FK3tegy5hpqm07u36bpi70uqvrl` FOREIGN KEY (`clinic`) REFERENCES `clinics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKivtnuuio2xfaga7bxv7o4oj36` FOREIGN KEY (`user_id`) REFERENCES `appusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `owners` WRITE;
INSERT INTO `owners` VALUES
(1,1,4,'110 W. Liberty St.','Sevilla','George','Franklin','608555103'),
(1,2,5,'638 Cardinal Ave.','Sevilla','Betty','Davis','608555174'),
(1,3,6,'2693 Commerce St.','Sevilla','Eduardo','Rodriquez','608558763'),
(2,4,7,'563 Friendly St.','Sevilla','Harold','Davis','608555319'),
(2,5,8,'2387 S. Fair Way','Sevilla','Peter','McTavish','608555765'),
(2,6,9,'105 N. Lake St.','Badajoz','Jean','Coleman','608555264'),
(3,7,10,'1450 Oak Blvd.','Badajoz','Jeff','Black','608555538'),
(3,8,11,'345 Maple St.','Badajoz','Maria','Escobito','608557683'),
(3,9,12,'2749 Blackhawk Trail','CÃ¡diz','David','Schroeder','685559435'),
(3,10,13,'2335 Independence La.','CÃ¡diz','Carlos','Estaban','685555487'),
(1,11,20,'address','city','name','last name','600700800'),
(1,12,21,'address','city','name','last name','600700800'),
(1,13,22,'address','city','name','last name','600700800'),
(1,14,23,'address','city','name','last name','600700800'),
(1,15,24,'address','city','name','last name','600700800'),
(1,16,25,'address','city','name','last name','600700800'),
(1,17,26,'address','city','name','last name','600700800'),
(1,18,27,'address','city','name','last name','600700800'),
(1,19,28,'address','city','name','last name','600700800'),
(1,20,29,'address','city','name','last name','600700800'),
(1,21,30,'address','city','name','last name','600700800'),
(1,22,31,'address','city','name','last name','600700800'),
(1,23,32,'address','city','name','last name','600700800'),
(1,24,33,'address','city','name','last name','600700800'),
(1,25,34,'address','city','name','last name','600700800'),
(1,26,35,'address','city','name','last name','600700800'),
(1,27,36,'address','city','name','last name','600700800'),
(1,28,37,'address','city','name','last name','600700800'),
(1,29,38,'address','city','name','last name','600700800'),
(1,30,39,'address','city','name','last name','600700800'),
(1,31,40,'address','city','name','last name','600700800'),
(1,32,41,'address','city','name','last name','600700800'),
(1,33,42,'address','city','name','last name','600700800'),
(1,34,43,'address','city','name','last name','600700800'),
(1,35,44,'address','city','name','last name','600700800'),
(1,36,45,'address','city','name','last name','600700800'),
(1,37,46,'address','city','name','last name','600700800'),
(1,38,47,'address','city','name','last name','600700800'),
(1,39,48,'address','city','name','last name','600700800'),
(1,40,49,'address','city','name','last name','600700800'),
(2,41,50,'address','city','name','last name','600700800'),
(2,42,51,'address','city','name','last name','600700800'),
(2,43,52,'address','city','name','last name','600700800'),
(2,44,53,'address','city','name','last name','600700800'),
(2,45,54,'address','city','name','last name','600700800'),
(2,46,55,'address','city','name','last name','600700800'),
(2,47,56,'address','city','name','last name','600700800'),
(2,48,57,'address','city','name','last name','600700800'),
(2,49,58,'address','city','name','last name','600700800'),
(2,50,59,'address','city','name','last name','600700800'),
(2,51,60,'address','city','name','last name','600700800'),
(2,52,61,'address','city','name','last name','600700800'),
(2,53,62,'address','city','name','last name','600700800'),
(2,54,63,'address','city','name','last name','600700800'),
(2,55,64,'address','city','name','last name','600700800'),
(2,56,65,'address','city','name','last name','600700800'),
(2,57,66,'address','city','name','last name','600700800'),
(2,58,67,'address','city','name','last name','600700800'),
(2,59,68,'address','city','name','last name','600700800'),
(2,60,69,'address','city','name','last name','600700800'),
(2,61,70,'address','city','name','last name','600700800'),
(2,62,71,'address','city','name','last name','600700800'),
(2,63,72,'address','city','name','last name','600700800'),
(2,64,73,'address','city','name','last name','600700800'),
(2,65,74,'address','city','name','last name','600700800'),
(2,66,75,'address','city','name','last name','600700800'),
(2,67,76,'address','city','name','last name','600700800'),
(2,68,77,'address','city','name','last name','600700800'),
(2,69,78,'address','city','name','last name','600700800'),
(3,70,79,'address','city','name','last name','600700800'),
(3,71,80,'address','city','name','last name','600700800'),
(3,72,81,'address','city','name','last name','600700800'),
(3,73,82,'address','city','name','last name','600700800'),
(3,74,83,'address','city','name','last name','600700800'),
(3,75,84,'address','city','name','last name','600700800'),
(3,76,85,'address','city','name','last name','600700800'),
(3,77,86,'address','city','name','last name','600700800'),
(3,78,87,'address','city','name','last name','600700800'),
(3,79,88,'address','city','name','last name','600700800'),
(3,80,89,'address','city','name','last name','600700800'),
(3,81,90,'address','city','name','last name','600700800'),
(3,82,91,'address','city','name','last name','600700800'),
(3,83,92,'address','city','name','last name','600700800'),
(3,84,93,'address','city','name','last name','600700800'),
(3,85,94,'address','city','name','last name','600700800'),
(3,86,95,'address','city','name','last name','600700800'),
(3,87,96,'address','city','name','last name','600700800'),
(3,88,97,'address','city','name','last name','600700800'),
(3,89,98,'address','city','name','last name','600700800'),
(3,90,99,'address','city','name','last name','600700800'),
(3,91,100,'address','city','name','last name','600700800'),
(3,92,101,'address','city','name','last name','600700800'),
(3,93,102,'address','city','name','last name','600700800'),
(3,94,103,'address','city','name','last name','600700800'),
(3,95,104,'address','city','name','last name','600700800'),
(3,96,105,'address','city','name','last name','600700800'),
(3,97,106,'address','city','name','last name','600700800'),
(3,98,107,'address','city','name','last name','600700800'),
(3,99,108,'address','city','name','last name','600700800'),
(3,100,109,'address','city','name','last name','600700800'),
(3,101,110,'address','city','name','last name','600700800'),
(3,102,111,'address','city','name','last name','600700800'),
(3,103,112,'address','city','name','last name','600700800'),
(3,104,113,'address','city','name','last name','600700800'),
(3,105,114,'address','city','name','last name','600700800'),
(3,106,115,'address','city','name','last name','600700800'),
(3,107,116,'address','city','name','last name','600700800'),
(3,108,117,'address','city','name','last name','600700800'),
(3,109,118,'address','city','name','last name','600700800'),
(3,110,119,'address','city','name','last name','600700800'),
(3,111,120,'address','city','name','last name','600700800'),
(3,112,121,'address','city','name','last name','600700800'),
(3,113,122,'address','city','name','last name','600700800'),
(3,114,123,'address','city','name','last name','600700800'),
(3,115,124,'address','city','name','last name','600700800'),
(3,116,125,'address','city','name','last name','600700800'),
(3,117,126,'address','city','name','last name','600700800'),
(3,118,127,'address','city','name','last name','600700800'),
(3,119,128,'address','city','name','last name','600700800'),
(3,120,129,'address','city','name','last name','600700800'),
(3,121,130,'address','city','name','last name','600700800'),
(3,122,131,'address','city','name','last name','600700800'),
(3,123,132,'address','city','name','last name','600700800'),
(3,124,133,'address','city','name','last name','600700800'),
(3,125,134,'address','city','name','last name','600700800'),
(3,126,135,'address','city','name','last name','600700800'),
(3,127,136,'address','city','name','last name','600700800'),
(3,128,137,'address','city','name','last name','600700800'),
(3,129,138,'address','city','name','last name','600700800'),
(3,130,139,'address','city','name','last name','600700800'),
(3,131,140,'address','city','name','last name','600700800'),
(3,132,141,'address','city','name','last name','600700800'),
(3,133,142,'address','city','name','last name','600700800'),
(3,134,143,'address','city','name','last name','600700800'),
(3,135,144,'address','city','name','last name','600700800'),
(3,136,145,'address','city','name','last name','600700800'),
(3,137,146,'address','city','name','last name','600700800'),
(3,138,147,'address','city','name','last name','600700800'),
(3,139,148,'address','city','name','last name','600700800'),
(3,140,149,'address','city','name','last name','600700800'),
(3,141,150,'address','city','name','last name','600700800'),
(3,142,151,'address','city','name','last name','600700800'),
(3,143,152,'address','city','name','last name','600700800'),
(3,144,153,'address','city','name','last name','600700800'),
(3,145,154,'address','city','name','last name','600700800'),
(3,146,155,'address','city','name','last name','600700800'),
(3,147,156,'address','city','name','last name','600700800'),
(3,148,157,'address','city','name','last name','600700800'),
(3,149,158,'address','city','name','last name','600700800'),
(3,150,159,'address','city','name','last name','600700800'),
(3,151,160,'address','city','name','last name','600700800'),
(3,152,161,'address','city','name','last name','600700800'),
(3,153,162,'address','city','name','last name','600700800'),
(3,154,163,'address','city','name','last name','600700800'),
(3,155,164,'address','city','name','last name','600700800'),
(3,156,165,'address','city','name','last name','600700800'),
(3,157,166,'address','city','name','last name','600700800'),
(3,158,167,'address','city','name','last name','600700800'),
(3,159,168,'address','city','name','last name','600700800'),
(3,160,169,'address','city','name','last name','600700800'),
(3,161,170,'address','city','name','last name','600700800'),
(3,162,171,'address','city','name','last name','600700800'),
(3,163,172,'address','city','name','last name','600700800'),
(3,164,173,'address','city','name','last name','600700800'),
(3,165,174,'address','city','name','last name','600700800'),
(3,166,175,'address','city','name','last name','600700800'),
(3,167,176,'address','city','name','last name','600700800'),
(3,168,177,'address','city','name','last name','600700800'),
(3,169,178,'address','city','name','last name','600700800'),
(3,170,179,'address','city','name','last name','600700800'),
(3,171,180,'address','city','name','last name','600700800'),
(3,172,181,'address','city','name','last name','600700800'),
(3,173,182,'address','city','name','last name','600700800'),
(3,174,183,'address','city','name','last name','600700800'),
(3,175,184,'address','city','name','last name','600700800'),
(3,176,185,'address','city','name','last name','600700800'),
(3,177,186,'address','city','name','last name','600700800'),
(3,178,187,'address','city','name','last name','600700800'),
(3,179,188,'address','city','name','last name','600700800'),
(3,180,189,'address','city','name','last name','600700800'),
(3,181,190,'address','city','name','last name','600700800'),
(3,182,191,'address','city','name','last name','600700800'),
(3,183,192,'address','city','name','last name','600700800'),
(3,184,193,'address','city','name','last name','600700800'),
(3,185,194,'address','city','name','last name','600700800'),
(3,186,195,'address','city','name','last name','600700800'),
(3,187,196,'address','city','name','last name','600700800'),
(3,188,197,'address','city','name','last name','600700800'),
(3,189,198,'address','city','name','last name','600700800'),
(3,190,199,'address','city','name','last name','600700800'),
(3,191,200,'address','city','name','last name','600700800'),
(3,192,201,'address','city','name','last name','600700800'),
(3,193,202,'address','city','name','last name','600700800'),
(3,194,203,'address','city','name','last name','600700800'),
(3,195,204,'address','city','name','last name','600700800'),
(3,196,205,'address','city','name','last name','600700800'),
(3,197,206,'address','city','name','last name','600700800'),
(3,198,207,'address','city','name','last name','600700800'),
(3,199,208,'address','city','name','last name','600700800'),
(3,200,209,'address','city','name','last name','600700800');
UNLOCK TABLES;



CREATE TABLE `pets` (
  `birth_date` date DEFAULT NULL,
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `type_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6teg4kcjcnjhduguft56wcfoa` (`owner_id`),
  KEY `FKtmmh1tq8pah5vxf8kuqqplo4p` (`type_id`),
  CONSTRAINT `FK6teg4kcjcnjhduguft56wcfoa` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKtmmh1tq8pah5vxf8kuqqplo4p` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `pets` WRITE;
INSERT INTO `pets` VALUES
('2010-09-07',1,1,1,'Leo'),
('2012-08-06',2,2,6,'Basil'),
('2011-04-17',3,3,2,'Rosy'),
('2010-03-07',4,3,2,'Jewel'),
('2010-11-30',5,4,3,'Iggy'),
('2010-01-20',6,5,4,'George'),
('2012-09-04',7,6,1,'Samantha'),
('2012-09-04',8,6,1,'Max'),
('2011-08-06',9,7,5,'Lucky'),
('2007-02-24',10,8,2,'Mulligan'),
('2010-03-09',11,9,5,'Freddy'),
('2010-06-24',12,10,2,'Lucky'),
('2012-06-08',13,10,1,'Sly');
UNLOCK TABLES;



CREATE TABLE `vets` (
  `clinic` int DEFAULT NULL,
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_a08qu59euub9njcbl4pk0d3ox` (`user_id`),
  KEY `FK2p0tbc3ckxffr5b9in4umxfy8` (`clinic`),
  CONSTRAINT `FK2p0tbc3ckxffr5b9in4umxfy8` FOREIGN KEY (`clinic`) REFERENCES `clinics` (`id`),
  CONSTRAINT `FK5nwjcgpnlqwu01x2qm0ixk9n7` FOREIGN KEY (`user_id`) REFERENCES `appusers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `vets` WRITE;
INSERT INTO `vets` VALUES
(1,1,14,'Sevilla','James','Carter'),
(1,2,15,'Sevilla','Helen','Leary'),
(2,3,16,'Sevilla','Linda','Douglas'),
(2,4,17,'Badajoz','Rafael','Ortega'),
(3,5,18,'Badajoz','Henry','Stevens'),
(3,6,19,'Cádiz','Sharon','Jenkins');
UNLOCK TABLES;



CREATE TABLE `consultations` (
  `id` int NOT NULL,
  `is_clinic_comment` bit(1) NOT NULL,
  `owner_id` int NOT NULL,
  `pet_id` int DEFAULT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `status` enum('ANSWERED','CLOSED','PENDING') NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3l5xlwv6xtgcgrcdm70g8hb37` (`owner_id`),
  KEY `FK1u4ifl4aogb549rkac3xqbm60` (`pet_id`),
  CONSTRAINT `FK1u4ifl4aogb549rkac3xqbm60` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`),
  CONSTRAINT `FK3l5xlwv6xtgcgrcdm70g8hb37` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `consultations` WRITE;
INSERT INTO `consultations` VALUES
(1,_binary '\0',1,1,'2023-01-04 17:30:00.000000','ANSWERED','Consultation about vaccines'),
(2,_binary '\0',1,1,'2022-01-02 19:30:00.000000','PENDING','My dog gets really nervous'),
(3,_binary '\0',2,2,'2023-04-11 11:20:00.000000','PENDING','My cat does not eat'),
(4,_binary '\0',2,2,'2023-02-24 10:30:00.000000','CLOSED','My lovebird does not sing'),
(5,_binary '\0',10,12,'2023-04-11 11:20:00.000000','PENDING','My snake has layed eggs');
UNLOCK TABLES;



CREATE TABLE `consultation_tickets` (
  `consultation_id` int NOT NULL,
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt3l8ba6gpdfikmpsh5wx76e6h` (`consultation_id`),
  KEY `FKbp301erbrnmul0mep92t4nohg` (`user_id`),
  CONSTRAINT `FKbp301erbrnmul0mep92t4nohg` FOREIGN KEY (`user_id`) REFERENCES `appusers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKt3l8ba6gpdfikmpsh5wx76e6h` FOREIGN KEY (`consultation_id`) REFERENCES `consultations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `consultation_tickets` WRITE;
INSERT INTO `consultation_tickets` VALUES
(1,1,4,'2023-01-04 17:32:00.000000','What vaccine should my dog receive?'),
(1,2,14,'2023-01-04 17:36:00.000000','Rabies'' one.'),
(2,3,4,'2022-01-02 19:31:00.000000','My dog gets really nervous during football matches. What should I do?'),
(2,4,4,'2022-01-02 19:33:00.000000','It also happens with tennis matches.'),
(3,5,5,'2023-04-11 11:30:00.000000','My cat han''t been eating his fodder.'),
(3,6,15,'2023-04-11 15:20:00.000000','Try to give him some tuna to check if he eats that.'),
(4,7,5,'2023-02-24 12:30:00.000000','My lovebird doesn''t sing as my neighbour''s one.'),
(4,8,16,'2023-02-24 18:30:00.000000','Lovebirds do not sing.');
UNLOCK TABLES;



CREATE TABLE `entity_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `entity_sequence` WRITE;
INSERT INTO `entity_sequence` VALUES (100);
UNLOCK TABLES;



CREATE TABLE `vet_specialties` (
  `specialty_id` int NOT NULL,
  `vet_id` int NOT NULL,
  UNIQUE KEY `UK5vkcw8m2n1pifb4h4meuv8p3a` (`specialty_id`,`vet_id`),
  KEY `FKby1c0fbaa0byaifi63vt18sx9` (`vet_id`),
  CONSTRAINT `FK35uiboyrpfn1bndrr5jorcj0m` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`),
  CONSTRAINT `FKby1c0fbaa0byaifi63vt18sx9` FOREIGN KEY (`vet_id`) REFERENCES `vets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `vet_specialties` WRITE;
INSERT INTO `vet_specialties` VALUES 
(1,2),
(2,3),
(3,3),
(2,4),
(1,5);
UNLOCK TABLES;


CREATE TABLE `visits` (
  `id` int NOT NULL,
  `pet_id` int DEFAULT NULL,
  `vet_id` int NOT NULL,
  `visit_date_time` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6jcifhlqqlsfseu67utlouauy` (`pet_id`),
  KEY `FK8036qgt84d8h5cckxrj952qoe` (`vet_id`),
  CONSTRAINT `FK6jcifhlqqlsfseu67utlouauy` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK8036qgt84d8h5cckxrj952qoe` FOREIGN KEY (`vet_id`) REFERENCES `vets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `visits` WRITE;
INSERT INTO `visits` VALUES
(1,7,4,'2013-01-01 13:00:00.000000','rabies shot'),
(2,8,5,'2013-01-02 15:30:00.000000','rabies shot'),
(3,8,5,'2013-01-03 09:45:00.000000','neutered'),
(4,7,4,'2013-01-04 17:30:00.000000','spayed'),
(5,1,1,'2013-01-01 13:00:00.000000','rabies shot'),
(6,1,1,'2020-01-02 15:30:00.000000','rabies shot'),
(7,1,1,'2020-01-02 15:30:00.000000','rabies shot'),
(8,2,2,'2013-01-03 09:45:00.000000','neutered'),
(9,3,3,'2013-01-04 17:30:00.000000','spayed');
UNLOCK TABLES;
