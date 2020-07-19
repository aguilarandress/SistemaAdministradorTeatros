USE SISTEMA_TEATROS
GO

CREATE PROCEDURE GetTeatros
AS
	SELECT Id, Nombre, Capacidad, Correo, SitioWeb, TelefonoAdministracion, TelefonoBoleteria
	FROM Teatros;
go

EXEC GetTeatros;

CREATE PROCEDURE GetByNombreTeatros
	@NombreTeatro VARCHAR(30)
AS
	SELECT * FROM Teatros WHERE Nombre = @NombreTeatro;
go;

CREATE PROCEDURE CreateTeatros
	@Nombre NVARCHAR(30),
	@Capacidad INT,
	@Correo NVARCHAR(30),
	@SitioWeb NVARCHAR(30),
	@TelefonoAdministracion VARCHAR(9),
	@TelefonoBoleteria VARCHAR(9)
AS
	INSERT INTO Teatros(Nombre, Capacidad, Correo, SitioWeb, TelefonoAdministracion, TelefonoBoleteria)
	VALUES(@Nombre, @Capacidad, @Correo, @SitioWeb, @TelefonoAdministracion, @TelefonoBoleteria);

GO;

USE SISTEMA_TEATROS;
GO

CREATE PROCEDURE CreateBloques
	@Nombre NVARCHAR(20),
	@IdTeatro INT
AS
	INSERT INTO Bloques(Nombre, IdTeatro) VALUES(@Nombre, @IdTeatro);

CREATE PROCEDURE GetByNombreBloques
	@NombreBloque NVARCHAR(20),
	@IdTeatro INT
AS
	SELECT * FROM Bloques WHERE Bloques.Nombre = @NombreBloque AND Bloques.IdTeatro = @IdTeatro;

	GO

CREATE PROCEDURE GetByTeatroIdBloques
	@IdTeatro INT
AS 
	SELECT Id, Nombre, IdTeatro
	FROM Bloques WHERE Bloques.IdTeatro = @IdTeatro;
	GO

CREATE PROCEDURE GetByLetraFilas
	@Letra CHAR,
	@IdBloque INT
AS
	SELECT * FROM Filas WHERE FilaId = @Letra AND BloqueId = @IdBloque;

GO;

CREATE PROCEDURE CreateFilas
	@FilaId CHAR,
	@BloqueId INT,
	@NumeroAsientos INT
AS
	DECLARE @TeatroId INT;
	INSERT INTO Filas(FilaId, BloqueId, NumeroAsientos) VALUES(@FilaId, @BloqueId, @NumeroAsientos);
	SELECT @TeatroId = Bloques.IdTeatro FROM Bloques WHERE Bloques.Id = @BloqueId;
	UPDATE Teatros SET Capacidad = Capacidad + @NumeroAsientos WHERE Id = @TeatroId;
GO;

CREATE TRIGGER Trg_FilasIns
	ON Filas
	FOR INSERT
	AS
		DECLARE @NumeroAsientos INT;
		DECLARE @FilaId CHAR;
		DECLARE @BloqueId INT;
		DECLARE @contador INT;
		SET @contador = 0;

		SELECT @NumeroAsientos = inserted.NumeroAsientos, @FilaId = inserted.FilaId, @BloqueId = inserted.BloqueId 
		FROM inserted;

		WHILE @contador < @NumeroAsientos
			BEGIN
				INSERT INTO Asientos(AsientoId, FilaId, BloqueId) VALUES(@contador + 1, @FilaId, @BloqueId);
				SET @contador = @contador + 1;
			END

GO;

USE SISTEMA_TEATROS;

GO

CREATE PROCEDURE GetByIdTeatroAdministradores
	@Id INT
AS
	SELECT Id, Nombre, Direccion, TelefonoCasa, TelefonoCelular, TelefonoOtro,
		Email, Sexo, FechaNacimiento, IdTeatro
	FROM TeatroAdministradores
	WHERE Id = @Id;

GO

CREATE PROCEDURE GetByNombreTeatroAdministradores
	@Nombre VARCHAR(30)
AS
	SELECT Id, Nombre, Direccion, TelefonoCasa, TelefonoCelular, TelefonoOtro,
		Email, Sexo, FechaNacimiento, IdTeatro
	FROM TeatroAdministradores
	WHERE Nombre = @Nombre;

GO

CREATE PROCEDURE GetByUsuarioTeatroAdministradores
	@Usuario VARCHAR(20)
AS
	SELECT Id, Nombre, Direccion, TelefonoCasa, TelefonoCelular, TelefonoOtro,
		Email, Sexo, FechaNacimiento, IdTeatro, Usuario
	FROM TeatroAdministradores
	WHERE Usuario = @Usuario;

GO

CREATE PROCEDURE CreateTeatroAdministradores
	@Id INT,
	@Nombre VARCHAR(30),
	@IdTeatro INT,
	@FechaNacimiento DATE,
	@Sexo CHAR,
	@Direccion VARCHAR(40),
	@TelefonoCasa VARCHAR(9) = NULL, --DEFAULT VALUES
	@TelefonoCelular VARCHAR(9) = NULL,
	@TelefonoOtro VARCHAR(9) = NULL,
	@Email VARCHAR(20),
	@Usuario VARCHAR(20),
	@Password CHAR(60)
AS
	INSERT INTO TeatroAdministradores(Id, Nombre, IdTeatro, FechaNacimiento, Sexo, Direccion,
	TelefonoCasa, TelefonoCelular, TelefonoOtro, Email, Usuario, Password)
	VALUES(@Id, @Nombre, @IdTeatro, @FechaNacimiento, @Sexo, @Direccion, @TelefonoCasa, 
	@TelefonoCelular, @TelefonoOtro, @Email, @Usuario, @Password);

GO