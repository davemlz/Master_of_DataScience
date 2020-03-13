---------------------------------------------------------------------------------------------------------
-- Resolución del Ejercicio 6 - Tema 2
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------

-- 1.	Devolver el tipo de dato, para cada fila, de las columnas ‘codigpro’, ‘cifpro’ y ‘emailpro’ de la tabla Proveedores.
SELECT typeof(pr.codigpro), typeof(pr.cifpro), typeof(pr.emailpro) FROM Proveedores pr;

-- 2.	Devolver el código de los proveedores junto con sus teléfonos y faxes, eliminando de estos últimos el prefijo nacional ‘(34)’.
SELECT pr.codigpro, replace(pr.telefpro,'(34) ','') as telefono, replace(pr.faxpro,'(34) ','') as fax FROM Proveedores pr;

-- 3.	Devolver el código de los artículos junto con el tamaño (en número de caracteres) del campo ‘descart’.
SELECT a.codigart, length(a.descrart) as tamanio FROM Articulos a;

-- 4.	Retornar el código de los proveedores junto a su dirección, esta última con todos los caracteres en minúscula.
SELECT pr.codigpro, lower(pr.direcpro) as direccion FROM Proveedores pr;

-- 5.	Devolver los datos de los artículos junto a una columna adicional que retorne ‘reponer’ si el stock es igual o menor al stock mínimo, y ‘no reponer’ en caso contrario.
SELECT a.*, CASE WHEN a.stockart > a.stockmin THEN 'no reponer' ELSE 'reponer' END as reposicion FROM Articulos a; 

-- 6.	Devolver los datos de los pedidos junto con una columna adicional que muestre la fecha más alta de entre la fecha de pedido y la fecha de entrega para cada fila. 
-- Es decir, deberá mostrar la fecha de pedido si está es posterior a la de envío. Implementar esta consulta usando la estructura CASE.
SELECT pe.*, CASE WHEN pe.fechaped > pe.fentrped THEN pe.fechaped ELSE pe.fentrped END as fechaPost FROM Pedidos pe;

-- 7.	Repetir la consulta anterior usando funciones de SQLite en vez de la estructura condicional CASE.
SELECT pe.*, max(pe.fechaped, pe.fentrped) as fechaPost FROM Pedidos pe;
