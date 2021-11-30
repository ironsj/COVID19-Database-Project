SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
Alek Sherwood
Annemieke Engelsma
Jake Irons
Karim Seif
*/
--
--
/*< The SQL/DDL code that creates your schema >*/
CREATE TABLE Residence(
residenceID INTEGER,
residenceName VARCHAR2(25) NOT NULL,
residenceType VARCHAR2(15) NOT NULL,
-- residenceIC1: residenceID is unique
CONSTRAINT residenceIC1 PRIMARY KEY (residenceID),
-- ressidenceIC2: residenceType must be "On Campus" or "Off Campus"
CONSTRAINT residenceIC2 CHECK( residenceType IN('On Campus', 'Off Campus'))
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
CREATE TABLE Class(
classID CHAR(7),
className VARCHAR2(25) NOT NULL,
numStudents INTEGER NOT NULL,
roomNum INTEGER NOT NULL,
-- classIC1: classID is unique
CONSTRAINT classIC1 PRIMARY KEY (classID),
-- classIC2: Every class must have a room
CONSTRAINT classIC2 FOREIGN KEY (roomNum) REFERENCES Room(roomNum),
-- classIC3: The number of students in a class must be less than 76
CONSTRAINT classIC3 CHECK (numStudents > 0 AND numStudents <= 75)
);
--
CREATE TABLE Person(
gNumber CHAR(10),
pName VARCHAR2(20) NOT NULL,
pType VARCHAR2(15) NOT NULL,
resID INTEGER NOT NULL,
-- personIC1: gNumbers are unique
CONSTRAINT personIC1 PRIMARY KEY (gNumber),
-- personIC2: Every person must have a residence
CONSTRAINT personIC2 FOREIGN KEY (resID) REFERENCES Residence(residenceID),
-- personIC3: A person must be a professor or a student
CONSTRAINT personIC3 CHECK( pType IN ('Student', 'Professor'))
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
testType VARCHAR2(10) NOT NULL,
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
vaccineType VARCHAR2(20) NOT NULL,
shotNumber INTEGER NOT NULL,
-- recordIC1: A person can receive one COVID vaccine on a given date
CONSTRAINT recordIC1 PRIMARY KEY (gNumber, shotDate),
-- recordIC2: A COVID vaccine must be given to a real person
CONSTRAINT recordIC2 FOREIGN KEY (gNumber)
	REFERENCES Person(gNumber)
	ON DELETE CASCADE,
-- recordIC3: A COVID vaccine must be of the type Moderna, Pfizer, or Johnson and Johnson
CONSTRAINT recordIC3 CHECK (vaccineType IN ('Moderna', 'Pfizer', 'Johnson and Johnson')),
-- recordIC4: If a person received the Johnson and Johnson vaccine their shot number must be 1
CONSTRAINT recordIC4 CHECK (NOT((vaccineType IN ('Johnson and Johnson')) AND (shotNumber != 1))),
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
classID CHAR(7),
role VARCHAR2(15) NOT NULL,
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
SET FEEDBACK OFF
/*< The INSERT statements that populate the tables>*/
INSERT INTO Residence VALUES (111, 'Campus View', 'Off Campus');
INSERT INTO Residence VALUES (222, '48 West', 'Off Campus');
INSERT INTO Residence VALUES (333, 'Laker Village', 'On Campus');
INSERT INTO Residence VALUES (444, 'VanSteeland Apartments', 'On Campus');
INSERT INTO Residence VALUES (1, 'Home Owner', 'Off Campus');
--------
INSERT INTO Room VALUES (1111, 30, 'Mackinac Hall');
INSERT INTO Room VALUES (2222, 30, 'Mackinac Hall');
INSERT INTO Room VALUES (3333, 40, 'Seidman Center');
INSERT INTO Room VALUES (4444, 75, 'Loutit Lecture Halls');
--------
INSERT INTO Class VALUES ('CIS 353', 'Database', 28, 1111);
INSERT INTO Class VALUES ('MGT 438', 'Business Ethics', 19, 3333);
INSERT INTO Class VALUES ('BMS 250', 'Anatomy', 74, 4444);
INSERT INTO Class VALUES ('MTH 408', 'Advance Calculus I', 14, 2222);
INSERT INTO Class VALUES ('MTH 315', 'Discrete Mathematics', 24, 2222);
--------
INSERT INTO Person VALUES ('G00000000', 'John Smith', 'Student', 111);
INSERT INTO Person VALUES ('G00000001', 'Jessica Williams', 'Student', 222);
INSERT INTO Person VALUES ('G00000002', 'Benjamin Mcguire', 'Student', 333);
INSERT INTO Person VALUES ('G00000003', 'Jane Wheeler', 'Student', 444);
INSERT INTO Person VALUES ('G00000004', 'Meoldy Harmon', 'Student', 111);
INSERT INTO Person VALUES ('G00000005', 'Erma Nguyen', 'Student', 222);
INSERT INTO Person VALUES ('G00000006', 'Gregg Roberson', 'Student', 333);
INSERT INTO Person VALUES ('G00000007', 'Alexandra Cain', 'Student', 444);
INSERT INTO Person VALUES ('G00000008', 'Peggy Holloway', 'Student', 1);
INSERT INTO Person VALUES ('G00000009', 'Suzanne Barber', 'Student', 222);
INSERT INTO Person VALUES ('G11111111', 'Sarah Jones', 'Professor', 1);
INSERT INTO Person VALUES ('G22222222', 'Stacy Baldwin', 'Professor', 1);
INSERT INTO Person VALUES ('G33333333', 'Gene Copeland', 'Professor', 1);
INSERT INTO Person VALUES ('G44444444', 'Francisco Brock', 'Professor', 1);
--------
INSERT INTO Department VALUES (11, 'Business', 'G11111111');
INSERT INTO Department VALUES (22, 'Nursing', 'G44444444');
INSERT INTO Department VALUES (33, 'Engineering and Computing', 'G22222222');
INSERT INTO Department VALUES (44, 'Mathematics', NULL);
--------
INSERT INTO VaccineRecord VALUES ('G00000000', TO_DATE('04/10/21', 'MM/DD/YY'), 'Pfizer', 1);
INSERT INTO VaccineRecord VALUES ('G00000000', TO_DATE('05/01/21', 'MM/DD/YY'), 'Pfizer', 2);
INSERT INTO VaccineRecord VALUES ('G00000001', TO_DATE('04/10/21', 'MM/DD/YY'), 'Johnson and Johnson', 1);
INSERT INTO VaccineRecord VALUES ('G00000003', TO_DATE('07/01/21', 'MM/DD/YY'), 'Moderna', 1);
INSERT INTO VaccineRecord VALUES ('G00000003', TO_DATE('07/22/21', 'MM/DD/YY'), 'Moderna', 2);
INSERT INTO VaccineRecord VALUES ('G00000004', TO_DATE('11/12/21', 'MM/DD/YY'), 'Pfizer', 1);
INSERT INTO VaccineRecord VALUES ('G00000005', TO_DATE('10/09/21', 'MM/DD/YY'), 'Johnson and Johnson', 1);
INSERT INTO VaccineRecord VALUES ('G00000006', TO_DATE('08/30/21', 'MM/DD/YY'), 'Moderna', 1);
INSERT INTO VaccineRecord VALUES ('G00000006', TO_DATE('09/20/21', 'MM/DD/YY'), 'Moderna', 2);
INSERT INTO VaccineRecord VALUES ('G00000008', TO_DATE('03/25/21', 'MM/DD/YY'), 'Pfizer', 1);
INSERT INTO VaccineRecord VALUES ('G00000008', TO_DATE('04/15/21', 'MM/DD/YY'), 'Pfizer', 2);
INSERT INTO VaccineRecord VALUES ('G00000009', TO_DATE('09/02/21', 'MM/DD/YY'), 'Johnson and Johnson', 1);
INSERT INTO VaccineRecord VALUES ('G11111111', TO_DATE('11/23/21', 'MM/DD/YY'), 'Moderna', 1);
INSERT INTO VaccineRecord VALUES ('G22222222', TO_DATE('02/13/21', 'MM/DD/YY'), 'Moderna', 1);
INSERT INTO VaccineRecord VALUES ('G22222222', TO_DATE('03/06/21', 'MM/DD/YY'), 'Moderna', 2);
INSERT INTO VaccineRecord VALUES ('G33333333', TO_DATE('08/30/21', 'MM/DD/YY'), 'Pfizer', 1);
INSERT INTO VaccineRecord VALUES ('G33333333', TO_DATE('09/20/21', 'MM/DD/YY'), 'Pfizer', 2);
INSERT INTO VaccineRecord VALUES ('G44444444', TO_DATE('04/10/21', 'MM/DD/YY'), 'Johnson and Johnson', 1);
--------
INSERT INTO VaccineTest VALUES ('G00000000', TO_DATE('09/10/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000000', TO_DATE('10/16/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000002', TO_DATE('11/16/21', 'MM/DD/YY'), 'Positive', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000003', TO_DATE('05/16/21', 'MM/DD/YY'), 'Negative', 'Slow');
INSERT INTO VaccineTest VALUES ('G00000003', TO_DATE('06/17/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000005', TO_DATE('11/28/21', 'MM/DD/YY'), NULL, 'Slow');
INSERT INTO VaccineTest VALUES ('G00000006', TO_DATE('04/11/21', 'MM/DD/YY'), 'Negative', 'Slow');
INSERT INTO VaccineTest VALUES ('G00000006', TO_DATE('06/18/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000006', TO_DATE('08/15/21', 'MM/DD/YY'), 'Positive', 'Rapid');
INSERT INTO VaccineTest VALUES ('G00000006', TO_DATE('10/31/20', 'MM/DD/YY'), 'Positive', 'Slow');
INSERT INTO VaccineTest VALUES ('G00000007', TO_DATE('01/05/21', 'MM/DD/YY'), 'Positive', 'Slow');
INSERT INTO VaccineTest VALUES ('G00000008', TO_DATE('05/06/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G11111111', TO_DATE('07/10/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G22222222', TO_DATE('12/17/20', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G44444444', TO_DATE('10/21/20', 'MM/DD/YY'), 'Negative', 'Slow');
INSERT INTO VaccineTest VALUES ('G44444444', TO_DATE('01/27/20', 'MM/DD/YY'), 'Negative', 'Slow');
INSERT INTO VaccineTest VALUES ('G44444444', TO_DATE('02/14/21', 'MM/DD/YY'), 'Negative', 'Rapid');
INSERT INTO VaccineTest VALUES ('G44444444', TO_DATE('09/10/21', 'MM/DD/YY'), 'Negative', 'Rapid');
--------
INSERT INTO DepartmentLocation VALUES (11, 'Allendale');
INSERT INTO DepartmentLocation VALUES (11, 'Grand Rapids');
INSERT INTO DepartmentLocation VALUES (11, 'Holland');
INSERT INTO DepartmentLocation VALUES (33, 'Allendale');
INSERT INTO DepartmentLocation VALUES (22, 'Grand Rapids');
INSERT INTO DepartmentLocation VALUES (44, 'Allendale');
INSERT INTO DepartmentLocation VALUES (44, 'Grand Rapids');
--------
INSERT INTO Attends VALUES ('G22222222', 'CIS 353', 'Professor');
INSERT INTO Attends VALUES ('G33333333', 'MTH 408', 'Professor');
INSERT INTO Attends VALUES ('G33333333', 'MTH 315', 'Professor');
INSERT INTO Attends VALUES ('G44444444', 'BMS 250', 'Professor');
INSERT INTO Attends VALUES ('G11111111', 'MGT 438', 'Professor');
INSERT INTO Attends VALUES ('G00000000', 'MTH 315', 'Student');
INSERT INTO Attends VALUES ('G00000001', 'MGT 438', 'Student');
INSERT INTO Attends VALUES ('G00000002', 'BMS 250', 'Student');
INSERT INTO Attends VALUES ('G00000003', 'CIS 353', 'Student');
INSERT INTO Attends VALUES ('G00000003', 'MTH 315', 'Student');
INSERT INTO Attends VALUES ('G00000004', 'MTH 315', 'Student');
INSERT INTO Attends VALUES ('G00000004', 'MTH 408', 'Student');
INSERT INTO Attends VALUES ('G00000004', 'CIS 353', 'Student');
INSERT INTO Attends VALUES ('G00000005', 'MGT 438', 'Student');
INSERT INTO Attends VALUES ('G00000005', 'MTH 315', 'Student');
INSERT INTO Attends VALUES ('G00000006', 'BMS 250', 'Student');
INSERT INTO Attends VALUES ('G00000007', 'BMS 250', 'Student');
INSERT INTO Attends VALUES ('G00000007', 'MTH 408', 'Student');
INSERT INTO Attends VALUES ('G00000008', 'MGT 438', 'Student');
INSERT INTO Attends VALUES ('G00000009', 'CIS 353', 'Student');
INSERT INTO Attends VALUES ('G00000009', 'MGT 438', 'Student');
INSERT INTO Attends VALUES ('G00000009', 'MTH 408', 'Student');
INSERT INTO Attends VALUES ('G00000009', 'BMS 250', 'Student');
--------
SET FEEDBACK ON
COMMIT;
--
/*< One query (per table) of the form: SELECT * FROM table; in order to display your database >*/
SELECT * FROM Residence;
SELECT * FROM Room;
SELECT * FROM Class;
SELECT * FROM Person;
SELECT * FROM Department;
SELECT * FROM VaccineRecord;
SELECT * FROM VaccineTest;
SELECT * FROM DepartmentLocation;
SELECT * FROM Attends;
--
/*< The SQL queries>*/
--
-- Q1: A join involving at least four relations
-- Select the G number and names of people who attend Business Ethics and received the Johnson and Johnson vaccine.
SELECT	p.gNumber, p.pName
FROM	Person p, Class c, VaccineRecord v, Attends a
WHERE	p.gNumber = a.gNumber AND
	a.classID = c.classID AND
	c.className = 'Business Ethics' AND
	p.gNumber = v.gNumber AND
	v.vaccineType = 'Johnson and Johnson';
-- Q2: A self-join
-- Select pairs of classes that are taught in the same room. Remove duplicates.
SELECT	c1.className, c2.className
FROM	Class c1, Class c2
WHERE	c1.roomNum = c2.roomNum AND
	c1.classID < c2.classID;
-- Q3: Union
-- Select the G number and name of every person whose name is ‘John Smith’ or every person that lives on campus.
SELECT	p.gNumber, p.pName
FROM	Person p
WHERE	p.pName = 'John Smith'
UNION
SELECT	p.gNumber, p.pName
FROM	Person p, Residence r
WHERE	p.resID = r.residenceID AND
	r.residenceType = 'On Campus';
-- Q4: Max, Min
-- Select the highest and lowest capacities from the Room table.
SELECT MAX(roomCapacity), MIN(roomCapacity)
FROM Room;
-- Q5: GROUP BY, HAVING, and ORDER BY, all appearing in the same query.
-- Select the G number and name of students that are taking more than 2 classes. Order by G number.
SELECT	p.gNumber, p.pName, COUNT(*) AS numClasses
FROM	Person p, Attends a
WHERE	p.gNumber = a.gNumber
GROUP BY p.gNumber, p.pName
HAVING	COUNT(*) > 2
ORDER BY p.gNumber;
-- Q6: A correlated subquery
-- Select the G number and names of students who live on campus and received the Moderna vaccine.
SELECT  p.gNumber, p.pName
FROM 	Person p, Residence r
WHERE 	p.resID = r.residenceID AND
	r.residenceType = 'On Campus' AND 
	EXISTS (SELECT *
		FROM VaccineRecord v
		WHERE p.gNumber = v.gNumber AND
		v.vaccineType = 'Moderna');
-- Q7: A non-correlated subquery
-- Select the G number and names of students who live on campus and received the Moderna vaccine.
SELECT	p.gNumber, p.pName
FROM	Person p, Residence r
WHERE	p.resID = r.residenceID AND
	r.residenceType = 'On Campus' AND 
	p.gNumber IN (SELECT v.gNumber
			FROM VaccineRecord v
			WHERE v.vaccineType = 'Moderna');
-- Q8: A relational DIVISION query
-- Select the G number and name of every person who attends every class that is held in room 2222.
SELECT p.gNumber, p.pName
FROM Person p
WHERE NOT EXISTS((SELECT c.classID
		   FROM Class c
   	           WHERE c.roomNum = 2222)
                   MINUS
                 (SELECT c.classID
                   FROM Class c, Attends a
                   WHERE p.gNumber = a.gNumber AND
                   a.classID = c.classID AND
                   c.roomNum = 2222));
-- Q9: An outer join query.
-- Select the G number and name of every person. Also, for those who have received a COVID test, show the date and results of the test.
SELECT p.gNumber, p.pName, v.testResult, v.testDate
FROM Person P LEFT OUTER JOIN VaccineTest v on p.gNumber = v.gNumber;
-- Q10: Count
-- Find the number of locations for each department.
SELECT	d.departmentID, COUNT(*)
FROM	DepartmentLocation d
GROUP BY d.departmentID;
--
/*< The insert/delete/update statements to test the enforcement of ICs >*/
--
-- Testing: personIC1
INSERT INTO Person VALUES ('G00000000', 'James Smith', 'Student', 111);
-- Testing: personIC2
UPDATE Person SET resID = 0 WHERE gNumber = 'G00000000';
-- Testing: recordIC3
INSERT INTO VaccineRecord VALUES ('G00000002', TO_DATE('10/01/21', 'MM/DD/YY'), 'Fake Vaccine', 1);
-- Testing: recordIC4
INSERT INTO VaccineRecord VALUES ('G00000001', TO_DATE('05/10/21', 'MM/DD/YY'), 'Johnson and Johnson', 2);
--
COMMIT;
--
SPOOL OFF
