-- create temp tables for 14-15







CREATE TABLE private_institutions (

 aun int,

 institution varchar(100),

 mail_adr varchar(100),

 loc_adr varchar(100),

 total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

 academic_year_start int DEFAULT 2014,

 academic_year_end int DEFAULT 2015,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 k4pp int,

 k5pp int,

 k5fpf int,

 onepp int,

 onefpf int,

 twopp int,

 twofpf int,

 threepp int,

 threefpf int,

 fourpp int,

 fourfpf int,

 fivepp int,

 fivefpf int,

 sixpp int,

 sixfpf int,

 sevenepp int,

 sevenefpf int,

 eightepp int,

 eightefpf int,

 eugpp int,

 eugfpf int,

 totalee int,

 blankcolumn varchar(50),

 totalnrpp int,

 totalnrfpf int,

 totalrpp int,

 totalrfpf int,

 totalee_2 int

);




CREATE TABLE private_secondary_enrollment (

 academic_year_start int DEFAULT 2014,

 academic_year_end int DEFAULT 2015,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 sevenspp int,

 sevensfpf int,

 eightspp int,

 eightsfpf int,

 ninepp int,

 ninefpf int,

 tenpp int,

 tenfpf int,

 elevenpp int,

 elevenfpf int,

 twelvepp int,

 twelvefpf int,

 sugpp int,

 sugfpf int,

 totalse int,

 blankcolumn varchar(50),

 nrpp int,

 nrfpf int,

 rpp int,

 rfpf int,

 totalse_2 int

);




CREATE TABLE private_other_enrollment (

 academic_year_start int DEFAULT 2014,

 academic_year_end int DEFAULT 2015,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 npp int,

 nfpf int,

 spedpreschk5pp int,

 spedpreschk5fpf int,

 spedpreschnurs345pp int,

 spedpreschnurs345fpf int,

 totaloe int,

 blankcolumn varchar(50),

 nrpp int,

 nrfpf int,

 rpp int,

 rfpf int,

 totaloe_2 int

);




CREATE TABLE private_fulltime_equivalent_teachers (

 academic_year_start int DEFAULT 2014,

 academic_year_end int DEFAULT 2015,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 nurseryfte real,

 elementaryfte real,

 secondaryfte real,

 spedpreschfte real,

 totalfte real

);




CREATE TABLE private_percentage_low_income (

 academic_year_start int DEFAULT 2014,

 academic_year_end int DEFAULT 2015,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 nurserypercent real,

 kto12percent real

);










-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions1415.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, blankcolumn, totalnrpp, totalnrfpf, totalrpp, totalrfpf, totalee_2) FROM './elementary1415.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, blankcolumn, nrpp, nrfpf, rpp, rfpf, totalse_2) FROM './secondary1415.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, blankcolumn, nrpp, nrfpf, rpp, rfpf, totaloe_2) FROM './other1415.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte1415.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, nurserypercent, kto12percent) FROM './pli1415.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;



























































































-- create temp tables for 13-14







CREATE TABLE private_institutions (

 aun int,

 institution varchar(100),

 mail_adr varchar(100),

 loc_adr varchar(100),

 total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

 academic_year_start int DEFAULT 2013,

 academic_year_end int DEFAULT 2014,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 totalrpp int,

 totalrfpf int,

 totalnrpp int,

 totalnrfpf int,

 totalee int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 k5pp int,

 k5fpf int,

 onepp int,

 onefpf int,

 twopp int,

 twofpf int,

 threepp int,

 threefpf int,

 fourpp int,

 fourfpf int,

 fivepp int,

 fivefpf int,

 sixpp int,

 sixfpf int,

 sevenepp int,

 sevenefpf int,

 eightepp int,

 eightefpf int,

 eugpp int,

 eugfpf int,

 totalee_2 int

);

