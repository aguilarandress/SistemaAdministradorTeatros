
CREATE PROCEDURE GetByUsernameSistemaTeatroAdmin @Usuario nvarchar(20)
AS
SELECT * FROM TeatroAdministradores WHERE Usuario = @Usuario
GO


CREATE PROCEDURE GetByIdTeatros
	@IdTeatro Int
AS
	SELECT * FROM Teatros WHERE Id = @IdTeatro
GO


CREATE PROCEDURE ValidateUsernameTeatroAgentes
@Username nvarchar(20)
AS
Select *
FROM TeatroAgentes
WHERE @Username = usuario
GO

CREATE PROCEDURE ValidateNameTeatroAgentes
@Nombre nvarchar(30)
AS
Select *
FROM TeatroAgentes
WHERE @Nombre = Nombre
GO
CREATE PROCEDURE CreateTeatroAgentes 
@nombre nvarchar(30) ,
@IdTeatro int,
@fecha date,
@sexo char,
@direccion nvarchar(40),
@tCasa varchar(9) = NULL,
@tMovil  varchar(9) = NULL,
@tOtro varchar(9) = NULL,
@email nvarchar(20),
@usuario nvarchar(20),
@password char(60)

AS
INSERT INTO TeatroAgentes(Nombre,IdTeatro,FechaNacimiento,Sexo,Direccion,TelefonoCasa,TelefonoCelular,TelefonoOtro,Email,Usuario,Password)

VALUES(@nombre,@IdTeatro,@fecha,@sexo,@direccion,@tCasa,@tMovil,@tOtro,@email,@usuario,@password)
GO