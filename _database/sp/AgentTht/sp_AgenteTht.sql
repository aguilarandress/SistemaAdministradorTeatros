CREATE PROCEDURE GetByUsuarioAgente
@username nvarchar(30)
AS
	SELECT *
	FROM Empleados
	INNER JOIN TeatroAgentes on (Empleados.Id = TeatroAgentes.Id)
	WHERE Usuario= @username
GO

CREATE TRIGGER Trg_EstadoProdMod on Producciones 
FOR Update
AS
	Declare @mensaje nvarchar(50);
	DECLARE @estado int;
	SELECT @estado = inserted.IdEstado 
	FROM inserted
	IF (@estado = 5)
	BEGIN
	SET @mensaje = 'Esta produccion ha sido cancelada'
	END

	IF (@estado = 6)
	BEGIN
	SET @mensaje = 'Muchas gracias por ver la produccion'
	END
	UPDATE Producciones
	SET Descripcion = @mensaje
	FROM Producciones
	INNER JOIN inserted on (inserted.Id = Producciones.Id)
	INNER JOIN ProduccionEstados on (inserted.IdEstado = ProduccionEstados.Id)
	WHERE ProduccionEstados.Nombre = 'cancelada' OR ProduccionEstados.Nombre ='finalizada'
	
GO

CREATE PROCEDURE GetByTeatroIdProduccionView
@TId INT
AS
SELECT *
FROM ViewProduccionesDisponibles
WHERE ViewProduccionesDisponibles.TeatroId = @TId
GO

CREATE VIEW ViewProduccionesDisponibles 
AS 
    SELECT Producciones.Id AS ProduccionId, ProduccionTipos.Id AS ProduccionesTiposId,Producciones.Nombre,Teatros.Id  AS TeatroId, 
           Producciones.Descripcion , Producciones.FechaInicial ,Producciones.FechaFinal ,ProduccionTipos.Nombre AS tipoProd
    FROM Producciones
    INNER JOIN ProduccionEstados ON (ProduccionEstados.Id = Producciones.IdEstado)
    INNER JOIN ProduccionTipos ON (Producciones.IdTipo = ProduccionTipos.Id)
    INNER JOIN Teatros ON (Producciones.IdTeatro = Teatros.Id)
    WHERE NOT ProduccionEstados.Nombre = 'confidencial'

GO
CREATE PROCEDURE GetByProduccionIdPresentacionView
@PId INT
AS
SELECT *
FROM ViewPresentacionesDisponibles
WHERE ViewPresentacionesDisponibles.ProduccionId = @PId 
GO


CREATE PROCEDURE GetByProdIdBloquePrecios
@ProdId INT
AS
SELECT * ,Bloques.Nombre as BloqueNombre , Bloques.Id as BloqueId
FROM BloquePrecios
INNER JOIN Bloques ON (Bloques.Id = BloquePrecios.IdBloque)
WHERE BloquePrecios.IdProduccion = @ProdId
GO

CREATE PROCEDURE GetByBloqueIdFilas
@BId INT
AS
SELECT *
FROM Filas
WHERE Filas.BloqueId = @BId
GO

CREATE PROCEDURE GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos 
@FId NVARCHAR(1),
@BId INT,
@PId INT,
@PSId INT
AS
SELECT *
FROM Asientos
WHERE NOT EXISTS( 
	SELECT *
	FROM Asientos
	INNER JOIN AsientosxReservaciones ON (AsientosxReservaciones.BloqueId = @BId AND AsientosxReservaciones.FilaId = @FId)
	INNER JOIN Reservaciones ON (Reservaciones.PresentacionId = @PSId AND Reservaciones.ProduccionId = @PId)
	) 
	AND Asientos.FilaId = @FId AND Asientos.BloqueId = @BId
GO

