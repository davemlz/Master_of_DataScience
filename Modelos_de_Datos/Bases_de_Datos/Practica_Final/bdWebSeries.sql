---------------------------------------------------------------------------------------------------------
-- Base de datos de una plataforma de series online para la práctica final
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------

-- Tabla que contiene los níveles de educación de los usuarios
create table NIVELES_EDUC
(
	idNivel int not null primary key,
	nivelEduc char(30) not null
);

insert into NIVELES_EDUC values (1,'Postgrado');
insert into NIVELES_EDUC values (2, 'Primaria');
insert into NIVELES_EDUC values (3, 'Secundaria');
insert into NIVELES_EDUC values (4, 'FP');
insert into NIVELES_EDUC values (5, 'Universitaria');

-- Tabla que contiene las profesiones de los usuarios
create table PROFESIONES
(
	idProfesion int not null constraint pk_profesiones primary key,
	profesion char(30) not null
);

insert into PROFESIONES values (1, 'Abogado/a');
insert into PROFESIONES values (2, 'Amo/a de casa');
insert into PROFESIONES values (3, 'Arquitecto/a');
insert into PROFESIONES values (4, 'Dependiente/a');
insert into PROFESIONES values (5, 'Desempleado/a');
insert into PROFESIONES values (6, 'Empresario/a');
insert into PROFESIONES values (7, 'Estudiante');
insert into PROFESIONES values (8, 'Funcionario/a');
insert into PROFESIONES values (9, 'Ingeniero/a');
insert into PROFESIONES values (10, 'Jubilado/a');
insert into PROFESIONES values (11, 'Médico');
insert into PROFESIONES values (12, 'Profesor/a');



-- Tabla que almacena los datos de los usuarios
create table USUARIOS
(
	idUsuario int not null constraint pk_usuarios primary key,
	email char(40) not null unique constraint ck_email check (email like '%@%'),
	nombreUsuario char(20) not null unique,
	contraseña char(10) not null,
	nombre char(20) not null,
	apellido1 char(20) not null,
	apellido2 char(20),
	fechaNacimiento date not null,
	fechaReg datetime not null,
	facebook varchar(150),
	twitter varchar(150),
	pais char(10) not null constraint ck_pais check (pais in ('España','Francia','Noruega','Andorra')),
	idProfesion int not null,
	idNivelEducativo int not null,
	constraint fk_usuario_profesion foreign key (idProfesion) references PROFESIONES(idProfesion),
	constraint fk_usuario_nivel foreign key (idNivelEducativo) references NIVELES_EDUC(idNivel)
);

insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(1, 'missgranger@gmail.com', 'HermioneGranger', '123456', 'María', 'López', 'Pérez', '1989-02-19', '2012-01-20', 'España', 12, 5);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(2, 'eli_barrera@gmail.com', 'lisasimpson', '654321', 'Elisa', 'Barrera', 'Martínez', '1992-12-9', '2013-12-20', 'Noruega', 1, 5);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(3, 'gonzalezmar@gmail.com', 'Mafalda', '456789', 'Marisa', 'González', 'García', '12-09-1970', '24-10-2014', 'España', 2, 4);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(4, 'lepetitnicolas@gmail.com', 'PequeñoNicolas', '123321', 'Francisco Nicolás', 'Gómez', 'Iglesias', '25-12-1994', '01-02-2013', 'España', 4,1);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(5, 'fernandogomez@gmail.com', 'Sheldon', '8543712', 'Fernando', 'Gómez', 'Fernández', '16-04-1976',  '23-03-2015', 'España', 5, 2);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(6, 'voldy@gmail.com', 'LordVoldemort', '666666', 'Thomas', 'Riddle', '31-12-1985', '06-06-2006', 'Francia', 5, 4);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(7, 'soniaramirez@gmail.com', 'Katniss', '456789', 'Sonia', 'Ramírez', 'Vázquez', '06-08-1990', '03-07-2014', 'España', 4, 3);
insert into usuarios (idUsuario, email, nombreUsuario, contraseña, nombre, apellido1, apellido2, fechaNacimiento, fechaReg, 
	pais, idProfesion, idNivelEducativo) VALUES
	(8, 'anita@gmail.com', 'AnnaAllen', '548427247', 'Anna', 'Allen', 'Rocasolano', '08-06-1980', '04-03-2015', 'España', 6, 5);


