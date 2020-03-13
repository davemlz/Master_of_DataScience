-- PRACTICA 2. CONSULTAS, BORRADOS Y ACTUALIZACIONES
-- MASTER EN DATA SCIENCE

-- DAVID MONTERO LOAIZA

-- 1. Mostrar los datos de los pedidos realizados entre octubre y noviembre de 2018 (0.5 ptos)
select p.* from Pedidos p where p.fechaHoraPedido between '2018-10-01' and '2018-11-31';

-- 2. Devolver el id, nombre, apellido1, apellido2, fecha de alta y fecha de baja de todos los miembros del personal que no estén de baja,
-- ordenados descendentemente por fecha de alta y ascendentemente por nombre
-- (0.75 pto, 0.25 ptos adicionales si la consulta se realiza con el nombre y apellidos concatenados).
select p.idpersonal, p.nombre || ' ' || p.apellido1 || ' ' || p.apellido2 nombre, p.fechaAlta, p.fechaBaja
from Personal p where p.fechaBaja is null order by p.fechaAlta asc, nombre desc;

-- 3. Retornar los datos de todos los clientes cuyo nombre de calle comience por G o J y que además tengan observaciones (1 pto).
select c.* from Clientes c where (c.calle like '% G%' or c.calle like '% J%') and c.observaciones is not null;

-- 4. Devolver el id e importe de las pizzas junto con el id y descripción de todos sus ingredientes,
-- siempre que el importe de estas pizzas sea mayor de 3 (1 pto).
select p.idpizza, p.importeBase, i.idingrediente, i.descripcion from Pizzas p
natural join IngredienteDePizza ip
natural join Ingredientes i
where p.importeBase > 3;

-- 5. Mostrar los datos de todas las pizzas que no hayan sido nunca pedidas, ordenados por id ascendentemente (1 pto).
select p.* from Pizzas p where p.idpizza not in (select lp.idpizza from LineasPedidos lp) order by p.idpizza asc;

-- 6. Devolver los datos de las bases, junto con los datos de las pizzas en las que están presentes,
-- incluyendo los datos de las bases que no están en ninguna pizza (0.5 ptos)
select b.*, p.* from Bases b left join pizzas p on b.idbase = p.idbase;

-- 7. Retornar los datos de los pedidos realizados por el cliente con id 1, junto con los datos de sus líneas y de las pizzas pedidas,
-- siempre que el precio unitario en la línea sea menor que el importe base de la pizza. (1.5 ptos)
select p.*, lp.*, pi.* from Pedidos p
join LineasPedidos lp on p.idpedido = lp.idpedido
join Pizzas pi on lp.idpizza = pi.idpizza
where p.idcliente = 1 and lp.precioUnidad < pi.importeBase;

-- 8. Mostrar el id y nif de todos los clientes, junto con el número total de pedidos realizados
-- (0.75 pto, 0.25 ptos adicionales si sólo se devuelven los datos de los que hayan realizado más de un pedido).
select c.idcliente, c.nif, count(*) totalPedidos from Clientes c
join Pedidos p on c.idcliente = p.idcliente
group by c.idcliente, c.nif
having totalPedidos > 1;

-- 9. Sumar 0.5 al importe base de todas las pizzas que contengan el ingrediente con id ‘JAM’ (0.75 pto).
update Pizzas set importeBase = importeBase + 0.5
where idpizza in (select p.idpizza from Pizzas p
natural join IngredienteDePizza ip
where ip.idingrediente like 'JAM');

-- 10. Eliminar las líneas de los pedidos anteriores a 2018 (0.75 pto).
delete from LineasPedidos where idpedido in
(select p.idpedido from LineasPedidos lp
join Pedidos p on lp.idpedido = p.idpedido
where p.fechaHoraPedido < '2018-01-01');

-- 11. BONUS para el 10: Realizar una consulta que devuelva el número de pizzas totales pedidas por cada cliente.
-- En la consulta deberán aparecer el id y nif de los clientes, además de su nombre y apellidos concatenados (1 pto).
select c.idcliente, c.nif, c.nombre || ' ' || c.apellido1 || ' ' || c.apellido2 nombreCliente, count(*) pizzasTotales from Clientes c
join Pedidos p on c.idcliente = p.idcliente
join LineasPedidos lp on p.idpedido = lp.idpedido
group by c.idcliente, c.nif, nombreCliente;