---------------------------------------------------------------------------------------------------------
-- Consultas con JOIN - Tema 3
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------

-- 1. devolver los datos de los proveedores junto con los datos de todos sus pedidos:
SELECT pr.*, pe.*
	FROM Proveedores pr JOIN Pedidos pe
		ON pr.codigpro = pe.codigpro;
  

SELECT pr.*, pe.*
	FROM Proveedores pr INNER JOIN Pedidos pe
		ON pr.codigpro = pe.codigpro;

-- 2. devolver los datos de los artículos junto con las líneas de pedido en las que aparecen.
SELECT a.*, l.*
	FROM Articulos a JOIN Lineas l
		ON a.codigart = l.codigart
		ORDER BY a.codigart;


-- 3. Devolver todas las filas de los provvedores junto con todas las filas de los pedidos
SELECT pr.*, pe.*
	FROM Proveedores pr JOIN Pedidos pe;



-- 4. devolver los datos de los artículos junto con las líneas de pedido en las que aparecen, siempre que el precio unitario del artículo sea mayor que el de la línea.

SELECT a.*, l.*
	FROM Articulos a JOIN Lineas l
		ON a.codigart = l.codigart
	WHERE a.preunart > l.preunlin
	ORDER BY a.codigart;
-- Más condiciones a la anterior consulta: Devolver los datos de los artículos junto con las líneas de pedido en las que aparecen, mostrando sólo aquellos casos en los que el artículo no se haya dado de baja y en los que no se haya aplicado ningún descuento.
SELECT a.*, l.*
	FROM Articulos a JOIN Lineas l
		ON a.codigart = l.codigart
	WHERE a.fecbaja IS null AND l.desculin = 0	
	ORDER BY a.codigart;

  
-- 4. Devolver los proveedores junto con sus pedidos, usando USING 
SELECT pr.*, pe.*
	FROM Proveedores pr JOIN Pedidos pe USING (codigpro);

-- 5. Devolver los proveedores junto con sus pedidos, usando NATURAL JOIN
SELECT pr.*, pe.*
	FROM Proveedores pr NATURAL JOIN Pedidos pe;

-- 6. Devolver los proveedores junto con sus pedidos, poniendo la condición en el WHERE en vez de en el ON
SELECT pr.*, pe.*
FROM Proveedores pr 
	JOIN Pedidos pe
WHERE pr.codigpro = pe.codigpro;

-- 7. Datos de proveedor P001 junto a los datos de sus pedidos. La primer consulta da error al no usar alias en el WHERE
SELECT pr.*, pe.*
FROM Proveedores pr 
	JOIN Pedidos pe
ON pr.codigpro = pe.codigpro
WHERE codigpro = ‘P001’;

SELECT pr.*, pe.*
FROM Proveedores pr 
	JOIN Pedidos pe
ON pr.codigpro = pe.codigpro
WHERE pr.codigpro = 'P001';



-- 8. devolver los datos de los artículos junto con las líneas de pedido en las que aparecen, y junto con los datos de los pedidos
SELECT a.*, l.*, pe.*
	FROM Articulos a 
                 JOIN Lineas l ON a.codigart = l.codigart
                 JOIN Pedidos pe ON pe.numped = l.numped;
                 


-- 9. devolver los datos de los artículos junto con las líneas de pedido en las que aparecen, junto con los datos de los pedidos y de los proveedores
SELECT a.*, l.*, pe.*, pr.*
	FROM Articulos a 
                 JOIN Lineas l ON a.codigart = l.codigart
                 JOIN Pedidos pe ON pe.numped = l.numped
                 JOIN Proveedores pr ON pe.codigpro = pr.codigpro;




-- 10. devolver los datos de los artículos junto con las líneas de pedido en las que aparecen, junto con los datos de los pedidos y de los proveedores. 
-- Filtrar devolviendo solamente los pedidos del proveedor ‘P002’ y cuyos artículos tengan un precio mayor a 300:
SELECT a.*, l.*, pe.*, pr.*
	FROM Articulos a 
                 JOIN Lineas l ON a.codigart = l.codigart
                 JOIN Pedidos pe ON pe.numped = l.numped
		   JOIN Proveedores pr ON pe.codigpro = pr.codigpro
	WHERE pr.codigpro = 'P002' AND a.preunart > 200;
 

-- 11. devolver los datos de los artículos junto con los datos de todos sus líneas. Devolver también los datos de los artículos que no tengan aparezcan en ninguna línea de pedido.
SELECT a.*, l.*
	FROM Articulos a LEFT JOIN Lineas l
		ON a.codigart = l.codigart;









 


