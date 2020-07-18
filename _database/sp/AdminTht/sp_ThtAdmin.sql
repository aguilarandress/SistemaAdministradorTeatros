
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
@Id int,
@nombre nvarchar(30) ,
@IdTeatro int,
@fecha date,
@sexo char,
@direccion nvarchar(40),
@email nvarchar(20),
@usuario nvarchar(20),
@password char(60),
@tCasa varchar(9) = NULL,
@tMovil  varchar(9) = NULL,
@tOtro varchar(9) = NULL

AS
INSERT INTO TeatroAgentes(Id,FechaNacimiento,Sexo,Direccion,TelefonoCasa,TelefonoCelular,TelefonoOtro,Email,Usuario,Password)

VALUES(@Id,@nombre,@IdTeatro,@fecha,@sexo,@direccion,@tCasa,@tMovil,@tOtro,@email,@usuario,@password)
GO

CREATE PROCEDURE ValidateIdTeatroAgentes 
@Id int
AS
SELECT *
FROM TeatroAgentes
WHERE Id = @ID
GO	

CREATE PROCEDURE GetProduccionesTipos
AS
SELECT * 
FROM ProduccionTipos
Order By ID
GO

CREATE PROCEDURE CreateProduccion
@desc text,
@dateI DATE,
@dateF DATE,
@name nvarchar(30),
@IdE int,
@IdTe int,
@IdTi int
AS
INSERT INTO Producciones(Descripcion,FechaInicial,FechaFinal,Nombre,IdEstado,IdTeatro,IdTipo)
VALUES(@desc,@dateI,@dateF,@name,@IdE,@IdTe,@IdTi)
GO