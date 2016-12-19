CREATE TABLE school_assessment_names (

 school_id int PRIMARY KEY,

 lea_name varchar(200),

 school_name varchar(200)

);

CREATE TABLE school_assessment_results (

 school_id int,

 subject varchar(1),

 grade varchar(20),

 student_group varchar(100),

 n_scored int,

 pct_advanced varchar(20),

 pct_proficient varchar(20),

 pct_basic varchar(20),

 pct_below_basic varchar(20),

 growth varchar(20),

 PRIMARY KEY (school_id, subject, grade, student_group)

);
