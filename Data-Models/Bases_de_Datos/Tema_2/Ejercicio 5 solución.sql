---------------------------------------------------------------------------------------------------------
-- Resolución del Ejercicio 5 - Tema 2
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------


-- 1.	Actualizar los precios de todos los artículos, de forma que valgan un 10% más.
update articulos set preunart = preunart*1.10;
select * from articulos;

-- 2.	Actualizar la fecha de baja del artículo 0001 al día de hoy.
update articulos set fecbaja = '2018-11-15' where codigart = '0001';
select * from articulos;

-- Alternativa
update articulos set fecbaja = date('now') where codigart = '0001';

-- 3.	Actualizar la fecha de baja del artículo 0002 y poner su stock a 1.
update articulos set fecbaja = '2018-11-15', stockart = 1 where codigart = '0002';
select * from articulos;


-- 4.	Actualizar a null el descuento de todas las líneas cuyo valor sea 0… ¿se puede?
update lineas set desculin = null where desculin = 0;

-- 5.	Borrar todos los datos de la tabla artículos… ¿se puede?
delete from articulos;

-- 6.	Eliminar los artículos dados de baja.
delete from articulos where fecbaja is not null;

-- 7.	Eliminar el artículo con código 0005
delete from articulos where codigart='0005';

