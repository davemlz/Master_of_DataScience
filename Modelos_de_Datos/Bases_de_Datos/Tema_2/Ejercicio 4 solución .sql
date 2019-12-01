---------------------------------------------------------------------------------------------------------
-- Resolución del Ejercicio 4 - Tema 2
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------
-- 1.	Seleccionar todos los datos de todos los artículos.
Select a.* from articulos a;

-- 2.	Seleccionar los datos de todos los proveedores, ordenados por nombre alfabéticamente, y secundariamente por código postal de forma descendente.
select pr.* from proveedores pr order by pr.nombrpro asc, pr.cpostpro desc;

-- 3.	Seleccionar el número de pedido, la fecha de pedido y el iva de todos los pedidos.
select pe.numped, pe.fechaped, pe.ivaped from pedidos pe;


-- 4.	Devolver las líneas de pedido ‘0002’, ordenadas por el coste total sin descuento (precio * unidad).
select l.* from lineas l where numped = '0002' order by (unilin*preunlin) asc;

-- 5.	Repetir la consulta anterior, devolviendo sólo las líneas sin descuento del mismo proveedor.
select l.* from lineas l where numped = '0002' and desculin=0 order by (unilin*preunlin) asc;

-- 6.	Retornar el número, fecha de pedido y fecha de envío de todos los pedidos que no se hayan enviado el mismo día en que se realizaron.
select pe.numped, pe.fechaped, pe.fentrped from pedidos pe where pe.fechaped<> pe.fentrped;

-- 7.	Seleccionar los datos de los artículos que no se hayan dado de baja, ordenados por nombre alfabéticamente.
select a.* from articulos a where a.fecbaja is null;

-- 8.	Repetir la consulta del punto 6 a la inversa, devolviendo los artículos que se hayan dado de baja.
select a.* from articulos a where a.fecbaja is not null;


-- 9.	Devolver los datos de los artículos dados de baja entre enero y junio de 2018.
select a.* from articulos a where a.fecbaja between '2018-01-01' and '2018-06-30';
select a.* from articulos a where a.fecbaja >= '2018-01-01' and a.fecbaja<= '2018-06-30';

-- 10.	Repetir la consulta anterior, devolviendo solamente los artículos dados de baja que aún tengan un stock mayor a 0.
select a.* from articulos a where a.fecbaja between '2018-01-01' and '2018-06-30' and stockart > 0;

-- 11.	Devolver el código y nombre de todos los proveedores cuyo nombre comience por A o B.
select pr.codigpro, pr.nombrpro from proveedores pr where pr.nombrpro like ('Z%') or  pr.nombrpro like ('B%');

-- 12.	Devolver el código y nombre de todos los proveedores cuyo nombre no comience por Z.
select pr.codigpro, pr.nombrpro from proveedores pr where pr.nombrpro not like ('Z%');

-- 13.	Devolver el código y nombre de todos los proveedores cuyo nombre termine por una vocal.
select pr.codigpro, pr.nombrpro from proveedores pr where pr.nombrpro like ('%a') or pr.nombrpro like ('%e') or pr.nombrpro like ('%i') or pr.nombrpro like ('%o') or pr.nombrpro like ('%u');

-- 14.	Retornar los datos de todos los pedidos cuyo IVA esté entre 18 y 21 (incluidos).
select pe.* from pedidos pe where pe.ivaped between 18 and 21;

-- 15.	Retornar los datos de los proveedores cuyos códigos postales sean ‘39390’ o ‘28119’.
select pr.* from proveedores pr where pr.cpostpro in ('39390','28119');

-- 16.	Repetir, a la inversa, la consulta 12, devolviendo los datos de todos los proveedores cuyos códigos postales no sean ‘39390’ ni ‘28119’.
select pr.* from proveedores pr where pr.cpostpro not in ('39390','28119');

-- 17.	Devolver los datos de los artículos cuya diferencia entre el stock actual y el mínimo sea igual o menor a 5. Devolver también esta diferencia en la proyección del SELECT.
select a.*, (a.stockart - a.stockmin) as stockDif from articulos a where (a.stockart - a.stockmin)<=5;

-- 18.	Devolver el número de líneas del pedido 1.
select count(*) numLinePed1 from lineas l where numped = 1;

-- 19.	Retornar la media de precio de los artículos.
select avg(a.preunart) precioMedio from articulos a;

-- 20.	Devolver el máximo pago realizado en una línea de pedido, teniendo en cuenta las unidades compradas en la línea, su precio y el descuento.
select max(l.unilin*l.preunlin-(l.unilin*l.preunlin*l.desculin/100)) as maximoLineas from lineas l;
