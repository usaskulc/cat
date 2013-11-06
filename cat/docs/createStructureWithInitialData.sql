CREATE DATABASE  IF NOT EXISTS `currimap` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `currimap`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: currimap
-- ------------------------------------------------------
-- Server version	5.1.45

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
-- Table structure for table `answer_option`
--

DROP TABLE IF EXISTS `answer_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_set_id` int(11) NOT NULL,
  `display` varchar(150) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_answer_option` (`id`),
  KEY `fk_answer_option_answer_set` (`answer_set_id`),
  CONSTRAINT `fk_answer_option_answer_set` FOREIGN KEY (`answer_set_id`) REFERENCES `answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_option`
--

LOCK TABLES `answer_option` WRITE;
/*!40000 ALTER TABLE `answer_option` DISABLE KEYS */;
INSERT INTO `answer_option` VALUES (1,1,'about 10 minutes','10',1),(2,1,'about 30 minutes','30',3),(3,1,'about an hour','60',4),(4,1,'more than an hour','100',5),(5,1,'about 20 minutes','20',2),(7,2,'Not at all','0',1),(8,2,'Somewhat','1',2),(9,2,'Often','2',3),(10,2,'Extensively','3',4),(11,3,'none','0',1),(12,3,'Level 1 (Prescribed Research) Highly structured directions and modelling from educator prompt student research','1',2),(13,3,'Level 2 (Bounded Research) Boundaries set by and limited directions from educator channel student research','2',3),(14,3,'Level 3 (Scaffolded Research) Scaffolds placed by educator shape student independent research','3',4),(15,3,'Level 4 (Student-initiated Research) Students initiate the research and this is guided by the educator','4',5),(16,3,'Level 5 (Open Research) Students research within self-determined guidelines that are in accord with discipline or context. ','5',6);
/*!40000 ALTER TABLE `answer_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_set`
--

DROP TABLE IF EXISTS `answer_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_set`
--

LOCK TABLES `answer_set` WRITE;
/*!40000 ALTER TABLE `answer_set` DISABLE KEYS */;
INSERT INTO `answer_set` VALUES (1,'TimeItTook'),(2,'Emphasis'),(3,'RSDLevels');
/*!40000 ALTER TABLE `answer_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `assessment_group_id` int(11) NOT NULL DEFAULT '1',
  `display_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_assessment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment`
--

