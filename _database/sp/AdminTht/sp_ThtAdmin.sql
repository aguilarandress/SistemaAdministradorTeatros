
CREATE PROCEDURE GetByUsernameSistemaTeatroAdmin @Usuario nvarchar(20)
AS
SELECT * FROM TeatroAdministradores WHERE Usuario = @Usuario
GO
