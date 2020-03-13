---------------------------------------------------------------------------------------------------------
-- Primeros pasos en SQLite: Ejemplo de relación N a N
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------

-- Tabla para dueños de mascotas
CREATE TABLE duenio(
 idduenio int PRIMARY KEY,
 nombre char NOT NULL,
 apellido1 char NOT NULL,
 apellido2 char NULL
);

-- Tabla de mascotas
CREATE TABLE mascota(
 idmascota int PRIMARY KEY,
 nombre char NOT NULL
);

-- Tabla que almacena la relación entre dueños y mascotas, permitiendo que una mascota pertenezca a varios dueños y viceversa
CREATE TABLE mascotaDuenio(
 idmascota int NOT NULL,
 idduenio int NOT NULL,
 FOREIGN KEY (idmascota) REFERENCES mascota(idmascota),
 FOREIGN KEY (idduenio) REFERENCES duenio(idduenio),
 PRIMARY KEY (idmascota,idduenio)
);



-- Inserción de datos en las tablas
INSERT INTO duenio (idduenio, nombre, apellido1, apellido2)
	VALUES(1, 'Marco', 'Polo', NULL);
INSERT INTO duenio (idduenio, nombre, apellido1, apellido2)
	VALUES(2, 'Mariano', 'Zapatero', 'Suárez');
	
INSERT INTO mascota (idmascota, nombre)
	VALUES(1, 'Toby');
INSERT INTO mascota (idmascota, nombre)
	VALUES(2, 'Balto');
INSERT INTO mascota (idmascota, nombre)
	VALUES(3, 'Jake the dog');

INSERT INTO MascotaDuenio(idmascota, idduenio)
	VALUES(1, 1);
INSERT INTO MascotaDuenio(idmascota, idduenio)
	VALUES(1, 2);
INSERT INTO MascotaDuenio(idmascota, idduenio)
	VALUES(2, 1);
	
	
-- Ejemplo de consulta de los datos de los dueños junto con los datos de sus mascotas
SELECT d.*, m.idmascota, m.nombre 
	from duenio d inner join mascotaduenio md on d.idduenio = md.idduenio
			inner join mascota m on m.idmascota = md.idmascota;
