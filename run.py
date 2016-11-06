''' 
assuming academic_end_year = academic_start_year + 1
the structure of 
'''
# Permanent relations' name
lea_permanent_rel = 'public_lea';
schools_permanent_rel = 'public_schools';
school_enrollment_permanent_rel = 'public_school_enrollment';
school_gender_enrollment_permanent_rel = 'public_school_gender_enrollment';
lea_race_enrollment_permanent_rel = 'public_lea_race_enrollment';

# Temporary relations' name
lea_school_temp_rel = 'public_lea_school'
lea_school_gender_temp_rel ='public_lea_school_gender'
lea_race_temp_rel = 'public_lea_race'

# backup relations' name
lea_school_backup_rel = 'public_lea_school_backup'
lea_school_gender_backup_rel ='public_lea_school_gender_backup'
lea_race_backup_rel = 'public_lea_race_backup'



def drop_all_relations_command():
	command = '''
	-- drop old public relations to rebuild from scratch
	DROP TABLE IF EXISTS '''+lea_permanent_rel+''';
	DROP TABLE IF EXISTS '''+schools_permanent_rel+''';
	DROP TABLE IF EXISTS '''+school_enrollment_permanent_rel+''';
	DROP TABLE IF EXISTS '''+school_gender_enrollment_permanent_rel+''';
	DROP TABLE IF EXISTS '''+lea_race_enrollment_permanent_rel+''';

	-- Drop old backup relations
	DROP TABLE '''+lea_school_backup_rel+''';
	DROP TABLE '''+lea_school_gender_backup_rel+''';
	DROP TABLE '''+lea_race_backup_rel+''';
	'''
	return command

# hardcode the structure of permanent relations
def create_all_relations_command():
	command = '''
	-- Create public relations
	CREATE TABLE '''+lea_permanent_rel+''' (
	 aun int PRIMARY KEY,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50)
	);

	CREATE TABLE '''+schools_permanent_rel+''' (
	 school_id int,
	 school_name varchar(100),
	 aun int,
	 PRIMARY KEY (school_id,aun)
	);

	CREATE TABLE '''+school_enrollment_permanent_rel+''' (
	 academic_year_start int,
	 academic_year_end int,
	 school_id int,
	 aun int,
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int,
	 PRIMARY KEY (academic_year_start, academic_year_end, school_id, aun)
	);

	CREATE TABLE '''+school_gender_enrollment_permanent_rel+''' (
	 academic_year_start int,
	 academic_year_end int,
	 school_id int,
	 aun int,
	 gender varchar(1),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int,
	 PRIMARY KEY (academic_year_start, academic_year_end, school_id, aun, gender)
	);

	CREATE TABLE '''+lea_race_enrollment_permanent_rel+''' (
	 academic_year_start int,
	 academic_year_end int,
	 aun int,
	 race varchar(100),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int,
	 PRIMARY KEY (academic_year_start, academic_year_end, aun, race)
	);

	-- Create backup relations
	CREATE TABLE '''+lea_school_backup_rel+''' (
	 academic_year_start int DEFAULT 2012,
	 academic_year_end int DEFAULT 2013,
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 school_id int,
	 school_name varchar(100),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);

	CREATE TABLE '''+lea_school_gender_backup_rel+''' (
	 academic_year_start int DEFAULT 2012,
	 academic_year_end int DEFAULT 2013,
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 school_id int,
	 school_name varchar(100),
	 gender varchar(1),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);

	CREATE TABLE '''+lea_race_backup_rel+''' (
	 academic_year_start int DEFAULT 2012,
	 academic_year_end int DEFAULT 2013,
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 race varchar(100),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);
	'''
	return command