CREATE TABLE private_secondary_enrollment (

 academic_year_start int DEFAULT 2013,

 academic_year_end int DEFAULT 2014,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 totalse int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 sevenspp int,

 sevensfpf int,

 eightspp int,

 eightsfpf int,

 ninepp int,

 ninefpf int,

 tenpp int,

 tenfpf int,

 elevenpp int,

 elevenfpf int,

 twelvepp int,

 twelvefpf int,

 sugpp int,

 sugfpf int,

 totalse_2 int

);




CREATE TABLE private_other_enrollment (

 academic_year_start int DEFAULT 2013,

 academic_year_end int DEFAULT 2014,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 totaloe int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 npp int,

 nfpf int,

 spedpreschnurs345pp int,

 spedpreschnurs345fpf int,

 spedpreschk5pp int,

 spedpreschk5fpf int,

 totaloe_2 int

);




CREATE TABLE private_fulltime_equivalent_teachers (

 academic_year_start int DEFAULT 2013,

 academic_year_end int DEFAULT 2014,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 nurseryfte real,

 spedpreschfte real,

 elementaryfte real,

 secondaryfte real,

 totalfte real

);




CREATE TABLE private_percentage_low_income (

 academic_year_start int DEFAULT 2013,

 academic_year_end int DEFAULT 2014,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 nurserypercent real,

 kto12percent real

);










-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions1314.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, totalee, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee_2) FROM './elementary1314.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, totalse, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse_2) FROM './secondary1314.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, totaloe, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, npp, nfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, totaloe_2) FROM './other1314.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, nurseryfte, spedpreschfte, elementaryfte, secondaryfte, totalfte) FROM './fte1314.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, nurserypercent, kto12percent) FROM './pli1314.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;














































-- create temp tables for 12-13







CREATE TABLE private_institutions (

 aun int,

 institution varchar(100),

 mail_adr varchar(100),

 loc_adr varchar(100),

 addr2 varchar(100),

 city varchar(50),

 state varchar(20),

 zip int,

 total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

 academic_year_start int DEFAULT 2012,

 academic_year_end int DEFAULT 2013,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 totalrpp int,

 totalrfpf int,

 totalnrpp int,

 totalnrfpf int,

 totalee int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 k4pp int,

 k4fpf int,

 k5pp int,

 k5fpf int,

 onepp int,

 onefpf int,

 twopp int,

 twofpf int,

 threepp int,

 threefpf int,

 fourpp int,

 fourfpf int,

 fivepp int,

 fivefpf int,

 sixpp int,

 sixfpf int,

 sevenepp int,

 sevenefpf int,

 eightepp int,

 eightefpf int,

 eugpp int,

 eugfpf int,

 totalee_2 int

);

CREATE TABLE private_secondary_enrollment (

 academic_year_start int DEFAULT 2012,

 academic_year_end int DEFAULT 2013,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 totalse int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 sevenspp int,

 sevensfpf int,

 eightspp int,

 eightsfpf int,

 ninepp int,

 ninefpf int,

 tenpp int,

 tenfpf int,

 elevenpp int,

 elevenfpf int,

 twelvepp int,

 twelvefpf int,

 sugpp int,

 sugfpf int,

 totalse_2 int

);




CREATE TABLE private_other_enrollment (

 academic_year_start int DEFAULT 2012,

 academic_year_end int DEFAULT 2013,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 totaloe int,

 blankcolumn varchar(50),

 blankcolumn2 varchar(50),

 blankcolumn3 varchar(50),

 aun2 int,

 institution2 varchar(100),

 npp int,

 nfpf int,

 spedpreschnurs345pp int,

 spedpreschnurs345fpf int,

 spedpreschk5pp int,

 spedpreschk5fpf int,

 totaloe_2 int

);




CREATE TABLE private_fulltime_equivalent_teachers (

 academic_year_start int DEFAULT 2012,

 academic_year_end int DEFAULT 2013,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 category varchar(20),

 nurseryfte real,

 elementaryfte real,

 secondaryfte real,

 spedpreschfte real,

 totalfte real

);




