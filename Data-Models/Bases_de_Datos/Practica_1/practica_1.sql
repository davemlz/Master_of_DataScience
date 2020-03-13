-- Integrantes:
-- Javier Alonso del Saso
-- Ana Gonzalez Guerra
-- Silvia Magdalena Lopez Monzo
-- David Montero Loaiza

-- Punto 1. Crear la tabla Director

CREATE TABLE Director(

    iddirector INT,
    dni CHAR NOT NULL,
    nombre CHAR NOT NULL,
    apellido1 CHAR NOT NULL,
    apellido2 CHAR,
    fechaNacimiento DATE NOT NULL,
    fechaRegistro DATE NOT NULL,
    fechaDeceso DATE,
    enActivo BOOLEAN NOT NULL,
    
    PRIMARY KEY(iddirector),
    UNIQUE(dni),
    CHECK(iddirector > 0),
    CHECK(fechaRegistro > fechaNacimiento),
    CHECK(fechaDeceso > fechaNacimiento),
    CHECK(enActivo IN (0,1))

);

-- Punto 2. Crear la tabla Pelicula

CREATE TABLE Pelicula(

    idpelicula INT,
    titulo CHAR NOT NULL,    
    fechaEstreno DATE NOT NULL,
    duracionMin REAL NOT NULL,
    genero CHAR NOT NULL,
    iddirector INT NOT NULL,
    
    PRIMARY KEY(idpelicula),
    FOREIGN KEY (iddirector) REFERENCES Director(iddirector),
    UNIQUE(titulo),
    CHECK(idpelicula > 0),
    CHECK(duracionMin > 0),    
    CHECK(genero IN ('terror','scifi','aventura'))

);

-- Punto 3. 3 filas válidas en ambas tablas

INSERT INTO Director(iddirector,dni,nombre,apellido1,apellido2,fechaNacimiento,fechaRegistro,fechaDeceso,enActivo)
VALUES
(1,'1234','Christopher','Nolan',NULL,'1970-07-30','2019-11-20',NULL,1),
(2,'1235','Timothy Walter','Burton',NULL,'1958-08-25','2019-11-20',NULL,1),
(3,'1236','James Francis','Cameron',NULL,'1954-08-16','2019-11-20',NULL,1);

INSERT INTO Pelicula(idpelicula,titulo,fechaEstreno,duracionMin,genero,iddirector)
VALUES
(1,'Terminator','1984-10-26',108,'scifi',3),
(2,'Avatar','2009-12-10',162,'scifi',3),
(3,'Dunquerke','2017-07-21',106,'aventura',1);

-- Punto 4. Nueva columna en Pelicula de Recaudacion

ALTER TABLE Pelicula ADD recaudacion REAL NOT NULL CHECK(recaudacion >= 0) DEFAULT 0;

-- Punto 5. Almacenar generos de peliculas

DROP TABLE Pelicula;

CREATE TABLE Genero(

    idgenero INT,
    nombre CHAR NOT NULL,
    
    PRIMARY KEY(idgenero),
    UNIQUE(nombre),
    CHECK(idgenero > 0)

);

CREATE TABLE Pelicula(

    idpelicula INT NOT NULL,
    titulo CHAR NOT NULL,    
    fechaEstreno DATE NOT NULL,
    duracionMin REAL NOT NULL,
    idgenero INT NOT NULL,
    iddirector INT NOT NULL,
    
    PRIMARY KEY(idpelicula),
    FOREIGN KEY (iddirector) REFERENCES Director(iddirector),
    FOREIGN KEY (idgenero) REFERENCES Genero(idgenero),
    UNIQUE(titulo),
    CHECK(idpelicula > 0),
    CHECK(duracionMin > 0)    

);

INSERT INTO Genero(idgenero,nombre)
VALUES
(1,'Terror'),
(2,'Scifi'),
(3,'Aventura');

INSERT INTO Pelicula(idpelicula,titulo,fechaEstreno,duracionMin,idgenero,iddirector)
VALUES
(1,'Terminator','1984-10-26',108,2,3),
(2,'Avatar','2009-12-10',162,2,3),
(3,'Dunquerke','2017-07-21',106,3,1);

-- Insertar nuevo genero

INSERT INTO Genero(idgenero,nombre)
VALUES
(4,'drama'),
(5,'suspenso');

-- Punto 6. Crear la tabla Actor y tablas que relacionen actores con peliculas

CREATE TABLE Actor(

    idactor INT,
    dni CHAR NOT NULL,
    nombre CHAR NOT NULL,
    apellido1 CHAR NOT NULL,
    apellido2 CHAR,
    fechaNacimiento DATE NOT NULL,
    fechaRegistro DATE NOT NULL,
    fechaDeceso DATE,
    enActivo BOOLEAN NOT NULL,
    
    PRIMARY KEY(idactor),
    UNIQUE(dni),
    CHECK(idactor > 0),
    CHECK(fechaRegistro > fechaNacimiento),
    CHECK(fechaDeceso > fechaNacimiento),
    CHECK(enActivo IN (0,1))

);

CREATE TABLE Reparto(

    idpelicula INT NOT NULL,
    idactor INT NOT NULL,
    
    FOREIGN KEY(idpelicula) REFERENCES Pelicula(idpelicula),
    FOREIGN KEY(idactor) REFERENCES Actor(idactor),
    PRIMARY KEY(idpelicula,idactor)

);

INSERT INTO Actor(idactor,dni,nombre,apellido1,apellido2,fechaNacimiento,fechaRegistro,fechaDeceso,enActivo)
VALUES
(1,'1234','Silvia','Lopez','Monzo','1997-11-15','2019-11-20',NULL,1),
(2,'1235','Ana','Gonzalez','Guerra','1997-10-10','2019-11-20',NULL,1),
(3,'1236','Javier','Alonso','Del Saso','1997-02-26','2019-11-20',NULL,1);

INSERT INTO Reparto(idpelicula,idactor)
VALUES
(3,1),
(2,2),
(2,3),
(1,2);