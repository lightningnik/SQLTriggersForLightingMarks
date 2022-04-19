USE [Evaluations]
GO
/****** Object:  Trigger [dbo].[RoleCheck]    Script Date: 03.04.2022 12:05:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER TeacherCkeck ON [dbo].[Disciplines] FOR INSERT
as 
IF (SELECT Role FROM     dbo.Persons INNER JOIN
                  dbo.Disciplines ON dbo.Disciplines.ID_Person = dbo.Persons.ID_Person
				  WHERE Role != 'Преподаватель') > 0
BEGIN
ROLLBACK TRANSACTION
END