CREATE TABLE private_percentage_low_income (

 academic_year_start int DEFAULT 2012,

 academic_year_end int DEFAULT 2013,

 aun int,

 institution varchar(100),

 kto12percent real,

 nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions1213.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, totalee, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee_2) FROM './elementary1213.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, totalse, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse_2) FROM './secondary1213.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, totaloe, blankcolumn, blankcolumn2, blankcolumn3, aun2, institution2, npp, nfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, totaloe_2) FROM './other1213.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte1213.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, kto12percent, nurserypercent) FROM './pli1213.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;

































































































-- create temp tables for 11-12







CREATE TABLE private_institutions (

 aun int,

 institution varchar(100),

 mail_adr varchar(100),

 loc_adr varchar(100),

 addr2 varchar(100),

 city varchar(50),

 state varchar(20),

 zip int,

 total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

 academic_year_start int DEFAULT 2011,

 academic_year_end int DEFAULT 2012,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 totalrpp int,

 totalrfpf int,

 totalnrpp int,

 totalnrfpf int,

 blankcolumn varchar(50),

 k4pp int,

 k4fpf int,

 k5pp int,

 k5fpf int,

 onepp int,

 onefpf int,

 twopp int,

 twofpf int,

 threepp int,

 threefpf int,

 fourpp int,

 fourfpf int,

 fivepp int,

 fivefpf int,

 sixpp int,

 sixfpf int,

 sevenepp int,

 sevenefpf int,

 eightepp int,

 eightefpf int,

 eugpp int,

 eugfpf int,

 totalee int

);

CREATE TABLE private_secondary_enrollment (

 academic_year_start int DEFAULT 2011,

 academic_year_end int DEFAULT 2012,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 blankcolumn varchar(50),

 sevenspp int,

 sevensfpf int,

 eightspp int,

 eightsfpf int,

 ninepp int,

 ninefpf int,

 tenpp int,

 tenfpf int,

 elevenpp int,

 elevenfpf int,

 twelvepp int,

 twelvefpf int,

 sugpp int,

 sugfpf int,

 totalse int

);




CREATE TABLE private_other_enrollment (

 academic_year_start int DEFAULT 2011,

 academic_year_end int DEFAULT 2012,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 blankcolumn varchar(50),

 npp int,

 nfpf int,

 age21pluspp int,

 age21plusfpf int,

 spedpreschnurs345pp int,

 spedpreschnurs345fpf int,

 spedpreschk5pp int,

 spedpreschk5fpf int,

 totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

 academic_year_start int DEFAULT 2011,

 academic_year_end int DEFAULT 2012,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 category varchar(20),

 nurseryfte real,

 elementaryfte real,

 secondaryfte real,

 spedpreschfte real,

 totalfte real

);




CREATE TABLE private_percentage_low_income (

 academic_year_start int DEFAULT 2011,

 academic_year_end int DEFAULT 2012,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 category varchar(20),

 kto12percent real,

 nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions1112.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee) FROM './elementary1112.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse) FROM './secondary1112.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, age21pluspp, age21plusfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, totaloe) FROM './other1112.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte1112.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, category, kto12percent, nurserypercent) FROM './pli1112.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;








































-- create temp tables for 10-11







CREATE TABLE private_institutions (

 aun int,

 institution varchar(100),

 mail_adr varchar(100),

 loc_adr varchar(100),

 addr2 varchar(100),

 city varchar(50),

 state varchar(20),

 zip int,

 total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

 academic_year_start int DEFAULT 2010,

 academic_year_end int DEFAULT 2011,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 totalrpp int,

 totalrfpf int,

 totalnrpp int,

 totalnrfpf int,

 blankcolumn varchar(50),

 k4pp int,

 k4fpf int,

 k5pp int,

 k5fpf int,

 onepp int,

 onefpf int,

 twopp int,

 twofpf int,

 threepp int,

 threefpf int,

 fourpp int,

 fourfpf int,

 fivepp int,

 fivefpf int,

 sixpp int,

 sixfpf int,

 sevenepp int,

 sevenefpf int,

 eightepp int,

 eightefpf int,

 eugpp int,

 eugfpf int,

 totalee int

);

