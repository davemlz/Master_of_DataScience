---------------------------------------------------------------------------------------------------------
-- Solución ejercicio 8
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------

-- 1.	Obtener el número de socios por localidad.
select id_localidad, count(*) as numSocios from socios group by id_localidad;


-- 2.	Repetir la consulta anterior, mostrando el nombre de la localidad, además del id.
select l.id_localidad, l.nombre, count(*) as numSocios from socios s inner join localidades l on l.id_localidad = s.id_localidad group by l.id_localidad, l.nombre;


-- 3.	Obtener la tarifa media, mínima y máxima por género de película.
select p.id_genero, avg(importeDia) media, min(importeDia), max(importeDia) from peliculas p inner join tarifas t on t.codigo = p.refTarifa group by p.id_genero;

-- 4.	Repetir la consulta anterior, contando sólo con las películas estrenadas a partir del año 2011.
select p.id_genero, avg(importeDia) media, min(importeDia), max(importeDia) 
from peliculas p inner join tarifas t on t.codigo = p.refTarifa 
where p.fecha_estreno >= '2011-01-01'
group by p.id_genero;


-- 5.	Repetir la consulta anterior, incluyendo la descripción del género en los resultados de la consulta.
select p.id_genero, g.desc_genero, avg(importeDia) media, min(importeDia), max(importeDia) 
from peliculas p inner join tarifas t on t.codigo = p.refTarifa 
    inner join generos g on g.id_genero = p.id_genero
where p.fecha_estreno >= '2011-01-01'
group by p.id_genero, g.desc_genero;


-- 6.	Devolver el id y nombre de todas las películas junto con la cantidad de copias disponibles en el videoclub, siempre y cuando esta cantidad sea mayor a 1.
select p.id_pelicula, p.nombre_pelicula, count(*)
from peliculas p inner join copias c on p.id_pelicula = c.id_pelicula
group by p.id_pelicula, p.nombre_pelicula
having count(*) > 1;


-- 7.	Consultar el número de alquileres realizados por cada socio entre marzo y abril de 2018. 
-- Mostrar en la consulta el nro, nif, nombre, apellido1 y apellido2 de los socios, y ordenar los resultados por número de alquileres de menor a mayor, 
-- y secundariamente por el nro de los socios de forma descendente.
select s.nro_socio, s.nif, s.nombre, s.apellido1, s.apellido2, count(*) as numAlquileres
from socios s inner join alquileres a on a.nro_socio = s.nro_socio
where a.fecha_alquiler between '2018-03-01' and '2018-04-30'
group by s.nro_socio, s.nif, s.nombre, s.apellido1, s.apellido2
order by count(*) asc, s.nro_socio desc; 


-- 8.	Repetir la consulta anterior, solo para los socios que en ese periodo hayan realizado más de 1 alquiler.
select s.nro_socio, s.nif, s.nombre, s.apellido1, s.apellido2, count(*) as numAlquileres
from socios s inner join alquileres a on a.nro_socio = s.nro_socio
where a.fecha_alquiler between '2018-03-01' and '2018-04-30'
group by s.nro_socio, s.nif, s.nombre, s.apellido1, s.apellido2
having count(*) > 1
order by count(*) asc, s.nro_socio desc; 


-- 9.	Repetir la consulta anterior, con el nombre y los apellidos de los socios concatenados en una sola columna.
select s.nro_socio, s.nif, s.nombre || ' ' || s.apellido1 || ' ' ||  s.apellido2 as nombreCompleto, count(*) as numAlquileres
from socios s inner join alquileres a on a.nro_socio = s.nro_socio
where a.fecha_alquiler between '2018-03-01' and '2018-04-30'
group by s.nro_socio, nombreCompleto
having count(*) > 1
order by count(*) asc, s.nro_socio desc; 