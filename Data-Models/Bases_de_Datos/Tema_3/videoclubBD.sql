---------------------------------------------------------------------------------------------------------
-- Script con la base de datos de un videoclub para los ejercicios 7, 8 y 9
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------
 
CREATE TABLE generos (
  id_genero INTEGER NOT NULL primary key,
  desc_genero VARCHAR(100) NOT NULL);

INSERT INTO generos (id_genero, desc_genero) VALUES 
  (1,'Accion'),
  (2,'Drama'),
  (3,'Suspense'),
  (4,'Comedia');


create table tarifas (
   codigo char(2) not null primary key,
   descripcion char (20) not null,
   importeDia decimal(4,2) not null default 0
);

insert into tarifas values 
  ('A1','Novedades', 2.5),
  ('B1','Normal', 2.0),
  ('C1','Archivo', 2.0);

CREATE TABLE peliculas (
  id_pelicula INTEGER NOT NULL primary key,
  nombre_pelicula VARCHAR(200) NOT NULL,
  fecha_estreno DATE NOT NULL,
  reparto VARCHAR(500) NOT NULL,
  id_genero INTEGER,
  director VARCHAR(100) ,
  sinopsis VARCHAR(1000),
  refTarifa char(2) not null,	
  CONSTRAINT peliculas_fk1 FOREIGN KEY (id_genero) REFERENCES generos (id_genero) on update cascade on delete no action,
  CONSTRAINT peliculas_fk2 FOREIGN KEY (refTarifa) REFERENCES tarifas (codigo) on update cascade on delete no action
);



INSERT INTO peliculas (refTarifa,id_pelicula, nombre_pelicula, fecha_estreno, reparto, 
                       id_genero, director, sinopsis) VALUES
('A1',1,
'LA CHISPA DE LA VIDA',
'2012-01-13',
'JOSE MOTA, SALMA HAYEK, JUAN LUIS GALIARDO COMES, FERNANDO TEJERO, MANUEL TALLAFE LEON',
 3,
 'ALEX DE LA IGLESIA',
 'Roberto es un publicista en paro que queda atrapado en un accidente de una forma en la que nadie se pone de acuerdo en la manera de rescatarlo. Una situación absurda y dramática que llama la atención de los medios de comunicación, que convierten la tragedia en un espectáculo. En semejante tesitura, Roberto decide sacar partido y vender la exclusiva para solucionar los problemas económicos de su familia de una vez por todas.' ),
 
('A1',2,
'LA HORA MAS OSCURA 3D',
'2018-01-13',
'EMILE HIRSCH, OLIVIA THIRLBY',
 1,
 'CHRIS GORAK',
 'Los termómetros marcan 40 grados durante la ola de calor más intensa de la historia de Moscú. Dos jóvenes buscan cobertura bajo un coche de policía abandonado en la Plaza Roja, ahora completamente desierta. No están buscando una sombra para resguardarse del sofocante calor. Tratan de evitar que les localicen unos alienígenas camuflados que han colonizado la ciudad. Desde hace algunos días, estos jóvenes y sus compañeros se han visto obligados a buscar refugio bajo tierra, ya que la ciudad, como el resto del mundo, ha sido diezmada por una amenaza alienígena. Ahora han de esconderse, cuentan con pocos suministros y buscan desesperadamente seguridad, algo difícil de encontrar incluso en la mayor atracción turística moscovita.' ),

('A1',3,
'MILLENNIUM: LOS HOMBRES QUE NO AMABAN A LAS MUJERES',
'2012-11-13',
'STELLAN SKARSGARD, DANIEL CRAIG, CHRISTOPHER PLUMMER, ROONEY MARA',
 3,
 'DAVID FINCHER',
 'En el laberinto de la historia de “Millennium: Los hombres que no amaban a las mujeres” hallamos asesinatos, corrupción, secretos familiares y los demonios internos de dos inesperados socios en búsqueda de la verdad sobre un misterio oculto durante 40 años.' ),