LOCK TABLES `assessment` WRITE;
/*!40000 ALTER TABLE `assessment` DISABLE KEYS */;
INSERT INTO `assessment` VALUES (11,'Research Papers','(may require academic references or direct student research)',1,9),(22,'Participation or engagement','(may include attendance, contribution to class discussion)',2,3),(25,'Written Assignments','(completed weekly or in a shorter time frame)',1,10),(32,'Project','(may include a larger scale assignments, reports, or productions)',1,7),(34,'Skill demonstration','(may include practice, clinical or lab skills, fine or gross motor skills)',3,4),(35,'Essay','(may include compare or contrast, provide analysis, articulate an argument or provide rationale)',1,3),(36,'Presentation','(e.g., oral presentation of information, leadership of discussion, persuasive speech)',2,4),(38,'Reflection','(may include journaling, learning logs or blogs, portfolios)',1,8),(41,'Analysis','(e.g., current event report, document analysis, case study, critique)',1,1),(42,'Performance or production','(may include artistic performances or artifacts, media products)',3,2),(44,'Oral project presentation','(e.g., larger scale assignments, reports, or productions)',2,2),(47,'Oral Exam','(e.g., demonstration of oral language skills)',2,1),(48,'Final Exam - open-ended writing','(e.g., short-answer; essay)',4,2),(49,'Final Exam - closed question','(e.g., multiple choice; matching; true/false)',4,1),(50,'Final Exam - problem solving','(e.g., math proof; computation; formula application)',4,3),(51,'Midterm, content quiz, lab exam - closed questions','(e.g., multiple choice; matching; true/false)',4,5),(52,'Midterm, content quiz, lab exam - open-ended','(e.g., short-answer; essay)',4,6),(53,'Midterm, content quiz, lab exam - problem solving','(e.g., math proof; computation; formula application)',4,7),(54,'Final Lab Exam (e.g., sample identification)','',4,4),(55,'Problem set','(e.g., assignments involving solving, deriving or applying)',3,3),(60,'Lab Report','(reports on experiment, field-based research)',1,4),(61,'Portfolio','',1,6),(63,'Concept map','',1,2),(64,'Authentic Assessment','(applying knowledge and skills to real-world challenges; direct evidence)',3,1),(65,'Logbook','',1,5);
/*!40000 ALTER TABLE `assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_feedback_option`
--

DROP TABLE IF EXISTS `assessment_feedback_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_feedback_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `assessment_feedback_option_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_assessment_feedback_option` (`id`),
  KEY `fk_assessment_feedback_option_option_type` (`assessment_feedback_option_type_id`),
  CONSTRAINT `fk_assessment_feedback_option_option_type` FOREIGN KEY (`assessment_feedback_option_type_id`) REFERENCES `assessment_feedback_option_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_feedback_option`
--

LOCK TABLES `assessment_feedback_option` WRITE;
/*!40000 ALTER TABLE `assessment_feedback_option` DISABLE KEYS */;
INSERT INTO `assessment_feedback_option` VALUES (1,'within a week of due date',3,1),(2,'ongoing',2,1),(3,'after end of classes (before final)',6,1),(4,'after final',7,1),(5,'you(instructor)',1,2),(6,'other students (peer)',2,2),(7,'self (the student)',3,2),(8,'teaching assistant',4,2),(9,'not applicable',1,3),(10,'yes',2,3),(11,'no',3,3),(12,'not applicable',1,4),(13,'yes',2,4),(14,'no',3,4),(15,'upon request',4,4),(16,'Recall/Awareness',1,5),(17,'Practice or Synthesize',2,5),(18,'Apply',3,5),(19,'On their own',1,6),(20,'With others',2,6),(21,'Students were given the option to work alone or with others',3,6),(22,'clinical or practicum supervisor',5,2),(23,'never',1,1),(24,'Knowledge',1,7),(25,'Skills',2,7),(26,'Values/Attitudes',3,7),(27,'within two weeks of due date',4,1),(28,'within one month of due date',5,1),(29,'Knowledge & Skills',4,7),(30,'Knowledge & Values/Attitudes',5,7),(31,'Skills & Values/Attitudes',6,7),(32,'Knowledge, Skills & Values/Attitudes',7,7);
/*!40000 ALTER TABLE `assessment_feedback_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_feedback_option_type`
--

DROP TABLE IF EXISTS `assessment_feedback_option_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_feedback_option_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(300) NOT NULL,
  `display_index` int(11) NOT NULL,
  `question_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_assessment_feedback_option_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_feedback_option_type`
--

LOCK TABLES `assessment_feedback_option_type` WRITE;
/*!40000 ALTER TABLE `assessment_feedback_option_type` DISABLE KEYS */;
INSERT INTO `assessment_feedback_option_type` VALUES (1,'When did student receive feedback on this?',6,'select'),(2,'Who provided feedback? (select all that apply)',7,'checkbox'),(3,'Students were required to submit a draft or proposal for this?',5,'radio'),(4,'Students had the opportunity to receive feedback prior to due date?',4,'radio'),(5,'What is the level of engagement?',3,'checkbox'),(6,'Students completed this assignment:',1,'select'),(7,'Select the learning domain(s) that best describe(s) this learning outcome',2,'select');
/*!40000 ALTER TABLE `assessment_feedback_option_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_group`
--

DROP TABLE IF EXISTS `assessment_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_assessment_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_group`
--

LOCK TABLES `assessment_group` WRITE;
/*!40000 ALTER TABLE `assessment_group` DISABLE KEYS */;
INSERT INTO `assessment_group` VALUES (1,'Predominantly a written format that you then assess',2,'Writing'),(2,'Predominantly an oral format for assessment',3,'Speaking'),(3,'Predominantly a demonstration of ability',4,'Demonstrating/performing'),(4,'Midterm, Exams and Tests',1,'Test');
/*!40000 ALTER TABLE `assessment_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_time_option`
--

DROP TABLE IF EXISTS `assessment_time_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_time_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `time_period` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_assessment_time_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_time_option`
--

LOCK TABLES `assessment_time_option` WRITE;
/*!40000 ALTER TABLE `assessment_time_option` DISABLE KEYS */;
INSERT INTO `assessment_time_option` VALUES (3,'during first half',1,'Y'),(4,'at middle of term',2,'N'),(7,'during second half',3,'Y'),(8,'last 2 weeks of classes',4,'N'),(9,'after end of classes (before final)',5,'N'),(10,'ongoing',7,'O'),(11,'final exam period',6,'N');
/*!40000 ALTER TABLE `assessment_time_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characteristic`
--

DROP TABLE IF EXISTS `characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characteristic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `display_index` int(11) NOT NULL,
  `Characteristic_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_Characteristic` (`id`),
  KEY `fk_Characteristic` (`Characteristic_type_id`),
  CONSTRAINT `fk_Characteristic` FOREIGN KEY (`Characteristic_type_id`) REFERENCES `characteristic_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characteristic`
--

LOCK TABLES `characteristic` WRITE;
/*!40000 ALTER TABLE `characteristic` DISABLE KEYS */;
INSERT INTO `characteristic` VALUES (1,'Knowledge','Knowledge',1,1),(2,'Skills','Skills',2,1),(3,'Values/Attitudes','',3,1),(4,'Remember','Recall from memory.',1,2),(5,'Understand','Understand the concept',2,2),(6,'Apply','Apply the knowledge',3,2),(7,'Analyse/Evaluate/Create','',4,2),(10,'Recall / Awareness','',1,4),(11,'Practice or synthesize ','',2,4),(12,'Apply','',3,4),(32,'Self directed learning','',1,8),(33,'Social Agency','',2,8),(34,'Authentic Assessment','',3,8),(35,'Scaffolded experiences','',4,8),(36,'Introductory','',1,9),(37,'Intermediate','',2,9),(38,'Advanced','',3,9),(40,'Negligible','',1,10),(41,'Moderate','',2,10),(42,'Extensive','',3,10),(43,'Knowledge & Skills','',4,1),(44,'Knowledge & Values/Attitudes','',5,1),(45,'Skills & Values/Attitudes','',6,1),(46,'Knowledge, Skills & Values/Attitudes','',7,1),(47,'Extensively','',3,12),(48,'Not at all','',1,12),(49,'Somewhat','',2,12);
/*!40000 ALTER TABLE `characteristic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characteristic_type`
--

DROP TABLE IF EXISTS `characteristic_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characteristic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value_type` varchar(30) NOT NULL,
  `question_display` varchar(200) DEFAULT NULL,
  `short_display` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_Characteristic_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characteristic_type`
--

LOCK TABLES `characteristic_type` WRITE;
/*!40000 ALTER TABLE `characteristic_type` DISABLE KEYS */;
INSERT INTO `characteristic_type` VALUES (1,'Learning Domain','String','Select the learning domain(s) that best describe(s) this learning outcome:','Learning Domain'),(2,'Bloom\'s taxonomy','String','Under what Bloom\'s taxonomy category does this fit best ?','Bloom\'s'),(4,'Levels of Engagement with Concept/Indicator','String','What is the level of engagement?','Engagement'),(8,'Authentic Learning','String','What type of authentic learning does this relate to?','Authentic Learning'),(9,'Depth','String','The level of depth at which this outcome is addressed:','Depth'),(10,'Emphasis','String','The extent of instructional emphasis placed on this outcome:','Emphasis'),(12,'Ways of knowing: Indigenous knowledge','String','To what extent is Indigenous content, perspectives and/or ways of knowing embedded in this learning outcome?','default short value'),(13,'test','NOT SET','No Question set yet','default short value');
/*!40000 ALTER TABLE `characteristic_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contribution_option_value`
--

DROP TABLE IF EXISTS `contribution_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contribution_option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_contribution_option_values` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contribution_option_value`
--

LOCK TABLES `contribution_option_value` WRITE;
/*!40000 ALTER TABLE `contribution_option_value` DISABLE KEYS */;
INSERT INTO `contribution_option_value` VALUES (1,'negligible',2,1),(2,'moderate',3,2),(3,'extensive',4,3),(5,'not at all',1,0);
/*!40000 ALTER TABLE `contribution_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(10) NOT NULL,
  `course_number` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4498 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (3851,'BASK',101,'Survey of the History of Basket Weaving',''),(3852,'BASK',201,'Making Baskets with Aesthetic merit',''),(4208,'BASK',300,'advanced weaving','practical application course to demonstrate dexterity and intricate technique'),(4209,'BASK',105,'Fundamentals in Basket Weaving Technique',''),(4211,'BASK',404,'External internship in Basket Weaving',''),(4311,'BASK',303,'Contemporary weaving applications',''),(4314,'BASK',900,'Dissertation in basketweaving',''),(4391,'BASK',400,'Presentation in department seminar series',''),(4392,'BASK',202,'Structures of baskets',''),(4393,'BASK',301,'Corporate Basket Weaving',''),(4473,'BASK',499,'Honours thesis',''),(4495,'BASK',115,'Geographical dispersion of materials',''),(4496,'BASK',676,'Trial by Fire',''),(4497,'BASK',444,'seminar','');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_attribute`
--

DROP TABLE IF EXISTS `course_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_course_attribute` (`id`),
  KEY `fk_course_attribute_organization` (`organization_id`),
  CONSTRAINT `fk_course_attribute_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_attribute`
--

LOCK TABLES `course_attribute` WRITE;
/*!40000 ALTER TABLE `course_attribute` DISABLE KEYS */;
INSERT INTO `course_attribute` VALUES (2,'Natural Science',12),(3,'Math',12),(4,'Complementary Studies',12),(5,'Engineering Science',12),(6,'Engineering Design',12),(7,'Natural Science',19),(8,'Math',19),(9,'Complementary Studies',19),(10,'Engineering Science',19),(11,'Engineering Design',19);
/*!40000 ALTER TABLE `course_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_attribute_value`
--

DROP TABLE IF EXISTS `course_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_attribute_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `course_attribute_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_course_attribute_value` (`id`),
  KEY `fk_course_attribute_value_attr` (`course_attribute_id`),
  KEY `fk_course_attribute_value_course` (`course_id`),
  CONSTRAINT `fk_course_attribute_value_attr` FOREIGN KEY (`course_attribute_id`) REFERENCES `course_attribute` (`id`),
  CONSTRAINT `fk_course_attribute_value_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_attribute_value`
--

LOCK TABLES `course_attribute_value` WRITE;
/*!40000 ALTER TABLE `course_attribute_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_classification`
--

DROP TABLE IF EXISTS `course_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `display_index` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `PK_course_classification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_classification`
--

LOCK TABLES `course_classification` WRITE;
/*!40000 ALTER TABLE `course_classification` DISABLE KEYS */;
INSERT INTO `course_classification` VALUES (1,'Required','This courses is a requirement for the program',1),(2,'an Elective','This courses is an optional component for the program',4),(3,'depends on specialization','This course could be required, it would depend on their specialization',3),(4,'recommended','This course is recommended for the program',2);
/*!40000 ALTER TABLE `course_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_offering`
--

DROP TABLE IF EXISTS `course_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_offering` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `term` varchar(6) NOT NULL,
  `section_number` varchar(4) DEFAULT NULL,
  `medium` varchar(20) DEFAULT NULL,
  `num_students` int(11) DEFAULT NULL,
  `comments` text,
  `time_it_took_id` int(11) DEFAULT NULL,
  `teaching_comment` text,
  `outcome_comment` text,
  `contribution_comment` text,
  PRIMARY KEY (`id`),
  KEY `PK_course_offering` (`id`),
  KEY `fk_course_offering_course` (`course_id`),
  CONSTRAINT `fk_course_offering_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52462 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offering`
--

LOCK TABLES `course_offering` WRITE;
/*!40000 ALTER TABLE `course_offering` DISABLE KEYS */;
INSERT INTO `course_offering` VALUES (13691,3851,'201109','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(13692,3852,'201109','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(31993,3851,'201209','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(31995,3851,'201209','02','Blended',0,NULL,NULL,NULL,NULL,NULL),(40180,3851,'201109','06','Face to face',0,NULL,2,'',NULL,NULL),(40181,4211,'201109','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(40182,3851,'201109','05','Face to face',0,NULL,NULL,NULL,NULL,NULL),(40183,4209,'201109','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(40185,3852,'201109','02','Face to face',0,NULL,NULL,NULL,NULL,NULL),(40187,3851,'201109','02','Face to face',0,NULL,NULL,NULL,NULL,NULL),(40188,3851,'201209','03','Face to face',0,NULL,2,NULL,NULL,NULL),(40189,4208,'201109','01','Face to face',0,'weaving is fun',1,NULL,NULL,NULL),(46098,4393,'201301','01','Face to face',0,NULL,NULL,NULL,NULL,NULL),(52423,4209,'201109','02','Face to face',0,NULL,NULL,NULL,NULL,NULL),(52425,4209,'201301','03','Face to face',0,NULL,1,'this is my course ',NULL,NULL),(52426,3851,'201209','04','Face to face',0,NULL,NULL,NULL,NULL,NULL),(52429,4311,'201209','01','Face to face',0,NULL,NULL,'More information here\n',NULL,NULL),(52448,4209,'201109','11','Face to face',0,NULL,NULL,'testing\n123',NULL,NULL),(52451,4311,'201209','02','Face to face',0,NULL,NULL,NULL,NULL,NULL),(52459,3851,'201301','06','Face to face',0,NULL,NULL,'',NULL,NULL),(52461,4496,'201109','01','Face to face',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `course_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_outcome`
--

DROP TABLE IF EXISTS `course_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(400) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `course_outcome_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_course_outcome` (`id`),
  KEY `fk_course_outcome_course_outcome_group` (`course_outcome_group_id`),
  CONSTRAINT `fk_course_outcome_course_outcome_group` FOREIGN KEY (`course_outcome_group_id`) REFERENCES `course_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1436 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_outcome`
--

LOCK TABLES `course_outcome` WRITE;
/*!40000 ALTER TABLE `course_outcome` DISABLE KEYS */;
INSERT INTO `course_outcome` VALUES (432,'Knowing which types of wicker are good to use','',NULL),(433,'Selecting for the maximum flexibility of wicker strands','',NULL),(434,'Ability to create a small (< 10\") basket','',NULL),(435,'Develop an appreciation for the weaving of Baskets','',NULL),(465,'Participate in the collegial  profession of Basket Weavers','',NULL),(470,'select appropriate weaving materials','',NULL),(471,'select appropriate weaving materials','',NULL),(472,'select appropriate materials','',NULL),(477,'Plan patterns with colourful materials','',NULL),(478,'Understand the process of basket weaving.','',NULL),(483,'articulate 3 modes of thought about baskets','',NULL),(485,'By the end of this course the student should be able create a basket by applying the weaving skill.','',NULL),(533,'By the end of this course the students will communicate the benefits of basket weaving. ','',NULL),(534,'By the end of this course the student should be able to demonstrate their skill by weaving a basket','',NULL),(549,'recall the basic variations in patterns for baskets','',NULL),(550,'describe the differences between historic patterns','',NULL),(551,'create the proper weave technique','',NULL),(552,'weave 10 baskets in one hour','',NULL),(579,'By the end of this course the students should be able to construct  an functional basket.','',NULL),(984,'No match to a course outcome',NULL,NULL),(985,'weave','',NULL),(1187,'APA writing style knowledge ','',NULL),(1434,'Apply critical thinking skills','',NULL),(1435,'Reflection on learning experience ','',NULL);
/*!40000 ALTER TABLE `course_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_outcome_group`
--

DROP TABLE IF EXISTS `course_outcome_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_outcome_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `department_specific` varchar(1) NOT NULL,
  `department_id` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `PK_course_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_outcome_group`
--

LOCK TABLES `course_outcome_group` WRITE;
/*!40000 ALTER TABLE `course_outcome_group` DISABLE KEYS */;
INSERT INTO `course_outcome_group` VALUES (1,'Gwenna Moss Centre Custom',NULL,'Y',1),(2,'Custom',NULL,'N',-1);
/*!40000 ALTER TABLE `course_outcome_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `ldap_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Gwenna Moss Centre','Gwenna Moss Centre'),(117,'Test Classes','Test Classes');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_feature` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,'Inventory: My Instructional Methods',1,'editableTeachingMethods'),(2,'Inventory: My Assessment Methods',2,'assessmentMethods'),(3,'Inventory: My Course Learning Outcomes',3,'outcomes'),(4,'Identifying Congruencies: How I Assess for My Course Learning Outcomes',4,'outcomeAssessmentMapping'),(5,'Identifying Congruencies: My Course Within this Program',5,'programOutcomeContributions'),(6,'Identifying Congruencies: My Course Outcomes in Relation to Program Outcomes',6,'outcomesMapping'),(7,'Some final questions',7,'completionTime');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(30) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2496 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES (2236,'cah793','Carolyn','Hoessler'),(2495,'CATvisitor','Carolyn','Hoessler');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_attribute`
--

DROP TABLE IF EXISTS `instructor_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_instructor_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_attribute`
--

LOCK TABLES `instructor_attribute` WRITE;
/*!40000 ALTER TABLE `instructor_attribute` DISABLE KEYS */;
INSERT INTO `instructor_attribute` VALUES (4,'Professional Registration',12),(5,'PhD',12);
/*!40000 ALTER TABLE `instructor_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_attribute_value`
--

DROP TABLE IF EXISTS `instructor_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_attribute_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) NOT NULL,
  `instructor_attribute_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_instructor_attribute_value` (`id`),
  KEY `fk_instructor_attribute_value_attr` (`instructor_attribute_id`),
  KEY `fk_instructor_attribute_value_instructor` (`instructor_id`),
  CONSTRAINT `fk_instructor_attribute_value_attr` FOREIGN KEY (`instructor_attribute_id`) REFERENCES `instructor_attribute` (`id`),
  CONSTRAINT `fk_instructor_attribute_value_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_attribute_value`
--

LOCK TABLES `instructor_attribute_value` WRITE;
/*!40000 ALTER TABLE `instructor_attribute_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_assessment_course_outcome`
--

DROP TABLE IF EXISTS `link_assessment_course_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_assessment_course_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `course_outcome_id` int(11) NOT NULL,
  `link_assessment_course_offering_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_assessment_course_outcome` (`id`),
  KEY `fk_link_assessment_course_outcome_course_outcome` (`course_outcome_id`),
  KEY `fk_link_assessment_course_outcome_link_asses_co` (`link_assessment_course_offering_id`),
  CONSTRAINT `fk_link_assessment_course_outcome_course_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`),
  CONSTRAINT `fk_link_assessment_course_outcome_link_asses_co` FOREIGN KEY (`link_assessment_course_offering_id`) REFERENCES `link_course_offering_assessment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_assessment_course_outcome`
--

LOCK TABLES `link_assessment_course_outcome` WRITE;
/*!40000 ALTER TABLE `link_assessment_course_outcome` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_assessment_course_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_assessment_feedback_option_value`
--

DROP TABLE IF EXISTS `link_course_assessment_feedback_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_assessment_feedback_option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessment_feedback_option_id` int(11) NOT NULL,
  `link_course_offering_assessment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_assessment_feedback_option_value` (`id`),
  KEY `fk_link_course_assessment_feedback_option_value_option` (`assessment_feedback_option_id`),
  KEY `fk_link_course_assessment_feedback_option_value_link` (`link_course_offering_assessment_id`),
  CONSTRAINT `fk_link_course_assessment_feedback_option_value_link` FOREIGN KEY (`link_course_offering_assessment_id`) REFERENCES `link_course_offering_assessment` (`id`),
  CONSTRAINT `fk_link_course_assessment_feedback_option_value_option` FOREIGN KEY (`assessment_feedback_option_id`) REFERENCES `assessment_feedback_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12946 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_assessment_feedback_option_value`
--

LOCK TABLES `link_course_assessment_feedback_option_value` WRITE;
/*!40000 ALTER TABLE `link_course_assessment_feedback_option_value` DISABLE KEYS */;
INSERT INTO `link_course_assessment_feedback_option_value` VALUES (437,1,109),(438,9,109),(439,12,109),(440,1,110),(441,9,110),(442,12,110),(452,1,114),(453,9,114),(454,12,114),(642,2,141),(643,6,141),(644,7,141),(645,9,141),(646,12,141),(647,16,141),(648,19,141),(678,1,145),(679,9,145),(680,12,145),(681,16,145),(682,19,145),(689,1,147),(690,9,147),(691,12,147),(692,16,147),(693,19,147),(706,1,148),(707,8,148),(708,9,148),(709,12,148),(710,18,148),(711,19,148),(712,1,142),(713,5,142),(714,9,142),(715,12,142),(716,18,142),(717,19,142),(912,1,187),(913,9,187),(914,12,187),(915,16,187),(916,19,187),(923,1,190),(924,9,190),(925,12,190),(929,2,192),(930,6,192),(931,7,192),(932,9,192),(933,12,192),(934,16,192),(935,19,192),(939,1,144),(940,5,144),(941,9,144),(942,12,144),(943,16,144),(944,19,144),(971,1,196),(972,5,196),(973,9,196),(974,12,196),(975,18,196),(976,19,196),(977,1,197),(978,5,197),(979,9,197),(980,12,197),(981,16,197),(982,19,197),(983,1,198),(984,8,198),(985,9,198),(986,12,198),(987,18,198),(988,19,198),(994,1,200),(995,9,200),(996,12,200),(997,16,200),(998,19,200),(999,1,201),(1000,9,201),(1001,12,201),(1002,16,201),(1003,19,201),(1033,1,205),(1034,5,205),(1035,9,205),(1036,12,205),(1037,17,205),(1038,19,205),(1098,1,216),(1099,5,216),(1100,6,216),(1101,7,216),(1102,10,216),(1103,13,216),(1104,18,216),(1105,21,216),(1112,1,218),(1113,5,218),(1114,6,218),(1115,7,218),(1116,10,218),(1117,13,218),(1118,17,218),(1119,20,218),(1417,1,256),(1418,9,256),(1419,12,256),(1420,16,256),(1421,19,256),(1422,1,257),(1423,9,257),(1424,12,257),(1425,16,257),(1426,19,257),(1427,4,258),(1428,8,258),(1429,9,258),(1430,12,258),(1431,16,258),(1432,19,258),(1433,1,259),(1434,9,259),(1435,12,259),(1436,16,259),(1437,19,259),(1833,1,296),(1834,5,296),(1835,9,296),(1836,12,296),(1837,16,296),(1838,19,296),(1839,26,296),(1946,23,321),(1947,5,321),(1948,8,321),(1949,9,321),(1950,12,321),(1951,16,321),(1952,19,321),(1953,24,321),(1954,1,322),(1955,9,322),(1956,12,322),(1957,19,322),(1958,24,322),(1959,4,323),(1960,5,323),(1961,9,323),(1962,12,323),(1963,16,323),(1964,19,323),(1965,24,323),(2262,1,295),(2263,5,295),(2264,9,295),(2265,12,295),(2266,17,295),(2267,19,295),(2268,25,295),(2269,1,297),(2270,5,297),(2271,9,297),(2272,12,297),(2273,16,297),(2274,19,297),(2275,24,297),(2325,1,219),(2326,8,219),(2327,9,219),(2328,12,219),(2329,16,219),(2330,19,219),(2331,24,219),(3625,1,476),(3626,9,476),(3627,12,476),(3628,18,476),(3629,19,476),(3630,24,476),(4336,1,186),(4337,5,186),(4338,9,186),(4339,12,186),(4340,16,186),(4341,19,186),(4342,24,186),(5686,2,539),(5687,5,539),(5688,9,539),(5689,13,539),(5690,18,539),(5691,19,539),(5692,26,539),(5916,1,702),(5917,9,702),(5918,12,702),(5919,19,702),(5920,24,702),(5931,1,705),(5932,9,705),(5933,12,705),(5934,19,705),(5935,24,705),(5997,1,293),(5998,5,293),(5999,9,293),(6000,12,293),(6001,16,293),(6002,19,293),(6003,24,293),(6805,1,790),(6806,10,790),(6807,14,790),(6808,18,790),(6809,21,790),(6810,24,790),(9016,20,1022),(9017,31,1022),(9018,17,1022),(9019,12,1022),(9020,9,1022),(9021,23,1022),(9022,20,1023),(9023,31,1023),(9024,17,1023),(9025,12,1023),(9026,9,1023),(9027,1,1023),(9028,5,1023),(9029,8,1023),(9030,21,1024),(9031,26,1024),(9032,16,1024),(9033,14,1024),(9034,9,1024),(9035,23,1024),(9036,21,1025),(9037,26,1025),(9038,16,1025),(9039,14,1025),(9040,9,1025),(9041,23,1025),(9042,21,1026),(9043,26,1026),(9044,16,1026),(9045,14,1026),(9046,9,1026),(9047,23,1026),(9048,21,1027),(9049,26,1027),(9050,16,1027),(9051,14,1027),(9052,9,1027),(9053,23,1027),(9054,20,793),(9055,30,793),(9056,17,793),(9057,15,793),(9058,11,793),(9059,27,793),(9060,5,793),(9061,8,793),(9067,19,791),(9068,24,791),(9069,12,791),(9070,9,791),(9071,1,791),(9293,19,475),(9294,24,475),(9295,12,475),(9296,9,475),(9297,1,475),(9298,5,475),(9357,19,340),(9358,32,340),(9359,18,340),(9360,15,340),(9361,11,340),(9362,1,340),(9363,5,340),(11208,1,1239),(11209,5,1239),(11210,9,1239),(11211,12,1239),(11212,17,1239),(11213,19,1239),(11214,25,1239),(11222,1,1241),(11223,5,1241),(11224,9,1241),(11225,12,1241),(11226,16,1241),(11227,19,1241),(11228,24,1241),(11235,1,1243),(11236,9,1243),(11237,12,1243),(11238,18,1243),(11239,19,1243),(11240,24,1243),(11241,1,1244),(11242,8,1244),(11243,9,1244),(11244,12,1244),(11245,16,1244),(11246,19,1244),(11247,24,1244),(11255,1,1246),(11256,5,1246),(11257,9,1246),(11258,12,1246),(11259,17,1246),(11260,19,1246),(11261,25,1246),(11262,1,1247),(11263,5,1247),(11264,9,1247),(11265,12,1247),(11266,16,1247),(11267,19,1247),(11268,26,1247),(11269,1,1248),(11270,5,1248),(11271,9,1248),(11272,12,1248),(11273,16,1248),(11274,19,1248),(11275,24,1248),(11276,19,1249),(11277,24,1249),(11278,12,1249),(11279,9,1249),(11280,1,1249),(11281,5,1249),(11282,1,1250),(11283,9,1250),(11284,12,1250),(11285,18,1250),(11286,19,1250),(11287,24,1250),(11288,1,1251),(11289,8,1251),(11290,9,1251),(11291,12,1251),(11292,16,1251),(11293,19,1251),(11294,24,1251),(11295,19,1252),(11296,32,1252),(11297,18,1252),(11298,15,1252),(11299,11,1252),(11300,1,1252),(11301,5,1252),(12472,19,1380),(12473,24,1380),(12474,12,1380),(12475,9,1380),(12476,23,1380),(12498,21,1384),(12499,31,1384),(12500,18,1384),(12501,12,1384),(12502,9,1384),(12503,23,1384),(12504,19,1385),(12505,24,1385),(12506,12,1385),(12507,9,1385),(12508,23,1385),(12509,19,792),(12510,32,792),(12511,12,792),(12512,9,792),(12513,27,792),(12514,5,792),(12609,19,1398),(12610,24,1398),(12611,17,1398),(12612,12,1398),(12613,9,1398),(12614,2,1398),(12615,5,1398),(12681,21,1409),(12682,30,1409),(12683,16,1409),(12684,17,1409),(12685,18,1409),(12686,13,1409),(12687,11,1409),(12688,2,1409),(12689,5,1409),(12690,8,1409),(12721,1,1413),(12722,5,1413),(12723,9,1413),(12724,12,1413),(12725,16,1413),(12726,19,1413),(12727,24,1413),(12728,1,1414),(12729,9,1414),(12730,12,1414),(12731,16,1414),(12732,19,1414),(12733,1,1415),(12734,9,1415),(12735,12,1415),(12736,19,1415),(12737,24,1415),(12738,19,1416),(12739,24,1416),(12740,12,1416),(12741,9,1416),(12742,23,1416),(12743,19,1417),(12744,24,1417),(12745,12,1417),(12746,9,1417),(12747,23,1417),(12748,1,1418),(12749,9,1418),(12750,12,1418),(12751,1,1419),(12752,5,1419),(12753,9,1419),(12754,12,1419),(12755,17,1419),(12756,19,1419),(12757,1,1420),(12758,5,1420),(12759,9,1420),(12760,12,1420),(12761,16,1420),(12762,19,1420),(12763,24,1420),(12764,19,1421),(12765,24,1421),(12766,17,1421),(12767,12,1421),(12768,9,1421),(12769,2,1421),(12770,5,1421),(12771,2,1422),(12772,6,1422),(12773,7,1422),(12774,9,1422),(12775,12,1422),(12776,16,1422),(12777,19,1422),(12778,21,1423),(12779,31,1423),(12780,18,1423),(12781,12,1423),(12782,9,1423),(12783,23,1423),(12818,19,1428),(12819,24,1428),(12820,12,1428),(12821,9,1428),(12822,23,1428),(12823,20,1399),(12824,24,1399),(12825,18,1399),(12826,13,1399),(12827,11,1399),(12828,27,1399),(12829,7,1399),(12830,19,1245),(12831,32,1245),(12832,18,1245),(12833,15,1245),(12834,11,1245),(12835,1,1245),(12836,5,1245),(12837,19,1242),(12838,24,1242),(12839,12,1242),(12840,9,1242),(12841,1,1242),(12842,5,1242),(12843,19,1240),(12844,26,1240),(12845,16,1240),(12846,12,1240),(12847,9,1240),(12848,1,1240),(12849,5,1240),(12902,19,1433),(12903,24,1433),(12904,16,1433),(12905,12,1433),(12906,9,1433),(12907,27,1433),(12908,5,1433),(12909,19,1434),(12910,24,1434),(12911,18,1434),(12912,12,1434),(12913,9,1434),(12914,27,1434),(12915,5,1434),(12922,19,1436),(12923,29,1436),(12924,18,1436),(12925,14,1436),(12926,11,1436),(12927,28,1436),(12928,5,1436),(12929,6,1436),(12930,7,1436),(12931,19,1437),(12932,29,1437),(12933,18,1437),(12934,13,1437),(12935,9,1437),(12936,4,1437),(12937,5,1437),(12938,6,1437),(12939,7,1437),(12940,19,1438),(12941,24,1438),(12942,16,1438),(12943,12,1438),(12944,9,1438),(12945,23,1438);
/*!40000 ALTER TABLE `link_course_assessment_feedback_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_contribution_program_outcome`
--

DROP TABLE IF EXISTS `link_course_contribution_program_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_contribution_program_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `contribution_option_id` int(11) NOT NULL,
  `mastery_option_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `PK_link_course_outcome_program_outcome` (`id`),
  KEY `fk_link_course_contribution_program_outcome_course` (`course_id`),
  KEY `fk_llink_course_contribution_program_outcome_contribution` (`contribution_option_id`),
  CONSTRAINT `fk_link_course_contribution_program_outcome_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_llink_course_contribution_program_outcome_contribution` FOREIGN KEY (`contribution_option_id`) REFERENCES `contribution_option_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1819 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_contribution_program_outcome`
--

LOCK TABLES `link_course_contribution_program_outcome` WRITE;
/*!40000 ALTER TABLE `link_course_contribution_program_outcome` DISABLE KEYS */;
INSERT INTO `link_course_contribution_program_outcome` VALUES (29,3851,84,5,1),(30,3851,85,5,1),(31,3851,86,5,1),(32,3851,87,5,1),(33,3851,88,5,1),(34,3851,89,5,1),(35,3851,90,5,1),(36,3851,91,5,1),(37,3851,92,5,1),(108,4209,84,1,1),(109,4209,85,3,1),(110,4209,86,5,1),(111,4209,87,5,1),(112,4209,88,5,1),(113,4209,89,5,1),(114,4209,90,5,1),(115,4209,91,5,1),(116,4209,92,5,1),(126,4211,84,5,1),(127,4211,85,5,1),(128,4211,86,5,1),(129,4211,87,5,1),(130,4211,88,5,1),(131,4211,89,5,1),(132,4211,90,5,1),(133,4211,91,5,1),(134,4211,92,5,1),(203,4311,84,5,1),(204,4311,85,5,1),(205,4311,86,5,1),(206,4311,87,5,1),(207,4311,88,5,1),(208,4311,89,5,1),(209,4311,90,5,1),(210,4311,91,5,1),(211,4311,92,5,1),(294,4311,199,5,1),(353,4314,199,5,1),(354,4314,84,5,1),(355,4314,85,5,1),(356,4314,86,5,1),(357,4314,87,5,1),(358,4314,88,5,1),(359,4314,89,5,1),(360,4314,90,5,1),(361,4314,91,5,1),(362,4314,92,5,1),(363,4208,199,5,1),(364,4208,84,5,1),(365,4208,85,5,1),(366,4208,86,5,1),(367,4208,87,5,1),(368,4208,88,5,1),(369,4208,89,5,1),(370,4208,90,5,1),(371,4208,91,5,1),(372,4208,92,5,1),(384,4208,230,5,1),(385,4311,230,5,1),(420,4392,233,5,1),(682,4209,199,5,1),(683,4209,230,5,1),(684,3852,199,5,1),(685,3852,84,5,1),(686,3852,85,5,1),(687,3852,86,5,1),(688,3852,87,5,1),(689,3852,88,5,1),(690,3852,89,5,1),(691,3852,230,5,1),(692,3852,90,5,1),(693,3852,91,5,1),(694,3852,92,5,1),(695,4211,199,5,1),(696,4211,230,5,1),(697,3851,199,5,1),(698,3851,230,5,1),(1021,4473,199,5,1),(1022,4473,84,5,1),(1023,4473,85,5,1),(1024,4473,86,5,1),(1025,4473,87,5,1),(1026,4473,88,5,1),(1027,4473,89,5,1),(1028,4473,230,5,1),(1029,4473,90,5,1),(1030,4473,91,5,1),(1031,4473,92,5,1),(1695,4495,199,5,1),(1696,4495,84,5,1),(1697,4495,85,5,1),(1698,4495,86,5,1),(1699,4495,87,5,1),(1700,4495,88,5,1),(1701,4495,89,5,1),(1702,4495,230,5,1),(1703,4495,90,5,1),(1704,4495,91,5,1),(1705,4495,92,5,1),(1807,4496,199,5,1),(1808,4496,84,5,1),(1809,4496,85,5,1),(1810,4496,86,5,1),(1811,4496,87,5,1),(1812,4496,88,5,1),(1813,4496,89,5,1),(1814,4496,230,5,1),(1815,4496,90,5,1),(1816,4496,91,5,1),(1817,4496,92,5,1),(1818,4497,1,5,1);
/*!40000 ALTER TABLE `link_course_contribution_program_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_department`
--

DROP TABLE IF EXISTS `link_course_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_department` (`id`),
  KEY `fk_link_course_department_course` (`course_id`),
  KEY `fk_link_course_department_department` (`department_id`),
  CONSTRAINT `fk_link_course_department_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_department_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4639 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_department`
--

LOCK TABLES `link_course_department` WRITE;
/*!40000 ALTER TABLE `link_course_department` DISABLE KEYS */;
INSERT INTO `link_course_department` VALUES (3840,1,3851),(3841,1,3852),(4416,1,4211),(4417,1,4209),(4549,1,4208),(4630,1,4391),(4631,1,4392),(4638,1,4393);
/*!40000 ALTER TABLE `link_course_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_assessment`
--

DROP TABLE IF EXISTS `link_course_offering_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_assessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `weight` double(6,3) DEFAULT NULL,
  `assessment_time_option_id` int(11) NOT NULL,
  `additional_info` varchar(1000) DEFAULT NULL,
  `criterion_exists` varchar(1) NOT NULL DEFAULT 'N',
  `criterion_level` double(5,3) NOT NULL DEFAULT '0.000',
  `criterion_completion_required` varchar(1) NOT NULL DEFAULT 'N',
  `criterion_submit_required` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `PK_link_course_assessment` (`id`),
  KEY `fk_link_course_offering_assessment_course` (`course_offering_id`),
  KEY `fk_link_course_offering_assessment_time_option` (`assessment_time_option_id`),
  KEY `fk_link_course_offering_assessment_assessment` (`assessment_id`),
  CONSTRAINT `fk_link_course_offering_assessment_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `fk_link_course_offering_assessment_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_assessment_time_option` FOREIGN KEY (`assessment_time_option_id`) REFERENCES `assessment_time_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1439 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_assessment`
--

LOCK TABLES `link_course_offering_assessment` WRITE;
/*!40000 ALTER TABLE `link_course_offering_assessment` DISABLE KEYS */;
INSERT INTO `link_course_offering_assessment` VALUES (109,13692,32,50.000,4,'Making a exceptionally pretty basket, a plan','N',0.000,'N','N'),(110,13692,32,50.000,9,'Making a exceptionally pretty basket, the final product','N',0.000,'N','N'),(114,13691,25,10.000,7,'Assignment 4','N',0.000,'N','N'),(141,13691,38,5.000,10,'Journal','N',0.000,'N','N'),(142,31993,35,5.000,3,'','N',0.000,'N','N'),(144,31993,35,10.000,3,'','Y',50.000,'N','N'),(145,31993,44,10.000,7,'','N',0.000,'N','N'),(147,31993,38,20.000,8,'','N',0.000,'N','N'),(148,31993,36,10.000,3,'','N',0.000,'N','N'),(186,40180,25,5.000,3,' article review','N',0.000,'N','N'),(187,40180,25,10.000,3,NULL,'N',0.000,'N','N'),(190,40180,25,10.000,7,NULL,'N',0.000,'N','N'),(192,40180,38,5.000,10,NULL,'N',0.000,'N','N'),(196,40182,35,5.000,3,NULL,'N',0.000,'N','N'),(197,40182,35,10.000,3,NULL,'Y',50.000,'N','N'),(198,40182,36,10.000,3,NULL,'N',0.000,'N','N'),(200,40182,44,10.000,7,NULL,'N',0.000,'N','N'),(201,40182,38,20.000,8,NULL,'N',0.000,'N','N'),(205,40180,36,10.000,7,'','N',0.000,'N','N'),(216,40181,32,30.000,3,'','Y',85.000,'N','N'),(218,40181,34,40.000,7,'','N',0.000,'N','N'),(219,40183,11,10.000,7,'','N',0.000,'N','N'),(256,40181,49,30.000,3,'','N',0.000,'N','N'),(257,40182,49,0.000,3,'','N',0.000,'N','N'),(258,40182,49,30.000,9,'','N',0.000,'N','N'),(259,40182,48,15.000,9,'','N',0.000,'N','N'),(293,40180,49,30.000,9,'','N',0.000,'N','N'),(295,40183,48,10.000,3,'','N',0.000,'N','N'),(296,40183,51,20.000,3,'','N',0.000,'N','N'),(297,40183,41,10.000,3,'','N',0.000,'N','N'),(321,40188,49,20.000,9,'','N',0.000,'N','N'),(322,40188,32,20.000,4,'','N',0.000,'N','N'),(323,40189,49,40.000,9,'','Y',70.000,'Y','Y'),(340,40183,64,25.000,8,'Must make a basket','Y',0.000,'Y','Y'),(475,40183,51,20.000,3,'','N',0.000,'Y','Y'),(476,40183,41,5.000,3,'','N',0.000,'N','N'),(539,40189,22,20.000,10,'','Y',0.000,'Y','Y'),(702,13692,49,0.000,3,'','N',0.000,'N','N'),(705,40180,41,10.000,3,'','N',0.000,'N','N'),(790,52425,63,30.000,3,'','N',0.000,'N','N'),(791,52425,51,20.000,4,'','N',0.000,'N','N'),(792,52425,61,25.000,9,'','Y',75.000,'Y','Y'),(793,52425,44,5.000,3,'','N',0.000,'N','N'),(1022,52429,35,0.000,7,'','N',0.000,'N','N'),(1023,52429,35,0.000,7,'','N',20.000,'N','N'),(1024,52429,61,0.000,7,'','N',0.000,'N','N'),(1025,52429,61,0.000,7,'','N',0.000,'N','N'),(1026,52429,61,0.000,7,'','N',0.000,'N','N'),(1027,52429,61,0.000,7,'','N',0.000,'N','N'),(1239,52448,48,10.000,3,NULL,'N',0.000,'N','N'),(1240,52448,51,15.000,3,'','N',0.000,'N','N'),(1241,52448,41,10.000,3,NULL,'N',0.000,'N','N'),(1242,52448,51,15.000,3,'','N',0.000,'Y','Y'),(1243,52448,41,5.000,3,NULL,'N',0.000,'N','N'),(1244,52448,11,10.000,7,NULL,'N',0.000,'N','N'),(1245,52448,64,15.000,8,'','Y',0.000,'Y','Y'),(1246,52423,48,10.000,3,NULL,'N',0.000,'N','N'),(1247,52423,51,20.000,3,NULL,'N',0.000,'N','N'),(1248,52423,41,10.000,3,NULL,'N',0.000,'N','N'),(1249,52423,51,20.000,3,NULL,'N',0.000,'Y','Y'),(1250,52423,41,5.000,3,NULL,'N',0.000,'N','N'),(1251,52423,11,10.000,7,NULL,'N',0.000,'N','N'),(1252,52423,64,25.000,8,NULL,'Y',0.000,'Y','Y'),(1380,40180,49,0.000,3,'','N',0.000,'N','N'),(1384,40180,22,15.000,10,'','N',0.000,'N','N'),(1385,40180,49,0.000,3,'','N',0.000,'N','N'),(1398,40180,22,0.000,10,'','N',0.000,'N','N'),(1399,52451,25,10.000,3,'','N',60.000,'N','N'),(1409,52448,34,20.000,9,'','N',80.000,'Y','Y'),(1413,52459,25,5.000,3,NULL,'N',0.000,'N','N'),(1414,52459,25,10.000,3,NULL,'N',0.000,'N','N'),(1415,52459,41,10.000,3,NULL,'N',0.000,'N','N'),(1416,52459,49,0.000,3,NULL,'N',0.000,'N','N'),(1417,52459,49,0.000,3,NULL,'N',0.000,'N','N'),(1418,52459,25,10.000,7,NULL,'N',0.000,'N','N'),(1419,52459,36,10.000,7,NULL,'N',0.000,'N','N'),(1420,52459,49,30.000,9,NULL,'N',0.000,'N','N'),(1421,52459,22,0.000,10,NULL,'N',0.000,'N','N'),(1422,52459,38,5.000,10,NULL,'N',0.000,'N','N'),(1423,52459,22,15.000,10,NULL,'N',0.000,'N','N'),(1428,52451,49,80.000,3,'','N',0.000,'N','N'),(1433,52426,51,10.000,3,'About half of the exam','N',0.000,'N','N'),(1434,52426,52,10.000,3,'','N',0.000,'N','N'),(1436,52426,34,20.000,3,'project 1','N',0.000,'N','Y'),(1437,52426,34,30.000,8,'','N',0.000,'N','Y'),(1438,52426,49,30.000,11,'','N',0.000,'N','N');
/*!40000 ALTER TABLE `link_course_offering_assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_contribution_program_outcome`
--

DROP TABLE IF EXISTS `link_course_offering_contribution_program_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_contribution_program_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `contribution_option_id` int(11) NOT NULL,
  `mastery_option_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `PK_link_course_off_contr_program_outcome` (`id`),
  KEY `fk_link_course_off_contribution_program_outcome_course_off` (`course_offering_id`),
  KEY `fk_link_course_off_contribution_program_outcome_contribution` (`contribution_option_id`),
  CONSTRAINT `fk_link_course_off_contribution_program_outcome_contribution` FOREIGN KEY (`contribution_option_id`) REFERENCES `contribution_option_value` (`id`),
  CONSTRAINT `fk_link_course_off_contribution_program_outcome_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6765 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_contribution_program_outcome`
--

LOCK TABLES `link_course_offering_contribution_program_outcome` WRITE;
/*!40000 ALTER TABLE `link_course_offering_contribution_program_outcome` DISABLE KEYS */;
INSERT INTO `link_course_offering_contribution_program_outcome` VALUES (108,31993,84,5,1),(109,31993,85,2,1),(110,31993,86,2,1),(111,31993,87,3,1),(112,31993,88,1,1),(113,31993,89,3,1),(114,31993,90,2,1),(115,31993,91,3,1),(116,31993,92,2,1),(131,31993,93,2,1),(132,31993,94,3,1),(150,13692,84,5,1),(151,13692,85,5,1),(152,13692,86,5,1),(153,13692,87,5,1),(154,13692,88,5,1),(155,13692,89,5,1),(156,13692,90,5,1),(157,13692,91,5,1),(158,13692,92,5,1),(159,13691,93,5,1),(160,13691,94,5,1),(162,13691,84,5,1),(163,13691,85,3,1),(164,13691,86,3,1),(165,13691,87,5,1),(166,13691,88,2,1),(167,13691,89,5,1),(168,13691,90,3,1),(169,13691,91,5,1),(170,13691,92,5,1),(173,40180,93,5,1),(174,40180,94,5,1),(176,40180,84,5,1),(177,40180,85,3,2),(178,40180,86,3,1),(179,40180,87,5,5),(180,40180,88,2,1),(181,40180,89,5,1),(182,40180,90,3,1),(183,40180,91,2,1),(184,40180,92,5,1),(198,40182,84,5,1),(199,40182,85,2,1),(200,40182,86,2,1),(201,40182,87,3,1),(202,40182,88,1,1),(203,40182,89,3,1),(204,40182,90,2,1),(205,40182,91,3,1),(206,40182,92,2,1),(207,40182,93,2,1),(208,40182,94,3,1),(218,40183,84,1,5),(219,40183,85,5,1),(220,40183,86,1,5),(221,40183,87,3,2),(222,40183,88,5,1),(223,40183,89,1,3),(224,40183,90,2,3),(225,40183,91,3,3),(226,40183,92,3,5),(228,40181,84,3,5),(229,40181,85,3,3),(230,40181,86,5,1),(231,40181,87,3,5),(232,40181,88,5,1),(233,40181,89,5,1),(234,40181,90,5,1),(235,40181,91,5,1),(236,40181,92,5,1),(261,40180,157,5,1),(453,40183,199,1,1),(454,40180,199,5,1),(493,40180,202,5,1),(494,40180,203,5,1),(495,40180,204,5,1),(496,40180,205,5,1),(497,40180,206,5,1),(498,40180,207,5,1),(499,40180,208,5,1),(500,40180,209,5,1),(503,40180,212,5,1),(504,40180,213,5,1),(505,40180,214,5,1),(507,40180,216,5,1),(508,40180,217,5,1),(509,40180,218,5,1),(510,40180,219,5,1),(511,40180,220,5,1),(543,40181,199,5,1),(544,40181,230,5,1),(545,40188,199,1,2),(546,40188,84,2,2),(547,40188,85,5,1),(548,40188,86,1,2),(549,40188,87,5,1),(550,40188,88,5,1),(551,40188,89,5,1),(552,40188,230,5,1),(553,40188,90,5,1),(554,40188,91,5,1),(555,40188,92,5,1),(556,40188,93,2,1),(557,40188,94,5,3),(559,40189,199,2,3),(560,40189,84,1,2),(561,40189,85,5,1),(562,40189,86,5,1),(563,40189,87,5,1),(564,40189,88,5,1),(565,40189,89,5,1),(566,40189,230,5,1),(567,40189,90,5,1),(568,40189,91,5,1),(569,40189,92,5,1),(570,40180,230,5,3),(571,40183,230,5,1),(573,40183,233,2,3),(628,13692,233,5,1),(629,13692,199,1,1),(630,13692,230,5,1),(676,40180,272,5,1),(677,40180,273,5,1),(678,40180,274,5,1),(679,40180,275,5,1),(680,40180,276,5,1),(681,40180,277,5,1),(682,40180,278,5,1),(683,40180,279,5,1),(684,40180,280,5,1),(685,40180,281,5,1),(686,40180,282,5,1),(687,40180,283,5,1),(688,40180,284,5,1),(689,40180,285,5,1),(690,40180,286,5,1),(691,40180,287,5,1),(692,40180,288,5,1),(693,40180,290,5,1),(694,40180,289,5,1),(695,40180,291,5,1),(696,40180,292,5,1),(697,40180,293,5,1),(698,40180,294,5,1),(699,40180,295,5,1),(700,40180,296,5,1),(701,40180,297,5,1),(702,40180,298,5,1),(1541,40180,233,5,1),(1734,40183,272,5,1),(1735,40183,273,5,1),(1736,40183,274,5,1),(1737,40183,275,5,1),(1738,40183,276,5,1),(1739,40183,277,5,1),(1740,40183,278,5,1),(1741,40183,279,5,1),(1742,40183,280,5,1),(1743,40183,281,5,1),(1744,40183,282,5,1),(1745,40183,283,5,1),(1746,40183,284,5,1),(1747,40183,285,5,1),(1748,40183,286,5,1),(1749,40183,287,5,1),(1750,40183,288,5,1),(1751,40183,290,5,1),(1752,40183,289,5,1),(1753,40183,291,5,1),(1754,40183,292,5,1),(1755,40183,293,5,1),(1756,40183,294,5,1),(1757,40183,295,5,1),(1758,40183,296,5,1),(1759,40183,297,5,1),(1760,40183,298,5,1),(2083,40180,370,5,1),(2084,40180,371,5,1),(2085,40180,319,5,1),(2615,52425,199,1,3),(2616,52425,84,1,3),(2617,52425,85,2,3),(2618,52425,86,2,5),(2619,52425,87,1,2),(2620,52425,88,1,5),(2621,52425,89,3,2),(2622,52425,230,1,2),(2623,52425,90,2,3),(2624,52425,91,3,3),(2625,52425,92,2,3),(2626,52425,370,1,2),(2627,52425,371,3,5),(2628,52425,319,1,3),(2629,52425,233,2,5),(2630,52425,93,3,2),(2631,52425,94,2,5),(3643,31993,233,5,1),(3860,52426,233,5,1),(4740,52429,233,5,1),(4741,52429,199,3,1),(4742,52429,84,5,1),(4743,52429,85,5,1),(4744,52429,86,5,1),(4745,52429,87,5,1),(4746,52429,88,5,1),(4747,52429,89,5,1),(4748,52429,230,5,1),(4749,52429,90,5,1),(4750,52429,91,5,1),(4751,52429,92,5,1),(4752,52429,370,5,1),(4753,52429,371,5,1),(4754,52429,319,5,1),(4755,52429,93,2,2),(4756,52429,94,2,5),(5486,40180,438,5,1),(5487,40180,440,5,1),(5488,40180,443,5,1),(5489,40180,441,5,1),(5490,40180,442,5,1),(6079,52448,84,1,5),(6080,52448,85,5,1),(6081,52448,86,1,5),(6082,52448,87,2,2),(6083,52448,88,5,1),(6084,52448,89,1,3),(6085,52448,90,2,3),(6086,52448,91,3,3),(6087,52448,92,3,5),(6088,52448,199,1,2),(6089,52448,230,5,1),(6090,52448,233,2,3),(6091,52448,272,5,1),(6092,52448,273,5,1),(6093,52448,274,5,1),(6094,52448,275,5,1),(6095,52448,276,5,1),(6096,52448,277,5,1),(6097,52448,278,5,1),(6098,52448,279,5,1),(6099,52448,280,5,1),(6100,52448,281,5,1),(6101,52448,282,5,1),(6102,52448,283,5,1),(6103,52448,284,5,1),(6104,52448,285,5,1),(6105,52448,286,5,1),(6106,52448,287,5,1),(6107,52448,288,5,1),(6108,52448,290,5,1),(6109,52448,289,5,1),(6110,52448,291,5,1),(6111,52448,292,5,1),(6112,52448,293,5,1),(6113,52448,294,5,1),(6114,52448,295,5,1),(6115,52448,296,5,1),(6116,52448,297,5,1),(6117,52448,298,5,1),(6118,52423,84,1,5),(6119,52423,85,5,1),(6120,52423,86,1,5),(6121,52423,87,2,2),(6122,52423,88,5,1),(6123,52423,89,1,3),(6124,52423,90,2,3),(6125,52423,91,3,3),(6126,52423,92,3,5),(6127,52423,199,1,1),(6128,52423,230,5,1),(6129,52423,233,2,3),(6130,52423,272,5,1),(6131,52423,273,5,1),(6132,52423,274,5,1),(6133,52423,275,5,1),(6134,52423,276,5,1),(6135,52423,277,5,1),(6136,52423,278,5,1),(6137,52423,279,5,1),(6138,52423,280,5,1),(6139,52423,281,5,1),(6140,52423,282,5,1),(6141,52423,283,5,1),(6142,52423,284,5,1),(6143,52423,285,5,1),(6144,52423,286,5,1),(6145,52423,287,5,1),(6146,52423,288,5,1),(6147,52423,290,5,1),(6148,52423,289,5,1),(6149,52423,291,5,1),(6150,52423,292,5,1),(6151,52423,293,5,1),(6152,52423,294,5,1),(6153,52423,295,5,1),(6154,52423,296,5,1),(6155,52423,297,5,1),(6156,52423,298,5,1),(6511,52451,233,5,1),(6548,52459,93,5,1),(6549,52459,94,5,1),(6550,52459,84,5,1),(6551,52459,85,3,2),(6552,52459,86,3,1),(6553,52459,87,5,5),(6554,52459,88,2,1),(6555,52459,89,5,1),(6556,52459,90,3,1),(6557,52459,91,2,1),(6558,52459,92,5,1),(6559,52459,157,5,1),(6560,52459,199,5,1),(6561,52459,202,5,1),(6562,52459,203,5,1),(6563,52459,204,5,1),(6564,52459,205,5,1),(6565,52459,206,5,1),(6566,52459,207,5,1),(6567,52459,208,5,1),(6568,52459,209,5,1),(6569,52459,212,5,1),(6570,52459,213,5,1),(6571,52459,214,5,1),(6572,52459,216,5,1),(6573,52459,217,5,1),(6574,52459,218,5,1),(6575,52459,219,5,1),(6576,52459,220,5,1),(6577,52459,230,5,3),(6578,52459,272,5,1),(6579,52459,273,5,1),(6580,52459,274,5,1),(6581,52459,275,5,1),(6582,52459,276,5,1),(6583,52459,277,5,1),(6584,52459,278,5,1),(6585,52459,279,5,1),(6586,52459,280,5,1),(6587,52459,281,5,1),(6588,52459,282,5,1),(6589,52459,283,5,1),(6590,52459,284,5,1),(6591,52459,285,5,1),(6592,52459,286,5,1),(6593,52459,287,5,1),(6594,52459,288,5,1),(6595,52459,290,5,1),(6596,52459,289,5,1),(6597,52459,291,5,1),(6598,52459,292,5,1),(6599,52459,293,5,1),(6600,52459,294,5,1),(6601,52459,295,5,1),(6602,52459,296,5,1),(6603,52459,297,5,1),(6604,52459,298,5,1),(6605,52459,233,5,1),(6606,52459,370,5,1),(6607,52459,371,5,1),(6608,52459,319,5,1),(6628,52459,438,5,1),(6629,52459,440,5,1),(6630,52459,443,5,1),(6631,52459,441,5,1),(6632,52459,442,5,1),(6722,52448,93,5,1),(6723,52448,94,5,1),(6724,52448,616,5,1),(6725,52448,647,5,1),(6726,52448,649,5,1),(6727,52448,651,5,1),(6729,52448,650,5,1),(6732,52448,370,5,1),(6733,52448,371,5,1),(6734,52448,319,5,1),(6735,52461,199,3,2),(6736,52461,84,3,2),(6737,52461,85,3,2),(6738,52461,86,3,2),(6739,52461,87,3,2),(6740,52461,88,3,2),(6741,52461,89,3,2),(6742,52461,230,5,1),(6743,52461,90,5,1),(6744,52461,91,5,1),(6745,52461,92,5,1),(6746,52425,616,5,1),(6747,52425,647,5,1),(6748,52425,649,5,1),(6749,52425,651,5,1),(6751,52425,650,5,1),(6754,52426,199,5,1),(6755,52426,84,5,1),(6756,52426,85,5,1),(6757,52426,86,5,1),(6758,52426,87,5,1),(6759,52426,88,5,1),(6760,52426,89,5,1),(6761,52426,230,5,1),(6762,52426,90,5,1),(6763,52426,91,5,1),(6764,52426,92,5,1);
/*!40000 ALTER TABLE `link_course_offering_contribution_program_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_instructor`
--

DROP TABLE IF EXISTS `link_course_offering_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_instructor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_link_course_offering_instructor` (`id`),
  KEY `fk_link_course_offering_instructor_offering` (`course_offering_id`),
  KEY `fk_link_course_offering_instructor_instructor` (`instructor_id`),
  CONSTRAINT `fk_link_course_offering_instructor_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`),
  CONSTRAINT `fk_link_course_offering_instructor_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_instructor`
--

LOCK TABLES `link_course_offering_instructor` WRITE;
/*!40000 ALTER TABLE `link_course_offering_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_course_offering_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_outcome`
--

DROP TABLE IF EXISTS `link_course_offering_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `course_outcome_id` int(11) NOT NULL,
  `display_index` int(5) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `PK_link_course_offering_outcome` (`id`),
  KEY `fk_link_course_offering_outcome_course_offering` (`course_offering_id`),
  KEY `fk_link_course_offering_outcome_course_outcome` (`course_outcome_id`),
  CONSTRAINT `fk_link_course_offering_outcome_course_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_outcome_course_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_outcome`
--

LOCK TABLES `link_course_offering_outcome` WRITE;
/*!40000 ALTER TABLE `link_course_offering_outcome` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_course_offering_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_outcome_characteristic`
--

DROP TABLE IF EXISTS `link_course_offering_outcome_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_outcome_characteristic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_course_offering_outcome_id` int(11) NOT NULL,
  `Characteristic_id` int(11) NOT NULL,
  `created_by_userid` varchar(10) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_outcome_Characteristic` (`id`),
  KEY `fk_link_course_of_outc_characteristic_lnk_crs_outc` (`link_course_offering_outcome_id`),
  KEY `fk_link_course_of_outc_characteristic_Characteristic` (`Characteristic_id`),
  CONSTRAINT `fk_link_course_of_outc_characteristic_Characteristic` FOREIGN KEY (`Characteristic_id`) REFERENCES `characteristic` (`id`),
  CONSTRAINT `fk_link_course_of_outc_characteristic_lnk_crs_outc` FOREIGN KEY (`link_course_offering_outcome_id`) REFERENCES `link_course_offering_outcome` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_outcome_characteristic`
--

LOCK TABLES `link_course_offering_outcome_characteristic` WRITE;
/*!40000 ALTER TABLE `link_course_offering_outcome_characteristic` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_course_offering_outcome_characteristic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_offering_teaching_method`
--

DROP TABLE IF EXISTS `link_course_offering_teaching_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_offering_teaching_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `teaching_method_portion_option_id` int(11) NOT NULL,
  `teaching_method_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_offering_teaching_method` (`id`),
  KEY `fk_link_course_offering_teaching_method_course` (`course_offering_id`),
  KEY `fk_link_course_offering_teaching_method_teaching_method` (`teaching_method_id`),
  KEY `fk_link_course_offering_teaching_mthd_teaching_mthd_portion_opt` (`teaching_method_portion_option_id`),
  CONSTRAINT `fk_link_course_offering_teaching_method_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_teaching_method_teaching_method` FOREIGN KEY (`teaching_method_id`) REFERENCES `teaching_method` (`id`),
  CONSTRAINT `fk_link_course_offering_teaching_mthd_teaching_mthd_portion_opt` FOREIGN KEY (`teaching_method_portion_option_id`) REFERENCES `teaching_method_portion_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1463 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_offering_teaching_method`
--

LOCK TABLES `link_course_offering_teaching_method` WRITE;
/*!40000 ALTER TABLE `link_course_offering_teaching_method` DISABLE KEYS */;
INSERT INTO `link_course_offering_teaching_method` VALUES (128,13691,24,1),(129,13691,22,2),(130,13691,22,3),(131,13691,4,4),(132,13691,22,5),(138,13692,23,5),(139,13692,23,4),(140,13692,22,3),(141,13692,24,2),(142,13692,22,1),(157,31993,23,1),(158,31993,22,2),(159,31993,22,3),(160,31993,23,4),(161,31993,4,5),(177,40180,24,1),(178,40180,4,5),(179,40180,4,4),(180,40180,4,3),(181,40180,22,2),(182,40182,24,1),(183,40182,22,5),(184,40182,4,4),(185,40182,4,3),(186,40182,4,2),(187,40181,24,1),(188,40181,4,2),(189,40181,24,3),(190,40181,23,4),(191,40181,23,5),(198,40183,24,1),(199,40183,22,2),(200,40183,22,3),(201,40183,23,4),(202,40183,22,5),(257,40188,22,2),(260,40189,23,1),(261,40189,24,2),(262,40189,22,3),(263,40189,22,4),(264,40189,22,5),(758,52425,22,3),(759,52425,23,4),(760,52425,22,5),(924,52426,22,1),(925,52426,23,5),(926,52426,22,4),(927,52426,4,3),(928,52426,22,2),(1019,52429,22,5),(1020,52429,23,4),(1021,52429,24,3),(1022,52429,23,2),(1023,52429,23,1),(1268,52448,24,1),(1269,52448,22,5),(1270,52448,24,4),(1271,52448,22,3),(1272,52448,22,2),(1273,52423,24,1),(1274,52423,22,5),(1275,52423,23,4),(1276,52423,22,3),(1277,52423,22,2),(1415,52425,24,1),(1416,52425,4,2),(1448,52459,24,1),(1449,52459,4,5),(1450,52459,4,4),(1451,52459,4,3),(1452,52459,22,2),(1458,52451,24,1),(1459,52451,22,2),(1460,52451,4,3),(1461,52451,4,4),(1462,52451,4,5);
/*!40000 ALTER TABLE `link_course_offering_teaching_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_organization`
--

DROP TABLE IF EXISTS `link_course_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_organization` (`id`),
  KEY `fk_link_course_organization_course` (`course_id`),
  KEY `fk_link_course_organization_organization` (`organization_id`),
  CONSTRAINT `fk_link_course_organization_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_organization_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5220 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_organization`
--

LOCK TABLES `link_course_organization` WRITE;
/*!40000 ALTER TABLE `link_course_organization` DISABLE KEYS */;
INSERT INTO `link_course_organization` VALUES (4639,25,4209),(4640,25,3852),(4641,25,4208),(4642,25,4211),(4643,25,3851),(5137,25,4392),(5138,25,4393),(5139,25,4311),(5140,25,4391),(5141,25,4314),(5215,25,4495),(5216,25,4473),(5219,25,4496);
/*!40000 ALTER TABLE `link_course_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_outcome_program_outcome`
--

DROP TABLE IF EXISTS `link_course_outcome_program_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_outcome_program_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_outcome_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  `course_offering_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_outcome_program_outcome` (`id`),
  KEY `fk_link_course_outcome_program_outcome_offering` (`course_offering_id`),
  KEY `fk_link_course_outcome_program_outcome_p_outcome` (`program_outcome_id`),
  KEY `fk_link_course_outcome_program_outcome_c_outcome` (`course_outcome_id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_c_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_p_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5787 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_outcome_program_outcome`
--

LOCK TABLES `link_course_outcome_program_outcome` WRITE;
/*!40000 ALTER TABLE `link_course_outcome_program_outcome` DISABLE KEYS */;
INSERT INTO `link_course_outcome_program_outcome` VALUES (3,432,512,13691),(4,434,512,13691),(5,435,518,13691),(6,435,513,13691),(7,434,510,13691),(8,435,514,13691),(9,434,515,13691),(10,435,517,13691),(48,435,512,13691),(49,433,515,13691),(50,435,515,13691),(51,465,514,13691),(52,435,510,13691),(53,434,513,13691),(54,465,510,13691),(64,470,511,31993),(65,472,513,31993),(66,472,510,31993),(67,470,510,31993),(68,471,516,31993),(69,472,512,31993),(70,477,516,31993),(71,432,512,40180),(72,434,512,40180),(73,435,518,40180),(74,435,513,40180),(75,434,510,40180),(76,435,514,40180),(77,434,515,40180),(78,435,517,40180),(79,435,512,40180),(80,433,515,40180),(81,435,515,40180),(82,465,514,40180),(83,435,510,40180),(84,434,513,40180),(85,465,510,40180),(86,471,512,31993),(91,470,511,40182),(92,472,513,40182),(93,472,510,40182),(94,470,510,40182),(95,471,516,40182),(96,472,512,40182),(97,477,516,40182),(98,471,512,40182),(100,483,510,40181),(101,483,514,40181),(102,471,512,31993),(103,477,512,31993),(104,470,512,31993),(105,477,512,31993),(106,477,512,31993),(107,472,518,31993),(108,483,512,40181),(110,534,518,40183),(113,485,516,40183),(114,579,514,40183),(116,485,515,40183),(266,483,636,40181),(267,483,637,40181),(268,433,616,40180),(269,533,514,40183),(271,434,517,40180),(277,432,516,40180),(278,435,516,40180),(279,433,516,40180),(280,432,639,40180),(281,465,639,40180),(285,435,639,40180),(286,434,639,40180),(290,549,639,40188),(291,550,639,40188),(292,549,512,40188),(294,552,639,40189),(295,551,639,40189),(296,551,512,40189),(297,552,512,40189),(301,485,671,40183),(302,533,671,40183),(303,534,671,40183),(943,434,671,40180),(944,434,671,40180),(945,434,671,40180),(946,433,671,40180),(1098,534,512,40183),(1099,485,518,40183),(1100,485,510,40183),(1101,485,668,40183),(1102,485,668,40183),(1103,579,511,40183),(2006,478,512,13692),(2007,984,517,13692),(4045,1435,671,52425),(4047,985,671,52425),(4051,1187,671,52429),(5517,534,518,52448),(5518,485,516,52448),(5519,579,514,52448),(5520,485,515,52448),(5521,533,514,52448),(5522,485,671,52448),(5523,533,671,52448),(5524,534,671,52448),(5525,534,512,52448),(5526,485,518,52448),(5527,485,510,52448),(5528,485,668,52448),(5529,485,668,52448),(5530,579,511,52448),(5539,534,518,52423),(5540,485,516,52423),(5541,579,514,52423),(5542,485,515,52423),(5543,533,514,52423),(5544,485,671,52423),(5545,533,671,52423),(5546,534,671,52423),(5547,534,512,52423),(5548,485,518,52423),(5549,485,510,52423),(5550,485,668,52423),(5551,485,668,52423),(5552,579,511,52423),(5638,434,668,40180),(5657,984,639,52425),(5658,985,512,52425),(5659,985,512,52425),(5661,985,518,52425),(5662,984,510,52425),(5663,984,516,52425),(5664,984,514,52425),(5665,984,668,52425),(5666,984,511,52425),(5667,984,515,52425),(5668,984,517,52425),(5669,1434,671,52425),(5752,434,512,52459),(5753,435,518,52459),(5755,434,510,52459),(5759,435,512,52459),(5760,984,515,52459),(5762,465,514,52459),(5763,435,510,52459),(5764,434,513,52459),(5767,433,616,52459),(5770,435,516,52459),(5771,433,516,52459),(5773,465,639,52459),(5776,434,671,52459),(5777,434,671,52459),(5778,434,671,52459),(5779,433,671,52459),(5781,984,668,52459),(5782,433,511,52459),(5783,984,517,52459),(5785,1434,512,52425),(5786,984,639,52448);
/*!40000 ALTER TABLE `link_course_outcome_program_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_prerequisite`
--

DROP TABLE IF EXISTS `link_course_prerequisite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_prerequisite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `prerequisite_course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_prerequisite` (`id`),
  KEY `fk_link_course_prerequisite_course` (`course_id`),
  KEY `fk_link_course_prerequisite_course2` (`prerequisite_course_id`),
  CONSTRAINT `fk_link_course_prerequisite_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_prerequisite_course2` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_prerequisite`
--

LOCK TABLES `link_course_prerequisite` WRITE;
/*!40000 ALTER TABLE `link_course_prerequisite` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_course_prerequisite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_course_program`
--

DROP TABLE IF EXISTS `link_course_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_course_program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course_classification_id` int(11) NOT NULL,
  `time_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_course_program` (`id`),
  KEY `fk_link_course_program_course` (`course_id`),
  KEY `fk_link_course_program_program` (`program_id`),
  CONSTRAINT `fk_link_course_program_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_program_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=704 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_course_program`
--

LOCK TABLES `link_course_program` WRITE;
/*!40000 ALTER TABLE `link_course_program` DISABLE KEYS */;
INSERT INTO `link_course_program` VALUES (99,24,3851,1,12),(109,24,3852,1,6),(124,24,4209,1,5),(127,24,4211,2,8),(147,24,4311,1,5),(163,24,4314,1,5),(169,24,4208,1,7),(173,51,3851,1,5),(174,51,4211,2,8),(182,51,4391,1,8),(184,51,4392,3,6),(458,24,4473,4,8),(702,24,4496,1,5),(703,51,4497,1,5);
/*!40000 ALTER TABLE `link_course_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_department_characteristic_type`
--

DROP TABLE IF EXISTS `link_department_characteristic_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_department_characteristic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `characteristic_type_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_department_characteristic_type` (`id`),
  KEY `fk_link_dept_characteristic_type_char_type` (`characteristic_type_id`),
  KEY `fk_link_dept_characteristic_type_department` (`department_id`),
  CONSTRAINT `fk_link_dept_characteristic_type_char_type` FOREIGN KEY (`characteristic_type_id`) REFERENCES `characteristic_type` (`id`),
  CONSTRAINT `fk_link_dept_characteristic_type_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_department_characteristic_type`
--

LOCK TABLES `link_department_characteristic_type` WRITE;
/*!40000 ALTER TABLE `link_department_characteristic_type` DISABLE KEYS */;
INSERT INTO `link_department_characteristic_type` VALUES (1,1,1,1),(151,1,10,2),(152,1,9,3);
/*!40000 ALTER TABLE `link_department_characteristic_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_organization_characteristic_type`
--

DROP TABLE IF EXISTS `link_organization_characteristic_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_organization_characteristic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `characteristic_type_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_organization_characteristic_type` (`id`),
  KEY `fk_link_org_characteristic_type_char_type` (`characteristic_type_id`),
  KEY `fk_link_org_characteristic_type_organization` (`organization_id`),
  CONSTRAINT `fk_link_org_characteristic_type_char_type` FOREIGN KEY (`characteristic_type_id`) REFERENCES `characteristic_type` (`id`),
  CONSTRAINT `fk_link_org_characteristic_type_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_organization_characteristic_type`
--

LOCK TABLES `link_organization_characteristic_type` WRITE;
/*!40000 ALTER TABLE `link_organization_characteristic_type` DISABLE KEYS */;
INSERT INTO `link_organization_characteristic_type` VALUES (159,25,1,1);
/*!40000 ALTER TABLE `link_organization_characteristic_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_organization_organization_outcome`
--

DROP TABLE IF EXISTS `link_organization_organization_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_organization_organization_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `organization_outcome_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_organization_organization_outcome` (`id`),
  KEY `fk_link_organization_organization_outcome_org` (`organization_id`),
  KEY `fk_link_organization_organization_outcome_outcome` (`organization_outcome_id`),
  CONSTRAINT `fk_link_organization_organization_outcome_org` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_link_organization_organization_outcome_outcome` FOREIGN KEY (`organization_outcome_id`) REFERENCES `organization_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_organization_organization_outcome`
--

LOCK TABLES `link_organization_organization_outcome` WRITE;
/*!40000 ALTER TABLE `link_organization_organization_outcome` DISABLE KEYS */;
INSERT INTO `link_organization_organization_outcome` VALUES (33,25,63),(34,25,62),(35,25,61),(36,25,49),(37,25,50),(38,25,51),(39,25,55),(40,25,56),(42,25,52),(43,25,53),(44,25,54),(45,25,59),(46,25,60),(47,25,58),(76,25,87),(77,25,89),(78,25,88);
/*!40000 ALTER TABLE `link_organization_organization_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_part_of_organization`
--

DROP TABLE IF EXISTS `link_part_of_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_part_of_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `part_of_organization_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_part_of_organization` (`id`),
  KEY `fk_link_part_of_organization_organization1` (`organization_id`),
  KEY `fk_link_part_of_organization_organization2` (`part_of_organization_id`),
  CONSTRAINT `fk_link_part_of_organization_organization1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_link_part_of_organization_organization2` FOREIGN KEY (`part_of_organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_part_of_organization`
--

LOCK TABLES `link_part_of_organization` WRITE;
/*!40000 ALTER TABLE `link_part_of_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_part_of_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_program_outcome_organization_outcome`
--

DROP TABLE IF EXISTS `link_program_outcome_organization_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_program_outcome_organization_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_outcome_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_program_outcome_organization_outcome` (`id`),
  KEY `fk_link_program_outcome_organization_outcome_org_outcome` (`organization_outcome_id`),
  KEY `fk_link_program_outcome_organization_outcome_progr_outcome` (`program_outcome_id`),
  KEY `fk_link_program_outcome_organization_outcome_program` (`program_id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_org_outcome` FOREIGN KEY (`organization_outcome_id`) REFERENCES `organization_outcome` (`id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_progr_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_program_outcome_organization_outcome`
--

LOCK TABLES `link_program_outcome_organization_outcome` WRITE;
/*!40000 ALTER TABLE `link_program_outcome_organization_outcome` DISABLE KEYS */;
INSERT INTO `link_program_outcome_organization_outcome` VALUES (10,63,516,24),(11,62,518,24),(12,62,516,24),(13,61,517,24),(14,49,517,24),(15,87,514,24),(16,88,668,24),(19,87,671,51),(73,87,516,24),(74,87,668,24);
/*!40000 ALTER TABLE `link_program_outcome_organization_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_program_program_outcome`
--

DROP TABLE IF EXISTS `link_program_program_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_program_program_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_program_program_outcome` (`id`),
  KEY `fk_link_program_program_outcome_program` (`program_id`),
  KEY `fk_link_program_program_outcome_outcome` (`program_outcome_id`),
  CONSTRAINT `fk_link_program_program_outcome_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`),
  CONSTRAINT `fk_link_program_program_outcome_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_program_program_outcome`
--

LOCK TABLES `link_program_program_outcome` WRITE;
/*!40000 ALTER TABLE `link_program_program_outcome` DISABLE KEYS */;
INSERT INTO `link_program_program_outcome` VALUES (1,51,671);
/*!40000 ALTER TABLE `link_program_program_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_program_program_outcome_characteristic`
--

DROP TABLE IF EXISTS `link_program_program_outcome_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_program_program_outcome_characteristic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `characteristic_id` int(11) NOT NULL,
  `created_by_userid` varchar(10) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `PK_link_program_program_outcome_characteristic` (`id`),
  KEY `fk_link_program _prgm_outc_char_lnk_prm_outc` (`link_program_program_outcome_id`),
  KEY `fk_link_program_program_outcome_char_characteristic` (`characteristic_id`),
  CONSTRAINT `fk_link_program _prgm_outc_char_lnk_prm_outc` FOREIGN KEY (`link_program_program_outcome_id`) REFERENCES `link_program_program_outcome` (`id`),
  CONSTRAINT `fk_link_program_program_outcome_char_characteristic` FOREIGN KEY (`characteristic_id`) REFERENCES `characteristic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_program_program_outcome_characteristic`
--

LOCK TABLES `link_program_program_outcome_characteristic` WRITE;
/*!40000 ALTER TABLE `link_program_program_outcome_characteristic` DISABLE KEYS */;
INSERT INTO `link_program_program_outcome_characteristic` VALUES (324,230,1,'cah793','2013-03-18 16:00:20'),(325,230,40,'sdm746','2012-11-29 21:23:40'),(326,230,36,'sdm746','2012-11-29 21:23:40'),(329,92,1,'cah793','2012-12-05 17:34:40'),(330,92,40,'cah793','2012-12-05 17:34:40'),(331,92,36,'cah793','2012-12-05 17:34:40'),(392,85,1,'cah793','2013-03-18 16:01:07');
/*!40000 ALTER TABLE `link_program_program_outcome_characteristic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_program_question`
--

DROP TABLE IF EXISTS `link_program_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_program_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_link_program_question` (`id`),
  KEY `fk_link_program_question_question` (`question_id`),
  KEY `fk_link_program_question_program` (`program_id`),
  CONSTRAINT `fk_link_program_question_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `fk_link_program_question_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_program_question`
--

LOCK TABLES `link_program_question` WRITE;
/*!40000 ALTER TABLE `link_program_question` DISABLE KEYS */;
INSERT INTO `link_program_question` VALUES (15,1,24,1),(30,1,51,3),(75,28,24,2),(81,33,51,1),(82,34,51,2),(83,33,24,3),(88,40,24,4);
/*!40000 ALTER TABLE `link_program_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mastery_option_value`
--

DROP TABLE IF EXISTS `mastery_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mastery_option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_mastery_option_values` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mastery_option_value`
--

LOCK TABLES `mastery_option_value` WRITE;
/*!40000 ALTER TABLE `mastery_option_value` DISABLE KEYS */;
INSERT INTO `mastery_option_value` VALUES (1,'not at all',0,0),(2,'introductory',1,1),(3,'intermediate',2,2),(5,'advanced',3,3);
/*!40000 ALTER TABLE `mastery_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parent_organization_id` int(11) DEFAULT NULL,
  `system_name` varchar(255) DEFAULT NULL,
  `active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `PK_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (2,'College of Education',NULL,'College of Education','N'),(9,'Department of Curriculum Studies',2,'Curriculum Studies','N'),(10,'Department of Educational Foundations',2,'Educational Foundations','N'),(12,'College of Engineering',NULL,'College of Engineering','Y'),(13,'Agr & Bioresource Engineering',12,'Agri and Bioresource Engineering','N'),(14,'Bio Medical Engineering',12,'Bio Medical Engineering','N'),(15,'Chem & Bio Engineering',12,'Chemical and Biological Engin','N'),(16,'Civil & Geological Engineering',12,'Civil and Geological Engineer','N'),(17,'Elec & Comp Engineering',12,'Electrical and Cmptr Engin','N'),(18,'Environmental Engineering',12,'Environmental Engineering','N'),(19,'Mechanical Engineering',12,'Mechanical Engineering','Y'),(21,'College of Arts and Science',NULL,'College of Arts and Science','Y'),(22,'College of Kinesiology',NULL,'College of Kinesiology','N'),(23,'History',21,'History','N'),(24,'Biology',21,'Biology','N'),(25,'Basket Weaving (Demo)',NULL,'Basket Weaving (Demo)','Y'),(26,'College of Pharmacy and Nutrition',NULL,'College of Pharmacy and Nutrition','N'),(29,'College of Agriculture and Bioresources',NULL,'College of Agriculture and Bioresources','N'),(30,'Department of Soil Science',29,'Soil Science','N'),(31,'Geological Sciences',21,'Geological Sciences','N'),(32,'School of Environment and Sustainability',NULL,'School of Environ and Sustain','N'),(35,'Linguistics',21,'Linguistics','N'),(37,'Mathematics and Statistics',21,'Mathematics and Statistics','N'),(38,'Physics and Engineering Physics',21,'Physics and Engin Physics','N'),(40,'Geography and Planning',21,'Geography and Planning','Y'),(41,'Gwenna Moss Centre',NULL,'Gwenna Moss Centre','N'),(42,'ULC',NULL,'ULC','N'),(44,'University Learning Centre',NULL,'University Learning Centre','N'),(45,'Training Sample Dept',NULL,'Training Sample Dept','N'),(46,'Native Studies',NULL,'Native Studies','N'),(47,'U of S International',NULL,'U of S International','N'),(48,'Chemistry',NULL,'Chemistry','N'),(49,'Computer Science',21,'Computer Science','N'),(50,'Medicine (Dean\'s Office)',NULL,'Medicine (Dean\'s Office)','N'),(51,'Graduate Studies and Research',NULL,'Graduate Studies and Research','N'),(52,'Law (Dean\'s Office)',NULL,'Law (Dean\'s Office)','N'),(53,'Drama',NULL,'Drama','N'),(54,'Engineering (Dean\'s Office)',NULL,'Engineering (Dean\'s Office)','N'),(56,'Small Animal Clinical Sciences',NULL,'Small Animal Clinical Sciences','N'),(57,'Nursing (Dean\'s Office)',NULL,'Nursing (Dean\'s Office)','N'),(58,'Veterinary Pathology',NULL,'Veterinary Pathology','N'),(59,'Art and Art History',NULL,'Art and Art History','N'),(60,'Geography',NULL,'Geography','N'),(62,'Economics',NULL,'Economics','N'),(64,'English',NULL,'English','N'),(65,'Arts & Science (Dean\'s Office)',NULL,'Arts and Science Dean\'s Office','N'),(66,'Languages and Linguistics',NULL,'Languages and Linguistics','N'),(67,'Relig Studies and Anthropology',NULL,'Relig Studies and Anthropology','N'),(68,'Ed Psych and Special Education',NULL,'Ed Psych and Special Education','N'),(69,'Chemical Engineering',NULL,'Chemical Engineering','N'),(70,'Biochemistry',21,'Biochemistry','N'),(71,'Philosophy',NULL,'Philosophy','N'),(72,'Music',NULL,'Music','N'),(73,'Physiology',NULL,'Physiology','N'),(76,'Anatomy & Cell Biology',NULL,'Anatomy and Cell Biology','N'),(77,'Extension Division',NULL,'Extension Division','N'),(78,'Sociology',NULL,'Sociology','N'),(79,'Womens and Gender Studies',NULL,'Womens and Gender Studies','N'),(80,'Psychology',NULL,'Psychology','N'),(81,'Agriculture (Dean\'s Office)',NULL,'Agriculture (Dean\'s Office)','N'),(82,'Management & Marketing',NULL,'Management and Marketing','N'),(83,'Finance',NULL,'Finance','N'),(85,'Dentistry (Dean\'s Office)',NULL,'Dentistry (Dean\'s Office)','N'),(87,'Industrial Relations',NULL,'Industrial Relations','N'),(88,'Plant Sciences',NULL,'Plant Sciences','N'),(89,'Kinesiology (Dean\'s Office)',NULL,'Kinesiology (Dean\'s Office)','N'),(90,'Education (Dean\'s Office)',NULL,'Education (Dean\'s Office)','N'),(91,'Large Animal Clinical Sciences',NULL,'Large Animal Clinical Sciences','N'),(92,'Educational Administration',NULL,'Educational Administration','N'),(93,'Political Studies',NULL,'Political Studies','N'),(94,'Pathology & Lab Medicine',NULL,'Pathology and Lab Medicine','N'),(96,'Agricultural Economics',NULL,'Agricultural Economics','N'),(97,'Nutrition',NULL,'Nutrition','N'),(98,'Animal & Poultry Science',NULL,'Animal and Poultry Science','N'),(99,'Pharm & Nutr (Dean\'s Office)',NULL,'Pharm & Nutr (Dean\'s Office)','N'),(100,'Veterinary Biomedical Sciences',NULL,'Veterinary Biomedical Sciences','N'),(101,'School of Physical Therapy',NULL,'School of Physical Therapy','N'),(102,'Applied Micro & Food Science',NULL,'Applied Micro & Food Science','N'),(103,'Microbiology',NULL,'Microbiology','N'),(104,'Pharmacology',NULL,'Pharmacology','N'),(105,'Toxicology Graduate Program',NULL,'Toxicology Graduate Program','N'),(106,'Accounting',NULL,'Accounting','N'),(107,'Anaesth Periop Med & Pain Mgmt',NULL,'Anaesth Periop Med & Pain Mgmt','N'),(108,'Psychiatry',NULL,'Psychiatry','N'),(109,'Obstetrics and Gynecology',NULL,'Obstetrics and Gynecology','N'),(110,'Medicine, Dept of',NULL,'Medicine, Dept of','N'),(111,'Pediatrics',NULL,'Pediatrics','N'),(112,'Surgery',NULL,'Surgery','N'),(113,'Family Medicine',NULL,'Family Medicine','N'),(114,'Community Hlth and Epidemiol',NULL,'Community Hlth and Epidemiol','N'),(115,'Veterinary Med (Dean\'s Office)',NULL,'Veterinary Med (Dean\'s Office)','N'),(116,'Veterinary Microbiology',NULL,'Veterinary Microbiology','N'),(117,'Biomedical Engineering',NULL,'Biomedical Engineering','N'),(118,'Marketing',NULL,'Marketing','N'),(119,'Commerce (Dean\'s Office)',NULL,'Commerce (Dean\'s Office)','N'),(123,'Microbiology and Immunology',NULL,'Microbiology and Immunology','N'),(124,'AGBIO (Dean\'s Office)',NULL,'AGBIO (Dean\'s Office)','N'),(129,'Bioresource Policy Bus Econ',NULL,'Bioresource Policy Bus Econ','N'),(132,'Food and Bioproduct Sciences',NULL,'Food and Bioproduct Sciences','N'),(135,'JSG School of Public Policy',NULL,'JSG School of Public Policy','N'),(136,'Training Classes',NULL,'Training Classes','N'),(137,'Religion and Culture',21,'Religion and Culture','N'),(138,'ESB (Dean\'s Office)',NULL,'ESB (Dean\'s Office)','N'),(139,'School of Public Health',NULL,'School of Public Health','N'),(141,'Human Resource Org Behaviour',NULL,'Human Resource Org Behaviour','N'),(143,'Interdisc Cntr Culture Creat',NULL,'Interdisc Cntr Culture Creat','N'),(145,'Intl Ctr for North Gov and Dev',NULL,'Intl Ctr for North Gov and Dev','N'),(146,'Electrical Engineering',NULL,'Electrical Engineering','N'),(147,'Pathology',NULL,'Pathology','N'),(149,'Indian and Northern Education',NULL,'Indian and Northern Education','N'),(152,'College of Engineering-DnOffce',NULL,'College of Engineering-DnOffce','N'),(153,'College of Nursing',NULL,'College of Nursing','N'),(154,'College of Arts&Science-DnOffc',NULL,'College of Arts&Science-DnOffc','N'),(155,'College of Pharmacy &Nutrition',NULL,'College of Pharmacy &Nutrition','N'),(158,'Languages',NULL,'Languages','N'),(159,'Science Division',NULL,'Science Division','N'),(161,'Vice-President (Research)',NULL,'Vice-President (Research)','N'),(162,'College of Education - DnOffce',NULL,'College of Education - DnOffce','N'),(163,'Archaeology and Anthropology',21,'Archaeology and Anthropology','N'),(164,'ZAnatom&Cellplaceholder',NULL,'Anatomy & Cell Biology','N'),(165,'ZAnimal&Poulplaceholder',NULL,'Animal & Poultry Science','N'),(166,'ZPhy&EngPhy_placeholder',NULL,'Physics & Engineering Physics','N'),(167,'Zmanagement_placeholder',NULL,'Management & Marketing','N'),(168,'Zmath_placeholder',NULL,'Mathematics & Statistics','N'),(169,'ZArts&ScDnsOplaceholder',NULL,'Arts & Science (Dean\'s Office)','N'),(170,'Agri & Bioresource Engineering',NULL,'Agri & Bioresource Engineering','N'),(171,'ZEle&CompEn_placeholder',NULL,'Electrical & Cmptr Engineering','N'),(172,'ZPath&LamMe_placeholder',NULL,'Pathology and Lab Medicine','N'),(173,'Agri and Bioresource Engin',NULL,'Agri and Bioresource Engin','N'),(175,'Nutrition Foundational Knowledge Specifications',26,'Nutrition Foundational Knowledge Specifications','N'),(176,'Applied Micro and Food Science',NULL,'Applied Micro and Food Science','N'),(179,'Postgraduate Medicine',NULL,'','N');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_admin`
--

DROP TABLE IF EXISTS `organization_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `type_display` varchar(100) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_organization_admin` (`id`),
  KEY `fk_link_organization_admin_organization` (`organization_id`),
  CONSTRAINT `fk_link_organization_admin_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_admin`
--

LOCK TABLES `organization_admin` WRITE;
/*!40000 ALTER TABLE `organization_admin` DISABLE KEYS */;
INSERT INTO `organization_admin` VALUES (71,'catvisitor','Userid',25,'Persons','Hoessler','Carolyn');
/*!40000 ALTER TABLE `organization_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_outcome`
--

DROP TABLE IF EXISTS `organization_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `organization_outcome_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_organization_outcome` (`id`),
  KEY `fk_organization_outcome_group` (`organization_outcome_group_id`),
  CONSTRAINT `fk_organization_outcome_group` FOREIGN KEY (`organization_outcome_group_id`) REFERENCES `organization_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_outcome`
--

LOCK TABLES `organization_outcome` WRITE;
/*!40000 ALTER TABLE `organization_outcome` DISABLE KEYS */;
INSERT INTO `organization_outcome` VALUES (49,'Apply critical and creative thinking to problems, including analysis, synthesis, and evaluation.',NULL,1),(50,'Be adept at learning in various ways, including independently, experientially, and in teams.',NULL,1),(51,'Possess intellectual flexibility, ability to manage change, and a zest for life-long learning.',NULL,1),(52,'Have a comprehensive knowledge of their subject area, discipline, or profession.',NULL,2),(53,'Understand how their subject area may intersect with related disciplines.',NULL,2),(54,'Utilize and apply their knowledge with judgement and prudence.',NULL,2),(55,'Exercise intellectual integrity and ethical behaviour.',NULL,3),(56,'Recognize and think through moral and ethical issues in a variety of contexts.',NULL,3),(58,'Communicate clearly, substantively, and persuasively.',NULL,4),(59,'Be able to locate and use information effectively, ethically, and legally.',NULL,4),(60,'Be technologically literate, and able to apply appropriate skills of research and inquiry.',NULL,4),(61,'Value diversity and the positive contributions this brings to society.',NULL,5),(62,'Share their knowledge and exercise leadership.',NULL,5),(63,'Contribute to society, locally, nationally, or globally.',NULL,5),(87,'	A recognition of the ethical application of intellectual property and privacy. ','',24),(88,'Competent, ethical, and effective use of technology. ','',24),(89,'	Meaningful, effective and appropriate communication of knowledge to engage different audiences. ','',24);
/*!40000 ALTER TABLE `organization_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_outcome_group`
--

DROP TABLE IF EXISTS `organization_outcome_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_outcome_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `organization_specific` varchar(1) NOT NULL,
  `organization_id` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `PK_organization_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_outcome_group`
--

LOCK TABLES `organization_outcome_group` WRITE;
/*!40000 ALTER TABLE `organization_outcome_group` DISABLE KEYS */;
INSERT INTO `organization_outcome_group` VALUES (1,'Learning Charter - Discovery Goals',NULL,'N',-1),(2,'Learning Charter - Knowledge Goals',NULL,'N',-1),(3,'Learning Charter - Integrity Goals',NULL,'N',-1),(4,'Learning Charter - Skills Goals',NULL,'N',-1),(5,'Learning Charter - Citizenship Goals',NULL,'N',-1),(6,'01 A Knowledge-Base for Engineering',NULL,'Y',12),(7,'02 Problem Analysis',NULL,'Y',12),(8,'03 Investigation',NULL,'Y',12),(9,'04 Design',NULL,'Y',12),(10,'05 Use of Engineering Tools',NULL,'Y',12),(11,'06 Individual and Team Work',NULL,'Y',12),(12,'07 Communication',NULL,'Y',12),(13,'08 Professionalism',NULL,'Y',12),(14,'09 Impact of Engineering on Society and the Environment',NULL,'Y',12),(15,'10 Ethics and Equity',NULL,'Y',12),(16,'11 Engineering Management',NULL,'Y',12),(17,'12 Life Long Learning',NULL,'Y',12),(19,'A&S Goal 1. Develop a wide range of effective communication skills. Demonstrate:',NULL,'Y',21),(20,'A&S Goal 2. Encourage personal development, growth, and responsibility. Demonstrate:',NULL,'Y',21),(21,'A&S Goal 3. Engage students in inquiry-based learning, critical thinking and creative processes.',NULL,'Y',21),(22,'A&S Goal 4. Prepare thoughtful, world-minded, educated, engaged citizens.',NULL,'Y',21),(23,'A&S Goal 5: Cultivate an understanding of & appreciation for the unique socio-cultural position of',NULL,'Y',21),(24,'A&S Goal 1. Develop a wide range of effective communication skills. Demonstrate:',NULL,'Y',25);
/*!40000 ALTER TABLE `organization_outcome_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_program` (`id`),
  KEY `fk_program_organization` (`organization_id`),
  CONSTRAINT `fk_program_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (24,'B.Sc. 4 year in Basket Weaving','undefined',25),(51,'All degrees in Basket Weaving','undefined',25);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_admin`
--

DROP TABLE IF EXISTS `program_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `created_userid` varchar(6) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `PK_program_admin` (`id`),
  KEY `fk_link_program_admin_program` (`program_id`),
  CONSTRAINT `fk_link_program_admin_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_admin`
--

LOCK TABLES `program_admin` WRITE;
/*!40000 ALTER TABLE `program_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_outcome`
--

DROP TABLE IF EXISTS `program_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `program_outcome_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_program_outcome` (`id`),
  KEY `fk_program_outcome_program_outcome_group` (`program_outcome_group_id`),
  CONSTRAINT `fk_program_outcome_program_outcome_group` FOREIGN KEY (`program_outcome_group_id`) REFERENCES `program_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_outcome`
--

LOCK TABLES `program_outcome` WRITE;
/*!40000 ALTER TABLE `program_outcome` DISABLE KEYS */;
INSERT INTO `program_outcome` VALUES (510,'Demonstrate a comprehensive knowledge of Basket W.and specific knowledge in selected sub disciplines','',144),(511,'Understand how basket weaving intersects with related fields, disciplines, and subject areas','',144),(512,'Apply critical and creative thinking to problems encountered in basket weaving, including analysis, ','Apply critical and creative thinking to problems encountered in basket weaving, including analysis, synthesis and evaluation',144),(513,'Communicate clearly, substantively, and persuasively in a manner consistent with  basket weaving','Communicate clearly, substantively, and persuasively in a manner consistent with basket weaving audiences and professions',144),(514,'Exercise appropriate skills of research and inquiry relevant in basket weaving, including the abilit','Exercise appropriate skills of research and inquiry relevant in basket weaving, including the ability to locate and use information effectively, ethically and legally',144),(515,'Use the technology, tools, and media typical in Basket Weaving','',144),(516,'Engage in Basket Weaving communities and contribute to society, locally, nationally or globally','',144),(517,'Value diversity and understand the positive contributions this brings to Basket Weaving and to society','Value diversity and understand the positive contributions this brings to Basket Weaving and to society',144),(518,'Behave in an intellectual, ethical, and professional manner consistent with the expectations of Basket weaving','Behave in an intellectual, ethical, and professional manner consistent with the expectations of Basket Weaving and society',144),(571,'New Outcome added to the new Outcome Group.  Also created on Sept 28th','',174),(611,'Apply knowledge of patterns to select and create appropriate designs','',185),(613,'Design intricate patterns reflecting nature','',186),(615,'Demonstrate meaningful, effective and appropriate communication of knowledge to engage different audiences.','',188),(616,'	Competent, ethical, and effective use of technology. ','',188),(617,'Meaningful, effective and appropriate communication of knowledge to engage different audiences. ','',188),(618,'	A commitment to life-long learning.','',189),(619,'	Developing leadership skills. ','',189),(620,'	Indicators of purposeful and satisfying lives. ','',189),(621,'	Realistic self-appraisal, self-understanding, and self-respect. ','',189),(622,'	The ability to work collaboratively with others. ','',189),(623,'Demonstrate the ability to integrate knowledge, ideas and experiences from a range of disciplines; identify, examine and use different ways of knowing, thinking and doing; and apply knowledge critically and creatively.','',190),(624,'Demonstrate critical and reflective thinking.','',190),(625,'Understand the processes and paradigms of scientific reasoning, knowledge production and the evaluation of evidence.','',190),(626,'Identify important problems, questions and issues.','',190),(627,'Analyze, interpret and judge the relevance and quality of information.','',190),(628,'Use and integrate multiple sources of information to solve problems or form a decision or opinion.','',190),(629,'Make meaning(s) from scientific methods and other interpretations of knowledge, texts, images, instruction and experience.','',190),(630,'Actively improve intercultural communication.','',191),(631,'Recognize social systems and their influence, systematic barriers to equality and inclusiveness, advocate and justify means for dismantling them. ','',191),(632,'Identify, analyze and challenge unfair, unjust or uncivil behaviour in our interconnected, global society.','',191),(633,'Understand and appreciate key concepts and theories in science and technology, major scientific and technological issues at the local, national and international level, the natural world, and social, cultural, political and economic contexts for the production and reception of scientific knowledge.','',191),(634,'Explore the interconnectedness between the natural, technological and social worlds. ','',191),(635,'Recognize the relationship among the scientific enterprise and cultural and artistic knowledge production.','',191),(636,'Recognize that there are multiple Aboriginal perspectives on the world.','',192),(637,'Understand that there have been and continue to be, historically, systematic barriers to equality for Aboriginal peoples.','',192),(639,'identify materials and necessary preservation steps','',193),(668,'Identify venture opportunities for basket production','',144),(671,'Apply basket weaving techniques to create baskets','',205);
/*!40000 ALTER TABLE `program_outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_outcome_group`
--

DROP TABLE IF EXISTS `program_outcome_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_outcome_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `program_specific` varchar(1) NOT NULL,
  `program_id` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `PK_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_outcome_group`
--

LOCK TABLES `program_outcome_group` WRITE;
/*!40000 ALTER TABLE `program_outcome_group` DISABLE KEYS */;
INSERT INTO `program_outcome_group` VALUES (144,'Program Outcomes for Basket Weaving',NULL,'Y',24),(174,'New outcome Group created on Sept 28',NULL,'Y',24),(185,'Knowledge application',NULL,'Y',24),(186,'Design',NULL,'Y',24),(188,'A&S Goal 1. Develop a wide range of effective communication skills. Demonstrate:',NULL,'Y',24),(189,'A&S Goal 2. Encourage personal development, growth, and responsibility. Demonstrate:',NULL,'Y',24),(190,'A&S Goal 3. Engage students in inquiry-based learning, critical thinking and creative processes.',NULL,'Y',24),(191,'A&S Goal 4. Prepare thoughtful, world-minded, educated, engaged citizens.',NULL,'Y',24),(192,'A&S Goal 5: Cultivate an understanding of and appreciation for the unique socio-cultural position of aboriginal peoples in Canada.',NULL,'Y',24),(193,'Program for ancient weaving preservation',NULL,'Y',24),(205,'All degrees in basket weaving',NULL,'Y',51),(206,'Honours degree in basket weaving',NULL,'Y',51),(207,'Goal 1. Effective communication',NULL,'Y',51);
/*!40000 ALTER TABLE `program_outcome_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display` varchar(500) DEFAULT NULL,
  `question_type_id` int(11) NOT NULL,
  `answer_set_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_question` (`id`),
  KEY `fk_question_answer_set` (`answer_set_id`),
  CONSTRAINT `fk_question_answer_set` FOREIGN KEY (`answer_set_id`) REFERENCES `answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'How long did it take to enter all the data?',1,1),(2,'To what extent are <b>Indigenous content, perspectives, ceremonies, protocols, languages and/or ways of knowing</b> embedded in your course?',2,2),(3,'To what extent are the following ways of knowing represented in your course:<br/><b>Art and creativity</b>',2,2),(4,'<b>Data modelling</b>',2,2),(5,'<b>Ceremony</b>',2,2),(6,'<b>Contemplation</b>',2,2),(7,'<b>Dialogue</b>',2,2),(8,'<b>Dreaming</b>',2,2),(9,'<b>Embodied/Kinaesthetic</b>',2,2),(10,'<b>Experiential</b>',2,2),(11,'<b>Experiment</b>',2,2),(12,'<b>Gut Feelings</b>',2,2),(13,'<b>Heightened perceptual awareness</b>',2,2),(14,'<b>Holistic</b>',2,2),(15,'<b>Inter-generational learning</b>',2,2),(16,'<b>Intuitive</b>',2,2),(17,'<b>Logical deduction</b>',2,2),(18,'<b>Meditation</b>',2,2),(19,'<b>Observation</b>',2,2),(20,'<b>Qualitative Analysis</b>',2,2),(21,'<b>Quantitative Analysis</b>',2,2),(22,'<b>Reflective contemplation</b>',2,2),(23,'<b>Sensory</b>',2,2),(24,'<b>Statistical analysis</b>',2,2),(25,'<b>Story-telling</b>',2,2),(26,'<b>Spiritual</b>',2,2),(27,'<b>Textual Analysis </b>',2,2),(28,'In what ways (specify activities, readings, content etc.), is <b> Indigenous content, perspectives, ceremonies, protocols, languages and/or ways of knowing</b> embedded in your course (If not included, please write \"none\")',4,NULL),(29,'<b>Visualization</b>',2,2),(30,'List additional ways of knowing, not covered by the ones above, with the extent each is represented in your course (not at all, somewhat, often, extensively).',4,NULL),(31,'<b>Listening to the land</b>',2,2),(33,'What Research Skills Development Inventory levels of student autonomy are embedded in your course?',3,3),(34,'How are Research Skills Development Inventory levels of student autonomy embedded in your course?',4,NULL),(40,'How do you integrate these High-Impact Educational Practices into your classes?',4,NULL),(41,'How useful do you find written curriculum development resources related to instructional practice?',1,2);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_response`
--

DROP TABLE IF EXISTS `question_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_offering_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `response` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_question_response` (`id`),
  KEY `fk_question_response_question` (`question_id`),
  KEY `fk_question_response_course_offering` (`course_offering_id`),
  KEY `fk_question_response_program` (`program_id`),
  CONSTRAINT `fk_question_response_course_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_question_response_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `fk_question_response_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=748 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_response`
--

LOCK TABLES `question_response` WRITE;
/*!40000 ALTER TABLE `question_response` DISABLE KEYS */;
INSERT INTO `question_response` VALUES (101,31993,24,28,'We do loads!'),(545,40183,24,28,'fr'),(671,52423,24,28,'fr'),(737,52425,24,1,'10'),(738,52425,24,28,'fefefef'),(739,52425,24,33,'1'),(740,52425,24,33,'2'),(741,52425,24,33,'3'),(742,52425,24,40,'fefefef'),(743,52425,51,1,'10'),(744,52425,51,33,'4'),(745,52425,51,33,'5'),(747,52459,24,1,'10');
/*!40000 ALTER TABLE `question_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_type`
--

DROP TABLE IF EXISTS `question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_type`
--

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;
INSERT INTO `question_type` VALUES (1,'select','select one of multiple answer options (select-box)'),(2,'radio','select one of multiple answer options (radio)'),(3,'checkbox','select any of multiple answer options (checkbox)'),(4,'textarea','Open answer format');
/*!40000 ALTER TABLE `question_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_admin`
--

DROP TABLE IF EXISTS `system_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `created_userid` varchar(30) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type_display` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_system_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_admin`
--

LOCK TABLES `system_admin` WRITE;
/*!40000 ALTER TABLE `system_admin` DISABLE KEYS */;
INSERT INTO `system_admin` VALUES (30,'cah793','Userid','cah793','2013-08-15 20:33:29','Persons','Carolyn','Hoessler'),(31,'slb534','Userid','cah793','2013-11-05 21:06:14','Persons','Steph','');
/*!40000 ALTER TABLE `system_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_method`
--

DROP TABLE IF EXISTS `teaching_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaching_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `display_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_teaching_method` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_method`
--

LOCK TABLES `teaching_method` WRITE;
/*!40000 ALTER TABLE `teaching_method` DISABLE KEYS */;
INSERT INTO `teaching_method` VALUES (1,'Direct Instruction','Possibilities include: Structured Overview, Lecture, Explicit Teaching, Drill & Practice, Compare & Contrast, Didactic Questions, Demonstrations, Guided & Shared - reading, listening, viewing, thinking',1),(2,'Interactive Instruction','Possibilities include: Debates, Role Playing, Panels, Brainstorming, Peer Partner Learning, Discussion, Laboratory Groups, Think, Pair, Share, Cooperative Learning Groups, Jigsaw, Problem Solving, Structured Controversy, Tutorial Groups, Interviewing, Conferencing',2),(3,'Indirect Instruction','Possibilities include: Problem Solving, Case Studies, Reading for Meaning, Inquiry, Reflective Discussion, Writing to Inform, Concept Formation, Concept Mapping, Concept Attainment, Cloze Procedure',3),(4,'Independent Study','Possibilities include: Essays, Computer Assisted Instruction, Journals, Learning Logs, Reports, Learning Activity Packages, Correspondence Lessons, Learning Contracts, Homework, Research Projects, Assigned Questions, Learning Centers',4),(5,'Experiential Learning','Possibilities include: Field Trips, Narratives, Conducting Experiments, Simulations, Games, Storytelling, Focused Imaging, Field Observations, Role-playing, Model Building, Surveys, Studio Labs, Community Engaged Learning, Study Abroad, Community Service Learning, Undergraduate Research, Internships, Practicum, Apprenticeship and Field Courses',5);
/*!40000 ALTER TABLE `teaching_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_method_portion_option`
--

DROP TABLE IF EXISTS `teaching_method_portion_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaching_method_portion_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `comparative_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_teaching_method_portion_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_method_portion_option`
--

LOCK TABLES `teaching_method_portion_option` WRITE;
/*!40000 ALTER TABLE `teaching_method_portion_option` DISABLE KEYS */;
INSERT INTO `teaching_method_portion_option` VALUES (4,'not at all',0,0),(22,'occasionally',1,1),(23,'about half the time',2,2),(24,'mostly',3,3);
/*!40000 ALTER TABLE `teaching_method_portion_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time`
--

DROP TABLE IF EXISTS `time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `option_display_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PK_time` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time`
--

LOCK TABLES `time` WRITE;
/*!40000 ALTER TABLE `time` DISABLE KEYS */;
INSERT INTO `time` VALUES (5,'during their first year of undergraduate studies',1,1),(6,'during their second year of undergraduate studies',2,2),(7,'during their third year of undergraduate studies',3,3),(8,'during their fourth year of undergraduate studies',4,4),(12,'any time during undergraduate studies',5,5),(13,'during their first year of graduate studies',6,6),(14,'during their second year or after of graduate studies',7,7),(15,'any time during graduate studies',8,8);
/*!40000 ALTER TABLE `time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_it_took`
--

DROP TABLE IF EXISTS `time_it_took`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_it_took` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_time_it_took` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_it_took`
--

LOCK TABLES `time_it_took` WRITE;
/*!40000 ALTER TABLE `time_it_took` DISABLE KEYS */;
INSERT INTO `time_it_took` VALUES (1,'about 10 minutes',1,10),(2,'about 30 minutes',3,30),(3,'about an hour',4,60),(4,'more than an hour',5,100),(5,'about 20 minutes',2,20);
/*!40000 ALTER TABLE `time_it_took` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-06 13:16:10
