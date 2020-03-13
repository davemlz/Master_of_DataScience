---------------------------------------------------------------------------------------------------------
-- Consultas con subconsultas - Tema 3
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------



-- 1. devolver los datos de todos los artículos han sido comprados en alguna ocasión
SELECT a.*
FROM Articulos a
WHERE a.codigart IN (SELECT l.codigart FROM Lineas l);


-- 2. devolver los datos de todos los artículos NO han sido comprados en alguna ocasión
SELECT a.*
FROM Articulos a
WHERE a.codigart NOT IN (SELECT l.codigart FROM Lineas l);


-- 3. devolver los datos de todos los artículos han sido comprados en alguna ocasión (con EXISTS)
SELECT a.*
FROM Articulos a
WHERE EXISTS (SELECT * FROM Lineas l WHERE l.codigart = a.codigart);


-- 4. devolver los datos de todos los artículos que NO han sido comprados en alguna ocasión (con EXISTS)
SELECT a.*
FROM Articulos a
WHERE NOT EXISTS (SELECT * FROM Lineas l WHERE l.codigart = a.codigart);



-- 5. devolver los datos de los pedidos que se hayan enviado con posterioridad a los otros pedidos (es decir, los datos de el/los último/s pedido/s en enviarse)
SELECT pe.*
FROM Pedidos pe
	WHERE pe.fechaped = 
		(SELECT MAX(fechaped) FROM Pedidos);


-- 6. devolver el número de pedido y proveedor de todos los pedidos, junto con una columna añadida que indique el precio del artículo más caro del pedido
-- En este caso, se usa una subconsulta en la proyección
SELECT pe.numped, pe.codigpro, 
	(SELECT MAX(l.preunlin) FROM lineas l WHERE pe.numped = l.numped) as articuloMasCaro	
FROM Pedidos pe;


-- 7. devolver el número de pedido y proveedor de todos los pedidos, junto con una columna añadida que indique el precio del artículo más caro del pedido.
-- En este caso, se usa una subconsulta en el FROM
SELECT pe.numped, pe.codigpro, lm.maximo
FROM Pedidos pe JOIN 
	(SELECT l.numped, MAX(l.preunlin) as maximo FROM lineas l 
		GROUP BY l.numped) lm 
	ON pe.numped = lm.numped;



-- 8. actualizar a día de hoy la fecha de envío de los pedidos del proveedor con CIF ‘A39184215’.
UPDATE pedidos
SET fentrped = date('now')
WHERE codigpro = 
	(SELECT pr.codigpro 
		FROM Proveedores pr 
		WHERE pr.cifpro = 'A39184215');
  
select * from pedidos;



-- 9. Eliminar las lineas de los pedidos realizados entre abril y mayo de 2010
DELETE FROM Lineas
WHERE numped IN
	(SELECT pe.numped 
		FROM Pedidos pe
		WHERE pe.fechaped BETWEEN '2010-04-01' AND '2010-05-31');
  
select * from Linas;