('A1',4,
'THE COLLECTOR',
'2012-10-25',
'MICHAEL REILLY BURKE, JOSH STEWART, MADELINE ZIMA',
 3,
 'MARCUS DUNSTAN',
 'Para el manitas y ex-timador Arkin, un hogar tranquilo y una familia de vacaciones es una "oportunidad". Porque en el interior de la casa hay una caja fuerte con joyas, y dentro de la caja hay una rara gema, -su única esperanza para pagar la deuda de su ex esposa y mantener intacto lo que queda de su familia-. Desgraciadamente para Arkin, dentro de la casa hay también una caja que contiene el último espécimen de una colección catalogada como sangre, huesos y lágrimas... un espécimen humano denominado "cebo".' ),

('B1',5,
'ATRACO POR DUPLICADO',
'2012-01-13',
'PATRICK DEMPSEY , ASHLEY JUDD, TIM BLAKE NELSON, JEFFREY TAMBOR',
 2,
 'ROB MINKOFF',
 'Tripp Kennedy (Patrick Dempsey) entra tranquilamente en una sucursal bancaria poco antes de la hora de cierre, justo en el momento en que dos bandas distintas convergen por casualidad con intención cada una de realizar un atraco. Se produce un tiroteo y Tripp se abalanza sobre la guapa e inteligente cajera, Kaitlin (Ashley Judd), a fin de protegerla. Las dos bandas, una compuesta claramente por profesionales y la otra formada por un par de payasos llamados Mantequilla (Tim Blake Nelson) y Mermelada (Pruitt Taylor Vince), se encuentran estancadas en un punto muerto. El sistema de seguridad del banco inicia su procedimiento de cierre habitual al final de cada día y deja a todo el mundo atrapado dentro del edificio. A medida que avanza la noche, se pondrá en marcha un divertidísimo juego del gato y el ratón mientras Tripp y Kaitlin intentan salvar la situación, eludir la muerte y evitar enamorarse... o casi' ),

('B1',6,
'JUAN DE LOS MUERTOS',
'2013-01-13',
'LAURA ALVEA PEREZ, ALEJANDRO BRUGUES SELEME',
 1,
 'ALEJANDRO BRUGUES SELEME ',
 '50 años después de la Revolución Cubana, otra nueva Revolución llega a La Habana. Una misteriosa infección está convirtiendo a sus habitantes en muertos vivientes sedientos de carne humana.Juan, como buen cubano, decide montar un negocio para sacar partido de la situación: "Juan de los Muertos, matamos a sus seres queridos". Eliminando a los infectados, Juan y sus amigos comienzan a hacer fortuna.' ),

('B1',7,
'SHARKNADO',
'2013-01-13',
'Nunca volvieron a actuar',
 4,
 'How knows... ',
 'Tiburones que viajan en tornados y se comen a la gente.' );



CREATE TABLE copias (
     id_pelicula INTEGER NOT NULL,
     nro_copia INTEGER NOT NULL,
     fechaAlta date not null,
     fechaBaja date null,
     constraint ch_fechaAlt CHECK (fechaBaja is null or (fechaBaja >= fechaAlta)),
     PRIMARY KEY (id_pelicula, nro_copia),
     CONSTRAINT copias_peliculas_fk FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula) on update cascade on delete no action
  
  );


insert into copias (id_pelicula,nro_copia,fechaAlta) values
(1,1,'2018-05-22'), 
(1,2,'2018-01-30'),
(2,1,'2018-01-28'), 
(2,2,'2018-02-02'),
(3,1,'2018-09-03'), 
(3,2,'2018-10-01'),
(4,1,'2018-01-02'), 
(4,2,'2018-11-09'),
(5,1,'2018-01-02'), 
(5,2,'2018-09-15'),
(6,1,'2018-10-12'), 
(6,2,'2018-01-08');


CREATE TABLE Localidades (
      id_Localidad char (3)not null primary key,
      Nombre char (30) not null
);

