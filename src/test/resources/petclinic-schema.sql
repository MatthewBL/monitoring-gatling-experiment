
CREATE DATABASE IF NOT EXISTS `petclinic`;

USE `petclinic`;

DROP TABLE IF EXISTS `illnesses`;
DROP TABLE IF EXISTS `symptoms`;
DROP TABLE IF EXISTS `illnesses_symptoms`;
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


CREATE TABLE `symptoms` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `symptoms` WRITE;
INSERT INTO `symptoms` VALUESINSERT INTO symptom (id, name) VALUES
(1, 'fever'),
(2, 'coughing'),
(3, 'sneezing'),
(4, 'vomiting'),
(5, 'diarrhea'),
(6, 'lethargy'),
(7, 'loss of appetite'),
(8, 'increased thirst polydipsia'),
(9, 'increased urination polyuria'),
(10, 'weight loss'),
(11, 'weight gain'),
(12, 'difficulty breathing dyspnea'),
(13, 'nasal discharge'),
(14, 'eye discharge'),
(15, 'redness in eyes conjunctivitis'),
(16, 'itchy skin pruritus'),
(17, 'hair loss alopecia'),
(18, 'skin rashes'),
(19, 'lumps or masses'),
(20, 'bad breath halitosis'),
(21, 'excessive drooling ptyalism'),
(22, 'pale gums'),
(23, 'bleeding gums'),
(24, 'difficulty walking or limping'),
(25, 'stiffness in joints'),
(26, 'swollen joints'),
(27, 'seizures'),
(28, 'tremors'),
(29, 'aggressive behavior'),
(30, 'depression-like behavior'),
(31, 'restlessness or pacing'),
(32, 'excessive barking or vocalization'),
(33, 'difficulty urinating'),
(34, 'blood in urine (hematuria)'),
(35, 'blood in stool'),
(36, 'constipation'),
(37, 'bloated abdomen'),
(38, 'painful abdomen'),
(39, 'increased heart rate (tachycardia)'),
(40, 'decreased heart rate (bradycardia)'),
(41, 'uncoordinated movements (ataxia)'),
(42, 'weakness or collapsing'),
(43, 'excessive scratching of ears'),
(44, 'head shaking'),
(45, 'foul odor from ears'),
(46, 'excessive panting'),
(47, 'loss of consciousness'),
(48, 'disorientation'),
(49, 'excessive licking of paws or body'),
(50, 'paralysis in limbs');
UNLOCK TABLES;


CREATE TABLE `specialties` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
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



CREATE TABLE `illnesses` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `illnesses` WRITE;
INSERT INTO `illnesses` VALUES
(1,'Illness1'),
(2,'Illness2'),
(3,'Illness3'),
(4,'Illness4'),
(5,'Illness5'),
(6,'Illness6'),
(7,'Illness7'),
(8,'Illness8'),
(9,'Illness9'),
(10,'Illness10'),
(11,'Illness11'),
(12,'Illness12'),
(13,'Illness13'),
(14,'Illness14'),
(15,'Illness15'),
(16,'Illness16'),
(17,'Illness17'),
(18,'Illness18'),
(19,'Illness19'),
(20,'Illness20'),
(21,'Illness21'),
(22,'Illness22'),
(23,'Illness23'),
(24,'Illness24'),
(25,'Illness25'),
(26,'Illness26'),
(27,'Illness27'),
(28,'Illness28'),
(29,'Illness29'),
(30,'Illness30'),
(31,'Illness31'),
(32,'Illness32'),
(33,'Illness33'),
(34,'Illness34'),
(35,'Illness35'),
(36,'Illness36'),
(37,'Illness37'),
(38,'Illness38'),
(39,'Illness39'),
(40,'Illness40'),
(41,'Illness41'),
(42,'Illness42'),
(43,'Illness43'),
(44,'Illness44'),
(45,'Illness45'),
(46,'Illness46'),
(47,'Illness47'),
(48,'Illness48'),
(49,'Illness49'),
(50,'Illness50'),
(51,'Illness51'),
(52,'Illness52'),
(53,'Illness53'),
(54,'Illness54'),
(55,'Illness55'),
(56,'Illness56'),
(57,'Illness57'),
(58,'Illness58'),
(59,'Illness59'),
(60,'Illness60'),
(61,'Illness61'),
(62,'Illness62'),
(63,'Illness63'),
(64,'Illness64'),
(65,'Illness65'),
(66,'Illness66'),
(67,'Illness67'),
(68,'Illness68'),
(69,'Illness69'),
(70,'Illness70'),
(71,'Illness71'),
(72,'Illness72'),
(73,'Illness73'),
(74,'Illness74'),
(75,'Illness75'),
(76,'Illness76'),
(77,'Illness77'),
(78,'Illness78'),
(79,'Illness79'),
(80,'Illness80'),
(81,'Illness81'),
(82,'Illness82'),
(83,'Illness83'),
(84,'Illness84'),
(85,'Illness85'),
(86,'Illness86'),
(87,'Illness87'),
(88,'Illness88'),
(89,'Illness89'),
(90,'Illness90'),
(91,'Illness91'),
(92,'Illness92'),
(93,'Illness93'),
(94,'Illness94'),
(95,'Illness95'),
(96,'Illness96'),
(97,'Illness97'),
(98,'Illness98'),
(99,'Illness99');
UNLOCK TABLES;



