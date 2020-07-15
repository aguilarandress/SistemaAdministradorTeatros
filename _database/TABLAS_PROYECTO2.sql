USE SISTEMA_TEATROS;

-- CREAR TABLA TEATRO
CREATE TABLE Teatros (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre nVARCHAR(30) NOT NULL,
	Telefono nVARCHAR(9) NOT NULL,
	Capacidad INT NOT NULL,
	Correo nVARCHAR(30) NOT NULL,
	SitioWeb nVARCHAR(30) NOT NULL
		CONSTRAINT PkTeatros_Id PRIMARY KEY(Id),
		CONSTRAINT UnTeatros_Nombre UNIQUE(Nombre)
);

CREATE TABLE SistemaAdministradores (
	Id INT NOT NULL,
	Nombre nVARCHAR(30) NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Sexo CHAR NOT NULL,
	Direccion VARCHAR(40) NOT NULL,
	TelefonoCasa VARCHAR(9),
	TelefonoCelular VARCHAR(9),
	TelefonoOtro VARCHAR(9),
	Email nVARCHAR(20) NOT NULL,
	Usuario nVARCHAR(20) NOT NULL,
	Password CHAR(60) NOT NULL
		CONSTRAINT PkSistemaAdministradores_Id PRIMARY KEY(Id),
		CONSTRAINT UnSistemaAdministradores_Nombre UNIQUE(Nombre),
		CONSTRAINT UnSistemaAdministradores_Usuario UNIQUE(Usuario)
);

CREATE TABLE TeatroAdministradores (
    Id INT NOT NULL,
    Nombre nVARCHAR(30) NOT NULL,
    IdTeatro INT NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR NOT NULL,
    Direccion nVARCHAR(40) NOT NULL,
    TelefonoCasa VARCHAR(9),
    TelefonoCelular VARCHAR(9),
    TelefonoOtro VARCHAR(9),
    Email nVARCHAR(20) NOT NULL,
    Usuario nVARCHAR(20) NOT NULL,
    Password CHAR(60) NOT NULL
        CONSTRAINT PkTeatroAdministradores PRIMARY KEY(Id),
        CONSTRAINT UnTeatroAdministradores_Nombre UNIQUE(Nombre),
        CONSTRAINT UnTeatroAdministradores_Usuario UNIQUE(Usuario),
        CONSTRAINT FkTeatroAdministradores_IdTeatro
              FOREIGN KEY (IdTeatro) REFERENCES Teatros(Id)
);

CREATE TABLE TeatroAgentes (
    Id INT NOT NULL,
    Nombre nVARCHAR(30) NOT NULL,
    IdTeatro INT NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR NOT NULL,
    Direccion nVARCHAR(40) NOT NULL,
    TelefonoCasa VARCHAR(9),
    TelefonoCelular VARCHAR(9),
    TelefonoOtro VARCHAR(9),
    Email nVARCHAR(20) NOT NULL,
    Usuario nVARCHAR(20) NOT NULL,
    Password CHAR(60) NOT NULL
        CONSTRAINT PkTeatroAgentes PRIMARY KEY(Id),
        CONSTRAINT UnTeatroAgentes_Nombre UNIQUE(Nombre),
        CONSTRAINT UnTeatroAgentes_Usuario UNIQUE(Usuario),
        CONSTRAINT FkTeatroAgentes_IdTeatro
            FOREIGN KEY (IdTeatro) REFERENCES Teatros(Id)
);

CREATE TABLE ProduccionEstados (
	Id INT IDENTITY (1, 1) NOT NULL,
	Nombre nVARCHAR(30) NOT NULL
		CONSTRAINT PkProduccionEstados_Id PRIMARY KEY(Id),
		CONSTRAINT UnProduccionEstados_Nombre UNIQUE(Nombre)
);

CREATE TABLE ProduccionTipos (
	Id INT IDENTITY (1, 1) NOT NULL,
	Nombre nVARCHAR(30) NOT NULL
		CONSTRAINT PkProduccionTipos_Id PRIMARY KEY(Id),
		CONSTRAINT UnProduccionTipos_Nombre UNIQUE(Nombre)
);

