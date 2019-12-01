---------------------------------------------------------------------------------------------------------
-- Estructura de base de datos para consultas en SQLite
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------


CREATE TABLE Proveedores (
  codigpro	  CHAR(4)    NOT NULL    CONSTRAINT id_pro PRIMARY KEY,
  cifpro      CHAR(12)   NOT NULL    CONSTRAINT u_cif UNIQUE,
  nombrpro    CHAR(30)   NOT NULL,
  direcpro	  CHAR(30)   NOT NULL,
  cpostpro	  CHAR(5)	 NOT NULL,
  localpro	  CHAR(20)   NOT NULL,
  telefpro	  CHAR(17)   NOT NULL,
  faxpro	  CHAR(17),
  emailpro    CHAR(25),   
  procepro	  CHAR(5)  NOT NULL CHECK (procepro in ('UE', 'No UE')));

CREATE TABLE Articulos (
	codigart	CHAR(6)  NOT NULL    CONSTRAINT id_art PRIMARY KEY,
	descrart	CHAR(40) NOT NULL,
	preunart	DECIMAL(9,2)	 NOT NULL,
	stockart	INTEGER  NOT NULL check (stockart >=0),
	stockmin	INTEGER  NOT NULL check (stockmin >=0),
    fecbaja     DATE);

CREATE TABLE Pedidos (
	numped 		INTEGER  	 NOT NULL   CONSTRAINT id_ped PRIMARY KEY,
	fechaped	DATE	NOT NULL,
	codigpro	CHAR(4)	  	 NOT NULL,
	ivaped		DECIMAL(4,1) NOT NULL CHECK (ivaped>0 and ivaped<100),
	fentrped	DATE		 NOT NULL,
           CONSTRAINT f_pro FOREIGN KEY (codigpro) REFERENCES Proveedores (codigpro),
           CONSTRAINT c_fecha CHECK (fechaped<=fentrped));


CREATE TABLE Lineas (
	numped		INTEGER		 NOT NULL,
	numlin		SMALLINT	 NOT NULL,
	codigart	CHAR(6)		 NOT NULL,
	unilin		DECIMAL(6,0) NOT NULL,
	preunlin	DECIMAL(9,2) NOT NULL,
	desculin	DECIMAL(4,1) NOT NULL CHECK (desculin>=0 and desculin<=100),	
          CONSTRAINT id_lin PRIMARY KEY (numped, numlin),
          CONSTRAINT f_ped FOREIGN KEY (numped) REFERENCES Pedidos (numped),
          CONSTRAINT f_art FOREIGN KEY (codigart) REFERENCES Articulos (codigart));


