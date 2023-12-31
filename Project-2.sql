Q1.Create new schema as alumni

create database alumni;
use alumni;

Q2.Import all .csv files into MySQL
Ans.All csv files are successfully imported. screenshot attached.

Q3.Run SQL command to see the structure of six tables

desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

Q4.Display first 1000 rows of tables
(College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.

Ans.python file attached

Q5.


Q6.

SELECT * FROM college_a_hs;
CREATE VIEW College_A_HS_V AS (SELECT * FROM college_a_hs WHERE Rollno IS NOT NULL AND 
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND 
Fathername IS NOT NULL AND 
Mothername IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND 
PresentStatus IS NOT NULL AND 
HSDegree IS NOT NULL AND 
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND 
Location IS NOT NULL );

SELECT * FROM College_A_HS_v;

Q7.

select * from college_a_se;

CREATE VIEW college_A_SE_V AS (SELECT * FROM college_a_se WHERE rollno IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND
mothername IS NOT NULL AND
Batch IS NOT NULL AND
Degree IS NOT NULL AND
presentStatus IS NOT NULL AND
Organization IS NOT NULL AND
Location IS NOT NULL );

SELECT * FROM College_A_SE_V;

Q8.

SELECT * FROM college_A_SJ;
CREATE VIEW college_A_SJ_V AS (SELECT * FROM college_A_SJ WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
Organization IS NOT NULL AND
Designation IS NOT NULL AND
Location IS NOT NULL );

SELECT * FROM college_A_SJ_V;

Q9.

SELECT * FROM college_B_HS;
CREATE VIEW college_B_HS_V AS (SELECT * FROM college_B_HS WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND
Branch IS NOT NULL AND
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL );

SELECT * FROM college_B_HS_V;

Q10.

SELECT * FROM college_B_SE;
CREATE VIEW college_B_SE_V AS (SELECT * FROM college_B_SE WHERE ROllNo IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Branch IS NOT NULL AND
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
Organization IS NOT NULL AND
Location IS NOT NULL ); 

SELECT * FROM college_B_SE_V;

Q11.

SELECT * FROM college_B_SJ;
CREATE VIEW college_B_SJ_V AS (SELECT * FROM college_B_SJ WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND
Branch IS NOT NULL AND
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
Organization IS NOT NULL AND
Designation IS NOT NULL AND
Location IS NOT NULL );

SELECT * FROM college_B_SJ_V;

Q12

DELIMITER ||
CREATE PROCEDURE lower_case ()
BEGIN
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_hs_v;
SELECT LOWER(name) Name, LOWER(FatherName) FatherName, Lower(MotherName) MotherName FROM college_a_se_v;
SELECT LOWER(name) Name, LOWER(FatherName) FatherName, Lower(MotherName) MotherName FROM college_a_sj_v;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_hs_v;
SELECT LOWER(name) Name, LOWER(FatherName) FatherName, Lower(MotherName) MotherName FROM college_b_se_v;
SELECT LOWER(name) Name, LOWER(FatherName) FatherName, Lower(MotherName) MotherName FROM college_b_sj_v;
END ||
DELIMITER ;

CALL lower_case()

Q13.

Q14.

DELIMITER ||
CREATE PROCEDURE get_name_collegeA
(
INOUT name_A TEXT (50000)
)
BEGIN
     DECLARE finished INT DEFAULT 0;
     DECLARE namelist VARCHAR (16000) DEFAULT" ";
     DECLARE namedetail
             CURSOR FOR
             SELECT Name FROM college_A_HS
             UNION
             SELECT Name FROM college_A_SE
             UNION
             SELECT Name FROM college_A_SJ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FINISHED = 1;
    OPEN namedetail;
    getnameA:
    LOOP 
       FETCH namedetail INTO namelist;
       IF finished = 1 THEN
       LEAVE getnameA;
       END IF;
       SET name_A = concat
       (namelist,";",name_A);
       END LOOP getnameA;
       
       SELECT * FROM college_A_HS;
       SELECT * FROM college_A_SE;
       SELECT * FROM college_A_SJ;
       
       CLOSE namedetail;
       
END ||
DELIMITER ;

SET @name_A = "";
CALL get_name_collegeA(@name_A);
SELECT @name_A;

Q15.

DELIMITER ||
CREATE PROCEDURE get_name_collegeB
(
INOUT name_B TEXT (50000)
)
BEGIN
     DECLARE finished INT DEFAULT 0;
     DECLARE namelist VARCHAR (16000) DEFAULT" ";
     DECLARE namedetail
             CURSOR FOR
             SELECT Name FROM college_B_HS
             UNION
             SELECT Name FROM college_B_SE
             UNION
             SELECT Name FROM college_B_SJ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FINISHED = 1;
    OPEN namedetail;
    getnameB:
    LOOP 
       FETCH namedetail INTO namelist;
       IF finished = 1 THEN
       LEAVE getnameB;
       END IF;
       SET name_B = concat
       (namelist,";",name_B);
       END LOOP getnameB;
       
       SELECT * FROM college_B_HS;
       SELECT * FROM college_B_SE;
       SELECT * FROM college_B_SJ;
       
       CLOSE namedetail;
       
END ||
DELIMITER ;

SET @name_B = "";
CALL get_name_collegeA(@name_B);
SELECT @name_B;

Q16

SELECT "Higher Studies" career_choice, (SELECT COUNT(*) FROM college_a_hs)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100 AS College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select count(*) from college_b_sj)) * 100 AS College_B_Percentage
UNION
SELECT "Self Employed", (SELECT COUNT(*) FROM college_a_se)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100,
(SELECT COUNT(*) FROM college_b_se)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select Count(*) from college_b_sj)) * 100
UNION
SELECT "Service/Job", (SELECT COUNT(*) FROM college_a_sj)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100,
(SELECT COUNT(*) FROM college_b_sj)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select Count(*) from college_b_sj)) * 100
    