CREATE TABLE `illnesses_symptoms` (
  `symptom_id` int NOT NULL,
  `illness_id` int NOT NULL,
  UNIQUE KEY `UK5vkcw8m2n1pifb4h4meuv8p3b` (`symptom_id`,`illness_id`),
  KEY `FKby1c0fbaa0byaifi63vt18sx0` (`vet_id`),
  CONSTRAINT `UK5vkcw8m2n1pifb4h4meuv8p3b` FOREIGN KEY (`symptom_id`) REFERENCES `symptoms` (`id`),
  CONSTRAINT `FKby1c0fbaa0byaifi63vt18sx0` FOREIGN KEY (`illness_id`) REFERENCES `illnesses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `illnesses_symptoms` WRITE;
INSERT INTO `illnesses_symptoms` VALUES 
(1,1)
(2,1)
(2,2)
(3,1)
(3,2)
(3,3)
(4,1)
(4,2)
(4,3)
(4,4)
(5,1)
(5,2)
(5,3)
(5,4)
(5,5)
(6,1)
(6,2)
(6,3)
(6,4)
(6,5)
(6,6)
(7,1)
(7,2)
(7,3)
(7,4)
(7,5)
(7,6)
(7,7)
(8,1)
(8,2)
(8,3)
(8,4)
(8,5)
(8,6)
(8,7)
(8,8)
(9,1)
(9,2)
(9,3)
(9,4)
(9,5)
(9,6)
(9,7)
(9,8)
(9,9)
(10,1)
(10,2)
(10,3)
(10,4)
(10,5)
(10,6)
(10,7)
(10,8)
(10,9)
(10,10)
(11,1)
(11,2)
(11,3)
(11,4)
(11,5)
(11,6)
(11,7)
(11,8)
(11,9)
(11,10)
(11,11)
(12,1)
(12,2)
(12,3)
(12,4)
(12,5)
(12,6)
(12,7)
(12,8)
(12,9)
(12,10)
(12,11)
(12,12)
(13,1)
(13,2)
(13,3)
(13,4)
(13,5)
(13,6)
(13,7)
(13,8)
(13,9)
(13,10)
(13,11)
(13,12)
(13,13)
(14,1)
(14,2)
(14,3)
(14,4)
(14,5)
(14,6)
(14,7)
(14,8)
(14,9)
(14,10)
(14,11)
(14,12)
(14,13)
(14,14)
(15,1)
(15,2)
(15,3)
(15,4)
(15,5)
(15,6)
(15,7)
(15,8)
(15,9)
(15,10)
(15,11)
(15,12)
(15,13)
(15,14)
(15,15)
(16,1)
(16,2)
(16,3)
(16,4)
(16,5)
(16,6)
(16,7)
(16,8)
(16,9)
(16,10)
(16,11)
(16,12)
(16,13)
(16,14)
(16,15)
(16,16)
(17,1)
(17,2)
(17,3)
(17,4)
(17,5)
(17,6)
(17,7)
(17,8)
(17,9)
(17,10)
(17,11)
(17,12)
(17,13)
(17,14)
(17,15)
(17,16)
(17,17)
(18,1)
(18,2)
(18,3)
(18,4)
(18,5)
(18,6)
(18,7)
(18,8)
(18,9)
(18,10)
(18,11)
(18,12)
(18,13)
(18,14)
(18,15)
(18,16)
(18,17)
(18,18)
(19,1)
(19,2)
(19,3)
(19,4)
(19,5)
(19,6)
(19,7)
(19,8)
(19,9)
(19,10)
(19,11)
(19,12)
(19,13)
(19,14)
(19,15)
(19,16)
(19,17)
(19,18)
(19,19)
(20,1)
(20,2)
(20,3)
(20,4)
(20,5)
(20,6)
(20,7)
(20,8)
(20,9)
(20,10)
(20,11)
(20,12)
(20,13)
(20,14)
(20,15)
(20,16)
(20,17)
(20,18)
(20,19)
(20,20)
(21,1)
(21,2)
(21,3)
(21,4)
(21,5)
(21,6)
(21,7)
(21,8)
(21,9)
(21,10)
(21,11)
(21,12)
(21,13)
(21,14)
(21,15)
(21,16)
(21,17)
(21,18)
(21,19)
(21,20)
(21,21)
(22,1)
(22,2)
(22,3)
(22,4)
(22,5)
(22,6)
(22,7)
(22,8)
(22,9)
(22,10)
(22,11)
(22,12)
(22,13)
(22,14)
(22,15)
(22,16)
(22,17)
(22,18)
(22,19)
(22,20)
(22,21)
(22,22)
(23,1)
(23,2)
(23,3)
(23,4)
(23,5)
(23,6)
(23,7)
(23,8)
(23,9)
(23,10)
(23,11)
(23,12)
(23,13)
(23,14)
(23,15)
(23,16)
(23,17)
(23,18)
(23,19)
(23,20)
(23,21)
(23,22)
(23,23)
(24,1)
(24,2)
(24,3)
(24,4)
(24,5)
(24,6)
(24,7)
(24,8)
(24,9)
(24,10)
(24,11)
(24,12)
(24,13)
(24,14)
(24,15)
(24,16)
(24,17)
(24,18)
(24,19)
(24,20)
(24,21)
(24,22)
(24,23)
(24,24)
(25,1)
(25,2)
(25,3)
(25,4)
(25,5)
(25,6)
(25,7)
(25,8)
(25,9)
(25,10)
(25,11)
(25,12)
(25,13)
(25,14)
(25,15)
(25,16)
(25,17)
(25,18)
(25,19)
(25,20)
(25,21)
(25,22)
(25,23)
(25,24)
(25,25)
(26,1)
(26,2)
(26,3)
(26,4)
(26,5)
(26,6)
(26,7)
(26,8)
(26,9)
(26,10)
(26,11)
(26,12)
(26,13)
(26,14)
(26,15)
(26,16)
(26,17)
(26,18)
(26,19)
(26,20)
(26,21)
(26,22)
(26,23)
(26,24)
(26,25)
(26,26)
(27,1)
(27,2)
(27,3)
(27,4)
(27,5)
(27,6)
(27,7)
(27,8)
(27,9)
(27,10)
(27,11)
(27,12)
(27,13)
(27,14)
(27,15)
(27,16)
(27,17)
(27,18)
(27,19)
(27,20)
(27,21)
(27,22)
(27,23)
(27,24)
(27,25)
(27,26)
(27,27)
(28,1)
(28,2)
(28,3)
(28,4)
(28,5)
(28,6)
(28,7)
(28,8)
(28,9)
(28,10)
(28,11)
(28,12)
(28,13)
(28,14)
(28,15)
(28,16)
(28,17)
(28,18)
(28,19)
(28,20)
(28,21)
(28,22)
(28,23)
(28,24)
(28,25)
(28,26)
(28,27)
(28,28)
(29,1)
(29,2)
(29,3)
(29,4)
(29,5)
(29,6)
(29,7)
(29,8)
(29,9)
(29,10)
(29,11)
(29,12)
(29,13)
(29,14)
(29,15)
(29,16)
(29,17)
(29,18)
(29,19)
(29,20)
(29,21)
(29,22)
(29,23)
(29,24)
(29,25)
(29,26)
(29,27)
(29,28)
(29,29)
(30,1)
(30,2)
(30,3)
(30,4)
(30,5)
(30,6)
(30,7)
(30,8)
(30,9)
(30,10)
(30,11)
(30,12)
(30,13)
(30,14)
(30,15)
(30,16)
(30,17)
(30,18)
(30,19)
(30,20)
(30,21)
(30,22)
(30,23)
(30,24)
(30,25)
(30,26)
(30,27)
(30,28)
(30,29)
(30,30)
(31,1)
(31,2)
(31,3)
(31,4)
(31,5)
(31,6)
(31,7)
(31,8)
(31,9)
(31,10)
(31,11)
(31,12)
(31,13)
(31,14)
(31,15)
(31,16)
(31,17)
(31,18)
(31,19)
(31,20)
(31,21)
(31,22)
(31,23)
(31,24)
(31,25)
(31,26)
(31,27)
(31,28)
(31,29)
(31,30)
(31,31)
(32,1)
(32,2)
(32,3)
(32,4)
(32,5)
(32,6)
(32,7)
(32,8)
(32,9)
(32,10)
(32,11)
(32,12)
(32,13)
(32,14)
(32,15)
(32,16)
(32,17)
(32,18)
(32,19)
(32,20)
(32,21)
(32,22)
(32,23)
(32,24)
(32,25)
(32,26)
(32,27)
(32,28)
(32,29)
(32,30)
(32,31)
(32,32)
(33,1)
(33,2)
(33,3)
(33,4)
(33,5)
(33,6)
(33,7)
(33,8)
(33,9)
(33,10)
(33,11)
(33,12)
(33,13)
(33,14)
(33,15)
(33,16)
(33,17)
(33,18)
(33,19)
(33,20)
(33,21)
(33,22)
(33,23)
(33,24)
(33,25)
(33,26)
(33,27)
(33,28)
(33,29)
(33,30)
(33,31)
(33,32)
(33,33)
(34,1)
(34,2)
(34,3)
(34,4)
(34,5)
(34,6)
(34,7)
(34,8)
(34,9)
(34,10)
(34,11)
(34,12)
(34,13)
(34,14)
(34,15)
(34,16)
(34,17)
(34,18)
(34,19)
(34,20)
(34,21)
(34,22)
(34,23)
(34,24)
(34,25)
(34,26)
(34,27)
(34,28)
(34,29)
(34,30)
(34,31)
(34,32)
(34,33)
(34,34)
(35,1)
(35,2)
(35,3)
(35,4)
(35,5)
(35,6)
(35,7)
(35,8)
(35,9)
(35,10)
(35,11)
(35,12)
(35,13)
(35,14)
(35,15)
(35,16)
(35,17)
(35,18)
(35,19)
(35,20)
(35,21)
(35,22)
(35,23)
(35,24)
(35,25)
(35,26)
(35,27)
(35,28)
(35,29)
(35,30)
(35,31)
(35,32)
(35,33)
(35,34)
(35,35)
(36,1)
(36,2)
(36,3)
(36,4)
(36,5)
(36,6)
(36,7)
(36,8)
(36,9)
(36,10)
(36,11)
(36,12)
(36,13)
(36,14)
(36,15)
(36,16)
(36,17)
(36,18)
(36,19)
(36,20)
(36,21)
(36,22)
(36,23)
(36,24)
(36,25)
(36,26)
(36,27)
(36,28)
(36,29)
(36,30)
(36,31)
(36,32)
(36,33)
(36,34)
(36,35)
(36,36)
(37,1)
(37,2)
(37,3)
(37,4)
(37,5)
(37,6)
(37,7)
(37,8)
(37,9)
(37,10)
(37,11)
(37,12)
(37,13)
(37,14)
(37,15)
(37,16)
(37,17)
(37,18)
(37,19)
(37,20)
(37,21)
(37,22)
(37,23)
(37,24)
(37,25)
(37,26)
(37,27)
(37,28)
(37,29)
(37,30)
(37,31)
(37,32)
(37,33)
(37,34)
(37,35)
(37,36)
(37,37)
(38,1)
(38,2)
(38,3)
(38,4)
(38,5)
(38,6)
(38,7)
(38,8)
(38,9)
(38,10)
(38,11)
(38,12)
(38,13)
(38,14)
(38,15)
(38,16)
(38,17)
(38,18)
(38,19)
(38,20)
(38,21)
(38,22)
(38,23)
(38,24)
(38,25)
(38,26)
(38,27)
(38,28)
(38,29)
(38,30)
(38,31)
(38,32)
(38,33)
(38,34)
(38,35)
(38,36)
(38,37)
(38,38)
(39,1)
(39,2)
(39,3)
(39,4)
(39,5)
(39,6)
(39,7)
(39,8)
(39,9)
(39,10)
(39,11)
(39,12)
(39,13)
(39,14)
(39,15)
(39,16)
(39,17)
(39,18)
(39,19)
(39,20)
(39,21)
(39,22)
(39,23)
(39,24)
(39,25)
(39,26)
(39,27)
(39,28)
(39,29)
(39,30)
(39,31)
(39,32)
(39,33)
(39,34)
(39,35)
(39,36)
(39,37)
(39,38)
(39,39)
(40,1)
(40,2)
(40,3)
(40,4)
(40,5)
(40,6)
(40,7)
(40,8)
(40,9)
(40,10)
(40,11)
(40,12)
(40,13)
(40,14)
(40,15)
(40,16)
(40,17)
(40,18)
(40,19)
(40,20)
(40,21)
(40,22)
(40,23)
(40,24)
(40,25)
(40,26)
(40,27)
(40,28)
(40,29)
(40,30)
(40,31)
(40,32)
(40,33)
(40,34)
(40,35)
(40,36)
(40,37)
(40,38)
(40,39)
(40,40)
(41,1)
(41,2)
(41,3)
(41,4)
(41,5)
(41,6)
(41,7)
(41,8)
(41,9)
(41,10)
(41,11)
(41,12)
(41,13)
(41,14)
(41,15)
(41,16)
(41,17)
(41,18)
(41,19)
(41,20)
(41,21)
(41,22)
(41,23)
(41,24)
(41,25)
(41,26)
(41,27)
(41,28)
(41,29)
(41,30)
(41,31)
(41,32)
(41,33)
(41,34)
(41,35)
(41,36)
(41,37)
(41,38)
(41,39)
(41,40)
(41,41)
(42,1)
(42,2)
(42,3)
(42,4)
(42,5)
(42,6)
(42,7)
(42,8)
(42,9)
(42,10)
(42,11)
(42,12)
(42,13)
(42,14)
(42,15)
(42,16)
(42,17)
(42,18)
(42,19)
(42,20)
(42,21)
(42,22)
(42,23)
(42,24)
(42,25)
(42,26)
(42,27)
(42,28)
(42,29)
(42,30)
(42,31)
(42,32)
(42,33)
(42,34)
(42,35)
(42,36)
(42,37)
(42,38)
(42,39)
(42,40)
(42,41)
(42,42)
(43,1)
(43,2)
(43,3)
(43,4)
(43,5)
(43,6)
(43,7)
(43,8)
(43,9)
(43,10)
(43,11)
(43,12)
(43,13)
(43,14)
(43,15)
(43,16)
(43,17)
(43,18)
(43,19)
(43,20)
(43,21)
(43,22)
(43,23)
(43,24)
(43,25)
(43,26)
(43,27)
(43,28)
(43,29)
(43,30)
(43,31)
(43,32)
(43,33)
(43,34)
(43,35)
(43,36)
(43,37)
(43,38)
(43,39)
(43,40)
(43,41)
(43,42)
(43,43)
(44,1)
(44,2)
(44,3)
(44,4)
(44,5)
(44,6)
(44,7)
(44,8)
(44,9)
(44,10)
(44,11)
(44,12)
(44,13)
(44,14)
(44,15)
(44,16)
(44,17)
(44,18)
(44,19)
(44,20)
(44,21)
(44,22)
(44,23)
(44,24)
(44,25)
(44,26)
(44,27)
(44,28)
(44,29)
(44,30)
(44,31)
(44,32)
(44,33)
(44,34)
(44,35)
(44,36)
(44,37)
(44,38)
(44,39)
(44,40)
(44,41)
(44,42)
(44,43)
(44,44)
(45,1)
(45,2)
(45,3)
(45,4)
(45,5)
(45,6)
(45,7)
(45,8)
(45,9)
(45,10)
(45,11)
(45,12)
(45,13)
(45,14)
(45,15)
(45,16)
(45,17)
(45,18)
(45,19)
(45,20)
(45,21)
(45,22)
(45,23)
(45,24)
(45,25)
(45,26)
(45,27)
(45,28)
(45,29)
(45,30)
(45,31)
(45,32)
(45,33)
(45,34)
(45,35)
(45,36)
(45,37)
(45,38)
(45,39)
(45,40)
(45,41)
(45,42)
(45,43)
(45,44)
(45,45)
(46,1)
(46,2)
(46,3)
(46,4)
(46,5)
(46,6)
(46,7)
(46,8)
(46,9)
(46,10)
(46,11)
(46,12)
(46,13)
(46,14)
(46,15)
(46,16)
(46,17)
(46,18)
(46,19)
(46,20)
(46,21)
(46,22)
(46,23)
(46,24)
(46,25)
(46,26)
(46,27)
(46,28)
(46,29)
(46,30)
(46,31)
(46,32)
(46,33)
(46,34)
(46,35)
(46,36)
(46,37)
(46,38)
(46,39)
(46,40)
(46,41)
(46,42)
(46,43)
(46,44)
(46,45)
(46,46)
(47,1)
(47,2)
(47,3)
(47,4)
(47,5)
(47,6)
(47,7)
(47,8)
(47,9)
(47,10)
(47,11)
(47,12)
(47,13)
(47,14)
(47,15)
(47,16)
(47,17)
(47,18)
(47,19)
(47,20)
(47,21)
(47,22)
(47,23)
(47,24)
(47,25)
(47,26)
(47,27)
(47,28)
(47,29)
(47,30)
(47,31)
(47,32)
(47,33)
(47,34)
(47,35)
(47,36)
(47,37)
(47,38)
(47,39)
(47,40)
(47,41)
(47,42)
(47,43)
(47,44)
(47,45)
(47,46)
(47,47)
(48,1)
(48,2)
(48,3)
(48,4)
(48,5)
(48,6)
(48,7)
(48,8)
(48,9)
(48,10)
(48,11)
(48,12)
(48,13)
(48,14)
(48,15)
(48,16)
(48,17)
(48,18)
(48,19)
(48,20)
(48,21)
(48,22)
(48,23)
(48,24)
(48,25)
(48,26)
(48,27)
(48,28)
(48,29)
(48,30)
(48,31)
(48,32)
(48,33)
(48,34)
(48,35)
(48,36)
(48,37)
(48,38)
(48,39)
(48,40)
(48,41)
(48,42)
(48,43)
(48,44)
(48,45)
(48,46)
(48,47)
(48,48)
(49,1)
(49,2)
(49,3)
(49,4)
(49,5)
(49,6)
(49,7)
(49,8)
(49,9)
(49,10)
(49,11)
(49,12)
(49,13)
(49,14)
(49,15)
(49,16)
(49,17)
(49,18)
(49,19)
(49,20)
(49,21)
(49,22)
(49,23)
(49,24)
(49,25)
(49,26)
(49,27)
(49,28)
(49,29)
(49,30)
(49,31)
(49,32)
(49,33)
(49,34)
(49,35)
(49,36)
(49,37)
(49,38)
(49,39)
(49,40)
(49,41)
(49,42)
(49,43)
(49,44)
(49,45)
(49,46)
(49,47)
(49,48)
(49,49)
(50,1)
(50,2)
(50,3)
(50,4)
(50,5)
(50,6)
(50,7)
(50,8)
(50,9)
(50,10)
(50,11)
(50,12)
(50,13)
(50,14)
(50,15)
(50,16)
(50,17)
(50,18)
(50,19)
(50,20)
(50,21)
(50,22)
(50,23)
(50,24)
(50,25)
(50,26)
(50,27)
(50,28)
(50,29)
(50,30)
(50,31)
(50,32)
(50,33)
(50,34)
(50,35)
(50,36)
(50,37)
(50,38)
(50,39)
(50,40)
(50,41)
(50,42)
(50,43)
(50,44)
(50,45)
(50,46)
(50,47)
(50,48)
(50,49)
(50,50)
(51,2)
(51,3)
(51,4)
(51,5)
(51,6)
(51,7)
(51,8)
(51,9)
(51,10)
(51,11)
(51,12)
(51,13)
(51,14)
(51,15)
(51,16)
(51,17)
(51,18)
(51,19)
(51,20)
(51,21)
(51,22)
(51,23)
(51,24)
(51,25)
(51,26)
(51,27)
(51,28)
(51,29)
(51,30)
(51,31)
(51,32)
(51,33)
(51,34)
(51,35)
(51,36)
(51,37)
(51,38)
(51,39)
(51,40)
(51,41)
(51,42)
(51,43)
(51,44)
(51,45)
(51,46)
(51,47)
(51,48)
(51,49)
(51,50)
(52,3)
(52,4)
(52,5)
(52,6)
(52,7)
(52,8)
(52,9)
(52,10)
(52,11)
(52,12)
(52,13)
(52,14)
(52,15)
(52,16)
(52,17)
(52,18)
(52,19)
(52,20)
(52,21)
(52,22)
(52,23)
(52,24)
(52,25)
(52,26)
(52,27)
(52,28)
(52,29)
(52,30)
(52,31)
(52,32)
(52,33)
(52,34)
(52,35)
(52,36)
(52,37)
(52,38)
(52,39)
(52,40)
(52,41)
(52,42)
(52,43)
(52,44)
(52,45)
(52,46)
(52,47)
(52,48)
(52,49)
(52,50)
(53,4)
(53,5)
(53,6)
(53,7)
(53,8)
(53,9)
(53,10)
(53,11)
(53,12)
(53,13)
(53,14)
(53,15)
(53,16)
(53,17)
(53,18)
(53,19)
(53,20)
(53,21)
(53,22)
(53,23)
(53,24)
(53,25)
(53,26)
(53,27)
(53,28)
(53,29)
(53,30)
(53,31)
(53,32)
(53,33)
(53,34)
(53,35)
(53,36)
(53,37)
(53,38)
(53,39)
(53,40)
(53,41)
(53,42)
(53,43)
(53,44)
(53,45)
(53,46)
(53,47)
(53,48)
(53,49)
(53,50)
(54,5)
(54,6)
(54,7)
(54,8)
(54,9)
(54,10)
(54,11)
(54,12)
(54,13)
(54,14)
(54,15)
(54,16)
(54,17)
(54,18)
(54,19)
(54,20)
(54,21)
(54,22)
(54,23)
(54,24)
(54,25)
(54,26)
(54,27)
(54,28)
(54,29)
(54,30)
(54,31)
(54,32)
(54,33)
(54,34)
(54,35)
(54,36)
(54,37)
(54,38)
(54,39)
(54,40)
(54,41)
(54,42)
(54,43)
(54,44)
(54,45)
(54,46)
(54,47)
(54,48)
(54,49)
(54,50)
(55,6)
(55,7)
(55,8)
(55,9)
(55,10)
(55,11)
(55,12)
(55,13)
(55,14)
(55,15)
(55,16)
(55,17)
(55,18)
(55,19)
(55,20)
(55,21)
(55,22)
(55,23)
(55,24)
(55,25)
(55,26)
(55,27)
(55,28)
(55,29)
(55,30)
(55,31)
(55,32)
(55,33)
(55,34)
(55,35)
(55,36)
(55,37)
(55,38)
(55,39)
(55,40)
(55,41)
(55,42)
(55,43)
(55,44)
(55,45)
(55,46)
(55,47)
(55,48)
(55,49)
(55,50)
(56,7)
(56,8)
(56,9)
(56,10)
(56,11)
(56,12)
(56,13)
(56,14)
(56,15)
(56,16)
(56,17)
(56,18)
(56,19)
(56,20)
(56,21)
(56,22)
(56,23)
(56,24)
(56,25)
(56,26)
(56,27)
(56,28)
(56,29)
(56,30)
(56,31)
(56,32)
(56,33)
(56,34)
(56,35)
(56,36)
(56,37)
(56,38)
(56,39)
(56,40)
(56,41)
(56,42)
(56,43)
(56,44)
(56,45)
(56,46)
(56,47)
(56,48)
(56,49)
(56,50)
(57,8)
(57,9)
(57,10)
(57,11)
(57,12)
(57,13)
(57,14)
(57,15)
(57,16)
(57,17)
(57,18)
(57,19)
(57,20)
(57,21)
(57,22)
(57,23)
(57,24)
(57,25)
(57,26)
(57,27)
(57,28)
(57,29)
(57,30)
(57,31)
(57,32)
(57,33)
(57,34)
(57,35)
(57,36)
(57,37)
(57,38)
(57,39)
(57,40)
(57,41)
(57,42)
(57,43)
(57,44)
(57,45)
(57,46)
(57,47)
(57,48)
(57,49)
(57,50)
(58,9)
(58,10)
(58,11)
(58,12)
(58,13)
(58,14)
(58,15)
(58,16)
(58,17)
(58,18)
(58,19)
(58,20)
(58,21)
(58,22)
(58,23)
(58,24)
(58,25)
(58,26)
(58,27)
(58,28)
(58,29)
(58,30)
(58,31)
(58,32)
(58,33)
(58,34)
(58,35)
(58,36)
(58,37)
(58,38)
(58,39)
(58,40)
(58,41)
(58,42)
(58,43)
(58,44)
(58,45)
(58,46)
(58,47)
(58,48)
(58,49)
(58,50)
(59,10)
(59,11)
(59,12)
(59,13)
(59,14)
(59,15)
(59,16)
(59,17)
(59,18)
(59,19)
(59,20)
(59,21)
(59,22)
(59,23)
(59,24)
(59,25)
(59,26)
(59,27)
(59,28)
(59,29)
(59,30)
(59,31)
(59,32)
(59,33)
(59,34)
(59,35)
(59,36)
(59,37)
(59,38)
(59,39)
(59,40)
(59,41)
(59,42)
(59,43)
(59,44)
(59,45)
(59,46)
(59,47)
(59,48)
(59,49)
(59,50)
(60,11)
(60,12)
(60,13)
(60,14)
(60,15)
(60,16)
(60,17)
(60,18)
(60,19)
(60,20)
(60,21)
(60,22)
(60,23)
(60,24)
(60,25)
(60,26)
(60,27)
(60,28)
(60,29)
(60,30)
(60,31)
(60,32)
(60,33)
(60,34)
(60,35)
(60,36)
(60,37)
(60,38)
(60,39)
(60,40)
(60,41)
(60,42)
(60,43)
(60,44)
(60,45)
(60,46)
(60,47)
(60,48)
(60,49)
(60,50)
(61,12)
(61,13)
(61,14)
(61,15)
(61,16)
(61,17)
(61,18)
(61,19)
(61,20)
(61,21)
(61,22)
(61,23)
(61,24)
(61,25)
(61,26)
(61,27)
(61,28)
(61,29)
(61,30)
(61,31)
(61,32)
(61,33)
(61,34)
(61,35)
(61,36)
(61,37)
(61,38)
(61,39)
(61,40)
(61,41)
(61,42)
(61,43)
(61,44)
(61,45)
(61,46)
(61,47)
(61,48)
(61,49)
(61,50)
(62,13)
(62,14)
(62,15)
(62,16)
(62,17)
(62,18)
(62,19)
(62,20)
(62,21)
(62,22)
(62,23)
(62,24)
(62,25)
(62,26)
(62,27)
(62,28)
(62,29)
(62,30)
(62,31)
(62,32)
(62,33)
(62,34)
(62,35)
(62,36)
(62,37)
(62,38)
(62,39)
(62,40)
(62,41)
(62,42)
(62,43)
(62,44)
(62,45)
(62,46)
(62,47)
(62,48)
(62,49)
(62,50)
(63,14)
(63,15)
(63,16)
(63,17)
(63,18)
(63,19)
(63,20)
(63,21)
(63,22)
(63,23)
(63,24)
(63,25)
(63,26)
(63,27)
(63,28)
(63,29)
(63,30)
(63,31)
(63,32)
(63,33)
(63,34)
(63,35)
(63,36)
(63,37)
(63,38)
(63,39)
(63,40)
(63,41)
(63,42)
(63,43)
(63,44)
(63,45)
(63,46)
(63,47)
(63,48)
(63,49)
(63,50)
(64,15)
(64,16)
(64,17)
(64,18)
(64,19)
(64,20)
(64,21)
(64,22)
(64,23)
(64,24)
(64,25)
(64,26)
(64,27)
(64,28)
(64,29)
(64,30)
(64,31)
(64,32)
(64,33)
(64,34)
(64,35)
(64,36)
(64,37)
(64,38)
(64,39)
(64,40)
(64,41)
(64,42)
(64,43)
(64,44)
(64,45)
(64,46)
(64,47)
(64,48)
(64,49)
(64,50)
(65,16)
(65,17)
(65,18)
(65,19)
(65,20)
(65,21)
(65,22)
(65,23)
(65,24)
(65,25)
(65,26)
(65,27)
(65,28)
(65,29)
(65,30)
(65,31)
(65,32)
(65,33)
(65,34)
(65,35)
(65,36)
(65,37)
(65,38)
(65,39)
(65,40)
(65,41)
(65,42)
(65,43)
(65,44)
(65,45)
(65,46)
(65,47)
(65,48)
(65,49)
(65,50)
(66,17)
(66,18)
(66,19)
(66,20)
(66,21)
(66,22)
(66,23)
(66,24)
(66,25)
(66,26)
(66,27)
(66,28)
(66,29)
(66,30)
(66,31)
(66,32)
(66,33)
(66,34)
(66,35)
(66,36)
(66,37)
(66,38)
(66,39)
(66,40)
(66,41)
(66,42)
(66,43)
(66,44)
(66,45)
(66,46)
(66,47)
(66,48)
(66,49)
(66,50)
(67,18)
(67,19)
(67,20)
(67,21)
(67,22)
(67,23)
(67,24)
(67,25)
(67,26)
(67,27)
(67,28)
(67,29)
(67,30)
(67,31)
(67,32)
(67,33)
(67,34)
(67,35)
(67,36)
(67,37)
(67,38)
(67,39)
(67,40)
(67,41)
(67,42)
(67,43)
(67,44)
(67,45)
(67,46)
(67,47)
(67,48)
(67,49)
(67,50)
(68,19)
(68,20)
(68,21)
(68,22)
(68,23)
(68,24)
(68,25)
(68,26)
(68,27)
(68,28)
(68,29)
(68,30)
(68,31)
(68,32)
(68,33)
(68,34)
(68,35)
(68,36)
(68,37)
(68,38)
(68,39)
(68,40)
(68,41)
(68,42)
(68,43)
(68,44)
(68,45)
(68,46)
(68,47)
(68,48)
(68,49)
(68,50)
(69,20)
(69,21)
(69,22)
(69,23)
(69,24)
(69,25)
(69,26)
(69,27)
(69,28)
(69,29)
(69,30)
(69,31)
(69,32)
(69,33)
(69,34)
(69,35)
(69,36)
(69,37)
(69,38)
(69,39)
(69,40)
(69,41)
(69,42)
(69,43)
(69,44)
(69,45)
(69,46)
(69,47)
(69,48)
(69,49)
(69,50)
(70,21)
(70,22)
(70,23)
(70,24)
(70,25)
(70,26)
(70,27)
(70,28)
(70,29)
(70,30)
(70,31)
(70,32)
(70,33)
(70,34)
(70,35)
(70,36)
(70,37)
(70,38)
(70,39)
(70,40)
(70,41)
(70,42)
(70,43)
(70,44)
(70,45)
(70,46)
(70,47)
(70,48)
(70,49)
(70,50)
(71,22)
(71,23)
(71,24)
(71,25)
(71,26)
(71,27)
(71,28)
(71,29)
(71,30)
(71,31)
(71,32)
(71,33)
(71,34)
(71,35)
(71,36)
(71,37)
(71,38)
(71,39)
(71,40)
(71,41)
(71,42)
(71,43)
(71,44)
(71,45)
(71,46)
(71,47)
(71,48)
(71,49)
(71,50)
(72,23)
(72,24)
(72,25)
(72,26)
(72,27)
(72,28)
(72,29)
(72,30)
(72,31)
(72,32)
(72,33)
(72,34)
(72,35)
(72,36)
(72,37)
(72,38)
(72,39)
(72,40)
(72,41)
(72,42)
(72,43)
(72,44)
(72,45)
(72,46)
(72,47)
(72,48)
(72,49)
(72,50)
(73,24)
(73,25)
(73,26)
(73,27)
(73,28)
(73,29)
(73,30)
(73,31)
(73,32)
(73,33)
(73,34)
(73,35)
(73,36)
(73,37)
(73,38)
(73,39)
(73,40)
(73,41)
(73,42)
(73,43)
(73,44)
(73,45)
(73,46)
(73,47)
(73,48)
(73,49)
(73,50)
(74,25)
(74,26)
(74,27)
(74,28)
(74,29)
(74,30)
(74,31)
(74,32)
(74,33)
(74,34)
(74,35)
(74,36)
(74,37)
(74,38)
(74,39)
(74,40)
(74,41)
(74,42)
(74,43)
(74,44)
(74,45)
(74,46)
(74,47)
(74,48)
(74,49)
(74,50)
(75,26)
(75,27)
(75,28)
(75,29)
(75,30)
(75,31)
(75,32)
(75,33)
(75,34)
(75,35)
(75,36)
(75,37)
(75,38)
(75,39)
(75,40)
(75,41)
(75,42)
(75,43)
(75,44)
(75,45)
(75,46)
(75,47)
(75,48)
(75,49)
(75,50)
(76,27)
(76,28)
(76,29)
(76,30)
(76,31)
(76,32)
(76,33)
(76,34)
(76,35)
(76,36)
(76,37)
(76,38)
(76,39)
(76,40)
(76,41)
(76,42)
(76,43)
(76,44)
(76,45)
(76,46)
(76,47)
(76,48)
(76,49)
(76,50)
(77,28)
(77,29)
(77,30)
(77,31)
(77,32)
(77,33)
(77,34)
(77,35)
(77,36)
(77,37)
(77,38)
(77,39)
(77,40)
(77,41)
(77,42)
(77,43)
(77,44)
(77,45)
(77,46)
(77,47)
(77,48)
(77,49)
(77,50)
(78,29)
(78,30)
(78,31)
(78,32)
(78,33)
(78,34)
(78,35)
(78,36)
(78,37)
(78,38)
(78,39)
(78,40)
(78,41)
(78,42)
(78,43)
(78,44)
(78,45)
(78,46)
(78,47)
(78,48)
(78,49)
(78,50)
(79,30)
(79,31)
(79,32)
(79,33)
(79,34)
(79,35)
(79,36)
(79,37)
(79,38)
(79,39)
(79,40)
(79,41)
(79,42)
(79,43)
(79,44)
(79,45)
(79,46)
(79,47)
(79,48)
(79,49)
(79,50)
(80,31)
(80,32)
(80,33)
(80,34)
(80,35)
(80,36)
(80,37)
(80,38)
(80,39)
(80,40)
(80,41)
(80,42)
(80,43)
(80,44)
(80,45)
(80,46)
(80,47)
(80,48)
(80,49)
(80,50)
(81,32)
(81,33)
(81,34)
(81,35)
(81,36)
(81,37)
(81,38)
(81,39)
(81,40)
(81,41)
(81,42)
(81,43)
(81,44)
(81,45)
(81,46)
(81,47)
(81,48)
(81,49)
(81,50)
(82,33)
(82,34)
(82,35)
(82,36)
(82,37)
(82,38)
(82,39)
(82,40)
(82,41)
(82,42)
(82,43)
(82,44)
(82,45)
(82,46)
(82,47)
(82,48)
(82,49)
(82,50)
(83,34)
(83,35)
(83,36)
(83,37)
(83,38)
(83,39)
(83,40)
(83,41)
(83,42)
(83,43)
(83,44)
(83,45)
(83,46)
(83,47)
(83,48)
(83,49)
(83,50)
(84,35)
(84,36)
(84,37)
(84,38)
(84,39)
(84,40)
(84,41)
(84,42)
(84,43)
(84,44)
(84,45)
(84,46)
(84,47)
(84,48)
(84,49)
(84,50)
(85,36)
(85,37)
(85,38)
(85,39)
(85,40)
(85,41)
(85,42)
(85,43)
(85,44)
(85,45)
(85,46)
(85,47)
(85,48)
(85,49)
(85,50)
(86,37)
(86,38)
(86,39)
(86,40)
(86,41)
(86,42)
(86,43)
(86,44)
(86,45)
(86,46)
(86,47)
(86,48)
(86,49)
(86,50)
(87,38)
(87,39)
(87,40)
(87,41)
(87,42)
(87,43)
(87,44)
(87,45)
(87,46)
(87,47)
(87,48)
(87,49)
(87,50)
(88,39)
(88,40)
(88,41)
(88,42)
(88,43)
(88,44)
(88,45)
(88,46)
(88,47)
(88,48)
(88,49)
(88,50)
(89,40)
(89,41)
(89,42)
(89,43)
(89,44)
(89,45)
(89,46)
(89,47)
(89,48)
(89,49)
(89,50)
(90,41)
(90,42)
(90,43)
(90,44)
(90,45)
(90,46)
(90,47)
(90,48)
(90,49)
(90,50)
(91,42)
(91,43)
(91,44)
(91,45)
(91,46)
(91,47)
(91,48)
(91,49)
(91,50)
(92,43)
(92,44)
(92,45)
(92,46)
(92,47)
(92,48)
(92,49)
(92,50)
(93,44)
(93,45)
(93,46)
(93,47)
(93,48)
(93,49)
(93,50)
(94,45)
(94,46)
(94,47)
(94,48)
(94,49)
(94,50)
(95,46)
(95,47)
(95,48)
(95,49)
(95,50)
(96,47)
(96,48)
(96,49)
(96,50)
(97,48)
(97,49)
(97,50)
(98,49)
(98,50)
(99,50)
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