
CREATE TABLE Persons(
ID_Person int PRIMARY KEY Identity(1,1),
Surname varchar(50),
Name varchar(50),
Patronymic varchar(50),
Role varchar(50),
Phone_number varchar(50),
email varchar(50) UNIQUE,
CHECK (role = 'Студент' OR role = 'Преподаватель' OR role = 'Администратор'),
CHECK (Phone_number like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CHECK (email like '%@%.%'),
);

CREATE TABLE Disciplines(
ID_Discipline int PRIMARY KEY Identity(1,1),
ID_Person int,
Name_Discipline varchar(50),
);

CREATE TABLE Marks(
ID_Person int,
ID_Discipline int,
Mark int,
Date date
);

CREATE TABLE Groups(
ID_Group varchar(20) PRIMARY KEY,
ID_Person int,
Course int
);

CREATE TABLE Login_Data(
ID_Person int,
email varchar(50) UNIQUE,
Password varchar(20) UNIQUE,
);