---------------------------------------------------------------------------------------------------------
-- Consultas con agrupaciones - Tema 3
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------

-- 1. obtener el número de líneas por pedido
SELECT l.numped, COUNT(*) numLineas 
FROM Lineas l
GROUP BY l.numped;


-- 2. obtener el número de unidades vendidas por artículo
SELECT l.codigart, SUM(l.unilin) numUnidades 
FROM Lineas l
GROUP BY l.codigart;


-- 3. obtener la media, máximo y mínimo precio pagado por cada artículo
SELECT l.codigart, MAX(l.preunlin) maximo, MIN(l.preunlin) minimo, AVG(l.preunlin) media
FROM Lineas l
GROUP BY l.codigart;


--4 . obtener el número de líneas por pedido, junto con la fecha del pedido
SELECT pe.numped, pe.fechaped, COUNT(*) numLineas 
FROM Lineas l JOIN Pedidos pe ON pe.numped = l.numped
GROUP BY pe.numped, pe.fechaped;



--5 . obtener la media, máximo y mínimo precio pagado por cada artículo, junto con la descripción del artículo, su stock y su fecha de baja
SELECT a.codigart, a.fecbaja, a.descrart, a.stockart,
MAX(l.preunlin) maximo, MIN(l.preunlin) minimo, AVG(l.preunlin) media
FROM Lineas l JOIN Articulos a ON a.codigart = l.codigart
GROUP BY l.codigart, a.fecbaja, a.descrart, a.stockart;


-- 6. obtener el número de líneas sin descuento por pedido
SELECT l.numped, COUNT(*) numLineas 
FROM Lineas l
WHERE l.desculin = 0
GROUP BY l.numped;



-- 7. obtener el número de unidades vendidas por artículo, junto a la descripción del artículo. Filtrar solamente para aquellos artículos con stock superior al mínimo, y siempre que el precio unitario de venta fuese mayor a 200
SELECT l.codigart, a.descrart, SUM(l.unilin) numUnidades 
FROM Lineas l INNER JOIN Articulos a ON a.codigart = l.codigart
WHERE a.stockart > a.stockmin AND l.preunlin > 200
GROUP BY l.codigart, a.descrart;



--8. obtener el número de líneas por pedido, siempre que el número de líneas sea mayor a 2
SELECT l.numped, COUNT(*) numLineas 
FROM Lineas l
GROUP BY l.numped
HAVING COUNT(*) > 1;

-- 9. obtener el número de líneas sin descuento por pedido, siempre que el número de líneas que cumplan la restricción sea mayor a 2
SELECT l.numped, COUNT(*) numLineas 
FROM Lineas l
WHERE l.desculin =0
GROUP BY l.numped
HAVING COUNT(*) > 1;

-- 10. obtener el número de unidades vendidas por artículo, junto a la descripción del artículo. Filtrar solamente para aquellos artículos con stock superior al mínimo, y siempre que la suma de unidades vendidas sea mayor a 2
SELECT l.codigart, a.descrart, SUM(l.unilin) numUnidades 
FROM Lineas l INNER JOIN Articulos a ON a.codigart = l.codigart
WHERE a.stockart > a.stockmin
GROUP BY l.codigart, a.descrart
HAVING SUM(l.unilin) > 2;


-- 11. obtener el número de líneas por pedido, siempre que el número de líneas sea mayor a 1, y ordenar por el número de líneas.
SELECT l.numped, COUNT(*) numLineas 
FROM Lineas l
GROUP BY l.numped
HAVING COUNT(*) > 1
ORDER BY COUNT(*);