CREATE TABLE private_secondary_enrollment (

 academic_year_start int DEFAULT 2010,

 academic_year_end int DEFAULT 2011,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 blankcolumn varchar(50),

 sevenspp int,

 sevensfpf int,

 eightspp int,

 eightsfpf int,

 ninepp int,

 ninefpf int,

 tenpp int,

 tenfpf int,

 elevenpp int,

 elevenfpf int,

 twelvepp int,

 twelvefpf int,

 sugpp int,

 sugfpf int,

 totalse int

);




CREATE TABLE private_other_enrollment (

 academic_year_start int DEFAULT 2010,

 academic_year_end int DEFAULT 2011,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 rpp int,

 rfpf int,

 nrpp int,

 nrfpf int,

 blankcolumn varchar(50),

 npp int,

 nfpf int,

 age21pluspp int,

 age21plusfpf int,

 spedpreschnurs345pp int,

 spedpreschnurs345fpf int,

 spedpreschk5pp int,

 spedpreschk5fpf int,

 totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

 academic_year_start int DEFAULT 2010,

 academic_year_end int DEFAULT 2011,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 category varchar(20),

 nurseryfte real,

 elementaryfte real,

 secondaryfte real,

 spedpreschfte real,

 totalfte real

);




CREATE TABLE private_percentage_low_income (

 academic_year_start int DEFAULT 2010,

 academic_year_end int DEFAULT 2011,

 aun int,

 institution varchar(100),

 iu int,

 county varchar(50),

 category varchar(20),

 kto12percent real,

 nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions1011.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee) FROM './elementary1011.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse) FROM './secondary1011.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, age21pluspp, age21plusfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, totaloe) FROM './other1011.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte1011.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, category, kto12percent, nurserypercent) FROM './pli1011.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;








































-- create temp tables for 09-10







CREATE TABLE private_institutions (

aun int,

institution varchar(100),

mail_adr varchar(100),

loc_adr varchar(100),

addr2 varchar(100),

city varchar(50),

state varchar(20),

zip int,

total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

academic_year_start int DEFAULT 2009,

academic_year_end int DEFAULT 2010,

aun int,

institution varchar(100),

iu int,

county varchar(50),

totalrpp int,

totalrfpf int,

totalnrpp int,

totalnrfpf int,

blankcolumn varchar(50),

k4pp int,

k4fpf int,

k5pp int,

k5fpf int,

onepp int,

onefpf int,

twopp int,

twofpf int,

threepp int,

threefpf int,

fourpp int,

fourfpf int,

fivepp int,

fivefpf int,

sixpp int,

sixfpf int,

sevenepp int,

sevenefpf int,

eightepp int,

eightefpf int,

eugpp int,

eugfpf int,

totalee int

);

CREATE TABLE private_secondary_enrollment (

academic_year_start int DEFAULT 2009,

academic_year_end int DEFAULT 2010,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

sevenspp int,

sevensfpf int,

eightspp int,

eightsfpf int,

ninepp int,

ninefpf int,

tenpp int,

tenfpf int,

elevenpp int,

elevenfpf int,

twelvepp int,

twelvefpf int,

sugpp int,

sugfpf int,

totalse int

);




CREATE TABLE private_other_enrollment (

academic_year_start int DEFAULT 2009,

academic_year_end int DEFAULT 2010,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

npp int,

nfpf int,

spedpreschnurs345pp int,

spedpreschnurs345fpf int,

spedpreschk5pp int,

spedpreschk5fpf int,

age21pluspp int,

age21plusfpf int,

totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

academic_year_start int DEFAULT 2009,

academic_year_end int DEFAULT 2010,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

nurseryfte real,

elementaryfte real,

secondaryfte real,

spedpreschfte real,

totalfte real

);




