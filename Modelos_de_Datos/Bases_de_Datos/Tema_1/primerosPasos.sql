---------------------------------------------------------------------------------------------------------
-- Primeros pasos en SQLite: Ejemplo de creación de tablas (CREATE), inserción de datos (INSERT) y modificación de tablas (ALTER)
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------


-- Tabla que almacena los datos de los profesores
CREATE TABLE Profesor(
	idprofesor int PRIMARY KEY,
	dni char not null UNIQUE,
	nombre char not null,
	apellido1 char not null,
	apellido2 char null,
	tipoProfesor char not null,
	email char not null UNIQUE,
	fechaNacimiento date not null,
	fechaAlta date not null,
           CHECK (fechaAlta>fechaNacimiento),
           CHECK (tipoProfesor IN ('Ayudante', 'AyudanteDoctor', 'Titular')),
           CHECK (email LIKE '%@%')
);


-- Inserción de datos en la tabla Profesor
INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, tipoProfesor, email, fechaNacimiento, fechaAlta)
    VALUES (1, '76576589J', 'Manuel', 'Váquez', 'De la Sierra', 'Ayudante', 'manu@kmail.com','1990-01-02','2016-06-07');
INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, tipoProfesor, email, fechaNacimiento, fechaAlta)
    VALUES (2, '78576182V', 'John', 'Doe', NULL, 'AyudanteDoctor', 'john@kmail.com','1992-01-02','2015-12-07');
    
-- Consula de datos de la tabla profesor
SELECT * FROM Profesor;



-- EJEMPLO de FK con dos tablas
CREATE TABLE duenio(
idduenio int PRIMARY KEY,
nombre char NOT NULL,
apellido1 char NOT NULL,
apellido2 char NULL
);

CREATE TABLE mascota(
idmascota int PRIMARY KEY,
nombre char NOT NULL,
idduenio int NOT NULL,
FOREIGN KEY (idduenio) REFERENCES duenio(idduenio)
);


INSERT INTO duenio (idduenio, nombre, apellido1, apellido2)
    VALUES(1, 'Marco', 'Polo', NULL);
INSERT INTO duenio (idduenio, nombre, apellido1, apellido2)
    VALUES(2, 'Mariano', 'Zapatero', 'Suárez');  

INSERT INTO mascota (idmascota, nombre, idduenio)
    VALUES(1, 'Toby', 2);
	
	
	
-- ALTER TABLEs
-- Añade una columna llamada "dni" de tipo "char" a los "dueños"
ALTER TABLE mascota ADD genero char NOT NULL CHECK (genero in ('M','F')) DEFAULT 'M';  
    

-- Ejemplo de consulta de los datos de las mascotas junto con los datos de sus dueños
SELECT d.*, m.nombre from duenio d inner join mascota m on m.idduenio = d.idduenio;