insert into Localidades (id_Localidad,Nombre) values 
('001', 'Santander'),
('002', 'Torrelavega'),
('003', 'Laredo'),
('004', 'San Vicente');


CREATE TABLE  socios  (
     nro_socio  integer NOT NULL primary key,
     Nif  char(10) NOT NULL,
     Nombre char (100) NOT NULL,
     Apellido1 char (100) NOT NULL,
     Apellido2 char (100) NOT NULL,
     Dirección char (100) NOT NULL,
     id_Localidad char (3) NOT NULL,
     Telefono  char(12),
     Email char(30) check (Email like '%@%'),
     fechaAlta date not null,
     fechaBaja date null,
     constraint ch_fechaAlta CHECK (fechaBaja is null or (fechaBaja >= fechaAlta)),
     FOREIGN KEY  (id_Localidad) references 
                 Localidades (id_Localidad) on update cascade on delete no action
   );


insert into socios (nro_socio, Nif, Nombre,Apellido1, Apellido2,
                        Dirección, id_Localidad, Telefono, Email,fechaAlta)
                       values 
(1,'13775935S','Manuel', 'Pérez', 'Alonso','Paseo del pino 5', '001', null,null,'2018-01´-01'),                              
(2,'14775935S','José Antonio', 'Carrillo', 'Alonso','Avda. Reina Victoria 2', '001', null,null,'2018-01-01'),
(3,'13445935S','Miguel Angel', 'Castro', 'Alonso','Paseo Pereda 5', '001', null,null,'2018-01-01'),
(4,'22775935S','Paloma', 'Gutierrez', 'Del Pino','Lealtad 55', '003', null,null,'2018-01-01'),
(5,'42775935S','Angel', 'Gutierrez', 'Alonso','Tetuan 23', '004', null,null,'2018-01-01'),
(6,'45775935S','Angela', 'Gutierrez', 'Noriega','Lealtad 34', '003', null,null,'2018-01-01'), 
(7,'56775935S','Angeles', 'López', 'López','Lealtad 70', '002', null,null,'2018-01-01'), 
(8,'27788935S','Pedro', 'López', 'Jimeze','Calle alta', '001', null,null,'2018-01-01'), 
(9,'88788935S','Martin Pedro', 'Matinez', 'Castro', 'Toreviejo 34', '002', null,null,'2018-01-01'); 




CREATE TABLE alquileres (
     id_alquiler INTEGER NOT NULL primary key,
     nro_socio INTEGER NOT NULL,
     id_pelicula INTEGER NOT NULL,
     nro_copia INTEGER NOT NULL,
     fecha_alquiler DATETIME NOT NULL,
     fecha_devolucion dateTIME,
     constraint ch_fecha CHECK (fecha_devolucion is null or fecha_devolucion >= fecha_alquiler),
     constraint alquileres_socios_fk1 foreign key (nro_socio) references socios(nro_socio),
     CONSTRAINT alquileres_copias_fk2 FOREIGN KEY (id_pelicula, nro_copia) REFERENCES copias (id_pelicula, nro_copia)
   );
   
insert into alquileres (id_alquiler,nro_socio, id_pelicula, nro_copia, fecha_alquiler,fecha_devolucion) values
(1,1,1,1, '2018-02-14','2018-02-15'),
(2,2,1,2, '2018-02-14','2018-02-15'),
(3,3,2,1, '2018-03-14','2018-03-16'),
(4,4,2,2, '2018-03-14','2018-03-16'),
(5,5,3,1, '2018-02-14','2018-02-15'),
(6,6,3,2, '2018-02-14','2018-02-18'),
(7,7,4,1, '2018-02-14','2018-02-18'),
(8,1,1,1, '2018-04-02',null),
(9,2,1,2, '2018-03-31',null),
(10,3,2,1, '2018-04-01',null),
(11,4,2,2, '2018-04-01',null),
(12,5,3,1, '2018-04-02',null);