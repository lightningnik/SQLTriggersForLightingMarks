CREATE TRIGGER RoleCheck ON Marks FOR INSERT
as 
IF (SELECT Role FROM     dbo.Persons INNER JOIN
                  dbo.Marks ON dbo.Marks.ID_Person = dbo.Persons.ID_Person
				  WHERE Role != '�������') > 0
BEGIN
print '�� �������'
ROLLBACK TRANSACTION
END