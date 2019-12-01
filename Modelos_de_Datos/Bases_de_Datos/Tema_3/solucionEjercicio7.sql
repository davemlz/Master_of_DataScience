---------------------------------------------------------------------------------------------------------
-- Solución ejercicio 7
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------

--1. Devolver los datos de las peliculas junto con los datos de sus géneros
SELECT p.*, g.* from Peliculas p JOIN Generos g on g.id_genero = p.id_genero;

--2. Repetir la consulta anterior, devolviendo solamente el id de las películas, su nombre y la descripción del género
SELECT p.id_pelicula, p.nombre_pelicula, g.desc_genero from Peliculas p JOIN Generos g on g.id_genero = p.id_genero;

--3. Devolver los datos de los socios cuyo id de localidad sea 001 o 002, junto con los datos de la localidad
SELECT s.*, l.* from Socios s JOIN Localidades l on s.id_localidad = l.id_localidad where l.id_localidad IN ('001','002');


-- 4. Mostrar el nombre y apellidos de los socios concatenados, junto con los datos de todos sus alquileres, y junto al nombre de la película alquilada.
select s.nombre || ' ' || s.apellido1 || ' ' || s.apellido2, a.*, p.nombre_pelicula
from socios s inner join alquileres a on s.nro_socio = a.nro_socio
    inner join peliculas p on p.id_pelicula = a.id_pelicula;


-- 5.	Repetir la consulta anterior, devolviendo solamente los alquileres de películas no devueltas.
select s.nombre || ' ' || s.apellido1 || ' ' || s.apellido2, a.*, p.nombre_pelicula
from socios s inner join alquileres a on s.nro_socio = a.nro_socio
    inner join peliculas p on p.id_pelicula = a.id_pelicula
    where a.fecha_devolucion is null;

-- 6. Retornar el id y nombre de las películas, junto con el código e importe diario de sus tarifas, y junto con la descripción de su género.
-- El resultado habrá de estar ordenado por título (ascendente) y por importe (descendente)
SELECT p.id_pelicula, p.nombre_pelicula, g.desc_genero, t.codigo, t.importeDia 
from Peliculas p JOIN Generos g on g.id_genero = p.id_genero
    JOIN Tarifas t on t.codigo = p.refTarifa
    ORDER BY p.nombre_pelicula ASC, t.importeDia DESC;

-- 7. Repetir la consulta anterior, devolviendo solo los resultados de las películas que comiencen por 'L' o 'M', y cuyo género sea Suspense 
SELECT p.id_pelicula, p.nombre_pelicula, g.desc_genero, t.codigo, t.importeDia 
from Peliculas p JOIN Generos g on g.id_genero = p.id_genero
    JOIN Tarifas t on t.codigo = p.refTarifa
    WHERE (p.nombre_pelicula LIKE ('M%') OR p.nombre_pelicula LIKE ('L%')) AND g.desc_genero = 'Suspense'
    ORDER BY p.nombre_pelicula ASC, t.importeDia DESC;
    
-- 8. Devolver el id y nombre de todas las películas junto con los datos de todas sus copias, incluyendo aquellas películas que no tienen copias
select p.id_pelicula, p.nombre_pelicula, c.* from peliculas p left join copias c on c.id_pelicula = p.id_pelicula;


-- 9. Realizar una consulta que devuelta todos los datos de todas las tablas.
select * from peliculas p inner join generos g on g.id_genero = p.id_genero
            inner join copias c on c.id_pelicula = p.id_pelicula
            inner join tarifas t on t.codigo = p.refTarifa
            inner join alquileres a on p.id_pelicula = a.id_pelicula
            inner join socios s on s.nro_socio = a.nro_socio
            inner join localidades l on l.id_localidad = s.id_localidad;