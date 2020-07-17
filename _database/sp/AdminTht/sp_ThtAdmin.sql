
CREATE PROCEDURE GetByUsernameSistemaTeatroAdmin @Usuario nvarchar(20)
AS
SELECT * FROM TeatroAdministradores WHERE Usuario = @Usuario
GO


CREATE PROCEDURE GetByIdTeatros
	@IdTeatro Int
AS
	SELECT * FROM Teatros WHERE Id = @IdTeatro
GO