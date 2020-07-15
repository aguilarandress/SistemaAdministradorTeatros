USE [SISTEMA_TEATROS]
GO
/****** Object:  User [app_sysadmin]    Script Date: 15/7/2020 17:32:20 ******/
CREATE USER [app_sysadmin] FOR LOGIN [app_sysadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [app_teatroadmin]    Script Date: 15/7/2020 17:32:20 ******/
CREATE USER [app_teatroadmin] FOR LOGIN [app_teatroadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [app_sysadmin]
GO
ALTER ROLE [db_owner] ADD MEMBER [app_teatroadmin]
GO
/****** Object:  Table [dbo].[Asientos]    Script Date: 15/7/2020 17:32:20 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AsientosxReservaciones]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BloquePrecios]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bloques]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Filas]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producciones]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduccionEstados]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduccionTipos]    Script Date: 15/7/2020 17:32:21 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservaciones]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[IdCliente] [int] NOT NULL,
	[PresentacionId] [int] NOT NULL,
 CONSTRAINT [PkReservaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SistemaAdministradores]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SistemaAdministradores](
	[Id] [int] NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Direccion] [varchar](40) NOT NULL,
	[TelefonoCasa] [varchar](9) NULL,
	[TelefonoCelular] [varchar](9) NULL,
	[TelefonoOtro] [varchar](9) NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Usuario] [nvarchar](20) NOT NULL,
	[Password] [char](60) NOT NULL,
 CONSTRAINT [PkSistemaAdministradores_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeatroAdministradores]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeatroAdministradores](
	[Id] [int] NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[IdTeatro] [int] NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Direccion] [nvarchar](40) NOT NULL,
	[TelefonoCasa] [varchar](9) NULL,
	[TelefonoCelular] [varchar](9) NULL,
	[TelefonoOtro] [varchar](9) NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Usuario] [nvarchar](20) NOT NULL,
	[Password] [char](60) NOT NULL,
 CONSTRAINT [PkTeatroAdministradores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeatroAgentes]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeatroAgentes](
	[Id] [int] NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[IdTeatro] [int] NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Direccion] [nvarchar](40) NOT NULL,
	[TelefonoCasa] [varchar](9) NULL,
	[TelefonoCelular] [varchar](9) NULL,
	[TelefonoOtro] [varchar](9) NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Usuario] [nvarchar](20) NOT NULL,
	[Password] [char](60) NOT NULL,
 CONSTRAINT [PkTeatroAgentes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teatros]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teatros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Telefono] [nvarchar](9) NOT NULL,
	[Capacidad] [int] NOT NULL,
	[Correo] [nvarchar](30) NOT NULL,
	[SitioWeb] [nvarchar](30) NOT NULL,
 CONSTRAINT [PkTeatros_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [UnBloquePrecios_BloqueProduccion]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[BloquePrecios] ADD  CONSTRAINT [UnBloquePrecios_BloqueProduccion] UNIQUE NONCLUSTERED 
(
	[IdBloque] ASC,
	[IdProduccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnClientes_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[Clientes] ADD  CONSTRAINT [UnClientes_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProducciones_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[Producciones] ADD  CONSTRAINT [UnProducciones_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProduccionEstados_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[ProduccionEstados] ADD  CONSTRAINT [UnProduccionEstados_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnProduccionTipos_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[ProduccionTipos] ADD  CONSTRAINT [UnProduccionTipos_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnSistemaAdministradores_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[SistemaAdministradores] ADD  CONSTRAINT [UnSistemaAdministradores_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnSistemaAdministradores_Usuario]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[SistemaAdministradores] ADD  CONSTRAINT [UnSistemaAdministradores_Usuario] UNIQUE NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatroAdministradores_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[TeatroAdministradores] ADD  CONSTRAINT [UnTeatroAdministradores_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatroAdministradores_Usuario]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[TeatroAdministradores] ADD  CONSTRAINT [UnTeatroAdministradores_Usuario] UNIQUE NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatroAgentes_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[TeatroAgentes] ADD  CONSTRAINT [UnTeatroAgentes_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatroAgentes_Usuario]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[TeatroAgentes] ADD  CONSTRAINT [UnTeatroAgentes_Usuario] UNIQUE NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UnTeatros_Nombre]    Script Date: 15/7/2020 17:32:21 ******/
ALTER TABLE [dbo].[Teatros] ADD  CONSTRAINT [UnTeatros_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[BloquePrecios]  WITH CHECK ADD  CONSTRAINT [FkBloquePrecios_IdBloque] FOREIGN KEY([IdBloque])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[BloquePrecios] CHECK CONSTRAINT [FkBloquePrecios_IdBloque]
GO
ALTER TABLE [dbo].[BloquePrecios]  WITH CHECK ADD  CONSTRAINT [FkBloquePrecios_IdProduccion] FOREIGN KEY([IdProduccion])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[BloquePrecios] CHECK CONSTRAINT [FkBloquePrecios_IdProduccion]
GO
ALTER TABLE [dbo].[Bloques]  WITH CHECK ADD  CONSTRAINT [FkBloques_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Bloques] CHECK CONSTRAINT [FkBloques_IdTeatro]
GO
ALTER TABLE [dbo].[Filas]  WITH CHECK ADD  CONSTRAINT [FkFilas_IdBloque] FOREIGN KEY([BloqueId])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[Filas] CHECK CONSTRAINT [FkFilas_IdBloque]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FkPresentaciones_IdProduccion] FOREIGN KEY([ProduccionId])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FkPresentaciones_IdProduccion]
GO
ALTER TABLE [dbo].[Producciones]  WITH CHECK ADD  CONSTRAINT [FkProducciones_IdEstado] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[ProduccionEstados] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdEstado]
GO
ALTER TABLE [dbo].[Producciones]  WITH CHECK ADD  CONSTRAINT [FkProducciones_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdTeatro]
GO
ALTER TABLE [dbo].[Producciones]  WITH CHECK ADD  CONSTRAINT [FkProducciones_IdTipo] FOREIGN KEY([IdTipo])
REFERENCES [dbo].[ProduccionTipos] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FkProducciones_IdTipo]
GO
ALTER TABLE [dbo].[Reservaciones]  WITH CHECK ADD  CONSTRAINT [FkReservaciones_IdCliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([Id])
GO
ALTER TABLE [dbo].[Reservaciones] CHECK CONSTRAINT [FkReservaciones_IdCliente]
GO
ALTER TABLE [dbo].[TeatroAdministradores]  WITH CHECK ADD  CONSTRAINT [FkTeatroAdministradores_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[TeatroAdministradores] CHECK CONSTRAINT [FkTeatroAdministradores_IdTeatro]
GO
ALTER TABLE [dbo].[TeatroAgentes]  WITH CHECK ADD  CONSTRAINT [FkTeatroAgentes_IdTeatro] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[TeatroAgentes] CHECK CONSTRAINT [FkTeatroAgentes_IdTeatro]
GO
/****** Object:  StoredProcedure [dbo].[GetByUsernameSistemaAdministradores]    Script Date: 15/7/2020 17:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByUsernameSistemaAdministradores]
	@Username VARCHAR(20)
AS
	SELECT * FROM SistemaAdministradores WHERE Usuario = @Username;
GO