CREATE TABLE private_percentage_low_income (

academic_year_start int DEFAULT 2009,

academic_year_end int DEFAULT 2010,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

kto12percent real,

nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions0910.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee) FROM './elementary0910.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse) FROM './secondary0910.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, age21pluspp, age21plusfpf, totaloe) FROM './other0910.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte0910.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, category, kto12percent, nurserypercent) FROM './pli0910.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;






















-- create temp tables for 08-09







CREATE TABLE private_institutions (

aun int,

institution varchar(100),

mail_adr varchar(100),

loc_adr varchar(100),

addr2 varchar(100),

city varchar(50),

state varchar(20),

zip int,

total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

academic_year_start int DEFAULT 2008,

academic_year_end int DEFAULT 2009,

aun int,

institution varchar(100),

iu int,

county varchar(50),

totalrpp int,

totalrfpf int,

totalnrpp int,

totalnrfpf int,

blankcolumn varchar(50),

k4pp int,

k4fpf int,

k5pp int,

k5fpf int,

onepp int,

onefpf int,

twopp int,

twofpf int,

threepp int,

threefpf int,

fourpp int,

fourfpf int,

fivepp int,

fivefpf int,

sixpp int,

sixfpf int,

sevenepp int,

sevenefpf int,

eightepp int,

eightefpf int,

eugpp int,

eugfpf int,

totalee int

);

CREATE TABLE private_secondary_enrollment (

academic_year_start int DEFAULT 2008,

academic_year_end int DEFAULT 2009,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

sevenspp int,

sevensfpf int,

eightspp int,

eightsfpf int,

ninepp int,

ninefpf int,

tenpp int,

tenfpf int,

elevenpp int,

elevenfpf int,

twelvepp int,

twelvefpf int,

sugpp int,

sugfpf int,

totalse int

);




CREATE TABLE private_other_enrollment (

academic_year_start int DEFAULT 2008,

academic_year_end int DEFAULT 2009,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

npp int,

nfpf int,

blankcolumn2 varchar(50),

spedpreschnurs345pp int,

spedpreschnurs345fpf int,

spedpreschk5pp int,

spedpreschk5fpf int,

blankcolumn3 varchar(50),

age21pluspp int,

age21plusfpf int,

blankcolumn4 varchar(50),

totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

academic_year_start int DEFAULT 2008,

academic_year_end int DEFAULT 2009,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

nurseryfte real,

elementaryfte real,

secondaryfte real,

spedpreschfte real,

totalfte real

);




CREATE TABLE private_percentage_low_income (

academic_year_start int DEFAULT 2008,

academic_year_end int DEFAULT 2009,

iu int,

county varchar(50),

category varchar(20),

aun int,

institution varchar(100),

kto12percent real,

nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions0809.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee) FROM './elementary0809.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse) FROM './secondary0809.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, blankcolumn2, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, blankcolumn3, age21pluspp, age21plusfpf, blankcolumn4, totaloe) FROM './other0809.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte0809.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(iu, county, category, aun, institution, kto12percent, nurserypercent) FROM './pli0809.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;








































-- create temp tables for 07-08







CREATE TABLE private_institutions (

aun int,

institution varchar(100),

mail_adr varchar(100),

loc_adr varchar(100),

addr2 varchar(100),

city varchar(50),

state varchar(20),

zip int,

total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

academic_year_start int DEFAULT 2007,

academic_year_end int DEFAULT 2008,

aun int,

institution varchar(100),

iu int,

county varchar(50),

totalrpp int,

totalrfpf int,

totalnrpp int,

totalnrfpf int,

blankcolumn varchar(50),

k4pp int,

k4fpf int,

k5pp int,

k5fpf int,

onepp int,

onefpf int,

twopp int,

twofpf int,

threepp int,

threefpf int,

fourpp int,

fourfpf int,

fivepp int,

fivefpf int,

sixpp int,

sixfpf int,

sevenepp int,

sevenefpf int,

eightepp int,

eightefpf int,

eugpp int,

eugfpf int,

blankcolumn2 varchar(50),

totalee int

);

