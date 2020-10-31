ALTER TABLE Students
	ADD credit INT;


CREATE TABLE Courses 
(
	ID char(6) PRIMARY KEY,
	Title VARCHAR(20),
	Credits	INT,
	DepartmentID CHAR(5),
	FOREIGN KEY (DepartmentID) REFERENCES Departments(ID)
);

CREATE TABLE Available_Courses
(	
	CourseID CHAR(6),
	Semester VARCHAR(10) CHECK (Semester in ('fall', 'spring')),
	[Year] INT,
	ID CHAR(5) PRIMARY KEY,
	TeacherID CHAR(7),
	FOREIGN KEY (CourseID) REFERENCES Courses(ID),
	FOREIGN KEY (TeacherID) REFERENCES Teachers(ID)
);

CREATE TABLE Taken_Courses
(
	StudentID CHAR(7),
	CourseID CHAR(6),
	Semester VARCHAR(10) CHECK (Semester in ('fall', 'spring')),
	[Year] INT,
	Grade VARCHAR(10),
	FOREIGN KEY (StudentID) REFERENCES Students(StudentNumber),
	FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);


CREATE TABLE Prerequisites
(
	CourseId char(6),
	PrereqID char(6),
	FOREIGN KEY (CourseId) REFERENCES Courses(ID),
	FOREIGN KEY (PrereqID) REFERENCES Courses(ID)
);
////////////////////////////////////////////////////////////////////////////////////

INSERT INTO Departments(Name, ID, Budget, Category) VALUES
					   ('comp', '11111', 4.20, 'Engineering'),
					   ('elec', '22222', 3.20, 'Engineering'),
					   ('mech', '33333', 2.20, 'Engineering');



INSERT INTO Teachers (FirstName, LastName, ID, BirthYear, DepartmentID, salary) VALUES
					   ('ahmad', 'A', '4444444', 1999, '11111', 55.20),
					   ('yasaman', 'B', '5555555', 1998, '22222',56.20),
					   ('reza', 'C', '6666666', 1997, '33333',57.20);



INSERT INTO Students (FirstName , LastName , StudentNumber , BirthYear , DepartmentID , AdvisorID ) VALUES
					   ('mohommad', 'D', '7777777', 1999, '11111', '4444444'),
					   ('ali', 'E', '8888888', 1998, '22222','5555555'),
					   ('zahra', 'F', '9999999', 1997, '33333','6666666');



INSERT INTO Courses (ID , Title , Credits, DepartmentID) VALUES
					   ('111112', 'G', 3, '11111'),
					   ('111113', 'H', 4, '22222'),
					   ('111114', 'I', 2, '33333');



INSERT INTO Available_Courses (CourseID , Semester, [Year], ID, TeacherID) VALUES
					   ('111112', 'fall', 1999, '22223', '4444444'),
					   ('111113', 'fall', 1998, '22224', '5555555'),
					   ('111114', 'fall', 1997, '22225', '6666666');



INSERT INTO Taken_Courses(StudentID, CourseID, Semester, [Year], Grade) VALUES
					   ('7777777', '111112', 'fall', 1999, '123'),
					   ('8888888', '111113', 'fall', 1998, '345'),
					   ('9999999', '111114', 'fall', 1997, '678');



INSERT INTO Prerequisites(CourseId, PrereqID) VALUES
					   ('111113', '111112'),
					   ('111112', '111113'),
					   ('111114', '111114');





