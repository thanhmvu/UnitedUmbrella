-- create temp table for assessments







CREATE TABLE state_assessments (

school_id int,

lea_name varchar(200),

school_name varchar(200),

subject varchar(1),

grade varchar(20),

student_group varchar(100),

n_scored int,

pct_advanced varchar(20),

pct_proficient varchar(20),

pct_basic varchar(20),

pct_below_basic varchar(20),

growth varchar(20)

);













-- copy data from csv into temporary table







\COPY state_assessments FROM './assessments0515.csv' DELIMITER ',' CSV;













-- move data from temporary table to final tables







INSERT INTO school_assessment_names SELECT distinct school_id, lea_name, school_name FROM state_assessments;




INSERT INTO school_assessment_results(school_id, subject, grade, student_group, n_scored, pct_advanced, pct_proficient, pct_basic, pct_below_basic, growth) SELECT school_id, subject, grade, student_group, n_scored, pct_advanced, pct_proficient, pct_basic, pct_below_basic, growth FROM state_assessments;










-- drop temporary tables







DROP TABLE state_assessments;
