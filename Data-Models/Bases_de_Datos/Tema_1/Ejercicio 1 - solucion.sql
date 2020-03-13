---------------------------------------------------------------------------------------------------------
-- Resolución del Ejercicio 1 - Tema 1
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2019-2020
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------



-- Tabla para profesor para hacer referencia desde la tabla PlanEstudios
CREATE TABLE Profesor(
	idprofesor int PRIMARY KEY,
	dni char not null UNIQUE,
	nombre char not null,
	apellido1 char not null,
	apellido2 char null,
	tipoprofesor char not null,
	email char not null UNIQUE,
	fechaNacimiento date not null,
	fechaAlta date not null,
           CHECK (fechaAlta>fechaNacimiento),
           CHECK (email LIKE ('%@%')),
           CHECK (tipoprofesor IN ('Ayudante','AyudanteDoctor','Catedrático','Titular','ContratadoDoctor'))
);


-- Inserción de dos profesores
INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, tipoprofesor, email, fechaNacimiento, fechaAlta)
VALUES (1, '76576589J', 'Manuel', 'Váquez', 'De la Sierra', 'Ayudante', 'manu@kmail.com','1990-01-02','2016-06-07');

INSERT INTO Profesor (idprofesor, dni, nombre, apellido1, apellido2, tipoprofesor, email, fechaNacimiento, fechaAlta)
VALUES (2, '78576182V', 'John', 'Doe', NULL, 'AyudanteDoctor','john@kmail.com','1992-01-02','2015-12-07');



-- 1. Tabla para almacenar los planes de estudio
CREATE TABLE PlanEstudios(
    idplan int primary key,
    nombre char not null unique,
    creditos int not null,
    area char not null,
    fechaAlta date not null,
    fechaBaja date null,
    idprofesor int not null,
    check(creditos>=60 and creditos<=120),
    check(fechaAlta<fechaBaja),
    check (area in ('Ciencias','Humanidades', 'CienciasSociales', 'Ingenieria', 'CienciasSalud')),
    foreign key (idprofesor) references Profesor(idprofesor)
);



-- 2. Inserción de tres planes de estudios válidos (cumplen todas las restricciones)
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(1,'Plan1',90,'Ciencias','2018-09-10',NULL, 1);
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(2,'Plan2',90,'Ciencias','2018-09-10',NULL, 1);
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(3,'Plan3',60,'Ciencias','2018-09-10',NULL, 2); 

--  3. Inserciones que no cumplen las restricciones:

-- Un plan con un valor nulo en una columna que no admite nulos
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',90,'Ciencias',NULL,NULL, 1);
-- Un plan que tenga un identificador ya existente en otra fila
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(3,'Plan4',90,'Ciencias','2018-09-10',NULL, 1);
-- Un plan que tenga el mismo nombre que otro ya insertado.
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan3',90,'Ciencias','2018-09-10',NULL, 1);
-- Un plan cuya área de conocimiento sea “derecho”
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',90,'Derecho','2018-09-10',NULL, 1);
-- Un plan cuyo número de créditos sea mayor de 120, y otro menor de 60.
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',121,'Ciencias','2018-09-10',NULL, 1);
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',59,'Ciencias','2018-09-10',NULL, 1);
-- Un plan cuyo profesor responsable no exista en la tabla que almacena los profesores.
insert into PlanEstudios(idplan, nombre, creditos, area, fechaAlta, fechaBaja, idprofesor)
    values(4,'Plan4',90,'Ciencias','2018-09-10',NULL, 3);