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
	INNER JOIN Reservaciones ON (Reservaciones.PresentacionId = @PId AND Reservaciones.ProduccionId = @PSId)

	) 
	AND Asientos.FilaId = @FId AND Asientos.BloqueId = @BId
GO
