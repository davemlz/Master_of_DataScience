-- 1. Actualiza el iva de todos los pedidos a 21
UPDATE pedidos set ivaped = 21;
select * from pedidos;

-- 2. Actualiza el email del proveedor con código 'P003' a 'mailto:luzgras@kmail.com'
update proveedores set emailpro = 'mailto:luzgras@kmail.com' where codigpro = 'P004';

-- 3. Pon a 0 el sotck y sotck mínimo de todos los artículos con fecha de baja no nula
update articulos set stockart = 0, stockmin = 0 where fecbaja is not null;


-- 4 Borra todos los datos de la tabla lineas
delete from lineas;

-- 5. Borra los datos de los pedidos del proveedor 'P004'
delete from pedidos where codigpro = 'P004';
