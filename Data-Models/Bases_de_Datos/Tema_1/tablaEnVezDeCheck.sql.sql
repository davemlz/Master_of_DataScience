---------------------------------------------------------------------------------------------------------
-- Primeros pasos en SQLite: Ejemplo de tabla en vez de CHECK
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------


-- Tabla que almacena los tipos de profesor
CREATE TABLE TipoProfesor(
	idtipoprofesor int PRIMARY KEY,
	tipo char not null UNIQUE
);

-- Tabla para profesor
CREATE TABLE Profesor(
	idprofesor int PRIMARY KEY,
	dni char not null UNIQUE,
	nombre char not null,
	apellido1 char not null,
	apellido2 char null,
	idtipoprofesor int not null,
	email char not null UNIQUE,
	fechaNacimiento date not null,
	fechaAlta date not null,
           CHECK (fechaAlta>fechaNacimiento),
           FOREIGN KEY (idtipoprofesor) REFERENCES TipoProfesor(idtipoprofesor),
           CHECK (email LIKE ('%@%'))
);



-- Inserción de tipos de profesor
INSERT INTO TipoProfesor (idtipoprofesor, tipo)
			VALUES(1,'Ayudante');
INSERT INTO TipoProfesor (idtipoprofesor, tipo)
			VALUES(2, 'AyudanteDoctor');


-- Tabla que almacena la relación entre dueños y mascotas, permitiendo que una mascota pertenezca a varios dueños y viceversa
INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, idtipoprofesor, email, fechaNacimiento, fechaAlta)
VALUES (1, '76576589J', 'Manuel', 'Váquez', 'De la Sierra', 2, 'manu@kmail.com','1990-01-02','2016-06-07');

INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, idtipoprofesor, email, fechaNacimiento, fechaAlta)
VALUES (2, '78576182V', 'John', 'Doe', NULL, 1,'john@kmail.com','1992-01-02','2015-12-07');



-- Consulta de los profesores junto con los datos de sus categorias
SELECT p.*, t.tipo from profesor p inner join tipoprofesor t on p.idtipoprofesor = t.idtipoprofesor;
