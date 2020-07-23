/**
	SCRIPT PARA CREAR ROLES Y ASIGNAR PERMISOS
**/
USE SISTEMA_TEATROS;
CREATE ROLE SistemaAdministradores;
CREATE ROLE TeatroAdministradores;
CREATE ROLE TeatroAgentes;

-- Denegar SELECT, INSERT, UPDATE Y DELETE

EXEC sp_MSforeachtable @command1 = 'DENY SELECT, INSERT, DELETE, UPDATE on ? TO TeatroAgentes AS [dbo]'
