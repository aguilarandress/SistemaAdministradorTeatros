
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
@name nvarchar(30),
@desc text,
@dateI DATE,
@dateF DATE,
@IdE int,
@IdTe int,
@IdTi int
AS
INSERT INTO Producciones(Descripcion,FechaInicial,FechaFinal,Nombre,IdEstado,IdTeatro,IdTipo)
VALUES(@desc,@dateI,@dateF,@name,@IdE,@IdTe,@IdTi)
GO

CREATE PROCEDURE getProducciones
AS
SELECT * 
FROM Producciones
GO

CREATE PROCEDURE ValidateNameProducciones
@Nombre nvarchar(30)
AS
Select *
FROM Producciones
WHERE @Nombre = Nombre
GO

CREATE PROCEDURE GetByNombreProduccion	
@nombre nvarchar(30)
AS
SELECT *
FROM Producciones
WHERE nombre =  @nombre
GO

CREATE PROCEDURE GetByProduccionIdPresentaciones
@Id int
AS
SELECT *
FROM Presentaciones
WHERE ProduccionId = @Id
Order by Fecha,Hora
GO

CREATE PROCEDURE CreatePresentacion
@IdProd int,
@Id int,
@Fecha Date,
@Hora Time

AS
	INSERT INTO Presentaciones(ProduccionId,PresentacionId,Fecha,Hora)
	VALUES(@IdProd,@Id,@Fecha,@Hora)

GO

CREATE PROCEDURE ValidateDatePresentaciones
@IdProd int,
@fecha date,
@hora time
AS
SELECT *
FROM Presentaciones
WHERE ProduccionId = @IdProd AND Fecha = @fecha AND Hora = @hora

GO

CREATE PROCEDURE GetProduccionEstados
AS
SELECT *
FROM ProduccionEstados
Order by Id 
GO

CREATE PROCEDURE GetByIdProduccionEstados
@Id int
AS
SELECT *
FROM ProduccionEstados
Where Id = @Id
GO

CREATE PROCEDURE UpdateIdEstadoProduccion
@Id int,
@Estado int
AS
UPDATE Producciones
SET IdEstado = @Estado
WHERE Id = @Id

GO

CREATE PROCEDURE CreateBloquePrecios
@Monto Decimal(10,2),
@IdBloque INT,
@IdProduccion INT
AS
INSERT INTO BloquePrecios(Monto,IdBloque,IdProduccion)
VALUES (@Monto,@IdBloque,@IdProduccion)
GO