CREATE TYPE TablaAsientos AS TABLE(BloqueId int not null,FilaId char not null,AsientoId INT not null, Primary Key (BloqueId,FilaId,AsientoId))
GO
DROP PROCEDURE RealizarCompraTarjeta
CREATE PROCEDURE RealizarCompraTarjeta 
@nombre NVARCHAR(30),
@telefono VARCHAR(9),
@CVC INT,
@Pago DECIMAL(10,2),
@Asientos TablaAsientos READONLY,
@PId int,
@PSId int,
@Success bit OUTPUT,
@NumAprob int OUTPUT ,
@DateDone DATETIME OUTPUT
AS
BEGIN
DECLARE @IDCliente INT
DECLARE @IDReservacion INT
BEGIN TRANSACTION
	INSERT INTO CLIENTES(Nombre,Telefono)
	VALUES( @nombre , @telefono)
	SELECT @NumAprob = FLOOR(RAND()*(999999-100000+1))+100000;
	SET @IDCliente = SCOPE_IDENTITY()
	SET @DateDone =GETDATE()
	INSERT INTO Reservaciones(IdCliente,Comprobante,Fecha,ProduccionId,PresentacionId,Monto)
	VALUES(@IDCliente,@NumAprob,@DateDone,@PId,@PSId,@Pago)
	SET @IDReservacion = SCOPE_IDENTITY()

	DECLARE cur_asientos CURSOR FOR
	SELECT BloqueId , FilaId , AsientoId
	FROM @Asientos

	OPEN cur_asientos
	DECLARE @BloqId INT;
	DECLARE @FilaId Char;
	DECLARE @AsienId INT
	FETCH NEXT FROM cur_asientos INTO @BloqId , @FilaId ,@AsienId ;
	WHILE @@FETCH_STATUS = 0
	BEGIN
	INSERT INTO AsientosxReservaciones(ReservacionId,BloqueId,FilaId,AsientoId)
	VALUES(@IDReservacion,@BloqId,@FilaId,@AsienId)
	FETCH NEXT FROM cur_asientos INTO @BloqId , @FilaId ,@AsienId;
	END

	CLOSE cur_asientos
	DEALLOCATE cur_asientos

	IF NOT(((@CVC%2)= 0 AND (@Pago%2 != 0)) OR (@CVC%2)!= 0 AND (@Pago%2 = 0))
	BEGIN
	ROLLBACK TRANSACTION
	SET @NumAprob = -1
	SET @Success = 0
	SET @DateDone = NULL
	RETURN 
	END
	
	SET @Success = 1
	COMMIT TRANSACTION
END 
GO

DECLARE @Asientos TablaAsientos 
INSERT INTO @Asientos (BloqueId,FilaId,AsientoId)
VALUES(1,'A',1),(1,'A',2)


DECLARE @A BIT;
DECLARE @B INT ;
DECLARE @C DATETIME;
EXEC  RealizarCompraTarjeta 'PIPITITIN','8888-8888',343,20005,@Asientos,3,2 ,@A,@B,@C
Print @A


GO
Create TRIGGER [dbo].[Trg_SistemaAdministradoresInsUpd]
    ON [dbo].[SistemaAdministradores]
    FOR INSERT, UPDATE
    AS
    IF EXISTS (SELECT * 
                FROM TeatroAdministradores
                INNER JOIN inserted ON inserted.Id = TeatroAdministradores.Id
                WHERE TeatroAdministradores.Id IS NOT NULL)
       OR EXISTS (SELECT * 
                    FROM TeatroAgentes
                    INNER JOIN inserted ON inserted.Id = TeatroAgentes.Id
                    WHERE TeatroAgentes.Id IS NOT NULL)
    BEGIN
        RAISERROR('Administrador del sistema no puede ser admin del teatro o agente', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
go
CREATE TRIGGER [dbo].[Trg_TeatroAdministradoresInsUpd]
ON [dbo].[TeatroAdministradores]
FOR INSERT, UPDATE
AS
IF EXISTS (SELECT * 
            FROM SistemaAdministradores
            INNER JOIN inserted ON inserted.Id = SistemaAdministradores.Id
            WHERE SistemaAdministradores.Id IS NOT NULL)
    OR EXISTS (SELECT * 
                FROM TeatroAgentes
                INNER JOIN inserted ON inserted.Id = TeatroAgentes.Id
                WHERE TeatroAgentes.Id IS NOT NULL)
BEGIN
    RAISERROR('Administrador del teatro no puede ser admin del sistema o agente', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END

GO

CREATE TRIGGER [dbo].[Trg_TeatroAgentesInsUpd]
    ON [dbo].[TeatroAgentes]
    FOR INSERT, UPDATE
    AS
    IF EXISTS (SELECT * 
                FROM SistemaAdministradores
                INNER JOIN inserted ON inserted.Id = SistemaAdministradores.Id
                WHERE SistemaAdministradores.Id IS NOT NULL)
       OR EXISTS (SELECT * 
                    FROM TeatroAdministradores
                    INNER JOIN inserted ON inserted.Id = TeatroAdministradores.Id
                    WHERE TeatroAdministradores.Id IS NOT NULL)
    BEGIN
        RAISERROR('Agente del teatro no puede ser admin del sistema o del teatro', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END