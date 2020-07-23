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
	UPDATE Producciones
	SET Descripcion = 'Esta produccion ha sido cancelada'
	FROM Producciones
	INNER JOIN inserted on (inserted.Id = Producciones.Id)
	INNER JOIN ProduccionEstados on (inserted.IdEstado = ProduccionEstados.Id)
	WHERE ProduccionEstados.Nombre = 'cancelada'
GO