# hardcode the structure of 3 temp relations based on the structure of input csvfiles
def create_temp_tables_command(academic_year_start, academic_year_end):
	command = '''
	-- Create temp tables
	CREATE TABLE '''+lea_school_temp_rel+''' (
	 academic_year_start int DEFAULT '''+`academic_year_start`+''',
	 academic_year_end int DEFAULT '''+`academic_year_end`+''',
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 school_id int,
	 school_name varchar(100),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);

	CREATE TABLE '''+lea_school_gender_temp_rel+''' (
	 academic_year_start int DEFAULT '''+`academic_year_start`+''',
	 academic_year_end int DEFAULT '''+`academic_year_end`+''',
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 school_id int,
	 school_name varchar(100),
	 gender varchar(1),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);

	CREATE TABLE '''+lea_race_temp_rel+''' (
	 academic_year_start int DEFAULT '''+`academic_year_start`+''',
	 academic_year_end int DEFAULT '''+`academic_year_end`+''',
	 aun int,
	 lea_name varchar(100),
	 lea_type varchar(50),
	 county varchar(50),
	 race varchar(100),
	 pka int,
	 pkp int,
	 pkf int,
	 k4a int,
	 k4p int,
	 k4f int,
	 k5a int,
	 k5p int,
	 k5f int,
	 grade1 int,
	 grade2 int,
	 grade3 int,
	 grade4 int,
	 grade5 int,
	 grade6 int,
	 eug int,
	 grade7 int,
	 grade8 int,
	 grade9 int,
	 grade10 int,
	 grade11 int,
	 grade12 int,
	 sug int,
	 total int
	);
	'''
	return command

def delete_temp_tables_command():
	command = '''
	-- remove temp tables
	DROP TABLE '''+lea_school_temp_rel+''';
	DROP TABLE '''+lea_school_gender_temp_rel+''';
	DROP TABLE '''+lea_race_temp_rel+''';
	'''
	return command