CREATE TABLE Producciones (
	Id INT IDENTITY(1, 1) NOT NULL,
	Descripcion TEXT NOT NULL,
	FechaFinal DATE NOT NULL,
	FechaInicial DATE NOT NULL,
	Nombre nVARCHAR(30) NOT NULL,
	IdEstado INT NOT NULL,
	IdTeatro INT NOT NULL,
	IdTipo INT NOT NULL
		-- LLAVES
		CONSTRAINT PkProducciones_Id PRIMARY KEY(Id),
		CONSTRAINT FkProducciones_IdEstado 
				FOREIGN KEY (IdEstado) REFERENCES ProduccionEstados(Id),
		CONSTRAINT FkProducciones_IdTipo
			FOREIGN KEY (IdTipo) REFERENCES ProduccionTipos(Id),
		CONSTRAINT FkProducciones_IdTeatro
				FOREIGN KEY (IdTeatro) REFERENCES Teatros(Id),
		CONSTRAINT UnProducciones_Nombre UNIQUE(Nombre)
);

CREATE TABLE Presentaciones (
	PresentacionId INT NOT NULL,
	ProduccionId INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
		CONSTRAINT PkPresentaciones_Id PRIMARY KEY(ProduccionId, PresentacionId),
		CONSTRAINT FkPresentaciones_IdProduccion
			FOREIGN KEY (ProduccionId) REFERENCES Producciones(Id)
);

CREATE TABLE Bloques (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre nVARCHAR(20) NOT NULL,
	IdTeatro INT NOT NULL
		CONSTRAINT PkBloques_Id PRIMARY KEY(Id),
		CONSTRAINT FkBloques_IdTeatro
			FOREIGN KEY (IdTeatro) REFERENCES Teatros(Id)
);

CREATE TABLE BloquePrecios (
	Id INT IDENTITY (1, 1) NOT NULL,
	Monto DECIMAL(10, 2) NOT NULL,
	IdBloque INT NOT NULL,
	IdProduccion INT NOT NULL,
		CONSTRAINT PkBloquePrecios_Id PRIMARY KEY (Id),
		CONSTRAINT FkBloquePrecios_IdBloque
			FOREIGN KEY (IdBloque) REFERENCES Bloques(Id),
		CONSTRAINT FkBloquePrecios_IdProduccion
			FOREIGN KEY (IdProduccion) REFERENCES Producciones(Id),
		CONSTRAINT UnBloquePrecios_BloqueProduccion UNIQUE(IdBloque, IdProduccion)
);

CREATE TABLE Filas (
	FilaId CHAR NOT NULL,
	BloqueId INT NOT NULL,
	NumeroAsientos INT NOT NULL
		CONSTRAINT PkFilas_Id PRIMARY KEY (BloqueId, FilaId),
		CONSTRAINT FkFilas_IdBloque 
			FOREIGN KEY (BloqueId) REFERENCES Bloques(Id)
);

CREATE TABLE Asientos (
	AsientoId INT NOT NULL,
	FilaId CHAR NOT NULL,
	BloqueId INT NOT NULL
		CONSTRAINT PkAsientos_Id PRIMARY KEY (BloqueId, FilaId, AsientoId),
		CONSTRAINT FkAsientos_IdFilas
			FOREIGN KEY (BloqueId, FilaId) REFERENCES Filas(BloqueId, FilaId)
);


CREATE TABLE Clientes(
      Id INT IDENTITY(1,1) NOT NULL,
      Nombre nvarchar(30) NOT NULL,
      Telefono varchar(9) NOT NULL,
              CONSTRAINT PkClientes_Id
                    PRIMARY KEY(Id),
              CONSTRAINT UnClientes_Nombre 
                    UNIQUE(Nombre),
);

CREATE TABLE Reservaciones(
	Id INT IDENTITY(1,1) NOT NULL,
	Fecha Date NOT NULL,
	IdCliente INT NOT NULL,
	PresentacionId INT NOT NULL
	Constraint PkReservaciones PRIMARY KEY(Id),
	CONSTRAINT FkReservaciones_IdCliente FOREIGN KEY(IdCliente)
		REFERENCES Clientes(Id)
);

Create Table AsientosxReservaciones(
    AsientoId INT NOT NULL,
	FilaId CHAR NOT NULL,
	BloqueId INT NOT NULL,
	ReservacionId INT NOT NULL,
	CONSTRAINT PkAsientosxReservaciones_Id PRIMARY KEY (BloqueId,FilaId, AsientoId,ReservacionId),
	CONSTRAINT FkAsientosxReservaciones_IdAsientos 
		FOREIGN KEY (BloqueId, FilaId, AsientoId) REFERENCES Asientos(BloqueId, FilaId, AsientoId),
	CONSTRAINT FkAsientosxReservaciones_IdReservaciones
		FOREIGN KEY (ReservacionId) REFERENCES Reservaciones(Id)
);







