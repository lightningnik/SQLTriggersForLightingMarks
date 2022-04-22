SET NOCOUNT ON
GO

set nocount    on
set dateformat mdy

USE master


   CREATE DATABASE Evaluations
        ON PRIMARY 
            ( NAME= Evaluationsdata, 
	      FILENAME='C:\Users\Public\Evaluationsdata.mdf', SIZE=3 MB, MAXSIZE=100, FILEGROWTH=10) 
            LOG ON 
             (NAME= Evaluationslog, 
		  FILENAME='C:\Users\Public\Evaluationslog.ldf', SIZE=3MB, MAXSIZE=100, FILEGROWTH=10)

CHECKPOINT

GO

USE Evaluations

GO

CREATE TABLE Students
(
	Student_id   INT Identity (1,1) PRIMARY KEY ,
	Surname				varchar(20)  NOT NULL,
	Name				varchar(20)  NOT NULL,
	Patronymic			varchar(20)  NOT NULL,
	Date_Of_Birth		date		 NOT NULL,
	Phone_number		varchar(50)  NOT NULL UNIQUE,
	Mail				varchar(50)  NOT NULL UNIQUE,
	Password			varchar(50)	 NOT NULL UNIQUE,
	CHECK (Phone_number like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CHECK (Mail like '%@%.%'),
)

GO

CREATE TABLE Employees
(
	Employee_id   INT Identity (1,1) PRIMARY KEY ,
	Surname				varchar(20)  NOT NULL,
	Name				varchar(20)  NOT NULL,
	Patronymic			varchar(20)  NOT NULL,
	Role				varchar(20)  NOT NULL,
	Date_Of_Birth		date		 NOT NULL,
	Phone_number		varchar(50)  NOT NULL UNIQUE,
	Mail				varchar(50)  NOT NULL UNIQUE,
	Password			varchar(50)	 NOT NULL UNIQUE,
	CHECK (Phone_number like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CHECK (Mail like '%@%.%'),
	CHECK (role = 'Преподаватель' OR role = 'Админимтратор')
)

GO

CREATE TABLE Disciplines
(
	Discipline_id  INT Identity (1,1) PRIMARY KEY ,
	Name_Discipline	varchar(20)		NOT NULL,
)

GO

CREATE TABLE Groups
(
	Group_id    INT Identity (1,1) PRIMARY KEY ,
	Name_Group	varchar(20)		NOT NULL UNIQUE,
)

GO

CREATE TABLE Group_List
(
	Student_id			INT				NOT NULL,
		CONSTRAINT FKey_Student_id FOREIGN KEY (Student_id)
			REFERENCES Students(Student_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	Group_id		INT	UNIQUE NOT NULL,
	            CONSTRAINT FK_group_list_id FOREIGN KEY (Group_id) 
				  REFERENCES Groups(Group_id) ON DELETE CASCADE  ON UPDATE CASCADE,
				  CONSTRAINT PK_id PRIMARY KEY (Student_id ,Group_id)
)

GO

CREATE TABLE Marks(
Student_id			INT				NOT NULL,
		CONSTRAINT FKey_Student_marks_id FOREIGN KEY (Student_id)
			REFERENCES Students(Student_id) ON DELETE CASCADE  ON UPDATE CASCADE,
Employee_id			INT				NOT NULL,
		CONSTRAINT FKey_Employee_marks_id FOREIGN KEY (Employee_id)
			REFERENCES Employees(Employee_id) ON DELETE CASCADE  ON UPDATE CASCADE,
Discipline_id			INT				NOT NULL,
		CONSTRAINT FKey_Discipline_marks_id FOREIGN KEY (Discipline_id)
			REFERENCES Disciplines(Discipline_id) ON DELETE CASCADE  ON UPDATE CASCADE,
Mark INT NOT NULL,
Date date NOT NULL,
CONSTRAINT PK_marks_id PRIMARY KEY (Student_id ,Employee_id, Discipline_id)
)

GO

CREATE TABLE Lessons(
Group_id		INT	UNIQUE NOT NULL,
	            CONSTRAINT FK_group_lessons_id FOREIGN KEY (Group_id) 
				  REFERENCES Groups(Group_id) ON DELETE CASCADE  ON UPDATE CASCADE,
Employee_id			INT				NOT NULL,
		CONSTRAINT FKey_Employee_id FOREIGN KEY (Employee_id)
			REFERENCES Employees(Employee_id) ON DELETE CASCADE  ON UPDATE CASCADE,
Discipline_id			INT				NOT NULL,
		CONSTRAINT FKey_Discipline_id FOREIGN KEY (Discipline_id)
			REFERENCES Disciplines(Discipline_id) ON DELETE CASCADE  ON UPDATE CASCADE,
CONSTRAINT PK_lessons_id PRIMARY KEY (Group_id ,Employee_id, Discipline_id)
)

GO