# hardcode the structure of temp relations based on input csv file
def load_to_temp_tables_command(year_start, lea_school_input_file,lea_school_gender_input_file,lea_race_input_file):
	command = '''
	-- Load data from csv files to temp relations
	\copy '''+lea_school_temp_rel+''' (aun, lea_name, lea_type, county, school_id, school_name, pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +'''grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total) FROM \''''+lea_school_input_file+'''\' DELIMITER ',' CSV NULL AS '*' -- terminate with a new line
	'''
	if (year_start>=2011): command += '''
	\copy '''+lea_school_gender_temp_rel+''' (aun, lea_name, lea_type, county, school_id, school_name, gender, pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +'''grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total) FROM \''''+lea_school_gender_input_file+'''\' DELIMITER ',' CSV NULL AS '*' -- terminate with a new line

	\copy '''+lea_race_temp_rel+''' (aun, lea_name, lea_type, county, race, pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +'''grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total) FROM \''''+lea_race_input_file+'''\' DELIMITER ',' CSV NULL AS '*' -- terminate with a new line
	'''
	return command

# hardcode the name + structure of 5 permanent relations and 3 temp tables
def load_temp_to_backup_command(year_start):
	command = '''
	-- Load from temp tables to back up tables
	INSERT INTO '''+lea_school_backup_rel+''' 
	(academic_year_start, academic_year_end, school_id, school_name, 
	aun, lea_name, lea_type, county,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total)
	SELECT 
	academic_year_start, academic_year_end, school_id, school_name, 
	aun, lea_name, lea_type, county,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total
	FROM '''+lea_school_temp_rel+''';
	'''
	if(year_start >= 2011): command += '''
	INSERT INTO '''+lea_school_gender_backup_rel+''' 
	(academic_year_start, academic_year_end, school_id, school_name, 
	aun, lea_name, lea_type, county, gender,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total)
	SELECT 
	academic_year_start, academic_year_end, school_id, school_name, 
	aun, lea_name, lea_type, county, gender,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total
	FROM '''+lea_school_gender_temp_rel+''';
		
	INSERT INTO '''+lea_race_backup_rel+''' 
	(academic_year_start, academic_year_end, 
	aun, lea_name, lea_type, county, race,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total)
	SELECT 
	academic_year_start, academic_year_end, 
	aun, lea_name, lea_type, county, race,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, '''+ ('','eug, ')[year_start<2013] +''' 
	grade7, grade8, grade9, grade10, grade11, grade12, '''+ ('','sug, ')[year_start<2013] +'''total
	FROM '''+lea_race_temp_rel+''';
	'''
	return command

def load_backup_to_permanent_command():
	command = '''
	-- add data to static info relations 
	INSERT INTO '''+lea_permanent_rel+''' (aun, lea_name, lea_type, county)
	SELECT aun, lea_name, lea_type, county 
	FROM '''+lea_school_backup_rel+'''
	WHERE aun NOT IN (SELECT aun FROM '''+lea_permanent_rel+''');

	INSERT INTO '''+schools_permanent_rel+''' (school_id, school_name, aun)
	SELECT school_id, school_name, aun 
	FROM '''+lea_school_backup_rel+'''
	WHERE school_id NOT IN (SELECT aun FROM '''+schools_permanent_rel+''');

	-- add data to other relations
	INSERT INTO '''+school_enrollment_permanent_rel+''' 
	(academic_year_start, academic_year_end, school_id, aun,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total)
	SELECT 
	academic_year_start, academic_year_end, school_id, aun,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total
	FROM '''+lea_school_backup_rel+''' WHERE school_id > 0 AND school_id < 9999;

	INSERT INTO '''+school_gender_enrollment_permanent_rel+''' 
	(academic_year_start, academic_year_end, school_id, aun, gender, 
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total)
	SELECT 
	academic_year_start, academic_year_end, school_id, aun, gender,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total
	FROM '''+lea_school_gender_backup_rel+''' WHERE school_id > 0 AND school_id < 9999;
		
	INSERT INTO '''+lea_race_enrollment_permanent_rel+''' 
	(academic_year_start, academic_year_end, aun, race, 
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total)
	SELECT 
	academic_year_start, academic_year_end, aun, race,
	pka, pkp, pkf, k4a, k4p, k4f, k5a, k5p, k5f, 
	grade1, grade2, grade3, grade4, grade5, grade6, eug, 
	grade7, grade8, grade9, grade10, grade11, grade12, sug, total
	FROM '''+lea_race_backup_rel+''';
	'''
	return command


def load_public_year(academic_year_start, academic_year_end, lea_school_input_file_name, lea_school_gender_input_file, lea_race_input_file):
	command = '\n------------------------ START LOADING DATA FOR '+`academic_year_start`+'-'+`academic_year_end`+' ------------------------\n'
	command += create_temp_tables_command(academic_year_start, academic_year_end)
	command += load_to_temp_tables_command(academic_year_start, lea_school_input_file_name, lea_school_gender_input_file, lea_race_input_file)
	command += load_temp_to_backup_command(academic_year_start)
	command += delete_temp_tables_command()
	command += '\n------------------------ END LOADING DATA FOR '+`academic_year_start`+'-'+`academic_year_end`+' ------------------------\n'
	return command

# ------------------------ MAIN ---------------------------
# # add commands to reset all relations
# command += drop_all_relations_command()
# command += create_all_relations_command()


# add commands to load data
for academic_year_start in range(2007,2016):
	academic_year_end = academic_year_start + 1

	file = open("public"+`(academic_year_start%100)`.zfill(2)+`(academic_year_end%100)`.zfill(2)+"load.sql","w")
	command = ''

	folder_name = './public/Enrollment Public School '+`academic_year_start`+'-'+`(academic_year_end%100)`.zfill(2)+'.xls Data/'

	lea_school_input_file= folder_name+ 'LEA and School.csv'
	lea_school_gender_input_file = folder_name+ 'LEA, School, and Gender.csv'
	lea_race_input_file = folder_name+ 'LEA and Race.csv'
	school_data_input_file = folder_name+ 'School Enrollments - Data File.csv'


	if academic_year_start < 2011:
		command += load_public_year(academic_year_start, academic_year_end, school_data_input_file, None, None)
	else:
		command += load_public_year(academic_year_start, academic_year_end, lea_school_input_file, lea_school_gender_input_file, lea_race_input_file)

	file.write(command)
	file.close()

file = open ("loadBackupToPermanent.sql","w")
command = load_backup_to_permanent_command()
file.write(command)
file.close()

file = open ("resetPublicTables.sql","w")
command = drop_all_relations_command()
command += create_all_relations_command()
file.write(command)
file.close()