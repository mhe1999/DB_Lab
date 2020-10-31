CREATE TABLE Departments 
(
	Name varchar(20) NOT NULL ,
	ID char(5) PRIMARY KEY,
	Budget numeric(12,2),
	Category varchar(15) Check (Category in ('Engineering','Science'))
); 
 
 
CREATE TABLE Teachers 
(    
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL ,
	ID char(7),   
	BirthYear int,
	DepartmentID char(5), 
	Salary numeric(7,2) Default 10000.00,  
	PRIMARY KEY (ID), 
	FOREIGN KEY (DepartmentID) REFERENCES Departments(ID)
); 
 

CREATE TABLE Students 
(  
	FirstName varchar(20) NOT NULL, 
	LastName varchar(30) NOT NULL ,  
	StudentNumber char(7) PRIMARY KEY, 
	BirthYear int,  
	DepartmentID char(5), 
	AdvisorID char(7), 
	FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),  
	FOREIGN KEY (AdvisorID) REFERENCES Teachers(ID)
);
 