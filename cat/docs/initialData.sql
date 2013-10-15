

INSERT INTO `question_type` (`id`, `name`, `description`) VALUES (1,'select','select one of multiple answer options (select-box)'), (2,'radio','select one of multiple answer options (radio)'), (3,'checkbox','select any of multiple answer options (checkbox)'), (4,'textarea','Open answer format');



INSERT INTO `time` (`id`, `name`, `display_index`, `option_display_index`) VALUES (5,'during their first year of undergraduate studies',1,1), (6,'during their second year of undergraduate studies',2,2), (7,'during their third year of undergraduate studies',3,3), (8,'during their fourth year of undergraduate studies',4,4), (12,'any time during undergraduate studies',5,5), (13,'during their first year of graduate studies',6,6), (14,'during their second year or after of graduate studies',7,7), (15,'any time during graduate studies',8,8);



INSERT INTO `course_classification` (`id`, `name`, `description`,
`display_index`)
VALUES
	(1,'Required','This courses is a requirement for the program',1),
	(2,'an Elective','This courses is an optional component for the program',4),
	(3,'depends on specialization','This course could be required, it would depend on their specialization',3),
	(4,'recommended','This course is recommended for the program',2);



INSERT INTO `assessment_time_option` (`id`, `name`, `display_index`,
`time_period`)
VALUES
	(3,'during first half',1,'Y'),
	(4,'at middle of term',2,'N'),
	(7,'during second half',3,'Y'),
	(8,'last 2 weeks of classes',4,'N'),
	(9,'after end of classes (before final)',5,'N'),
	(10,'ongoing',7,'O'),
	(11,'final exam period',6,'N');



INSERT INTO `answer_option` (`id`, `answer_set_id`, `display`, `value`,
`display_index`)
VALUES
	(1,1,'about 10 minutes','10',1),
	(2,1,'about 30 minutes','30',3),
	(3,1,'about an hour','60',4),
	(4,1,'more than an hour','100',5),
	(5,1,'about 20 minutes','20',2),
	(7,2,'Not at all','0',1),
	(8,2,'Somewhat','1',2),
	(9,2,'Often','2',3),
	(10,2,'Extensively','3',4),
	(11,3,'none','0',1),
	(12,3,'Level 1 (Prescribed Research) Highly structured directions and modelling from educator prompt student research','1',2),
	(13,3,'Level 2 (Bounded Research) Boundaries set by and limited directions from educator channel student research','2',3),
	(14,3,'Level 3 (Scaffolded Research) Scaffolds placed by educator shape student independent research','3',4),
	(15,3,'Level 4 (Student-initiated Research) Students initiate the research and this is guided by the educator','4',5),
	(16,3,'Level 5 (Open Research) Students research within self-determined guidelines that are in accord with discipline or context. ','5',6);



	
INSERT INTO `teaching_method` (`id`, `name`, `description`, `display_index`)
VALUES
(1,'Direct Instruction','Possibilities include: Structured Overview, Lecture, Explicit Teaching, Drill & Practice, Compare & Contrast, Didactic Questions, Demonstrations, Guided & Shared - reading, listening, viewing, thinking',1),
(2,'Interactive Instruction','Possibilities include: Debates, Role Playing, Panels, Brainstorming, Peer Partner Learning, Discussion, Laboratory Groups, Think, Pair, Share, Cooperative Learning Groups, Jigsaw, Problem Solving, Structured Controversy, Tutorial Groups, Interviewing, Conferencing',2),
(3,'Indirect Instruction','Possibilities include: Problem Solving, Case Studies, Reading for Meaning, Inquiry, Reflective Discussion, Writing to Inform, Concept Formation, Concept Mapping, Concept Attainment, Cloze Procedure',3),
(4,'Independent Study','Possibilities include: Essays, Computer Assisted Instruction, Journals, Learning Logs, Reports, Learning Activity Packages, Correspondence Lessons, Learning Contracts, Homework, Research Projects, Assigned Questions, Learning Centers',4),
(5,'Experiential Learning','Possibilities include: Field Trips, Narratives, Conducting Experiments, Simulations, Games, Storytelling, Focused Imaging, Field Observations, Role-playing, Model Building, Surveys, Studio Labs, Community Engaged Learning, Study Abroad, Community Service Learning, Undergraduate Research, Internships, Practicum, Apprenticeship and Field Courses',5);



INSERT INTO `teaching_method_portion_option` (`id`, `name`, `display_index`, `comparative_value`)
VALUES
(4,'not at all',0,0),
(22,'occasionally',1,1),
(23,'about half the time',2,2),
(24,'mostly',3,3);

