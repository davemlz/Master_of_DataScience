---------------------------------------------------------------------------------------------------------
-- Código del tema 2 sobre funcoines SQLite y estructuras condicionales con CASE
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------

-- 1. Devolver el código de los proveedores junto con su email, y en una nueva columna, el mismo email eliminando el 'mailto:'
SELECT pr.codigpro, pr.emailpro, replace(pr.emailpro,'mailto:','') as email FROM Proveedores pr;

-- 2. Devolver el tipo de dato de cada columna de la tabla artículos
SELECT typeof(a.codigart), typeof(a.descrart), typeof(a.preunart), typeof(a.stockart), typeof(a.stockmin), typeof(a.fecbaja)
FROM Articulos a;

-- 3. Devolver el código de los proveedores, junto con el mensaje “no tiene correo” si su email es nulo. En caso contrario, devolver su email.
SELECT pr.codigpro, CASE WHEN pr.emailpro IS NULL THEN 'no tiene correo' ELSE pr.emailpro END as email FROM Proveedores pr;

-- 4. Devolver los artículos junto con una columna que indique "precioAlto" cuando el precio sea mayor a 300, "precioMedio" cuando el precio esté entre 150 y 300, y "precioBajo" cuando este sea menor de 150
SELECT a.*, CASE WHEN a.preunart > 300 THEN 'precioAlto' WHEN a.preunart >= 150 AND a.preunart <= 300 THEN 'precioMedio' ELSE 'precioBajo' END precio FROM Articulos a;