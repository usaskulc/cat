-- MySQL dump 10.11
--
-- Host: localhost    Database: currimap
-- ------------------------------------------------------
-- Server version	5.0.51a-community-nt

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `answer_option` (
  `id` int(11) NOT NULL auto_increment,
  `answer_set_id` int(11) NOT NULL,
  `display` varchar(100) NOT NULL,
  `value` varchar(100) default NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_answer_option` (`id`),
  KEY `fk_answer_option_answer_set` (`answer_set_id`),
  CONSTRAINT `fk_answer_option_answer_set` FOREIGN KEY (`answer_set_id`) REFERENCES `answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `answer_set`
--

DROP TABLE IF EXISTS `answer_set`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `answer_set` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assessment` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `assessment_group_id` int(11) NOT NULL default '1',
  `display_index` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_assessment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assessment_feedback_option`
--

DROP TABLE IF EXISTS `assessment_feedback_option`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assessment_feedback_option` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `assessment_feedback_option_type_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_assessment_feedback_option` (`id`),
  KEY `fk_assessment_feedback_option_option_type` (`assessment_feedback_option_type_id`),
  CONSTRAINT `fk_assessment_feedback_option_option_type` FOREIGN KEY (`assessment_feedback_option_type_id`) REFERENCES `assessment_feedback_option_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assessment_feedback_option_type`
--

DROP TABLE IF EXISTS `assessment_feedback_option_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assessment_feedback_option_type` (
  `id` int(11) NOT NULL auto_increment,
  `question` varchar(300) NOT NULL,
  `display_index` int(11) NOT NULL,
  `question_type` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_assessment_feedback_option_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assessment_group`
--

DROP TABLE IF EXISTS `assessment_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assessment_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) default NULL,
  `short_name` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_assessment_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assessment_time_option`
--

DROP TABLE IF EXISTS `assessment_time_option`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assessment_time_option` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `time_period` varchar(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_assessment_time_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `characteristic`
--

DROP TABLE IF EXISTS `characteristic`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `characteristic` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `display_index` int(11) NOT NULL,
  `Characteristic_type_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_Characteristic` (`id`),
  KEY `fk_Characteristic` (`Characteristic_type_id`),
  CONSTRAINT `fk_Characteristic` FOREIGN KEY (`Characteristic_type_id`) REFERENCES `characteristic_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `characteristic_type`
--

DROP TABLE IF EXISTS `characteristic_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `characteristic_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `value_type` varchar(30) NOT NULL,
  `question_display` varchar(200) default NULL,
  `short_display` varchar(32) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_Characteristic_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contribution_option_value`
--

DROP TABLE IF EXISTS `contribution_option_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contribution_option_value` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_contribution_option_values` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course` (
  `id` int(11) NOT NULL auto_increment,
  `subject` varchar(10) NOT NULL,
  `course_number` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4483 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_attribute`
--

DROP TABLE IF EXISTS `course_attribute`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_attribute` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `organization_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_course_attribute` (`id`),
  KEY `fk_course_attribute_organization` (`organization_id`),
  CONSTRAINT `fk_course_attribute_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_attribute_value`
--

DROP TABLE IF EXISTS `course_attribute_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_attribute_value` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) NOT NULL,
  `course_attribute_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_course_attribute_value` (`id`),
  KEY `fk_course_attribute_value_attr` (`course_attribute_id`),
  KEY `fk_course_attribute_value_course` (`course_id`),
  CONSTRAINT `fk_course_attribute_value_attr` FOREIGN KEY (`course_attribute_id`) REFERENCES `course_attribute` (`id`),
  CONSTRAINT `fk_course_attribute_value_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_classification`
--

DROP TABLE IF EXISTS `course_classification`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_classification` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `display_index` int(2) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `PK_course_classification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_offering`
--

DROP TABLE IF EXISTS `course_offering`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_offering` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) NOT NULL,
  `term` varchar(6) NOT NULL,
  `section_number` varchar(4) default NULL,
  `medium` varchar(20) default NULL,
  `num_students` int(11) default NULL,
  `comments` text,
  `time_it_took_id` int(11) default NULL,
  `teaching_comment` text,
  `outcome_comment` text,
  `contribution_comment` text,
  PRIMARY KEY  (`id`),
  KEY `PK_course_offering` (`id`),
  KEY `fk_course_offering_course` (`course_id`),
  CONSTRAINT `fk_course_offering_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52445 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_outcome`
--

DROP TABLE IF EXISTS `course_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(400) default NULL,
  `description` varchar(1024) default NULL,
  `course_outcome_group_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_course_outcome` (`id`),
  KEY `fk_course_outcome_course_outcome_group` (`course_outcome_group_id`),
  CONSTRAINT `fk_course_outcome_course_outcome_group` FOREIGN KEY (`course_outcome_group_id`) REFERENCES `course_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1212 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_outcome_group`
--

DROP TABLE IF EXISTS `course_outcome_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_outcome_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `department_specific` varchar(1) NOT NULL,
  `department_id` int(11) NOT NULL default '-1',
  PRIMARY KEY  (`id`),
  KEY `PK_course_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `department` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `ldap_name` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feature` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `file_name` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_feature` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `instructor` (
  `id` int(11) NOT NULL auto_increment,
  `userid` varchar(30) default NULL,
  `first_name` varchar(50) default NULL,
  `last_name` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2498 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor_attribute`
--

DROP TABLE IF EXISTS `instructor_attribute`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `instructor_attribute` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `organization_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_instructor_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor_attribute_value`
--

DROP TABLE IF EXISTS `instructor_attribute_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `instructor_attribute_value` (
  `id` int(11) NOT NULL auto_increment,
  `instructor_id` int(11) NOT NULL,
  `instructor_attribute_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_instructor_attribute_value` (`id`),
  KEY `fk_instructor_attribute_value_attr` (`instructor_attribute_id`),
  KEY `fk_instructor_attribute_value_instructor` (`instructor_id`),
  CONSTRAINT `fk_instructor_attribute_value_attr` FOREIGN KEY (`instructor_attribute_id`) REFERENCES `instructor_attribute` (`id`),
  CONSTRAINT `fk_instructor_attribute_value_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_assessment_course_outcome`
--

DROP TABLE IF EXISTS `link_assessment_course_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_assessment_course_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `course_outcome_id` int(11) NOT NULL,
  `link_assessment_course_offering_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_assessment_course_outcome` (`id`),
  KEY `fk_link_assessment_course_outcome_course_outcome` (`course_outcome_id`),
  KEY `fk_link_assessment_course_outcome_link_asses_co` (`link_assessment_course_offering_id`),
  CONSTRAINT `fk_link_assessment_course_outcome_course_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`),
  CONSTRAINT `fk_link_assessment_course_outcome_link_asses_co` FOREIGN KEY (`link_assessment_course_offering_id`) REFERENCES `link_course_offering_assessment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1480 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_assessment_feedback_option_value`
--

DROP TABLE IF EXISTS `link_course_assessment_feedback_option_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_assessment_feedback_option_value` (
  `id` int(11) NOT NULL auto_increment,
  `assessment_feedback_option_id` int(11) NOT NULL,
  `link_course_offering_assessment_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_assessment_feedback_option_value` (`id`),
  KEY `fk_link_course_assessment_feedback_option_value_option` (`assessment_feedback_option_id`),
  KEY `fk_link_course_assessment_feedback_option_value_link` (`link_course_offering_assessment_id`),
  CONSTRAINT `fk_link_course_assessment_feedback_option_value_link` FOREIGN KEY (`link_course_offering_assessment_id`) REFERENCES `link_course_offering_assessment` (`id`),
  CONSTRAINT `fk_link_course_assessment_feedback_option_value_option` FOREIGN KEY (`assessment_feedback_option_id`) REFERENCES `assessment_feedback_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9423 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_contribution_program_outcome`
--

DROP TABLE IF EXISTS `link_course_contribution_program_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_contribution_program_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) NOT NULL,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `contribution_option_id` int(11) NOT NULL,
  `mastery_option_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_outcome_program_outcome` (`id`),
  KEY `fk_link_course_contribution_program_outcome_course` (`course_id`),
  KEY `fk_llink_course_contribution_program_outcome_contribution` (`contribution_option_id`),
  CONSTRAINT `fk_link_course_contribution_program_outcome_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_llink_course_contribution_program_outcome_contribution` FOREIGN KEY (`contribution_option_id`) REFERENCES `contribution_option_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1302 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_department`
--

DROP TABLE IF EXISTS `link_course_department`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_department` (
  `id` int(11) NOT NULL auto_increment,
  `department_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_department` (`id`),
  KEY `fk_link_course_department_course` (`course_id`),
  KEY `fk_link_course_department_department` (`department_id`),
  CONSTRAINT `fk_link_course_department_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_department_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4639 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_assessment`
--

DROP TABLE IF EXISTS `link_course_offering_assessment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_assessment` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `weight` double(6,3) default NULL,
  `assessment_time_option_id` int(11) NOT NULL,
  `additional_info` varchar(1000) default NULL,
  `criterion_exists` varchar(1) NOT NULL default 'N',
  `criterion_level` double(5,3) NOT NULL default '0.000',
  `criterion_completion_required` varchar(1) NOT NULL default 'N',
  `criterion_submit_required` varchar(1) NOT NULL default 'N',
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_assessment` (`id`),
  KEY `fk_link_course_offering_assessment_course` (`course_offering_id`),
  KEY `fk_link_course_offering_assessment_time_option` (`assessment_time_option_id`),
  KEY `fk_link_course_offering_assessment_assessment` (`assessment_id`),
  CONSTRAINT `fk_link_course_offering_assessment_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `fk_link_course_offering_assessment_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_assessment_time_option` FOREIGN KEY (`assessment_time_option_id`) REFERENCES `assessment_time_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1068 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_contribution_program_outcome`
--

DROP TABLE IF EXISTS `link_course_offering_contribution_program_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_contribution_program_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `contribution_option_id` int(11) NOT NULL,
  `mastery_option_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_off_contr_program_outcome` (`id`),
  KEY `fk_link_course_off_contribution_program_outcome_course_off` (`course_offering_id`),
  KEY `fk_link_course_off_contribution_program_outcome_contribution` (`contribution_option_id`),
  CONSTRAINT `fk_link_course_off_contribution_program_outcome_contribution` FOREIGN KEY (`contribution_option_id`) REFERENCES `contribution_option_value` (`id`),
  CONSTRAINT `fk_link_course_off_contribution_program_outcome_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4962 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_instructor`
--

DROP TABLE IF EXISTS `link_course_offering_instructor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_instructor` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_link_course_offering_instructor` (`id`),
  KEY `fk_link_course_offering_instructor_offering` (`course_offering_id`),
  KEY `fk_link_course_offering_instructor_instructor` (`instructor_id`),
  CONSTRAINT `fk_link_course_offering_instructor_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`),
  CONSTRAINT `fk_link_course_offering_instructor_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31379 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_outcome`
--

DROP TABLE IF EXISTS `link_course_offering_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `course_outcome_id` int(11) NOT NULL,
  `display_index` int(5) default '1',
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_offering_outcome` (`id`),
  KEY `fk_link_course_offering_outcome_course_offering` (`course_offering_id`),
  KEY `fk_link_course_offering_outcome_course_outcome` (`course_outcome_id`),
  CONSTRAINT `fk_link_course_offering_outcome_course_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_outcome_course_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=861 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_outcome_characteristic`
--

DROP TABLE IF EXISTS `link_course_offering_outcome_characteristic`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_outcome_characteristic` (
  `id` int(11) NOT NULL auto_increment,
  `link_course_offering_outcome_id` int(11) NOT NULL,
  `Characteristic_id` int(11) NOT NULL,
  `created_by_userid` varchar(10) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_outcome_Characteristic` (`id`),
  KEY `fk_link_course_of_outc_characteristic_lnk_crs_outc` (`link_course_offering_outcome_id`),
  KEY `fk_link_course_of_outc_characteristic_Characteristic` (`Characteristic_id`),
  CONSTRAINT `fk_link_course_of_outc_characteristic_Characteristic` FOREIGN KEY (`Characteristic_id`) REFERENCES `characteristic` (`id`),
  CONSTRAINT `fk_link_course_of_outc_characteristic_lnk_crs_outc` FOREIGN KEY (`link_course_offering_outcome_id`) REFERENCES `link_course_offering_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1217 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_offering_teaching_method`
--

DROP TABLE IF EXISTS `link_course_offering_teaching_method`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_offering_teaching_method` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `teaching_method_portion_option_id` int(11) NOT NULL,
  `teaching_method_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_offering_teaching_method` (`id`),
  KEY `fk_link_course_offering_teaching_method_course` (`course_offering_id`),
  KEY `fk_link_course_offering_teaching_method_teaching_method` (`teaching_method_id`),
  KEY `fk_link_course_offering_teaching_mthd_teaching_mthd_portion_opt` (`teaching_method_portion_option_id`),
  CONSTRAINT `fk_link_course_offering_teaching_method_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_offering_teaching_method_teaching_method` FOREIGN KEY (`teaching_method_id`) REFERENCES `teaching_method` (`id`),
  CONSTRAINT `fk_link_course_offering_teaching_mthd_teaching_mthd_portion_opt` FOREIGN KEY (`teaching_method_portion_option_id`) REFERENCES `teaching_method_portion_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_organization`
--

DROP TABLE IF EXISTS `link_course_organization`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_organization` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_organization` (`id`),
  KEY `fk_link_course_organization_course` (`course_id`),
  KEY `fk_link_course_organization_organization` (`organization_id`),
  CONSTRAINT `fk_link_course_organization_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_organization_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5161 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_outcome_program_outcome`
--

DROP TABLE IF EXISTS `link_course_outcome_program_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_outcome_program_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `course_outcome_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  `course_offering_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_outcome_program_outcome` (`id`),
  KEY `fk_link_course_outcome_program_outcome_offering` (`course_offering_id`),
  KEY `fk_link_course_outcome_program_outcome_p_outcome` (`program_outcome_id`),
  KEY `fk_link_course_outcome_program_outcome_c_outcome` (`course_outcome_id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_c_outcome` FOREIGN KEY (`course_outcome_id`) REFERENCES `course_outcome` (`id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`),
  CONSTRAINT `fk_link_course_outcome_program_outcome_p_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4373 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_prerequisite`
--

DROP TABLE IF EXISTS `link_course_prerequisite`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_prerequisite` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) NOT NULL,
  `prerequisite_course_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_prerequisite` (`id`),
  KEY `fk_link_course_prerequisite_course` (`course_id`),
  KEY `fk_link_course_prerequisite_course2` (`prerequisite_course_id`),
  CONSTRAINT `fk_link_course_prerequisite_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_prerequisite_course2` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_course_program`
--

DROP TABLE IF EXISTS `link_course_program`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_course_program` (
  `id` int(11) NOT NULL auto_increment,
  `program_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course_classification_id` int(11) NOT NULL,
  `time_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_course_program` (`id`),
  KEY `fk_link_course_program_course` (`course_id`),
  KEY `fk_link_course_program_program` (`program_id`),
  CONSTRAINT `fk_link_course_program_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_link_course_program_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_department_characteristic_type`
--

DROP TABLE IF EXISTS `link_department_characteristic_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_department_characteristic_type` (
  `id` int(11) NOT NULL auto_increment,
  `department_id` int(11) NOT NULL,
  `characteristic_type_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_department_characteristic_type` (`id`),
  KEY `fk_link_dept_characteristic_type_char_type` (`characteristic_type_id`),
  KEY `fk_link_dept_characteristic_type_department` (`department_id`),
  CONSTRAINT `fk_link_dept_characteristic_type_char_type` FOREIGN KEY (`characteristic_type_id`) REFERENCES `characteristic_type` (`id`),
  CONSTRAINT `fk_link_dept_characteristic_type_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_organization_characteristic_type`
--

DROP TABLE IF EXISTS `link_organization_characteristic_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_organization_characteristic_type` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` int(11) NOT NULL,
  `characteristic_type_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_organization_characteristic_type` (`id`),
  KEY `fk_link_org_characteristic_type_char_type` (`characteristic_type_id`),
  KEY `fk_link_org_characteristic_type_organization` (`organization_id`),
  CONSTRAINT `fk_link_org_characteristic_type_char_type` FOREIGN KEY (`characteristic_type_id`) REFERENCES `characteristic_type` (`id`),
  CONSTRAINT `fk_link_org_characteristic_type_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_organization_organization_outcome`
--

DROP TABLE IF EXISTS `link_organization_organization_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_organization_organization_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` int(11) NOT NULL,
  `organization_outcome_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_organization_organization_outcome` (`id`),
  KEY `fk_link_organization_organization_outcome_org` (`organization_id`),
  KEY `fk_link_organization_organization_outcome_outcome` (`organization_outcome_id`),
  CONSTRAINT `fk_link_organization_organization_outcome_org` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_link_organization_organization_outcome_outcome` FOREIGN KEY (`organization_outcome_id`) REFERENCES `organization_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_part_of_organization`
--

DROP TABLE IF EXISTS `link_part_of_organization`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_part_of_organization` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` int(11) NOT NULL,
  `part_of_organization_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_part_of_organization` (`id`),
  KEY `fk_link_part_of_organization_organization1` (`organization_id`),
  KEY `fk_link_part_of_organization_organization2` (`part_of_organization_id`),
  CONSTRAINT `fk_link_part_of_organization_organization1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_link_part_of_organization_organization2` FOREIGN KEY (`part_of_organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_program_outcome_organization_outcome`
--

DROP TABLE IF EXISTS `link_program_outcome_organization_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_program_outcome_organization_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `organization_outcome_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_program_outcome_organization_outcome` (`id`),
  KEY `fk_link_program_outcome_organization_outcome_org_outcome` (`organization_outcome_id`),
  KEY `fk_link_program_outcome_organization_outcome_progr_outcome` (`program_outcome_id`),
  KEY `fk_link_program_outcome_organization_outcome_program` (`program_id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_org_outcome` FOREIGN KEY (`organization_outcome_id`) REFERENCES `organization_outcome` (`id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `fk_link_program_outcome_organization_outcome_progr_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_program_program_outcome`
--

DROP TABLE IF EXISTS `link_program_program_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_program_program_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `program_id` int(11) NOT NULL,
  `program_outcome_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_program_program_outcome` (`id`),
  KEY `fk_link_program_program_outcome_program` (`program_id`),
  KEY `fk_link_program_program_outcome_outcome` (`program_outcome_id`),
  CONSTRAINT `fk_link_program_program_outcome_outcome` FOREIGN KEY (`program_outcome_id`) REFERENCES `program_outcome` (`id`),
  CONSTRAINT `fk_link_program_program_outcome_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=448 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_program_program_outcome_characteristic`
--

DROP TABLE IF EXISTS `link_program_program_outcome_characteristic`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_program_program_outcome_characteristic` (
  `id` int(11) NOT NULL auto_increment,
  `link_program_program_outcome_id` int(11) NOT NULL,
  `characteristic_id` int(11) NOT NULL,
  `created_by_userid` varchar(10) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `PK_link_program_program_outcome_characteristic` (`id`),
  KEY `fk_link_program _prgm_outc_char_lnk_prm_outc` (`link_program_program_outcome_id`),
  KEY `fk_link_program_program_outcome_char_characteristic` (`characteristic_id`),
  CONSTRAINT `fk_link_program_program_outcome_char_characteristic` FOREIGN KEY (`characteristic_id`) REFERENCES `characteristic` (`id`),
  CONSTRAINT `fk_link_program _prgm_outc_char_lnk_prm_outc` FOREIGN KEY (`link_program_program_outcome_id`) REFERENCES `link_program_program_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `link_program_question`
--

DROP TABLE IF EXISTS `link_program_question`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `link_program_question` (
  `id` int(11) NOT NULL auto_increment,
  `question_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `display_index` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_link_program_question` (`id`),
  KEY `fk_link_program_question_question` (`question_id`),
  KEY `fk_link_program_question_program` (`program_id`),
  CONSTRAINT `fk_link_program_question_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `fk_link_program_question_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mastery_option_value`
--

DROP TABLE IF EXISTS `mastery_option_value`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `mastery_option_value` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_mastery_option_values` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `parent_organization_id` int(11) default NULL,
  `system_name` varchar(255) default NULL,
  `active` varchar(1) NOT NULL default 'Y',
  PRIMARY KEY  (`id`),
  KEY `PK_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `organization_admin`
--

DROP TABLE IF EXISTS `organization_admin`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `organization_admin` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) default NULL,
  `organization_id` int(11) default NULL,
  `type_display` varchar(100) default NULL,
  `last_name` varchar(50) default NULL,
  `first_name` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_organization_admin` (`id`),
  KEY `fk_link_organization_admin_organization` (`organization_id`),
  CONSTRAINT `fk_link_organization_admin_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `organization_outcome`
--

DROP TABLE IF EXISTS `organization_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `organization_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL,
  `description` varchar(1024) default NULL,
  `organization_outcome_group_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_organization_outcome` (`id`),
  KEY `fk_organization_outcome_group` (`organization_outcome_group_id`),
  CONSTRAINT `fk_organization_outcome_group` FOREIGN KEY (`organization_outcome_group_id`) REFERENCES `organization_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `organization_outcome_group`
--

DROP TABLE IF EXISTS `organization_outcome_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `organization_outcome_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL,
  `description` varchar(1024) default NULL,
  `organization_specific` varchar(1) NOT NULL,
  `organization_id` int(11) NOT NULL default '-1',
  PRIMARY KEY  (`id`),
  KEY `PK_organization_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `organization_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_program` (`id`),
  KEY `fk_program_organization` (`organization_id`),
  CONSTRAINT `fk_program_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `program_admin`
--

DROP TABLE IF EXISTS `program_admin`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program_admin` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) default NULL,
  `program_id` int(11) default NULL,
  `created_userid` varchar(6) default NULL,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `PK_program_admin` (`id`),
  KEY `fk_link_program_admin_program` (`program_id`),
  CONSTRAINT `fk_link_program_admin_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `program_outcome`
--

DROP TABLE IF EXISTS `program_outcome`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program_outcome` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(500) default NULL,
  `description` varchar(1024) default NULL,
  `program_outcome_group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_program_outcome` (`id`),
  KEY `fk_program_outcome_program_outcome_group` (`program_outcome_group_id`),
  CONSTRAINT `fk_program_outcome_program_outcome_group` FOREIGN KEY (`program_outcome_group_id`) REFERENCES `program_outcome_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=900 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `program_outcome_group`
--

DROP TABLE IF EXISTS `program_outcome_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `program_outcome_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(250) default NULL,
  `description` varchar(1024) default NULL,
  `program_specific` varchar(1) NOT NULL,
  `program_id` int(11) NOT NULL default '-1',
  PRIMARY KEY  (`id`),
  KEY `PK_outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question` (
  `id` int(11) NOT NULL auto_increment,
  `display` varchar(500) default NULL,
  `question_type_id` int(11) NOT NULL,
  `answer_set_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_question` (`id`),
  KEY `fk_question_answer_set` (`answer_set_id`),
  CONSTRAINT `fk_question_answer_set` FOREIGN KEY (`answer_set_id`) REFERENCES `answer_set` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `question_response`
--

DROP TABLE IF EXISTS `question_response`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_response` (
  `id` int(11) NOT NULL auto_increment,
  `course_offering_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `response` varchar(1024) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_question_response` (`id`),
  KEY `fk_question_response_question` (`question_id`),
  KEY `fk_question_response_course_offering` (`course_offering_id`),
  KEY `fk_question_response_program` (`program_id`),
  CONSTRAINT `fk_question_response_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `fk_question_response_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `fk_question_response_course_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `question_type`
--

DROP TABLE IF EXISTS `question_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `description` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `system_admin`
--

DROP TABLE IF EXISTS `system_admin`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `system_admin` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `type` varchar(10) default NULL,
  `created_userid` varchar(30) default NULL,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `type_display` varchar(100) default NULL,
  `first_name` varchar(50) default NULL,
  `last_name` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_system_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teaching_method`
--

DROP TABLE IF EXISTS `teaching_method`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `teaching_method` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(1024) default NULL,
  `display_index` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_teaching_method` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teaching_method_portion_option`
--

DROP TABLE IF EXISTS `teaching_method_portion_option`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `teaching_method_portion_option` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `comparative_value` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_teaching_method_portion_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `time`
--

DROP TABLE IF EXISTS `time`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `time` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `option_display_index` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `PK_time` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `time_it_took`
--

DROP TABLE IF EXISTS `time_it_took`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `time_it_took` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `display_index` int(11) NOT NULL,
  `calculation_value` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pk_time_it_took` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-08 19:13:12
