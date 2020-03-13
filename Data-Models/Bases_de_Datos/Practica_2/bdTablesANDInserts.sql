---------------------------------------------------------------------------------------------------------
-- Base de datos de una pizzería para el 2º ejercicio de seguimiento
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------
drop table if exists LineasPedidos;
drop table if exists Pedidos;
drop table if exists Estados;
drop table if exists IngredienteDePizza;
drop table if exists Clientes;
drop table if exists Personal;
drop table if exists Ingredientes;
drop table if exists Pizzas;
drop table if exists Bases;
drop table if exists Localidades;


CREATE TABLE  Localidades (
  idlocalidad char (3) NOT NULL ,
  nombre  char(50) NOT NULL,  
  codigopostal char(5),  
  PRIMARY KEY  (idlocalidad)
);


create table Clientes (
  idcliente integer NOT NULL ,
  nif  char(12) NOT NULL,
  nombre char(50) not null,
  apellido1 char(50) not null,
  apellido2 char(50) ,
  telefono char(12) not null,
  calle char(100) not null,
  numero char(4) not null,
  letra char(1),
  piso char (3),
  puerta char (2),
  observaciones varchar(200),
  idlocalidad char(3) not  null,
  PRIMARY KEY  (idcliente),
  FOREIGN KEY  (idlocalidad) references 
                 Localidades (idlocalidad)
);


create table Personal (
  idpersonal integer NOT NULL ,
  nif  char(12) NOT NULL UNIQUE,
  nombre char(50) not null,
  apellido1 char(50) not null,
  apellido2 char(50) ,
  telefono char(12),
  email char(50) check (email like '%@%'),
  calle char(100) not null,
  numero char(4) not null,
  piso char (3),
  puerta char (2),
  idlocalidad char(3) not  null,
  fechaAlta date not null default '2018-11-21',
  fechaBaja date,
  PRIMARY KEY  (idpersonal),
  FOREIGN KEY  (idlocalidad) references 
                 Localidades (idlocalidad) on update cascade on delete no action,
  CONSTRAINT fechaBaja check(fechaAlta<=fechaBaja or fechaBaja=null)
);


create table Estados (
	idestado char (3) not null,
	descripcion char (20) not null,
	PRIMARY KEY (idestado)
);



create table Ingredientes (
	idingrediente char (3) not null,
	descripcion char (20) not null,
	PRIMARY KEY (idingrediente)
);


create table Bases (
	idbase char (3) not null,
	descripcion char (20) not null,
	PRIMARY KEY (idbase)
);


create table Pizzas (
	idpizza integer not null,
	idbase char (3) not null,
	importeBase numeric(5,2) not null,
	PRIMARY KEY (idpizza),
	foreign key (idbase) references 
       Bases (idbase) 
);



create table IngredienteDePizza (
	idpizza integer not null,
	idingrediente char (3) not null,
            cantidad int not null default 1,
	PRIMARY KEY (idpizza,idingrediente),
	foreign key (idingrediente) references 
       Ingredientes (idingrediente),
	foreign key (idpizza) references 
       Pizzas (idpizza) 
);


create table Pedidos (
	idpedido integer not null,
	iva integer not null check (iva >=0 and iva<=100),
	fechaHoraPedido datetime not null,
	fechaHoraServicio datetime null,
	observaciones varchar (100) null,
	idestado char(3) not null,
	idcliente integer not null,
	idpersonal integer not null,
	PRIMARY KEY (idpedido),	
	foreign key (idestado) references 
       Estados (idestado),	
    foreign key (idcliente) references 
       Clientes (idcliente),
    foreign key (idpersonal) references 
       Personal (idpersonal)
);


create table LineasPedidos (
	idpedido integer not null,
	idlinea integer not null,
            idpizza integer not null,
            precioUnidad money not null,
            cantidad integer not null default 1,
            descuento decimal(4,2) not null default 0,
	PRIMARY KEY (idpedido, idlinea),	
	foreign key (idpedido) references 
       Pedidos (idpedido),	
    foreign key (idpizza) references 
       Pizzas (idpizza)
);








-- ----------------------------------------------
--  INSERCIÓN DE DATOS EN LAS TABLAS
-- ----------------------------------------------