CREATE TABLE private_secondary_enrollment (

academic_year_start int DEFAULT 2007,

academic_year_end int DEFAULT 2008,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

sevenspp int,

sevensfpf int,

eightspp int,

eightsfpf int,

ninepp int,

ninefpf int,

tenpp int,

tenfpf int,

elevenpp int,

elevenfpf int,

twelvepp int,

twelvefpf int,

sugpp int,

sugfpf int,

blankcolumn2 varchar(50),

totalse int

);




CREATE TABLE private_other_enrollment (

academic_year_start int DEFAULT 2007,

academic_year_end int DEFAULT 2008,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

npp int,

nfpf int,

blankcolumn2 varchar(50),

spedpreschnurs345pp int,

spedpreschnurs345fpf int,

spedpreschk5pp int,

spedpreschk5fpf int,

blankcolumn3 varchar(50),

age21pluspp int,

age21plusfpf int,

blankcolumn4 varchar(50),

totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

academic_year_start int DEFAULT 2007,

academic_year_end int DEFAULT 2008,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

nurseryfte real,

elementaryfte real,

secondaryfte real,

spedpreschfte real,

blankcolumn varchar(50),

totalfte real

);




CREATE TABLE private_percentage_low_income (

academic_year_start int DEFAULT 2007,

academic_year_end int DEFAULT 2008,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

kto12percent real,

nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions0708.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, blankcolumn2, totalee) FROM './elementary0708.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, blankcolumn2, totalse) FROM './secondary0708.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, blankcolumn2, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, blankcolumn3, age21pluspp, age21plusfpf, blankcolumn4, totaloe) FROM './other0708.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, blankcolumn, totalfte) FROM './fte0708.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, category, kto12percent, nurserypercent) FROM './pli0708.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k4fpf, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;










































































































-- create temp tables for 06-07







CREATE TABLE private_institutions (

aun int,

institution varchar(100),

mail_adr varchar(100),

loc_adr varchar(100),

addr2 varchar(100),

city varchar(50),

state varchar(20),

zip int,

blankcolumn varchar(50),

total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

academic_year_start int DEFAULT 2006,

academic_year_end int DEFAULT 2007,

aun int,

institution varchar(100),

iu int,

county varchar(50),

totalrpp int,

totalrfpf int,

totalnrpp int,

totalnrfpf int,

blankcolumn varchar(50),

k4pp int,

k5pp int,

k5fpf int,

onepp int,

onefpf int,

twopp int,

twofpf int,

threepp int,

threefpf int,

fourpp int,

fourfpf int,

fivepp int,

fivefpf int,

sixpp int,

sixfpf int,

sevenepp int,

sevenefpf int,

eightepp int,

eightefpf int,

eugpp int,

eugfpf int,

blankcolumn2 varchar(50),

totalee int

);

CREATE TABLE private_secondary_enrollment (

academic_year_start int DEFAULT 2006,

academic_year_end int DEFAULT 2007,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

sevenspp int,

sevensfpf int,

eightspp int,

eightsfpf int,

ninepp int,

ninefpf int,

tenpp int,

tenfpf int,

elevenpp int,

elevenfpf int,

twelvepp int,

twelvefpf int,

sugpp int,

sugfpf int,

blankcolumn2 varchar(50),

totalse int

);




CREATE TABLE private_other_enrollment (

academic_year_start int DEFAULT 2006,

academic_year_end int DEFAULT 2007,

aun int,

institution varchar(100),

iu int,

county varchar(50),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

npp int,

nfpf int,

blankcolumn2 varchar(50),

spedpreschnurs345pp int,

spedpreschnurs345fpf int,

spedpreschk5pp int,

spedpreschk5fpf int,

blankcolumn3 varchar(50),

age21pluspp int,

age21plusfpf int,

blankcolumn4 varchar(50),

totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

academic_year_start int DEFAULT 2006,

academic_year_end int DEFAULT 2007,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

nurseryfte real,

elementaryfte real,

secondaryfte real,

spedpreschfte real,

blankcolumn varchar(50),

totalfte real

);