-- Tabla que almacena la información sobre los posibles géneros de los contenidos
create table GENEROS
(
	idGenero int not null constraint pk_generos primary key,
	genero char(30) not null
);

insert into GENEROS values (1,'Suspense');
insert into GENEROS values (2,'Aventura') ;
insert into GENEROS values (3,'Drama'); 
insert into GENEROS values (4,'Comedia'); 
insert into GENEROS values (5,'Acción'); 
insert into GENEROS values (6,'Misterio'); 
insert into GENEROS values (7,'Historia'); 
insert into GENEROS values (8,'Fantasía'); 


-- Tabla que almacena los idiomas
create table IDIOMAS
(
	idIdioma int not null constraint pk_idiomas primary key,
	idioma char(30) not null
);


insert into IDIOMAS values (1,'Español');
insert into IDIOMAS values (2,'Inglés');
insert into IDIOMAS values (3,'Alemán');


-- Tabla que almacena el estado en el que se encuentran las series
create table ESTADOS_SERIES
(
	idEstadoSerie int not null constraint pk_estados_series primary key,
	estadoSerie char(40) not null
);


insert into ESTADOS_SERIES values (1,'En emisión');
insert into ESTADOS_SERIES values (2,'Esperando nueva temporada'); 
insert into ESTADOS_SERIES values (3,'Finalizada') ;
insert into ESTADOS_SERIES values (4,'Pendiente de estreno'); 
insert into ESTADOS_SERIES values (5,'Cancelada'); 

-- Tabla que almacena los datos de las series
create table SERIES
(
	idSerie int not null constraint pk_series primary key,
	titulo varchar(100) not null,
	tituloOriginal varchar(100) not null,
	anyoEstreno char(4),
	anyoFin char(4),
	sinopsis varchar(500),
	idGenero int not null,
	idIdioma int not null,
	idEstado int not null,
	constraint fk_serie_genero foreign key (idGenero) references GENEROS(idGenero),
	constraint fk_serie_idioma foreign key (idIdioma) references IDIOMAS(idIdioma),
	constraint fk_serie_estado foreign key (idEstado) references ESTADOS_SERIES(idEstadoSerie)
);


insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(1, 'Modern Family', 'Modern Family', '2009', 4, 2, 1);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(2, 'The Big Bang Theory', 'The Big Bang Theory', '2007', 4, 2, 1);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, anyoFin, idGenero, idIdioma, idEstado) values
	(3, 'Isabel', 'Isabel', '2012', '2014', 7, 1, 3);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, anyoFin, idGenero, idIdioma, idEstado) values
	(4, 'El tiempo entre costuras', 'El tiempo entre costuras', '2013', '2014', 3, 1, 3);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(5, 'Juego de tronos', 'Game of Thrones', '2011', 8, 1, 2);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, anyoFin, idGenero, idIdioma, idEstado) values
	(6, 'Perdidos', 'Lost', '2004', '2010', 2, 2, 3);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(7, 'Érase una vez', 'Once Upon a Time', '2011',  8, 2, 5);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(8, 'Sherlock', 'Sherlock', '2010', 2, 2, 2);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(9, 'Downton Abbey', 'Downton Abbey', '2010', 2, 2, 2);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, anyoFin, idGenero, idIdioma, idEstado) values
	(10, 'Matrimonio con hijos', 'Married...with childrea', '1987', '1997', 4, 2, 3);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, idGenero, idIdioma, idEstado) values
	(11, 'El Ministerio del Tiempo', 'El Ministerio del tiempo', '2015', 2, 1, 1);
