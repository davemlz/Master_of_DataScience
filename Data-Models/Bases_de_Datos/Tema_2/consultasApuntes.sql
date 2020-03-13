---------------------------------------------------------------------------------------------------------
-- Consultas en los apuntes
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------

-- 1. Selecciona todos los datos de los proveedores.
-- Selecciona todos los datos de los pedidos
SELECT p.* FROM Proveedores p;
SELECT p.* FROM Pedidos p;

-- 2. Selecciona el codigo, cif y nombre de todos los proveedores
-- Selecciona el código y stock de todos los artículos
SELECT p.codigpro, p.cifpro, p.nombrpro FROM Proveedores p;
SELECT a.codigart, a.stockart FROM Articulos a;


-- 3. Selecciona todos los datos de los Proveedores de Santander
SELECT p.* FROM Proveedores p WHERE p.localpro = 'Santander';
-- ... y de los que no residen en Santander
SELECT p.* FROM Proveedores p WHERE p.localpro <> 'Santander';

--4. Selecciona los datos de todos los pedidos realizados posteriormente agosto de 2018
SELECT p.* FROM Pedidos p WHERE p.fentrped > '2010-08-31';
SELECT p.* FROM Pedidos p WHERE p.fentrped >= '2010-09-01';

-- 5. Selecciona los datos de todas las líneas de pedidos con un descuento menor al 3%
SELECT l.* from Lineas l WHERE desculin < 3;

-- 6. Selecciona el cif y nombre de los proveedores de Santander u Oviedo
SELECT p.cifpro, p.nombrpro, p.localpro from Proveedores p WHERE p.localpro = 'Santander' OR p.localpro = 'Oviedo';
SELECT p.cifpro, p.nombrpro, p.localpro from Proveedores p WHERE p.localpro IN ('Santander','Oviedo');
-- Al revés, los proveedores que no son ni de Santander ni de oviedo
SELECT p.cifpro, p.nombrpro, p.localpro  FROM Proveedores p WHERE p.localpro NOT IN ('Santander','Oviedo'); 
SELECT pr.cifpro, pr.nombrpro, pr.localpro FROM Proveedores pr WHERE pr.localpro <> 'Santander' AND pr.localpro <> 'Oviedo'; 


--7. Selecciona los datos de todos los pedidos realizados entre junio y septiembre de 2018
SELECT p.* FROM Pedidos p WHERE p.fentrped >= '2010-06-01' AND p.fentrped <='2010-09-30';
SELECT p.* FROM Pedidos p WHERE p.fentrped BETWEEN '2010-06-01' AND '2010-09-30';

-- 8. Selecciona los datos de todas las líneas de pedidos con un descuento menor al 10% pero que no sea 0
SELECT l.* from Lineas l WHERE desculin < 10 AND desculin >0;
SELECT l.* from Lineas l WHERE desculin < 10 AND desculin <>0;

-- ESTO NO!!!!!
SELECT l.* from Lineas l WHERE desculin between 0 AND 10;

-- 9. Selecciona los datos de los artículos con un stock mayor que el stock mínimo
SELECT a.* from articulos a where stockart > stockmin;
-- 10. y todos los pedidos realizados enviados en el mismo día en que se realizaron
SELECT pe.* FROM Pedidos pe
WHERE pe.fechaped = pe.fentrped;


-- 11. Selecciona los datos de los proveedores que no tengan email (nulo)
SELECT p.* from proveedores p where emailpro is null;

-- 12. Selecciona los datos de los proveedores que tengan email (no nulo)
SELECT p.* from proveedores p where emailpro is not null;

-- 13. Selecciona los datos de los artículos cuyo precio unitario sea mayor de 200 y que aún tengan stock por encima del mínimo
SELECT a.* from articulos a where a.preunart>200 and stockart>stockmin;



-- 14. Selecciona todos los proveedores cuyo codigo postal comience por 4
SELECT p.* from proveedores p where p.cpostpro like ('4%');


-- 15. precio del artículo más caro
SELECT MAX(a.preunart) maximo FROM Articulos a;

-- 16. Obtener el pedido más antiguo
SELECT MIN(pe.fechaped) minimo FROM Pedidos pe;

-- 17. IVA medio de los pedidos del proveedor p0001
SELECT AVG(pe.ivaped) media FROM Pedidos pe where pe.codigpro = 'P001';

-- 18. Número de proveedores
SELECT COUNT(*) numero FROM Proveedores pr;

-- 19. Pedidos ordenados por fecha de pedido (asccendente) y fecha de entrega (Descendente)
SELECT pe.* 
FROM Pedidos pe
ORDER BY pe.fechaped ASC, pe.fentrped ASC;

--20. Artículos no dados de baja ordenados por precio y stock (ascendente)
SELECT a.* 
FROM Articulos a
WHERE a.fecbaja IS NULL
ORDER BY a.preunart ASC, a.stockart ASC;



-- 20. Calcula el coste de cada linea de pedidos, sin tener en cuenta los descuentos, y muestralo junto al resto de datos de la línea
SELECT l.*, (l.unilin*l.preunlin) precioTotalSinDesc from lineas l;
-- Devolver el sotck restante de cada artículo hasta antes de llegar al mínimo de stock permitido
SELECT a.*, (a.stockart-a.stockmin) stockRestante FROM Articulos a;

-- 21. devolver los datos de las líneas cuyo precio total sin descuento sea mayor a 300:
SELECT l.*, 
  (l.unilin*l.preunlin) precioTotalSinDesc 
FROM Lineas l 
WHERE (l.unilin*l.preunlin) > 300;

SELECT l.*, 
  (l.unilin*l.preunlin) precioTotalSinDesc 
FROM Lineas l 
WHERE precioTotalSinDesc  > 300