CREATE TABLE private_percentage_low_income (

academic_year_start int DEFAULT 2006,

academic_year_end int DEFAULT 2007,

aun int,

institution varchar(100),

iu int,

county varchar(50),

category varchar(20),

kto12percent real,

nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions0607.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(aun, institution, iu, county, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, blankcolumn2, totalee) FROM './elementary0607.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, blankcolumn2, totalse) FROM './secondary0607.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(aun, institution, iu, county, rpp, rfpf, nrpp, nrfpf, blankcolumn, npp, nfpf, blankcolumn2, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, blankcolumn3, age21pluspp, age21plusfpf, blankcolumn4, totaloe) FROM './other0607.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(aun, institution, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, blankcolumn, totalfte) FROM './fte0607.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, iu, county, category, kto12percent, nurserypercent) FROM './pli0607.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, nrfpf, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, category, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;































































































































-- create temp tables for 05-06







CREATE TABLE private_institutions (

institution varchar(100),

aun int,

loc_adr varchar(100),

city varchar(50),

state varchar(20),

zip int,

mail_adr varchar(100),

city2 varchar(50),

state2 varchar(20),

zip2 int,

total_enrollment int

);




CREATE TABLE private_elementary_enrollment (

academic_year_start int DEFAULT 2005,

academic_year_end int DEFAULT 2006,

institution varchar(100),

aun int,

iu int,

county varchar(50),

category varchar(20),

totalrpp int,

totalrfpf int,

totalnrpp int,

totalnrfpf int,

blankcolumn varchar(50),

k4pp int,

k5pp int,

k5fpf int,

onepp int,

onefpf int,

twopp int,

twofpf int,

threepp int,

threefpf int,

fourpp int,

fourfpf int,

fivepp int,

fivefpf int,

sixpp int,

sixfpf int,

sevenepp int,

sevenefpf int,

eightepp int,

eightefpf int,

eugpp int,

eugfpf int,

blankcolumn2 varchar(50),

totalee int

);

CREATE TABLE private_secondary_enrollment (

academic_year_start int DEFAULT 2005,

academic_year_end int DEFAULT 2006,

institution varchar(100),

aun int,

iu int,

county varchar(50),

category varchar(20),

rpp int,

rfpf int,

nrpp int,

nrfpf int,

blankcolumn varchar(50),

sevenspp int,

sevensfpf int,

eightspp int,

eightsfpf int,

ninepp int,

ninefpf int,

tenpp int,

tenfpf int,

elevenpp int,

elevenfpf int,

twelvepp int,

twelvefpf int,

sugpp int,

sugfpf int,

blankcolumn2 varchar(50),

totalse int

);




CREATE TABLE private_other_enrollment (

academic_year_start int DEFAULT 2005,

academic_year_end int DEFAULT 2006,

institution varchar(100),

aun int,

iu int,

county varchar(50),

category varchar(20),

npp int,

nfpf int,

age21pluspp int,

age21plusfpf int,

spedpreschnurs345pp int,

spedpreschnurs345fpf int,

spedpreschk5pp int,

spedpreschk5fpf int,

blankcolumn varchar(50),

rpp int,

rfpf int,

nrpp int,

blankcolumn2 varchar(50),

totaloe int

);




CREATE TABLE private_fulltime_equivalent_teachers (

academic_year_start int DEFAULT 2005,

academic_year_end int DEFAULT 2006,

institution varchar(100),

aun int,

iu int,

county varchar(50),

category varchar(20),

nurseryfte real,

elementaryfte real,

secondaryfte real,

spedpreschfte real,

totalfte real

);




CREATE TABLE private_percentage_low_income (

academic_year_start int DEFAULT 2005,

academic_year_end int DEFAULT 2006,

aun int,

institution varchar(100),

kto12percent real,

nurserypercent real

);
















-- copy data from csv into temporary tables







