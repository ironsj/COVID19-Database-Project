SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
<One line per team member name; in alphabetical order>
*/
--
--
/*< The SQL/DDL code that creates your schema >
In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.*/
CREATE TABLE Person(
gNumber INTEGER,
pName CHAR(15) NOT NULL,
pType CHAR(15) NOT NULL,
resID CHAR(15),
-- personIC1: gNumbers are unique
CONSTRAINT personIC1 PRIMARY KEY (gNumber),
-- personIC2: Every person must have a residence
CONSTRAINT personIC2 FOREIGN KEY (resID) REFERENCES Residence(residenceID)
);
--
CREATE TABLE Class(
classID INTEGER,
className CHAR(15) NOT NULL,
numStudents INTEGER NOT NULL,
roomNum INTEGER NOT NULL,
-- classIC1: classID is unique
CONSTRAINT classIC1 PRIMARY KEY (classID),
-- classIC2: Every class must have a room
CONSTRAINT classIC2 FOREIGN KEY (roomNum) REFERENCES Room(roomNum)
);
--
CREATE TABLE Room(
roomNum INTEGER,
roomCapacity INTEGER NOT NULL,
buildingName CHAR(15) NOT NULL,
-- roomIC1: roomNum is unique
CONSTRAINT roomIC1 PRIMARY KEY (roomNum)
);
--
CREATE TABLE Residence(
residenceID INTEGER,
residenceName CHAR(15) NOT NULL,
residenceType CHAR(15) NOT NULL,
-- residenceIC1: residenceID is unique
CONSTRAINT residenceIC1 PRIMARY KEY (residenceID)
);
--
CREATE TABLE Department(
departmentID INTEGER,
departmentName char(15) NOT NULL,
departmentLeadID INTEGER,
-- departmentIC1: departmentID is unique
CONSTRAINT departmentIC1 PRIMARY KEY (departmentID),
-- departmentIC2: The department lead must be a real person
CONSTRAINT departmentIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE SET NULL
);
--
CREATE TABLE VaccineTest(
gNumber INTEGER,
testDate DATE,
testResult CHAR(15)
-- testIC1: A person can get one COVID test on a given date
CONSTRAINT testIC1 PRIMARY KEY (gNumber, testDate),
-- testIC2: A COVID test must be given to a real person
CONSTRAINT testIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE
);
--
CREATE TABLE VaccineRecord(
gNumber INTEGER,
shotDate DATE,
vaccineType CHAR(15),
shotNumber INTEGER,
-- recordIC1: A person can receive one COVID vaccine on a given date
CONSTRAINT recordIC1 PRIMARY KEY (gNumber, shotDate),
-- recordIC2: A COVID vaccine must be given to a real person
CONSTRAINT testIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE
);
--
CREATE TABLE Attends(
gNumber INTEGER,
classID INTEGER,
role CHAR(15),
-- attendsIC1: The class a given person attends is unique
CONSTRAINT attendsIC1 PRIMARY KEY (gNumber, classID),
-- attendsIC2: A class must be attended by a real person
CONSTRAINT testIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE,
-- attendsIC3: A person must be in a real class
CONSTRAINT testIC3 FOREIGN KEY (classID)
	REFERENCES Class(classID)
	ON DELETE CASCADE	
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
(e.g. -- Q25 – correlated subquery).
? A comment line stating the query in English.
? The SQL code for the query.*/
--
/*< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
? A comment line stating: Testing: < IC name>
? A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;*/
--
SPOOL OFF
