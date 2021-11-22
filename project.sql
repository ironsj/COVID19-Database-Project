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
gNumber CHAR(10),
pName VARCHAR2(15) NOT NULL,
pType VARCHAR2(15) NOT NULL,
resID INTEGER,
-- personIC1: gNumbers are unique
CONSTRAINT personIC1 PRIMARY KEY (gNumber),
-- personIC2: Every person must have a residence
CONSTRAINT personIC2 FOREIGN KEY (resID) REFERENCES Residence(residenceID)
-- personIC3: A person must be a professor or a student
CONSTRAINT personIC3 CHECK( pType IN ('Student', 'Professor'))
);
--
CREATE TABLE Class(
classID CHAR(6),
className VARCHAR2(25) NOT NULL,
numStudents INTEGER NOT NULL,
roomNum INTEGER,
-- classIC1: classID is unique
CONSTRAINT classIC1 PRIMARY KEY (classID),
-- classIC2: Every class must have a room
CONSTRAINT classIC2 FOREIGN KEY (roomNum) REFERENCES Room(roomNum),
-- classIC3: The number of students in a class must be less than 76
CONSTRAINT classIC3 CHECK (numStudents > 0 AND numStudents <= 75
);
--
CREATE TABLE Room(
roomNum INTEGER,
roomCapacity INTEGER NOT NULL,
buildingName VARCHAR2(25) NOT NULL,
-- roomIC1: roomNum is unique
CONSTRAINT roomIC1 PRIMARY KEY (roomNum),
-- roomIC2: roomCapacity must be less than 76
CONSTRAINT roomIC2 CHECK (roomCapacity > 0 AND roomCapacity <= 75)
);
--
CREATE TABLE Residence(
residenceID INTEGER,
residenceName VARCHAR2(15) NOT NULL,
residenceType VARCHAR2(15) NOT NULL,
-- residenceIC1: residenceID is unique
CONSTRAINT residenceIC1 PRIMARY KEY (residenceID)
-- ressidenceIC2: residenceType must be "On Campus" or "Off Campus"
CONSTRAINT residenceIC2 CHECK( residenceType IN('On Campus', 'Off Campus'))
);
--
CREATE TABLE Department(
departmentID INTEGER,
departmentName VARCHAR2(25) NOT NULL,
departmentLeadID CHAR(10),
-- departmentIC1: departmentID is unique
CONSTRAINT departmentIC1 PRIMARY KEY (departmentID),
-- departmentIC2: The department lead must be a real person
CONSTRAINT departmentIC2 FOREIGN KEY (departmentLeadID)
	REFERENCES Person(gNumber)
	ON DELETE SET NULL,
-- departmentIC3: A department lead can only oversee one department
CONSTRAINT departmentIC3 UNIQUE (departmentLeadID)
);
--
CREATE TABLE VaccineTest(
gNumber CHAR(10),
testDate DATE,
testResult VARCHAR2(15),
-- testIC1: A person can get one COVID test on a given date
CONSTRAINT testIC1 PRIMARY KEY (gNumber, testDate),
-- testIC2: A COVID test must be given to a real person
CONSTRAINT testIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE,
-- testIC3: A COVID test type must be Rapid or Slow
CONSTRAINT testIC3 CHECK (testType IN ('Rapid', 'Slow')),
-- testIC4: A COVID test result must be Positive or Negative
CONSTRAINT testIC4 CHECK (testResult IN ('Positive', 'Negative'))
);
--
CREATE TABLE VaccineRecord(
gNumber CHAR(10),
shotDate DATE,
vaccineType VARCHAR2(20),
shotNumber INTEGER,
-- recordIC1: A person can receive one COVID vaccine on a given date
CONSTRAINT recordIC1 PRIMARY KEY (gNumber, shotDate),
-- recordIC2: A COVID vaccine must be given to a real person
CONSTRAINT recordIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE,
-- recordIC3: A COVID vaccine must be of the type Moderna, Pfizer, or Johnson & Johnson
CONSTRAINT recordIC3 CHECK (vaccineType IN ('Moderna', 'Pfizer', 'Johnson & Johnson')),
-- recordIC4: If a person received the Johnson & Johnson vaccine their shot number must be 1
CONSTRAINT recordIC4 CHECK (NOT((vaccineType IN ('Johnson & Johnson') AND (shotNumber != 1))),
-- recordIC5: The shot number cannot be greater than 2 and must be greater than 0
CONSTRAINT recordIC5 CHECK (shotNumber <= 2 AND shotNumber > 0)
);
--
CREATE TABLE DepartmentLocation(
departmentID INTEGER,
departmentLocation VARCHAR2(25),
-- dLocationIC1: A department and it's location are unique
CONSTRAINT dLocationIC1 PRIMARY KEY (departmentID, departmentLocation),
-- dLocationIC2: The department must exist
CONSTRAINT dLocationIC2 FOREIGN KEY (departmentID)
	REFERENCES Department(departmentID)
	ON DELETE CASCADE
);
--
CREATE TABLE Attends(
gNumber CHAR(10),
classID CHAR(6),
role VARCHAR2(15),
-- attendsIC1: The class a given person attends is unique
CONSTRAINT attendsIC1 PRIMARY KEY (gNumber, classID),
-- attendsIC2: A class must be attended by a real person
CONSTRAINT attendsIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE,
-- attendsIC3: A person must be in a real class
CONSTRAINT attendsIC3 FOREIGN KEY (classID)
	REFERENCES Class(classID)
	ON DELETE CASCADE,
-- attendsIC4: Role in class must be student or professor
CONSTRAINT attendsIC4 CHECK(role IN('Student', 'Professor'))
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
