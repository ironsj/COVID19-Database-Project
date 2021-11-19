SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
<One line per team member name; in alphabetical order>
*/
/*< The SQL/DDL code that creates your schema >
In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.*/
CREATE TABLE Person(
gNumber INTEGER,
pName CHAR(15),
pType CHAR(15),
resID CHAR(15)
);
--
CREATE TABLE Class(
classID INTEGER,
className CHAR(15),
numStudents INTEGER,
roomNum INTEGER
);
--
CREATE TABLE Room(
roomNum INTEGER,
roomCapacity INTEGER,
buildingName char(15)
);
--
CREATE TABLE Residence(
residenceID INTEGER,
residenceName char(15),
residenceType char(15)
);
--
CREATE TABLE VaccineTest(
gNumber INTEGER,
testDate DATE,
testResult char(15)
);
--
CREATE TABLE VaccineRecord(
gNumber INTEGER,
shotDate DATE,
vaccineType char(15),
shotNumber INTEGER
);
--
CREATE TABLE Attends(
gNumber INTEGER,
classID INTEGER,
role char(15)
);
--
--
/*SET FEEDBACK OFF
< The INSERT statements that populate the tables>
Important: Keep the number of rows in each table small enough so that the results of your
queries can be verified by hand. See the Sailors database as an example.
SET FEEDBACK ON
COMMIT;*/
--
/*< One query (per table) of the form: SELECT * FROM table; in order to display your database >*/
--
/*< The SQL queries>. Include the following for each query:
? A comment line stating the query number and the feature(s) it demonstrates
(e.g. -- Q25 � correlated subquery).
? A comment line stating the query in English.
? The SQL code for the query.*/
--
/*< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
�Submit a final report� regarding which ICs you need to test).
? A comment line stating: Testing: < IC name>
? A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;*/
--
SPOOL OFF