-- LOCALIDADES
insert into localidades (idlocalidad,nombre,codigopostal) values ('CAM', 'Camargo','39609');
insert into localidades (idlocalidad,nombre,codigopostal) values ('AST', 'Astillero', '39610');
insert into localidades (idlocalidad,nombre,codigopostal) values ('MAL', 'Malia�o','39600');
insert into localidades (idlocalidad,nombre,codigopostal) values ('HEL', 'Helguera (Reocin)', '39538');
insert into localidades (idlocalidad,nombre,codigopostal) values ('REO', 'Reocin', '39538');
insert into localidades (idlocalidad,nombre,codigopostal) values ('PSM', 'Puente San Miguel', '39530');

-- CLIENTES
insert into Clientes values('1','07659222R','Jaime', 'Mu�oz','Herrera','678342001', 'Avenida Mayor', '17','j', '6','a','Cliente frecuente', 'REO');
insert into Clientes values('2','07612231F','Juan', 'Del Castillo','Gonzalez','611342521', 'Plaza Castro', '21','i', '7','a',null, 'REO');
insert into Clientes values('3','03459231O','Ramiro', 'Polo','Garcia','942735201', 'Calle Sardinero', '231', 'h', '2','b',null, 'PSM');
insert into Clientes values('4','07659221P','Gema', 'Delgado','Tirado','678342209', 'Calle Romanones', '111', 'g', '2','d','Cliente frecuente', 'PSM');
insert into Clientes values('5','07655231I','Tomas', 'Fernandez','Cortes','600342521', 'Calle Castilla', '31', 'f', '5','b',null, 'HEL');
insert into Clientes values('6','12359231U','Jose', 'Gonzalez','Claro','678725021', 'Avenida Remos', '9','e', '4','a','Cliente frecuente', 'HEL');
insert into Clientes values('7','08959231H','Carla', 'Rivera','Vera','658142521', 'Calle Goya', '8','d', '9','e',null, 'AST');
insert into Clientes values('8','07459231R','Davinia', 'Castilla','Aguirre','678312521','Calle Lierganes', '1','c', '2','d',null, 'AST');
insert into Clientes values('9','07652131D','Aurora', 'Molina','Moraga','678343821', 'Avenida Mercader', '2','b', '1','a',null, 'MAL');
insert into Clientes values('10','07659211A','Macario', 'Polaino','Romero','678342521', 'Calle Galdos', '5','a', '5','c',null, 'MAL');

-- PERSONAL
insert into Personal VALUES ('1', '0891234554T','Juan' ,'Garcia', 'P�rez', '678342233','jgp@hotmail.com',
                                       'Calle Canarias','71','1','D','AST', '2010/01/01',null);
insert into Personal VALUES ('2', '08912345545','Pedro' ,'Lopez', 'AlonsoP�rez', '678342244','pla@hotmail.com',
                                       'Calle Sotelo','1','10','E','HEL', '2010/02/01',null);                                                         
insert into Personal VALUES ('3', '089123455345','Manuel' ,'Garcia', 'Fernandez', '678342256','mgf@hotmail.com',
                                       'Calle La uni�n','31','2','A','MAL', '2010/08/01',null);
insert into Personal VALUES ('4', '109422405345','Manuel' ,'Gonzalez', 'De Castro', '778389966','mgdc@hotmail.com',
                                       'Calle Rue del Percebe','13','3','A','MAL', '2018/08/01','2018/11/11');
-- BASES
insert into Bases values ('NOR','Normal');
insert into Bases values ('FIN','Fina');
insert into Bases values ('QUE','Borde con queso');

-- INGREDIENTES
insert into Ingredientes values ('JAM','Jamon');
insert into Ingredientes values('CHA','Champiñones');
insert into Ingredientes values('PIC','Queso Picon');
insert into Ingredientes values('ANC','Anchoas');
insert into Ingredientes values('ACE','Aceitunas');
insert into Ingredientes values('CHO','Chorizo');
insert into Ingredientes values('CEB','Cebolla');


-- ESTADOS
insert into Estados values ('PEN','Pendiente');
insert into Estados values ('ENT','Entregada');
insert into Estados values ('CAN','Cancelado');


