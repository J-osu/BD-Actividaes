-- 5)El código de oficina y la ciudad donde hay oficinas en EEUU.

select CodigoOficina, Ciudad from Oficinas where Pais = 'EEUU';

-- 6)Cuántos empleados hay en la compañía.

select count(*) from Empleados;

-- 7)Cuántos clientes tiene cada país.

select Pais, count(*) from Clientes group by Pais;

-- 8)Cuál fue el pago medio en 2008 (pista: Usar la función YEAR de MySQL o la función to-char(fecha,'yyyy') de Oracle o LIKE).

select avg(Cantidad) from Pagos where year(FechaPago) = 2008;

-- 9)Cuántos pedidos están en cada estado y ordena esta cuenta de manera descendente.

select estado, COUNT(*) AS total_pedidos from pedidos group by estado order by total_pedidos DESC;

-- 10)El precio del producto más caro y del más barato.

select max(PrecioVenta) as precio_mas_caro, min(PrecioVenta) as precio_mas_barato from Productos;

-- 11)Obtén el nombre del cliente con mayor límite de crédito.

select NombreCliente, limiteCredito from Clientes order by LimiteCredito DESC limit 1;

-- 12)Obtén el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

select Nombre, Apellido1, Puesto from Empleados where CodigoEmpleado not in (select CodigoEmpleadoRepVentas from Clientes);

-- 13)El nombre, los apellidos y el email de los empleados cuyo jefe es el empleado Alberto Soria.

select Nombre, Apellido1, Apellido2, Email from Empleados where CodigoJefe = (select CodigoEmpleado from Empleados where Nombre = 'Alberto' and Apellido1 = 'Soria');

-- 14)El cargo, nombre, apellidos y email del jefe de la empresa.

select nombre, apellido1, apellido2, puesto, email, codigojefe from empleados 
where codigoEmpleado = (select codigoEmpleado from empleados where puesto = 'director general');

-- 15)El nombre, apellidos y cargo de aquellos que no tienen puesto de representantes de ventas.

select nombre, apellido1, apellido2, puesto from empleados where puesto not like 'representante ventas' and puesto not like 'representante de ventas';

-- 16)El número de clientes que tiene la empresa.

select count(*) as total_clientes from clientes;

-- 17)El nombre de los clientes españoles.

select nombrecliente from clientes where pais = 'españa';

-- 18)¿Cuántos pedidos entregados ha realizado cada cliente?

select codigocliente, count(*) AS total_pedidos_entregados from pedidos
where estado = 'Entregado' group by codigocliente;

-- 19)¿Cuántos clientes tiene la ciudad de Madrid?

select count(*) as total_clientes from clientes where ciudad = 'Madrid';

-- 20)¿Cuántos clientes tienen las ciudades que empiezan por M?

select count(*) as total_clientes from clientes where ciudad like 'M%';

-- 21)El código de empleado y el número de clientes al que atiende cada representante de ventas.

select codigoempleadoRepVentas as codigoempleado, count(*) as total_clientes
from clientes group by codigoempleadoRepVentas;

-- 22)El número de clientes que no tiene asignado representante de ventas.

select count(*) as total_clientes from clientes where codigoempleadoRepVentas is null;

-- 23)¿Cuál fue la primera y última fecha en la que se hizo un pago?

select min(fechapago) as primera_fecha, max(fechapago) as ultima_fecha from pagos;

-- 24)El código de cliente de aquellos que hicieron pagos en 2008.

select codigocliente from pagos where year(fechapago) = 2008;

-- 25)Los distintos estados por los que puede pasar un pedido.

select distinct estado from pedidos;

-- 26)El número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregados a tiempo.

select codigopedido, codigocliente, fechaesperada, fechaentrega from pedidos where fechaentrega > fechaesperada;

-- 27)¿Cuántos productos existen en cada gama?

select gama, count(*) as total_productos from productos group by gama;

-- 28)Saca los 20 productos más solicitados por cantidad.

select codigoproducto, sum(cantidad) as total_cantidad from detallepedidos group by codigoproducto order by total_cantidad desc limit 20;

-- 29)La facturación que ha tenido la empresa en toda la historia, indicando el subtotal, el IVA y el total facturado. (cuidado con cómo usas los cálculos).

select sum(cantidad * preciounidad) as subtotal, sum(cantidad * preciounidad * (0.21)) as iva, sum(cantidad * preciounidad * (1 + (0.21))) as total_facturado from detallepedidos;

-- 30)La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por FR. 

select codigoproducto, sum(cantidad * preciounidad) as subtotal, sum(cantidad * preciounidad * (0.21)) as iva, sum(cantidad * preciounidad * (1 + (0.21))) as total_facturado from detallepedidos where codigoproducto like 'FR%' group by codigoproducto;


-- 1)¿Cuál es el nombre del producto con precio venta más caro?

select nombre from productos order by precioventa desc limit 1;

-- 2)¿Cuál es el nombre del producto del que más unidades se hayan vendido en un pedido?

select p.nombre from productos p join detallepedidos dp on p.codigoproducto = dp.codigoproducto
join pedidos pe on dp.codigopedido = pe.codigopedido group by p.codigoproducto, p.nombre 
order by sum(dp.cantidad) desc limit 1;

-- 3)El producto que más unidades tiene en stock o el que menos unidades tiene.

(SELECT nombre, cantidadenstock FROM productos ORDER BY cantidadenstock DESC LIMIT 1)
UNION
(SELECT nombre, cantidadenstock FROM productos ORDER BY cantidadenstock ASC LIMIT 1);

-- 4)¿Qué empleados trabajan en la oficinas de Madrid y Sydney?

select e.nombre, e.apellido1 from empleados e join oficinas o on e.codigooficina = o.codigooficina
where o.ciudad in ('Madrid', 'Sydney');

-- 5)¿Qué productos tienen una gama relacionada con plantas?

select nombre from productos where gama like '%plantas%';

-- 6)Utiliza la UNION para extraer el (nomre apellidos) y email de los empleados que son Director Oficina y Secretaria.

select nombre, apellido1, email from empleados where LOWER(puesto) = 'director oficina' 
union 
select nombre, apellido1, email from empleados where LOWER(puesto) = 'secretaria';