insert into series (idSerie, titulo, tituloOriginal, anyoEstreno, anyoFin, idGenero, idIdioma, idEstado) values
	(12, 'Embrujadas', 'Charmed', '1998', '2006', 8, 2, 3);


-- Tabla que almacena los datos de los actores
create table ACTORES
(
	idActor int not null constraint pk_actores primary key,
	nombreArtistico char(100) not null
);

insert into ACTORES(idActor, nombreArtistico) values (1, 'Ed Oneill');
insert into ACTORES(idActor, nombreArtistico) values (2, 'Sofia Vergara');
insert into ACTORES(idActor, nombreArtistico) values (3, 'Jim Parsons');
insert into ACTORES(idActor, nombreArtistico) values (4, 'Kaley Cuoco');
insert into ACTORES(idActor, nombreArtistico) values (5, 'Michelle Jenner');
insert into ACTORES(idActor, nombreArtistico) values (6, 'Rodolfo Sancho');
insert into ACTORES(idActor, nombreArtistico) values (7, 'Adriana Ugarte');
insert into ACTORES(idActor, nombreArtistico) values (8, 'Peter Vives');
insert into ACTORES(idActor, nombreArtistico) values (9, 'Benedict Cumberbatch');
insert into ACTORES(idActor, nombreArtistico) values (10, 'Martin Freeman');
insert into ACTORES(idActor, nombreArtistico) values (11, 'Aura Garrido');
insert into ACTORES(idActor, nombreArtistico) values (12, 'Holly Marie Combs');

-- Tabla que almacena la participación de actores en series
create table REPARTO
(
	idReparto int not null constraint pk_reparto primary key,
	personaje varchar(150) not null,
	idSerie int not null,
	idActor int not null,
	constraint fk_reparto_serie foreign key (idSerie) references SERIES(idSerie),
	constraint fk_reparto_actor foreign key (idActor) references ACTORES(idActor)

);


insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(1,'Jay Pritchett',1,1);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(2,'Gloria Delgado',1,2);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(3,'Sheldon Cooper',2,3);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(4,'Penny',2,4);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(5,'Isabel la Católica',3,5);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(6,'Fernando el Católico',3,6);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(7,'Sira Quiroga',4,7);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(8,'Marcus Logan',4,8);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(9,'Marcus Logan',4,8);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(10,'Al Bundy',10,1);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(11,'Julián Martínez',11,6);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(12,'Aura Garrido',11,11);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(13,'Piper Halliwell',12,12);
insert into REPARTO(idreparto, personaje, idSerie, idActor) values
	(14,'Billi Jenkins',12,4);

-- Tabla con las valoraciones que los usuarios dan a las series
create table VALORACIONES
(
            idValoracion int not null primary key,
	idUsuario int not null,
	idSerie int not null,
	puntuacion int not null constraint ck_puntuacion check (puntuacion >=1 and puntuacion <=10),
	constraint fk_valoraciones_usuarios foreign key(idUsuario) references Usuarios(idUsuario),
	constraint fk_valoraciones_series foreign key(idSerie) references SERIES(idSerie)
);

insert into VALORACIONES values (1,1,1,9);
insert into VALORACIONES values (2,1,3,9);
insert into VALORACIONES values (3,1,4,8);
insert into VALORACIONES values (4,2,12,6);
insert into VALORACIONES values (5,2,11,7);
insert into VALORACIONES values (6,3,10,4);
insert into VALORACIONES values (7,3,8,6);
insert into VALORACIONES values (8,4,5,10);
insert into VALORACIONES values (9,4,6,6);
insert into VALORACIONES values (10,5,2,10);
insert into VALORACIONES values (11,5,6,9);
insert into VALORACIONES values (12,5,7,2);
insert into VALORACIONES values (13,6,4,10);
insert into VALORACIONES values (14,6,5,1);

