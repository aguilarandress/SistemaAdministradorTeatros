USE [SISTEMA_TEATROS]
GO
ALTER PROCEDURE [dbo].[CreateTeatroAdministradores]
	@Id INT,
	@Nombre VARCHAR(30),
	@IdTeatro INT,
	@FechaNacimiento DATE,
	@Sexo CHAR,
	@Direccion VARCHAR(40),
	@TelefonoCasa VARCHAR(9) = NULL, --DEFAULT VALUES
	@TelefonoCelular VARCHAR(9) = NULL,
	@TelefonoOtro VARCHAR(9) = NULL,
	@Email VARCHAR(40),
	@Usuario VARCHAR(20),
	@Password CHAR(60)
AS
	INSERT INTO Empleados(Id, Nombre, FechaNacimiento, Sexo, Direccion,
	TelefonoCasa, TelefonoCelular, TelefonoOtro, Email, Usuario, Password)
	VALUES(@Id, @Nombre, @FechaNacimiento, @Sexo, @Direccion, @TelefonoCasa, 
	@TelefonoCelular, @TelefonoOtro, @Email, @Usuario, @Password)

	INSERT INTO TeatroAdministradores(Id, IdTeatro)
	VALUES(@Id, @IdTeatro);
	
GO
ALTER PROCEDURE [dbo].[GetByUsuarioTeatroAdministradores]
	@Usuario VARCHAR(20)
AS
	SELECT *
	FROM TeatroAdministradores
	INNER JOIN Empleados ON (Empleados.Id = TeatroAdministradores.Id)
	WHERE Empleados.Usuario = @Usuario;
GO

CREATE PROCEDURE ValidateUsernameTeatroAgentes
@Username nvarchar(20)
AS
Select *
FROM Empleados
INNER JOIN TeatroAgentes ON (TeatroAgentes.Id = Empleados.Id)
WHERE @Username = usuario
GO

CREATE PROCEDURE ValidateNameTeatroAgentes
@Nombre nvarchar(30)
AS
Select *
FROM Empleados
INNER JOIN TeatroAgentes ON  (TeatroAgentes.Id = Empleados.Id)
WHERE @Nombre = Nombre
GO

ALTER PROCEDURE [dbo].[CreateTeatroAgentes] 
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
INSERT INTO Empleados(Id,Nombre,FechaNacimiento,Sexo,Direccion,TelefonoCasa,TelefonoCelular,TelefonoOtro,Email,Usuario,Password)

VALUES(@Id,@nombre,@fecha,@sexo,@direccion,@tCasa,@tMovil,@tOtro,@email,@usuario,@password)

INSERT INTO TeatroAgentes(Id,IdTeatro)

VALUES (@Id,@IdTeatro)
