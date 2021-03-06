USE [master]
GO
/****** Object:  Database [SISTEMA_TEATROS]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE DATABASE [SISTEMA_TEATROS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SISTEMA_TEATROS', FILENAME = N'D:\Development\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\SISTEMA_TEATROS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SISTEMA_TEATROS_log', FILENAME = N'D:\Development\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\SISTEMA_TEATROS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SISTEMA_TEATROS] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SISTEMA_TEATROS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET RECOVERY FULL 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET  MULTI_USER 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SISTEMA_TEATROS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SISTEMA_TEATROS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SISTEMA_TEATROS', N'ON'
GO
ALTER DATABASE [SISTEMA_TEATROS] SET QUERY_STORE = OFF
GO
USE [SISTEMA_TEATROS]
GO
/****** Object:  User [pepito]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE USER [pepito] FOR LOGIN [pepito] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [app_teatroagente]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE USER [app_teatroagente] FOR LOGIN [app_teatroagente] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [app_teatroadmin]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE USER [app_teatroadmin] FOR LOGIN [app_teatroadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [app_sysadmin]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE USER [app_sysadmin] FOR LOGIN [app_sysadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [app_publicogeneral]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE USER [app_publicogeneral] FOR LOGIN [app_publicogeneral] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [TeatroAgentes]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE ROLE [TeatroAgentes]
GO
/****** Object:  DatabaseRole [TeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE ROLE [TeatroAdministradores]
GO
/****** Object:  DatabaseRole [SistemaAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE ROLE [SistemaAdministradores]
GO
/****** Object:  DatabaseRole [PublicoGeneral]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE ROLE [PublicoGeneral]
GO
ALTER ROLE [TeatroAgentes] ADD MEMBER [app_teatroagente]
GO
ALTER ROLE [TeatroAdministradores] ADD MEMBER [app_teatroadmin]
GO
ALTER ROLE [SistemaAdministradores] ADD MEMBER [app_sysadmin]
GO
ALTER ROLE [PublicoGeneral] ADD MEMBER [app_publicogeneral]
GO
GRANT CONNECT TO [app_publicogeneral] AS [dbo]
GO
GRANT CONNECT TO [app_sysadmin] AS [dbo]
GO
GRANT CONNECT TO [app_teatroadmin] AS [dbo]
GO
GRANT CONNECT TO [app_teatroagente] AS [dbo]
GO
GRANT CONNECT TO [pepito] AS [dbo]
GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO [public] AS [dbo]
GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO [public] AS [dbo]
GO
/****** Object:  UserDefinedTableType [dbo].[TablaAsientos]    Script Date: 7/27/2020 8:14:31 PM ******/
CREATE TYPE [dbo].[TablaAsientos] AS TABLE(
	[BloqueId] [int] NOT NULL,
	[FilaId] [char](1) NOT NULL,
	[AsientoId] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[BloqueId] ASC,
	[FilaId] ASC,
	[AsientoId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
GRANT CONTROL ON TYPE::[dbo].[TablaAsientos] TO [PublicoGeneral] AS [dbo]
GO
GRANT REFERENCES ON TYPE::[dbo].[TablaAsientos] TO [PublicoGeneral] AS [dbo]
GO
GRANT TAKE OWNERSHIP ON TYPE::[dbo].[TablaAsientos] TO [PublicoGeneral] AS [dbo]
GO
GRANT VIEW DEFINITION ON TYPE::[dbo].[TablaAsientos] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON TYPE::[dbo].[TablaAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY REFERENCES ON TYPE::[dbo].[TablaAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON TYPE::[dbo].[TablaAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON TYPE::[dbo].[TablaAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON TYPE::[dbo].[TablaAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY REFERENCES ON TYPE::[dbo].[TablaAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON TYPE::[dbo].[TablaAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON TYPE::[dbo].[TablaAsientos] TO [TeatroAdministradores] AS [dbo]
GO
GRANT CONTROL ON TYPE::[dbo].[TablaAsientos] TO [TeatroAgentes] AS [dbo]
GO
GRANT REFERENCES ON TYPE::[dbo].[TablaAsientos] TO [TeatroAgentes] AS [dbo]
GO
GRANT TAKE OWNERSHIP ON TYPE::[dbo].[TablaAsientos] TO [TeatroAgentes] AS [dbo]
GO
GRANT VIEW DEFINITION ON TYPE::[dbo].[TablaAsientos] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Producciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [text] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[FechaInicial] [date] NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[IdEstado] [int] NOT NULL,
	[IdTeatro] [int] NOT NULL,
	[IdTipo] [int] NOT NULL,
 CONSTRAINT [PkProducciones_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Producciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Producciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Producciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Producciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Producciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Producciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Producciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Producciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Producciones] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Producciones] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Producciones] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Producciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[ProduccionEstados]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduccionEstados](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
 CONSTRAINT [PkProduccionEstados_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[ProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[ProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[ProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[ProduccionTipos]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduccionTipos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
 CONSTRAINT [PkProduccionTipos_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[ProduccionTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[ProduccionTipos] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionTipos] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionTipos] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionTipos] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[ProduccionTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[ProduccionTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[ProduccionTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[ProduccionTipos] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Teatros]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teatros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Capacidad] [int] NOT NULL,
	[Correo] [nvarchar](30) NOT NULL,
	[SitioWeb] [nvarchar](30) NOT NULL,
	[TelefonoAdministracion] [varchar](9) NOT NULL,
	[TelefonoBoleteria] [varchar](9) NOT NULL,
 CONSTRAINT [PkTeatros_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Teatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Teatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Teatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Teatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Teatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Teatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Teatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Teatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Teatros] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Teatros] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Teatros] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Teatros] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  View [dbo].[ViewProduccionesDisponibles]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewProduccionesDisponibles] 
AS 
    SELECT Producciones.Id AS ProduccionId, ProduccionTipos.Id AS ProduccionesTiposId,Producciones.Nombre,Teatros.Id  AS TeatroId, 
           Producciones.Descripcion , Producciones.FechaInicial ,Producciones.FechaFinal ,ProduccionTipos.Nombre AS tipoProd
    FROM Producciones
    INNER JOIN ProduccionEstados ON (ProduccionEstados.Id = Producciones.IdEstado)
    INNER JOIN ProduccionTipos ON (Producciones.IdTipo = ProduccionTipos.Id)
    INNER JOIN Teatros ON (Producciones.IdTeatro = Teatros.Id)
    WHERE NOT ProduccionEstados.Nombre = 'confidencial'
GO
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presentaciones](
	[PresentacionId] [int] NOT NULL,
	[ProduccionId] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Hora] [time](7) NOT NULL,
 CONSTRAINT [PkPresentaciones_Id] PRIMARY KEY CLUSTERED 
(
	[ProduccionId] ASC,
	[PresentacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Presentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Presentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Presentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Presentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Presentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Presentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Presentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Presentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Presentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Presentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Presentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Presentaciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  View [dbo].[ViewPresentacionesDisponibles]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewPresentacionesDisponibles]
AS
    SELECT Presentaciones.ProduccionId, Presentaciones.PresentacionId, Producciones.Nombre AS NombreProduccion,
            Teatros.Nombre AS NombreTeatro, Teatros.Id AS IdTeatro, ProduccionEstados.Nombre AS Estado, ProduccionTipos.Nombre AS Tipo,
            Presentaciones.Fecha, Presentaciones.Hora, Producciones.Descripcion
    FROM Presentaciones
    INNER JOIN Producciones ON (Presentaciones.ProduccionId = Producciones.Id)
    INNER JOIN ProduccionEstados ON (Producciones.IdEstado = ProduccionEstados.Id)
    INNER JOIN ProduccionTipos ON (Producciones.IdTipo = ProduccionTipos.Id)
    INNER JOIN Teatros ON (Teatros.Id = Producciones.IdTeatro)
    WHERE NOT ProduccionEstados.Nombre = 'confidencial'
GO
/****** Object:  Table [dbo].[Asientos]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asientos](
	[AsientoId] [int] NOT NULL,
	[FilaId] [char](1) NOT NULL,
	[BloqueId] [int] NOT NULL,
 CONSTRAINT [PkAsientos_Id] PRIMARY KEY CLUSTERED 
(
	[BloqueId] ASC,
	[FilaId] ASC,
	[AsientoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Asientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Asientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Asientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Asientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Asientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Asientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Asientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Asientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Asientos] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Asientos] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Asientos] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Asientos] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[AsientosxReservaciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsientosxReservaciones](
	[AsientoId] [int] NOT NULL,
	[FilaId] [char](1) NOT NULL,
	[BloqueId] [int] NOT NULL,
	[ReservacionId] [int] NOT NULL,
 CONSTRAINT [PkAsientosxReservaciones_Id] PRIMARY KEY CLUSTERED 
(
	[BloqueId] ASC,
	[FilaId] ASC,
	[AsientoId] ASC,
	[ReservacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[AsientosxReservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[AsientosxReservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[AsientosxReservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[AsientosxReservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[AsientosxReservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[AsientosxReservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[AsientosxReservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[AsientosxReservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[AsientosxReservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[AsientosxReservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[AsientosxReservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[AsientosxReservaciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[BloquePrecios]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloquePrecios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[IdBloque] [int] NOT NULL,
	[IdProduccion] [int] NOT NULL,
 CONSTRAINT [PkBloquePrecios_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[BloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[BloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[BloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[BloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[BloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[BloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[BloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[BloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[BloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[BloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[BloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[BloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Bloques]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bloques](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](20) NOT NULL,
	[IdTeatro] [int] NOT NULL,
 CONSTRAINT [PkBloques_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Bloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Bloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Bloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Bloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Bloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Bloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Bloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Bloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Bloques] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Bloques] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Bloques] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Bloques] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Telefono] [varchar](9) NOT NULL,
 CONSTRAINT [PkClientes_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Clientes] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Clientes] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Clientes] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Clientes] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Clientes] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Clientes] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Clientes] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Clientes] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Clientes] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Clientes] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Clientes] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Clientes] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Direccion] [varchar](40) NOT NULL,
	[TelefonoCasa] [varchar](9) NULL,
	[TelefonoCelular] [varchar](9) NULL,
	[TelefonoOtro] [varchar](9) NULL,
	[Email] [varchar](40) NOT NULL,
	[Usuario] [varchar](20) NOT NULL,
	[Password] [char](60) NOT NULL,
 CONSTRAINT [PkEmpleados_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Empleados] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Empleados] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Empleados] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Empleados] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Empleados] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Empleados] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Empleados] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Empleados] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Empleados] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Empleados] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Empleados] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Empleados] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Filas]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Filas](
	[FilaId] [char](1) NOT NULL,
	[BloqueId] [int] NOT NULL,
	[NumeroAsientos] [int] NOT NULL,
 CONSTRAINT [PkFilas_Id] PRIMARY KEY CLUSTERED 
(
	[BloqueId] ASC,
	[FilaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Filas] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Filas] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Filas] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Filas] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Filas] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Filas] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Filas] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Filas] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Filas] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Filas] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Filas] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Filas] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[Reportes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[AsientosVendidos] [int] NOT NULL,
	[PromedioAsientos] [decimal](12, 2) NOT NULL,
 CONSTRAINT [PkReportes_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservaciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[PresentacionId] [int] NOT NULL,
	[ProduccionId] [int] NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[Comprobante] [decimal](6, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PkReservaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[Reservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Reservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Reservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Reservaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Reservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[Reservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[Reservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[Reservaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[Reservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[Reservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[Reservaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[Reservaciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[SistemaAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SistemaAdministradores](
	[Id] [int] NOT NULL,
 CONSTRAINT [PkSistemaAdministradores_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[SistemaAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[SistemaAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[SistemaAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[SistemaAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[SistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[SistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[SistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[SistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[SistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[SistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[SistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[SistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[TeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeatroAdministradores](
	[Id] [int] NOT NULL,
	[IdTeatro] [int] NOT NULL,
 CONSTRAINT [PkTeatroAdministradores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[TeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[TeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[TeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Table [dbo].[TeatroAgentes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeatroAgentes](
	[Id] [int] NOT NULL,
	[IdTeatro] [int] NOT NULL,
 CONSTRAINT [PkTeatroAgentes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DENY DELETE ON [dbo].[TeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[TeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY DELETE ON [dbo].[TeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY INSERT ON [dbo].[TeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY SELECT ON [dbo].[TeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY UPDATE ON [dbo].[TeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (1, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (2, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (3, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (4, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (5, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (6, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (7, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (8, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (9, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (10, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (11, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (12, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (13, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (14, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (15, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (16, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (17, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (18, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (19, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (20, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (21, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (22, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (23, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (24, N'A', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (1, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (2, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (3, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (4, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (5, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (6, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (7, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (8, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (9, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (10, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (11, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (12, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (13, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (14, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (15, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (16, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (17, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (18, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (19, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (20, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (21, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (22, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (23, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (24, N'B', 1)
INSERT [dbo].[Asientos] ([AsientoId], [FilaId], [BloqueId]) VALUES (25, N'B', 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (1, N'B', 1, 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (2, N'B', 1, 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (3, N'B', 1, 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (4, N'B', 1, 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (5, N'B', 1, 1)
INSERT [dbo].[AsientosxReservaciones] ([AsientoId], [FilaId], [BloqueId], [ReservacionId]) VALUES (6, N'B', 1, 1)
SET IDENTITY_INSERT [dbo].[BloquePrecios] ON 

INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (1, CAST(50000.00 AS Decimal(10, 2)), 1, 1)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (2, CAST(30000.00 AS Decimal(10, 2)), 2, 1)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (3, CAST(10000.00 AS Decimal(10, 2)), 3, 1)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (4, CAST(12000.00 AS Decimal(10, 2)), 4, 1)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (5, CAST(10000.00 AS Decimal(10, 2)), 5, 1)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (6, CAST(8000.00 AS Decimal(10, 2)), 1, 2)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (7, CAST(5000.00 AS Decimal(10, 2)), 2, 2)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (8, CAST(3000.00 AS Decimal(10, 2)), 3, 2)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (9, CAST(3000.00 AS Decimal(10, 2)), 4, 2)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (10, CAST(3000.00 AS Decimal(10, 2)), 5, 2)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (11, CAST(6000.00 AS Decimal(10, 2)), 6, 3)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (12, CAST(12000.00 AS Decimal(10, 2)), 7, 3)
INSERT [dbo].[BloquePrecios] ([Id], [Monto], [IdBloque], [IdProduccion]) VALUES (13, CAST(6000.00 AS Decimal(10, 2)), 8, 3)
SET IDENTITY_INSERT [dbo].[BloquePrecios] OFF
SET IDENTITY_INSERT [dbo].[Bloques] ON 

INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (2, N'butacas', 1)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (4, N'galeria central', 1)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (5, N'galeria derecha', 1)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (3, N'galeria izquierda', 1)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (1, N'lunetas', 1)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (7, N'luneta central', 2)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (8, N'luneta derecha', 2)
INSERT [dbo].[Bloques] ([Id], [Nombre], [IdTeatro]) VALUES (6, N'luneta izquierda', 2)
SET IDENTITY_INSERT [dbo].[Bloques] OFF
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([Id], [Nombre], [Telefono]) VALUES (1, N'PepeComprador', N'8888-8888')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (111111111, N'agente1', CAST(N'2020-07-20' AS Date), N'M', N'xd', NULL, NULL, NULL, N'agente1@gmail.com', N'Pepito2022', N'$2a$04$pSs2bZJGVMten5nBEGvSyeJIRGeRQvs50ej8p99C1PdEh/4x4Qjwq')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (111222555, N'Agente', CAST(N'2020-07-01' AS Date), N'M', N'micasa', NULL, NULL, NULL, N'micasa@queli.porta', N'Agente', N'$2a$04$aRl25q5/DXCyH1KCQl9fKe/p26/wSFIRMqcRRJZZ4/uFOvCGJ5clK')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (123123123, N'SuperPepe', CAST(N'2020-07-08' AS Date), N'M', N'quelimporta', NULL, N'1234-1234', NULL, N'pepe@pepe.pep', N'Pepepe3', N'$2a$04$BKIc0wWYlgRVm7fvLGDcGuvc.rheMHbTmEeuIQjWir.cUah0hZYZe')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (123456787, N'jost', CAST(N'2020-07-08' AS Date), N'M', N'xd', NULL, NULL, NULL, N'pepito@gmail.com', N'Pepito2021', N'$2a$04$KbiBP44i1AiYe4EN9p7FB.hMeEYFZseL/lM4LaBOkPfc3ih2ogLhq')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (123456788, N'Pepillo', CAST(N'2020-07-08' AS Date), N'M', N'Turrialba, Cartago', NULL, N'8888-8888', NULL, N'pepito@gmail.com', N'Pepillo', N'$2a$04$oqBio/3AM.agHzxF8EspS.7RKUfsKmF.ZUyXozv30oBBjPZSmnaQy')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (123456789, N'Pepito', CAST(N'2020-05-19' AS Date), N'M', N'Turrialba, Cartago', N'8888-8888', N'8888-8888', N'8888-8888', N'pepito@gmail.com', N'Pepito2020', N'$2a$04$EItaPLCWyAlonvXss6F8sewVgZiaQGN4mmONYv/GCrLL6mruLDCqS')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (132123123, N'Agente2', CAST(N'2020-07-22' AS Date), N'M', N'asd', NULL, NULL, NULL, N'email@correo.cor', N'Agente2', N'$2a$04$R3gCdsAo2WKxhLyazzY/0.I6wBGA/vLHkRUz8q27VLOP8ZXuhxw3m')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (208160911, N'pepepepe', CAST(N'2020-07-01' AS Date), N'M', N'asdasd', NULL, NULL, NULL, N'car@car.car', N'Pepepe1', N'$2a$04$kdLy9EgJkpXB1Tm3ZmNaieath0y570Obr9XCegt/aW9zgKAIqljJy')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (222222222, N'PRUEBA_NUEVA', CAST(N'2020-07-09' AS Date), N'M', N'xd', NULL, NULL, NULL, N'jost@gmail.com', N'PRUEBA_NUEVA', N'$2a$04$b7O21NJucphM3DRSI4moq.3UgQPUXiae/9r2NwYE7VWtcQ.bItN/q')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (321321321, N'ULTRAPEPE', CAST(N'2020-07-27' AS Date), N'M', N'NOSE', NULL, NULL, NULL, N'SUPER@PEPE.PEP', N'Pepepe4', N'$2a$04$tzENHmMoRVfa55vpTsGiYujdJex3ESATm/NUf1l7b94y895CKWPTy')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (987987987, N'Pepepe2', CAST(N'2020-07-22' AS Date), N'M', N'asd', NULL, NULL, NULL, N'asd@asd.asd', N'Pepepe2', N'$2a$04$.zUOh1gF.pTryEUqj4YVaOwGtF2.yIAEg3SJ8hVIW0TfYVbIAPwh.')
INSERT [dbo].[Empleados] ([Id], [Nombre], [FechaNacimiento], [Sexo], [Direccion], [TelefonoCasa], [TelefonoCelular], [TelefonoOtro], [Email], [Usuario], [Password]) VALUES (999999999, N'AGENTE3', CAST(N'2020-07-25' AS Date), N'M', N'Turrialba, Cartago', NULL, NULL, NULL, N'agente1@gmail.com', N'agente3', N'$2a$04$DmU5N3poi2Zdxotqpyrc9exQkeQ4Ehc2ciq0qGWipMwJXkRMdDq62')
INSERT [dbo].[Filas] ([FilaId], [BloqueId], [NumeroAsientos]) VALUES (N'A', 1, 24)
INSERT [dbo].[Filas] ([FilaId], [BloqueId], [NumeroAsientos]) VALUES (N'B', 1, 25)
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (1, 1, CAST(N'2019-06-09' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (2, 1, CAST(N'2019-06-10' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (3, 1, CAST(N'2019-06-12' AS Date), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (1, 2, CAST(N'2019-07-16' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (1, 3, CAST(N'2019-06-17' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (2, 3, CAST(N'2019-06-18' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (3, 3, CAST(N'2019-06-25' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (4, 3, CAST(N'2019-06-26' AS Date), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Presentaciones] ([PresentacionId], [ProduccionId], [Fecha], [Hora]) VALUES (5, 3, CAST(N'2019-06-26' AS Date), CAST(N'20:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Producciones] ON 

INSERT [dbo].[Producciones] ([Id], [Descripcion], [FechaFinal], [FechaInicial], [Nombre], [IdEstado], [IdTeatro], [IdTipo]) VALUES (1, N'Se presenta con todo lujo la gran obra de Federico Garcia Lorca.', CAST(N'2019-06-12' AS Date), CAST(N'2019-06-09' AS Date), N'Bodas de sangre', 4, 1, 1)
INSERT [dbo].[Producciones] ([Id], [Descripcion], [FechaFinal], [FechaInicial], [Nombre], [IdEstado], [IdTeatro], [IdTipo]) VALUES (2, N'Cinco coreografos jovenes nos muestran sus trabajos.', CAST(N'2019-07-16' AS Date), CAST(N'2019-07-16' AS Date), N'Jovenes Coreografos 2016', 4, 1, 2)
INSERT [dbo].[Producciones] ([Id], [Descripcion], [FechaFinal], [FechaInicial], [Nombre], [IdEstado], [IdTeatro], [IdTipo]) VALUES (3, N'La Orquesta Filarmonica se luce interpretando boleros clasicos que llegan al corazon de todos los romanticos.', CAST(N'2019-06-26' AS Date), CAST(N'2019-06-17' AS Date), N'Bolero Filarmonico', 4, 2, 3)
SET IDENTITY_INSERT [dbo].[Producciones] OFF
SET IDENTITY_INSERT [dbo].[ProduccionEstados] ON 

INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (4, N'abierta')
INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (2, N'adelantada')
INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (3, N'anunciada')
INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (5, N'cancelada')
INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (6, N'concluida')
INSERT [dbo].[ProduccionEstados] ([Id], [Nombre]) VALUES (1, N'confidencial')
SET IDENTITY_INSERT [dbo].[ProduccionEstados] OFF
SET IDENTITY_INSERT [dbo].[ProduccionTipos] ON 

INSERT [dbo].[ProduccionTipos] ([Id], [Nombre]) VALUES (2, N'danza')
INSERT [dbo].[ProduccionTipos] ([Id], [Nombre]) VALUES (3, N'musica')
INSERT [dbo].[ProduccionTipos] ([Id], [Nombre]) VALUES (4, N'otro')
INSERT [dbo].[ProduccionTipos] ([Id], [Nombre]) VALUES (1, N'teatro')
SET IDENTITY_INSERT [dbo].[ProduccionTipos] OFF
SET IDENTITY_INSERT [dbo].[Reportes] ON 

INSERT [dbo].[Reportes] ([Id], [Fecha], [AsientosVendidos], [PromedioAsientos]) VALUES (1, CAST(N'2020-07-27' AS Date), 6, CAST(50000.00 AS Decimal(12, 2)))
SET IDENTITY_INSERT [dbo].[Reportes] OFF
SET IDENTITY_INSERT [dbo].[Reservaciones] ON 

INSERT [dbo].[Reservaciones] ([Id], [IdCliente], [PresentacionId], [ProduccionId], [Monto], [Comprobante], [Fecha]) VALUES (1, 1, 1, 1, CAST(300000.00 AS Decimal(10, 2)), CAST(305022 AS Decimal(6, 0)), CAST(N'2020-07-27T19:46:25.030' AS DateTime))
SET IDENTITY_INSERT [dbo].[Reservaciones] OFF
INSERT [dbo].[SistemaAdministradores] ([Id]) VALUES (123456789)
INSERT [dbo].[TeatroAdministradores] ([Id], [IdTeatro]) VALUES (123123123, 1)
INSERT [dbo].[TeatroAgentes] ([Id], [IdTeatro]) VALUES (321321321, 1)
SET IDENTITY_INSERT [dbo].[Teatros] ON 

INSERT [dbo].[Teatros] ([Id], [Nombre], [Capacidad], [Correo], [SitioWeb], [TelefonoAdministracion], [TelefonoBoleteria]) VALUES (1, N'Teatro Nacional', 49, N'tn@yopmail.com', N'tnc.cr', N'2555985', N'8888-8888')
INSERT [dbo].[Teatros] ([Id], [Nombre], [Capacidad], [Correo], [SitioWeb], [TelefonoAdministracion], [TelefonoBoleteria]) VALUES (2, N'Melico Salazar', 0, N'tms@otromail.com', N'tms.cr', N'8888155', N'8888-8888')
SET IDENTITY_INSERT [dbo].[Teatros] OFF
/****** Object:  Index [UnBloquePrecios_BloqueProduccion]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[BloquePrecios] ADD  CONSTRAINT [UnBloquePrecios_BloqueProduccion] UNIQUE NONCLUSTERED 
(
	[IdBloque] ASC,
	[IdProduccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnBloques_NombreIdTeatro]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[Bloques] ADD  CONSTRAINT [UnBloques_NombreIdTeatro] UNIQUE NONCLUSTERED 
(
	[IdTeatro] ASC,
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnEmpleados_Nombre]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[Empleados] ADD  CONSTRAINT [UnEmpleados_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnEmpleados_Usuario]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[Empleados] ADD  CONSTRAINT [UnEmpleados_Usuario] UNIQUE NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProducciones_Nombre]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[Producciones] ADD  CONSTRAINT [UnProducciones_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProduccionEstados_Nombre]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[ProduccionEstados] ADD  CONSTRAINT [UnProduccionEstados_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProduccionTipos_Nombre]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[ProduccionTipos] ADD  CONSTRAINT [UnProduccionTipos_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatros_Nombre]    Script Date: 7/27/2020 8:14:31 PM ******/
ALTER TABLE [dbo].[Teatros] ADD  CONSTRAINT [UnTeatros_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reportes] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Asientos]  WITH CHECK ADD  CONSTRAINT [FkAsientos_IdFilas] FOREIGN KEY([BloqueId], [FilaId])
REFERENCES [dbo].[Filas] ([BloqueId], [FilaId])
GO
ALTER TABLE [dbo].[Asientos] CHECK CONSTRAINT [FkAsientos_IdFilas]
GO
ALTER TABLE [dbo].[AsientosxReservaciones]  WITH CHECK ADD  CONSTRAINT [FkAsientosxReservaciones_IdAsientos] FOREIGN KEY([BloqueId], [FilaId], [AsientoId])
REFERENCES [dbo].[Asientos] ([BloqueId], [FilaId], [AsientoId])
GO
ALTER TABLE [dbo].[AsientosxReservaciones] CHECK CONSTRAINT [FkAsientosxReservaciones_IdAsientos]
GO
ALTER TABLE [dbo].[AsientosxReservaciones]  WITH CHECK ADD  CONSTRAINT [FkAsientosxReservaciones_IdReservaciones] FOREIGN KEY([ReservacionId])
REFERENCES [dbo].[Reservaciones] ([Id])
GO
ALTER TABLE [dbo].[AsientosxReservaciones] CHECK CONSTRAINT [FkAsientosxReservaciones_IdReservaciones]
GO
ALTER TABLE [dbo].[BloquePrecios]  WITH NOCHECK ADD  CONSTRAINT [FkBloquePrecios_IdBloque] FOREIGN KEY([IdBloque])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[BloquePrecios] CHECK CONSTRAINT [FkBloquePrecios_IdBloque]
GO
ALTER TABLE [dbo].[BloquePrecios]  WITH NOCHECK ADD  CONSTRAINT [FkBloquePrecios_IdProduccion] FOREIGN KEY([IdProduccion])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[BloquePrecios] CHECK CONSTRAINT [FkBloquePrecios_IdProduccion]
GO
ALTER TABLE [dbo].[Bloques]  WITH NOCHECK ADD  CONSTRAINT [FkBloques_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Bloques] CHECK CONSTRAINT [FkBloques_IdTeatro]
GO
ALTER TABLE [dbo].[Filas]  WITH NOCHECK ADD  CONSTRAINT [FkFilas_IdBloque] FOREIGN KEY([BloqueId])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[Filas] CHECK CONSTRAINT [FkFilas_IdBloque]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH NOCHECK ADD  CONSTRAINT [FkPresentaciones_IdProduccion] FOREIGN KEY([ProduccionId])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FkPresentaciones_IdProduccion]
GO
ALTER TABLE [dbo].[Producciones]  WITH NOCHECK ADD  CONSTRAINT [FkProducciones_IdEstado] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[ProduccionEstados] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdEstado]
GO
ALTER TABLE [dbo].[Producciones]  WITH NOCHECK ADD  CONSTRAINT [FkProducciones_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdTeatro]
GO
ALTER TABLE [dbo].[Producciones]  WITH NOCHECK ADD  CONSTRAINT [FkProducciones_IdTipo] FOREIGN KEY([IdTipo])
REFERENCES [dbo].[ProduccionTipos] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdTipo]
GO
ALTER TABLE [dbo].[Reservaciones]  WITH CHECK ADD  CONSTRAINT [FKPresentaciones_Id] FOREIGN KEY([ProduccionId], [PresentacionId])
REFERENCES [dbo].[Presentaciones] ([ProduccionId], [PresentacionId])
GO
ALTER TABLE [dbo].[Reservaciones] CHECK CONSTRAINT [FKPresentaciones_Id]
GO
ALTER TABLE [dbo].[Reservaciones]  WITH CHECK ADD  CONSTRAINT [FkReservaciones_IdCliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([Id])
GO
ALTER TABLE [dbo].[Reservaciones] CHECK CONSTRAINT [FkReservaciones_IdCliente]
GO
ALTER TABLE [dbo].[SistemaAdministradores]  WITH CHECK ADD  CONSTRAINT [FkSistemaAdministradores_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Empleados] ([Id])
GO
ALTER TABLE [dbo].[SistemaAdministradores] CHECK CONSTRAINT [FkSistemaAdministradores_Id]
GO
ALTER TABLE [dbo].[TeatroAdministradores]  WITH CHECK ADD  CONSTRAINT [FkTeatroAdministradores_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Empleados] ([Id])
GO
ALTER TABLE [dbo].[TeatroAdministradores] CHECK CONSTRAINT [FkTeatroAdministradores_Id]
GO
ALTER TABLE [dbo].[TeatroAdministradores]  WITH CHECK ADD  CONSTRAINT [FkTeatroAdministradores_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[TeatroAdministradores] CHECK CONSTRAINT [FkTeatroAdministradores_IdTeatro]
GO
ALTER TABLE [dbo].[TeatroAgentes]  WITH CHECK ADD  CONSTRAINT [FkTeatroAgentes_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Empleados] ([Id])
GO
ALTER TABLE [dbo].[TeatroAgentes] CHECK CONSTRAINT [FkTeatroAgentes_Id]
GO
ALTER TABLE [dbo].[TeatroAgentes]  WITH CHECK ADD  CONSTRAINT [FkTeatroAgentes_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[TeatroAgentes] CHECK CONSTRAINT [FkTeatroAgentes_IdTeatro]
GO
/****** Object:  StoredProcedure [dbo].[CreateBloquePrecios]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateBloquePrecios]
@Monto Decimal(10,2),
@IdBloque INT,
@IdProduccion INT
AS
INSERT INTO BloquePrecios(Monto,IdBloque,IdProduccion)
VALUES (@Monto,@IdBloque,@IdProduccion)
GO
DENY ALTER ON [dbo].[CreateBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateBloques]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateBloques]
	@Nombre NVARCHAR(20),
	@IdTeatro INT
AS
	INSERT INTO Bloques(Nombre, IdTeatro) VALUES(@Nombre, @IdTeatro);
GO
DENY ALTER ON [dbo].[CreateBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateBloques] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateBloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateBloques] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateFilas]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateFilas]
	@FilaId CHAR,
	@BloqueId INT,
	@NumeroAsientos INT
AS
	DECLARE @TeatroId INT;
	INSERT INTO Filas(FilaId, BloqueId, NumeroAsientos) VALUES(@FilaId, @BloqueId, @NumeroAsientos);
	SELECT @TeatroId = Bloques.IdTeatro FROM Bloques WHERE Bloques.Id = @BloqueId;
	UPDATE Teatros SET Capacidad = Capacidad + @NumeroAsientos WHERE Id = @TeatroId;
GO
DENY ALTER ON [dbo].[CreateFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateFilas] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateFilas] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreatePresentacion]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreatePresentacion]
@IdProd int,
@Id int,
@Fecha Date,
@Hora Time

AS
	INSERT INTO Presentaciones(ProduccionId,PresentacionId,Fecha,Hora)
	VALUES(@IdProd,@Id,@Fecha,@Hora)

GO
DENY ALTER ON [dbo].[CreatePresentacion] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreatePresentacion] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreatePresentacion] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreatePresentacion] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreatePresentacion] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreatePresentacion] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreatePresentacion] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreatePresentacion] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreatePresentacion] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreatePresentacion] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreatePresentacion] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreatePresentacion] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateProduccion]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateProduccion]
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
DENY ALTER ON [dbo].[CreateProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateProduccion] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateProduccion] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateProduccion] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateProduccion] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateTeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateTeatroAdministradores]
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
DENY ALTER ON [dbo].[CreateTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateTeatroAgentes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateTeatroAgentes] 
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
GO
DENY ALTER ON [dbo].[CreateTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateTeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateTeatros]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateTeatros]
	@Nombre NVARCHAR(30),
	@Capacidad INT,
	@Correo NVARCHAR(30),
	@SitioWeb NVARCHAR(30),
	@TelefonoAdministracion VARCHAR(9),
	@TelefonoBoleteria VARCHAR(9)
AS
	INSERT INTO Teatros(Nombre, Capacidad, Correo, SitioWeb, TelefonoAdministracion, TelefonoBoleteria)
	VALUES(@Nombre, @Capacidad, @Correo, @SitioWeb, @TelefonoAdministracion, @TelefonoBoleteria);
GO
DENY ALTER ON [dbo].[CreateTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatros] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CreateTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[CreateTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[CreateTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[CreateTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[CreateTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[CreateTeatros] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GenerarReporte]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerarReporte]
AS
DECLARE @NumeroAsientos INT;
DECLARE @FECHAACTUAL DATE;
DECLARE @PromedioMonto INT;

SELECT @FECHAACTUAL = CONVERT(DATE,Reservaciones.Fecha),@NumeroAsientos= count(*)
FROM AsientosxReservaciones
INNER JOIN Reservaciones ON (Reservaciones.Id = AsientosxReservaciones.ReservacionId)
WHERE CONVERT(DATE,Reservaciones.Fecha) = CONVERT(DATE,GETDATE())
GROUP BY CONVERT(DATE,Reservaciones.Fecha)

SELECT @FECHAACTUAL = CONVERT(DATE,Reservaciones.Fecha),@PromedioMonto = AVG(BloquePrecios.Monto)
FROM AsientosxReservaciones
INNER JOIN Reservaciones ON (Reservaciones.Id = AsientosxReservaciones.ReservacionId)
INNER JOIN BloquePrecios ON (BloquePrecios.IdBloque = AsientosxReservaciones.BloqueId) AND (BloquePrecios.IdProduccion = Reservaciones.ProduccionId)
WHERE CONVERT(DATE,Reservaciones.Fecha) = CONVERT(DATE,GETDATE())
GROUP BY CONVERT(DATE,Reservaciones.Fecha)

INSERT INTO Reportes (Fecha,AsientosVendidos,PromedioAsientos)
VALUES(GETDATE(),@NumeroAsientos,@PromedioMonto)
GO
DENY ALTER ON [dbo].[GenerarReporte] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GenerarReporte] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GenerarReporte] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GenerarReporte] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GenerarReporte] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GenerarReporte] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GenerarReporte] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GenerarReporte] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GenerarReporte] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GenerarReporte] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GenerarReporte] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GenerarReporte] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GenerarReporte] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GenerarReporte] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GenerarReporte] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GenerarReporte] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GenerarReporte] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GenerarReporte] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GenerarReporte] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GenerarReporte] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByBloqueIdFilas]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByBloqueIdFilas]
@BId INT
AS
SELECT *
FROM Filas
WHERE Filas.BloqueId = @BId
GO
GRANT EXECUTE ON [dbo].[GetByBloqueIdFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByBloqueIdFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByBloqueIdFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByBloqueIdFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByBloqueIdFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByBloqueIdFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByBloqueIdFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByBloqueIdFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByBloqueIdFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByBloqueIdFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByBloqueIdFilas] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByBloqueIdFilas] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] 
	@BloqueId INT,
	@FilaId NVARCHAR(1),
	@ProduccionId INT,
	@PresentacionId INT
AS
	SELECT BloqueId, FilaId, AsientoId
			FROM Asientos
			WHERE BloqueId = @BloqueId AND FilaId = @FilaId
	EXCEPT
	SELECT BloqueId, FilaId, AsientoId
			FROM AsientosxReservaciones
			INNER JOIN Reservaciones ON (Reservaciones.Id = AsientosxReservaciones.ReservacionId)
			WHERE Reservaciones.ProduccionId = @ProduccionId AND Reservaciones.PresentacionId = @PresentacionId
GO
GRANT EXECUTE ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByIdBloque]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByIdBloque]
@BloqId INT,
@ProdId INT
AS
SELECT *
FROM BloquePrecios
WHERE BloquePrecios.IdBloque = @BloqId AND @ProdId = BloquePrecios.IdProduccion
GO
GRANT EXECUTE ON [dbo].[GetByIdBloque] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdBloque] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdBloque] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdBloque] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdBloque] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdBloque] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdBloque] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdBloque] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdBloque] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdBloque] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdBloque] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdBloque] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByIdProduccionBloquePrecios]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByIdProduccionBloquePrecios]
	@IdProduccion INT
	AS
	SELECT IdBloque, IdProduccion, Bloques.Nombre, BloquePrecios.Monto
	FROM BloquePrecios
	INNER JOIN Bloques ON (BloquePrecios.IdBloque = Bloques.Id)
	WHERE BloquePrecios.IdProduccion = @IdProduccion;
GO
GRANT EXECUTE ON [dbo].[GetByIdProduccionBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdProduccionBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdProduccionBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdProduccionBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdProduccionBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdProduccionBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdProduccionBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByIdProduccionEstados]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByIdProduccionEstados]
@Id int
AS
SELECT *
FROM ProduccionEstados
Where Id = @Id
GO
DENY ALTER ON [dbo].[GetByIdProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByIdTeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByIdTeatroAdministradores]
	@Id INT
AS
	SELECT Id, Nombre, Direccion, TelefonoCasa, TelefonoCelular, TelefonoOtro,
		Email, Sexo, FechaNacimiento
	FROM Empleados
	WHERE Empleados.Id = @Id;
GO
DENY ALTER ON [dbo].[GetByIdTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByIdTeatros]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetByIdTeatros]
	@IdTeatro Int
AS
	SELECT * FROM Teatros WHERE Id = @IdTeatro
GO
GRANT EXECUTE ON [dbo].[GetByIdTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByIdTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByIdTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByIdTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByIdTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByIdTeatros] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdTeatros] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByIdTeatros] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByLetraFilas]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByLetraFilas]
	@Letra CHAR,
	@IdBloque INT
AS
	SELECT * FROM Filas WHERE FilaId = @Letra AND BloqueId = @IdBloque;
GO
DENY ALTER ON [dbo].[GetByLetraFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByLetraFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByLetraFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByLetraFilas] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByLetraFilas] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByLetraFilas] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByLetraFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByLetraFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByLetraFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByLetraFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByLetraFilas] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByLetraFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByLetraFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByLetraFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByLetraFilas] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByLetraFilas] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByNombreBloques]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByNombreBloques]
	@NombreBloque NVARCHAR(20),
	@IdTeatro INT
AS
	SELECT * FROM Bloques WHERE Bloques.Nombre = @NombreBloque AND Bloques.IdTeatro = @IdTeatro;
GO
DENY ALTER ON [dbo].[GetByNombreBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreBloques] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByNombreBloques] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreBloques] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByNombreProduccion]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByNombreProduccion]	
@nombre nvarchar(30)
AS
SELECT *
FROM Producciones
WHERE nombre =  @nombre
GO
DENY ALTER ON [dbo].[GetByNombreProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreProduccion] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByNombreProduccion] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreProduccion] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByNombreTeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByNombreTeatroAdministradores]
	@Nombre VARCHAR(30)
AS
	SELECT Id, Nombre, Direccion, TelefonoCasa, TelefonoCelular, TelefonoOtro,
		Email, Sexo, FechaNacimiento
	FROM Empleados
	WHERE Empleados.Nombre = @Nombre;
GO
DENY ALTER ON [dbo].[GetByNombreTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByNombreTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByNombreTeatros]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetByNombreTeatros]
	@NombreTeatro VARCHAR(30)
AS
	SELECT * FROM Teatros WHERE Nombre = @NombreTeatro;
GO
DENY ALTER ON [dbo].[GetByNombreTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatros] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatros] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByNombreTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByNombreTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByNombreTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByNombreTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByNombreTeatros] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByNombreTeatros] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByProdIdBloquePrecios]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByProdIdBloquePrecios]
@ProdId INT
AS
SELECT * ,Bloques.Nombre as BloqueNombre , Bloques.Id as BloqueId
FROM BloquePrecios
INNER JOIN Bloques ON (Bloques.Id = BloquePrecios.IdBloque)
WHERE BloquePrecios.IdProduccion = @ProdId
GO
GRANT EXECUTE ON [dbo].[GetByProdIdBloquePrecios] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProdIdBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProdIdBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProdIdBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProdIdBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProdIdBloquePrecios] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByProdIdBloquePrecios] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByProduccionIdPresentaciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetByProduccionIdPresentaciones]
@Id int
AS
SELECT *
FROM Presentaciones
WHERE ProduccionId = @Id
Order by Fecha,Hora
GO
DENY ALTER ON [dbo].[GetByProduccionIdPresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProduccionIdPresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProduccionIdPresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProduccionIdPresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProduccionIdPresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProduccionIdPresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProduccionIdPresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProduccionIdPresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProduccionIdPresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProduccionIdPresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProduccionIdPresentaciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByProduccionIdPresentacionView]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByProduccionIdPresentacionView]
@PId INT
AS
SELECT *
FROM ViewPresentacionesDisponibles
WHERE ViewPresentacionesDisponibles.ProduccionId = @PId 
GO
GRANT EXECUTE ON [dbo].[GetByProduccionIdPresentacionView] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProduccionIdPresentacionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProduccionIdPresentacionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProduccionIdPresentacionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProduccionIdPresentacionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProduccionIdPresentacionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByProduccionIdPresentacionView] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByTeatroIdBloques]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByTeatroIdBloques]
	@IdTeatro INT
AS 
	SELECT Id, Nombre, IdTeatro
	FROM Bloques WHERE Bloques.IdTeatro = @IdTeatro;
GO
DENY ALTER ON [dbo].[GetByTeatroIdBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByTeatroIdBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByTeatroIdBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByTeatroIdBloques] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByTeatroIdBloques] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByTeatroIdBloques] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByTeatroIdBloques] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByTeatroIdBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByTeatroIdBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByTeatroIdBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByTeatroIdBloques] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByTeatroIdBloques] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByTeatroIdProduccionView]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByTeatroIdProduccionView]
@TId INT
AS
SELECT *
FROM ViewProduccionesDisponibles
WHERE ViewProduccionesDisponibles.TeatroId = @TId
GO
GRANT EXECUTE ON [dbo].[GetByTeatroIdProduccionView] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByTeatroIdProduccionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByTeatroIdProduccionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByTeatroIdProduccionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByTeatroIdProduccionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByTeatroIdProduccionView] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByTeatroIdProduccionView] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByUsernameSistemaAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByUsernameSistemaAdministradores]
	@Username VARCHAR(20)
AS
	SELECT * 
	FROM SistemaAdministradores
	INNER JOIN Empleados ON (SistemaAdministradores.Id = Empleados.Id)
	WHERE Usuario = @Username;
GO
DENY ALTER ON [dbo].[GetByUsernameSistemaAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsernameSistemaAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsernameSistemaAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsernameSistemaAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsernameSistemaAdministradores] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByUsernameSistemaAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsernameSistemaAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByUsuarioAgente]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByUsuarioAgente]
@username nvarchar(30)
AS
	SELECT *
	FROM Empleados
	INNER JOIN TeatroAgentes on (Empleados.Id = TeatroAgentes.Id)
	WHERE Usuario= @username
GO
DENY ALTER ON [dbo].[GetByUsuarioAgente] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioAgente] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioAgente] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioAgente] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioAgente] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsuarioAgente] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioAgente] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioAgente] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioAgente] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioAgente] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsuarioAgente] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioAgente] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioAgente] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioAgente] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioAgente] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByUsuarioAgente] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetByUsuarioTeatroAdministradores]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByUsuarioTeatroAdministradores]
	@Usuario VARCHAR(20)
AS
	SELECT *
	FROM Empleados INNER JOIN TeatroAdministradores ON (Empleados.Id = TeatroAdministradores.Id)
	WHERE Empleados.Usuario = @Usuario;
GO
DENY ALTER ON [dbo].[GetByUsuarioTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioTeatroAdministradores] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsuarioTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioTeatroAdministradores] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetByUsuarioTeatroAdministradores] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetPresentacionesDisponibles]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPresentacionesDisponibles]
		@FechaInicial DATE,
		@FechaFinal DATE
	AS
	SELECT ProduccionId, PresentacionId, NombreProduccion, IdTeatro, 
	NombreTeatro,
		Estado, Tipo, Fecha, Hora, Descripcion
	FROM ViewPresentacionesDisponibles
	WHERE Fecha >= @FechaInicial AND Fecha <= @FechaFinal
	ORDER BY NombreProduccion ASC;
GO
GRANT EXECUTE ON [dbo].[GetPresentacionesDisponibles] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetPresentacionesDisponibles] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetPresentacionesDisponibles] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetPresentacionesDisponibles] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetPresentacionesDisponibles] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetPresentacionesDisponibles] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetPresentacionesDisponibles] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetProducciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProducciones]
AS
SELECT * 
FROM Producciones
GO
DENY ALTER ON [dbo].[GetProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProducciones] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetProducciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProducciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetProduccionEstados]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProduccionEstados]
AS
SELECT *
FROM ProduccionEstados
Order by Id 
GO
DENY ALTER ON [dbo].[GetProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionEstados] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionEstados] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetProduccionEstados] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionEstados] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetProduccionesTipos]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProduccionesTipos]
AS
SELECT * 
FROM ProduccionTipos
Order By ID
GO
DENY ALTER ON [dbo].[GetProduccionesTipos] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionesTipos] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionesTipos] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionesTipos] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionesTipos] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProduccionesTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionesTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionesTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionesTipos] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionesTipos] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetProduccionesTipos] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetProduccionesTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetProduccionesTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetProduccionesTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetProduccionesTipos] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetProduccionesTipos] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetTeatros]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTeatros]
AS
	SELECT Id, Nombre, Capacidad, Correo, SitioWeb, TelefonoAdministracion, TelefonoBoleteria
	FROM Teatros;
GO
GRANT EXECUTE ON [dbo].[GetTeatros] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetTeatros] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[GetTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[GetTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[GetTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[GetTeatros] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[GetTeatros] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[GetTeatros] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[RealizarCompraEfectivo]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RealizarCompraEfectivo]
@nombre NVARCHAR(30),
@telefono VARCHAR(9),
@Pago DECIMAL(10,2),
@Asientos TablaAsientos READONLY,
@PId int,
@PSId int,
@Success bit OUTPUT,
@NumAprob DECIMAL(6) OUTPUT ,
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
	SET @Success = 1
	COMMIT TRANSACTION
END 
GO
GRANT EXECUTE ON [dbo].[RealizarCompraEfectivo] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[RealizarCompraEfectivo] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[RealizarCompraEfectivo] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[RealizarCompraEfectivo] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[RealizarCompraEfectivo] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[RealizarCompraEfectivo] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[RealizarCompraEfectivo] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[RealizarCompraEfectivo] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[RealizarCompraEfectivo] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[RealizarCompraEfectivo] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[RealizarCompraEfectivo] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[RealizarCompraEfectivo] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[RealizarCompraTarjeta]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RealizarCompraTarjeta] 
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
	BEGIN TRY
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
	END TRY
	BEGIN CATCH
		IF (@@TRANCOUNT > 0)
	   BEGIN
			ROLLBACK TRANSACTION
			SET @NumAprob = -1
			SET @Success = 0
			SET @DateDone = NULL
	   END 
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END 
GO
GRANT EXECUTE ON [dbo].[RealizarCompraTarjeta] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[RealizarCompraTarjeta] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[RealizarCompraTarjeta] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[RealizarCompraTarjeta] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[RealizarCompraTarjeta] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[RealizarCompraTarjeta] TO [SistemaAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[RealizarCompraTarjeta] TO [TeatroAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[RealizarCompraTarjeta] TO [TeatroAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[RealizarCompraTarjeta] TO [TeatroAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[RealizarCompraTarjeta] TO [TeatroAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[RealizarCompraTarjeta] TO [TeatroAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[RealizarCompraTarjeta] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[UpdateIdEstadoProduccion]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateIdEstadoProduccion]
@Id int,
@Estado int
AS
UPDATE Producciones
SET IdEstado = @Estado
WHERE Id = @Id

GO
DENY ALTER ON [dbo].[UpdateIdEstadoProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[UpdateIdEstadoProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[UpdateIdEstadoProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[UpdateIdEstadoProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[UpdateIdEstadoProduccion] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[UpdateIdEstadoProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[UpdateIdEstadoProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[UpdateIdEstadoProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[UpdateIdEstadoProduccion] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[UpdateIdEstadoProduccion] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[UpdateIdEstadoProduccion] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[ValidateDatePresentaciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateDatePresentaciones]
@IdProd int,
@fecha date,
@hora time
AS
SELECT *
FROM Presentaciones
WHERE ProduccionId = @IdProd AND Fecha = @fecha AND Hora = @hora

GO
DENY ALTER ON [dbo].[ValidateDatePresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateDatePresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateDatePresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateDatePresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateDatePresentaciones] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateDatePresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateDatePresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateDatePresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateDatePresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateDatePresentaciones] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateDatePresentaciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateDatePresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateDatePresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateDatePresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateDatePresentaciones] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateDatePresentaciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[ValidateIdTeatroAgentes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateIdTeatroAgentes] 
@Id int
AS
SELECT *
FROM Empleados
WHERE Id = @ID
GO
DENY ALTER ON [dbo].[ValidateIdTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateIdTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateIdTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateIdTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateIdTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateIdTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateIdTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateIdTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateIdTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateIdTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateIdTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[ValidateNameProducciones]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateNameProducciones]
@Nombre nvarchar(30)
AS
Select *
FROM Producciones
WHERE @Nombre = Nombre
GO
DENY ALTER ON [dbo].[ValidateNameProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateNameProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameProducciones] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateNameProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateNameProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameProducciones] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameProducciones] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateNameProducciones] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateNameProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateNameProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameProducciones] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameProducciones] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[ValidateNameTeatroAgentes]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateNameTeatroAgentes]
@Nombre nvarchar(30)
AS
Select *
FROM Empleados
WHERE @Nombre = Nombre
GO
DENY ALTER ON [dbo].[ValidateNameTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateNameTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameTeatroAgentes] TO [PublicoGeneral] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateNameTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameTeatroAgentes] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateNameTeatroAgentes] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  StoredProcedure [dbo].[ValidateUsername]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateUsername]
@Username nvarchar(20)
AS
Select *
FROM Empleados
WHERE @Username = usuario
GO
DENY ALTER ON [dbo].[ValidateUsername] TO [PublicoGeneral] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateUsername] TO [PublicoGeneral] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateUsername] TO [PublicoGeneral] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateUsername] TO [PublicoGeneral] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateUsername] TO [PublicoGeneral] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateUsername] TO [SistemaAdministradores] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ValidateUsername] TO [TeatroAdministradores] AS [dbo]
GO
DENY ALTER ON [dbo].[ValidateUsername] TO [TeatroAgentes] AS [dbo]
GO
DENY CONTROL ON [dbo].[ValidateUsername] TO [TeatroAgentes] AS [dbo]
GO
DENY EXECUTE ON [dbo].[ValidateUsername] TO [TeatroAgentes] AS [dbo]
GO
DENY TAKE OWNERSHIP ON [dbo].[ValidateUsername] TO [TeatroAgentes] AS [dbo]
GO
DENY VIEW DEFINITION ON [dbo].[ValidateUsername] TO [TeatroAgentes] AS [dbo]
GO
/****** Object:  Trigger [dbo].[Trg_FilasIns]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Trg_FilasIns]
	ON [dbo].[Filas]
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
GO
ALTER TABLE [dbo].[Filas] ENABLE TRIGGER [Trg_FilasIns]
GO
/****** Object:  Trigger [dbo].[Trg_EstadoProdMod]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Trg_EstadoProdMod] on [dbo].[Producciones] 
FOR Update
AS
	Declare @mensaje nvarchar(50);
	DECLARE @estado int;
	DECLARE @PId int;
	SELECT @estado = inserted.IdEstado ,
	@PId = inserted.Id
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
	WHERE (Producciones.IdEstado = 5 OR Producciones.IdEstado= 6) AND Producciones.Id = @PId
	
GO
ALTER TABLE [dbo].[Producciones] ENABLE TRIGGER [Trg_EstadoProdMod]
GO
/****** Object:  Trigger [dbo].[Trg_SistemaAdministradoresInsUpd]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
ALTER TABLE [dbo].[SistemaAdministradores] ENABLE TRIGGER [Trg_SistemaAdministradoresInsUpd]
GO
/****** Object:  Trigger [dbo].[Trg_TeatroAdministradoresInsUpd]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
ALTER TABLE [dbo].[TeatroAdministradores] ENABLE TRIGGER [Trg_TeatroAdministradoresInsUpd]
GO
/****** Object:  Trigger [dbo].[Trg_TeatroAgentesInsUpd]    Script Date: 7/27/2020 8:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
ALTER TABLE [dbo].[TeatroAgentes] ENABLE TRIGGER [Trg_TeatroAgentesInsUpd]
GO
USE [master]
GO
ALTER DATABASE [SISTEMA_TEATROS] SET  READ_WRITE 
GO