\COPY private_institutions FROM './institutions0506.csv' DELIMITER ',' CSV;




\COPY private_elementary_enrollment(institution, aun, iu, county, category, totalrpp, totalrfpf, totalnrpp, totalnrfpf, blankcolumn, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, blankcolumn2, totalee) FROM './elementary0506.csv' DELIMITER ',' CSV;




\COPY private_secondary_enrollment(institution, aun, iu, county, category, rpp, rfpf, nrpp, nrfpf, blankcolumn, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, blankcolumn2, totalse) FROM './secondary0506.csv' DELIMITER ',' CSV;




\COPY private_other_enrollment(institution, aun, iu, county, category, npp, nfpf, age21pluspp, age21plusfpf, spedpreschnurs345pp, spedpreschnurs345fpf, spedpreschk5pp, spedpreschk5fpf, blankcolumn, rpp, rfpf, nrpp, blankcolumn2, totaloe) FROM './other0506.csv' DELIMITER ',' CSV;




\COPY private_fulltime_equivalent_teachers(institution, aun, iu, county, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) FROM './fte0506.csv' DELIMITER ',' CSV;




\COPY private_percentage_low_income(aun, institution, kto12percent, nurserypercent) FROM './pli0506.csv' DELIMITER ',' CSV;










-- move data from temporary tables to final tables







INSERT INTO private_schools_enrollment(aun, name, mail_adr, loc_adr, total_enr) SELECT distinct aun, institution, mail_adr, loc_adr, total_enrollment FROM private_institutions WHERE aun NOT IN (SELECT aun FROM private_schools_enrollment);




UPDATE private_schools_enrollment SET iu = (SELECT iu FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);

UPDATE private_schools_enrollment SET county = (SELECT county FROM private_elementary_enrollment WHERE private_schools_enrollment.aun = private_elementary_enrollment.aun);




INSERT INTO private_schools_elementary_enrollment(aun, academic_year_start, academic_year_end, category, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf) SELECT aun, academic_year_start, academic_year_end, category, k4pp, k5pp, k5fpf, onepp, onefpf, twopp, twofpf, threepp, threefpf, fourpp, fourfpf, fivepp, fivefpf, sixpp, sixfpf, sevenepp, sevenefpf, eightepp, eightefpf, eugpp, eugfpf, totalee, totalnrpp, totalnrfpf, totalrpp, totalrfpf FROM private_elementary_enrollment;




INSERT INTO private_schools_secondary_enrollment(aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, sevenspp, sevensfpf, eightspp, eightsfpf, ninepp, ninefpf, tenpp, tenfpf, elevenpp, elevenfpf, twelvepp, twelvefpf, sugpp, sugfpf, totalse, nrpp, nrfpf, rpp, rfpf FROM private_secondary_enrollment;




INSERT INTO private_schools_other_enrollment(aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, rpp, rfpf) SELECT aun, academic_year_start, academic_year_end, npp, nfpf, age21pluspp, age21plusfpf, spedpreschk5pp, spedpreschk5fpf, spedpreschnurs345pp, spedpreschnurs345fpf, totaloe, nrpp, rpp, rfpf FROM private_other_enrollment;




INSERT INTO private_schools_fulltime_equivalent_teachers(aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte) SELECT aun, academic_year_start, academic_year_end, category, nurseryfte, elementaryfte, secondaryfte, spedpreschfte, totalfte FROM private_fulltime_equivalent_teachers;




INSERT INTO private_schools_percentage_low_income(aun, academic_year_start, academic_year_end, nurserypercent, kto12percent) SELECT aun, academic_year_start, academic_year_end, nurserypercent, kto12percent FROM private_percentage_low_income;










-- drop temporary tables







DROP TABLE private_institutions;

DROP TABLE private_elementary_enrollment;

DROP TABLE private_secondary_enrollment;

DROP TABLE private_other_enrollment;

DROP TABLE private_fulltime_equivalent_teachers;

DROP TABLE private_percentage_low_income;
