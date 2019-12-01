---------------------------------------------------------------------------------------------------------
-- Resolución del Ejercicio 1 - Tema 1
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------



-- Tabla para profesor para hacer referencia desde la tabla PlanEstudios
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




-- 1. Tabla que almacena los tipos de planes de estudio
CREATE TABLE areaPlanEstudio(
idareaplan int not null primary key,
nombrearea char not null unique);

-- 2. Inserción de las 5 áreas iniciales
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (1,'Ciencias');
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (2,'Humanidades');
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (3,'CienciasSociales');
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (4,'CienciasSalud');
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (5,'Ingeniería');

-- 3. Nueva tabla de planes de estudio, que referencia a la del punto 1
CREATE TABLE PlanEstudios(
    idplan int primary key,
    nombre char not null unique,
    creditos int not null,
    area int not null,
    fechaAlta date not null,
    fechaBaja date null,
    idprofesor int not null,
    check(creditos>=60 and creditos<=120),
    check(fechaAlta<fechaBaja),
    foreign key (idprofesor) references Profesor(idprofesor),
    foreign key (area) references areaPlanEstudio(idareaplan)
);



-- 4. Inserción de tres planes de estudios válidos
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(1,'Plan1',90,1,'2018-09-10',NULL, 1);
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(2,'Plan2',90,2,'2018-09-10',NULL, 1);
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(3,'Plan3',60,3,'2018-09-10',NULL, 2); 


-- 5. Creación de un nuevo área para los planes de estudio, y asignación a un plan
INSERT INTO areaPlanEstudio(idareaplan, nombrearea) VALUES (6,'Derecho');
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',60,6,'2018-09-10',NULL, 2); 