-- PEDIDOS select * from pedidos
insert into Pedidos
                      values (1, 18, '2018-10-05 21:09', null, '', 'PEN',1,1);
insert into Pedidos
                      values (2, 18, '2018-10-05 14:01', null, '', 'PEN',2,1);                      
insert into Pedidos
                      values (3, 18, '2018-11-29 11:11', '2018-11-29 12:09' , '', 'ENT',3,2);
insert into Pedidos
                      values (4, 18, '2018-10-11 17:46', '2018-10-11 18:39', '', 'ENT',3,2);
insert into Pedidos
                      values (5, 18, '2018-09-01 14:01', '2018-09-01 14:19', '', 'ENT',4,1);
insert into Pedidos
                      values (6, 18, '2017-10-01 19:11', '2017-10-01 19:59', '', 'ENT',6,2);                                          
insert into Pedidos
                      values (7, 18, '2016-01-27 23:08', '2016-01-27 23:32', '', 'ENT',7,1);
                      

-- PIZZAS
insert into Pizzas  values (1,'NOR', 3);
insert into Pizzas  values (2, 'FIN', 3.5);
insert into Pizzas  values (3, 'FIN', 3.5);
insert into Pizzas  values (4, 'FIN', 3.5);
insert into Pizzas  values (5, 'FIN', 3.5);
insert into Pizzas  values (6, 'FIN', 3.5);
insert into Pizzas  values (7, 'NOR', 3);
insert into Pizzas  values (8, 'FIN', 3.5);
insert into Pizzas  values (9, 'FIN', 3.5);
insert into Pizzas  values (10, 'FIN', 3.5);                     


-- INGREDIENTES DE PIZZA
insert into IngredienteDePizza values (1,'JAM', 3);
insert into IngredienteDePizza values (1,'CHA', 2);
insert into IngredienteDePizza values (1,'ANC', 3);
insert into IngredienteDePizza values (2,'PIC', 1);
insert into IngredienteDePizza values (2,'CHA', 2);
insert into IngredienteDePizza values (2,'ANC', 3);
insert into IngredienteDePizza values (3,'JAM', 3);
insert into IngredienteDePizza values (3,'CHA', 2);
insert into IngredienteDePizza values (3,'CHO', 1);
insert into IngredienteDePizza values (4,'JAM', 3);
insert into IngredienteDePizza values (4,'CHA', 2);
insert into IngredienteDePizza values (4,'CEB', 1);
insert into IngredienteDePizza values (5,'JAM', 3);
insert into IngredienteDePizza values (5,'CHA', 2);
insert into IngredienteDePizza values (5,'ACE', 2);
insert into IngredienteDePizza values (6,'JAM', 3);
insert into IngredienteDePizza values (6,'CHA', 2);
insert into IngredienteDePizza values (7,'JAM', 3);
insert into IngredienteDePizza values (7,'CHA', 2);
insert into IngredienteDePizza values (8,'CHA', 2);
insert into IngredienteDePizza values (8,'ANC', 3);
insert into IngredienteDePizza values (9,'CHO', 1);
insert into IngredienteDePizza values (9,'CEB', 1);
insert into IngredienteDePizza values (10,'JAM', 3);
insert into IngredienteDePizza values (10,'ACE', 2);



-- LINEAS DE PEDIDOS
insert into lineasPedidos values(1,1,1,3.1,2,0);

insert into lineasPedidos values(2,1,1,3.1,1,10);
insert into lineasPedidos values(2,2,3,3.5,1,10);

insert into lineasPedidos values(3,1,10,3.6,1,5);
insert into lineasPedidos values(3,2,6,3.5,2,5);
insert into lineasPedidos values(3,3,7,3.05,1,0);

insert into lineasPedidos values(4,1,1,3,1,4);

insert into lineasPedidos values(5,1,1,3,1,0);

insert into lineasPedidos values(6,1,2,3.4,1,0);

insert into lineasPedidos values(7,1,1,2.8,1,0);
insert into lineasPedidos values(7,2,2,3.4,3,5);
insert into lineasPedidos values(7,3,3,3.45,1,10);
insert into lineasPedidos values(7,4,4,3.5,1,0);