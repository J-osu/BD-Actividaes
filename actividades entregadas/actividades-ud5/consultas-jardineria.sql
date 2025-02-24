--1) Cambia la región de Madrid a MAD en Clientes.
SELECT * FROM Clientes WHERE Region = 'Madrid';
UPDATE Clientes SET Region = 'MAD' WHERE Region = 'Madrid';
--2) Coloca en región lo mismo que en Ciudad en los registros no indicados.
select * from clientes where region = '' or region is null;
UPDATE Clientes SET Region = Ciudad WHERE Region = '';
/*3) Incrementa el precio de venta en un 20% el precio de los productos que
no tengan pedidos.*/
UPDATE Productos SET PrecioVenta = PrecioVenta * 1.2 WHERE CodigoProducto NOT IN (SELECT DISTINCT CodigoProducto FROM DetallePedidos);
/*4) Modifica la tabla DetallePedido para incorporar un campo numérico
llamado TotalLinea, y actualiza todos sus registros para calcular su valor
con la fórmula TotalLinea=PrecioUnidad*Cantidad*IVA/100*/
--ALTER TABLE DetallePedidos ADD COLUMN TotalLinea NUMERIC(15, 2);
UPDATE DetallePedidos SET TotalLinea = PrecioUnidad * Cantidad * 21 / 100;
/*5) Establece a 0 el límite de crédito del cliente que menos unidades pedidas
tenga del producto 'OR-179'. */
-- UPDATE Clientes SET LimiteCredito = 0 WHERE CodigoCliente = (SELECT CodigoCliente FROM Pedidos JOIN DetallePedidos ON Pedidos.CodigoPedido = DetallePedidos.CodigoPedido WHERE CodigoProducto = 'OR-179' GROUP BY CodigoCliente ORDER BY SUM(Cantidad) ASC LIMIT 1);

-- 1) Borra los clientes que no tengan pedidos.
DELETE FROM Clientes WHERE CodigoCliente NOT IN (SELECT DISTINCT CodigoCliente FROM Pedidos);
-- 2) Borra los pagos del cliente con menor límite de crédito.
-- DELETE FROM Pagos WHERE CodigoCliente = (SELECT CodigoCliente FROM Clientes ORDER BY LimiteCredito ASC LIMIT 1);
-- 3) Borra los pagos por cheque.
DELETE FROM Pagos WHERE FormaPago = 'Cheque';
-- 4) Borra los pedidos y su detalle del cliente “Tendo Garden”.
DELETE FROM DetallePedidos WHERE CodigoPedido IN (SELECT CodigoPedido FROM Pedidos WHERE CodigoCliente = (SELECT CodigoCliente FROM Clientes WHERE NombreCliente = 'Tendo Garden'));
DELETE FROM Pedidos WHERE CodigoCliente = (SELECT CodigoCliente FROM Clientes WHERE NombreCliente = 'Tendo Garden');

--==========================================
--Elimina los clientes que no hayan realizado ningún pedido en 2006.
--(antes de eso modifique las claves foraneas y añadí el on delete cascade)
DELETE FROM Clientes 
WHERE CodigoCliente NOT IN (
    SELECT DISTINCT CodigoCliente 
    FROM Pedidos 
    WHERE YEAR(FechaPedido) = 2006
);
--(Estos no son para borrar nada solo estaba probando cosas)
-- select * from pedidos 
-- where codigocliente in ( select codigocliente from pedidos 
-- where year(fechapedido) = 2006) order by fechapedido asc limit 2;
-- select * from detallepedidos where codigopedido 
-- in (select codigopedido from pedidos where codigocliente 
-- in (select codigocliente from pedidos where year(fechapedido) = 2006));

--Reduce en un 20% el precio de venta de los 5 productos que tengan más pedidos.
-- UPDATE Productos P
-- JOIN (
--     SELECT CodigoProducto
--     FROM DetallePedidos
--     GROUP BY CodigoProducto
--     ORDER BY SUM(Cantidad) DESC
--     LIMIT 5
-- ) AS TopProductos
-- ON P.CodigoProducto = TopProductos.CodigoProducto
-- SET P.PrecioVenta = P.PrecioVenta * 0.8;

--Borra los pagos del cliente con menor límite de crédito.
-- DELETE FROM Pagos WHERE CodigoCliente = (
--     SELECT CodigoCliente
--     FROM Clientes
--     ORDER BY LimiteCredito ASC
--     LIMIT 1
-- );

--Establece a 0 el lmite de crdito del cliente que menos unidades pedidas tenga del producto 11679.
-- update Clientes set LimiteCredito = 0 where CodigoCliente = (
--     select CodigoCliente from DetallePedidos where CodigoProducto = '11679' group by CodigoCliente order by sum(Cantidad) asc limit 1
-- );

--Modifica la tabla detalle_pedido para insertar un campo numrico llamado iva. Establece el
-- valor de ese campo a 18 para aquellos registros cuyo pedido tenga fecha a partir de Enero de
-- 2009. A continuacin, actualiza el resto de pedidos estableciendo el iva al 21.
-- ALTER TABLE DetallePedidos ADD COLUMN iva decimal(5,2);
-- UPDATE DetallePedidos DP
-- JOIN Pedidos P ON DP.CodigoPedido = P.CodigoPedido
-- SET DP.iva = 18
-- WHERE P.FechaPedido >= '2009-01-01';
-- UPDATE DetallePedidos DP
-- JOIN Pedidos P ON DP.CodigoPedido = P.CodigoPedido
-- SET DP.iva = 21
-- WHERE P.FechaPedido < '2009-01-01';

--Modifica la tabla detalle_pedido para incorporar un campo numrico llamado total_linea y
-- actualiza todos sus registros para calcular su valor con la frmula: total_linea =
-- precio_unidad*cantidad * (1 + (iva/100));
-- alter table DetallePedidos add column total_linea decimal(15, 2);
-- update DetallePedidos set total_linea = PrecioUnidad * Cantidad * (1 + (iva / 100));

--Borra el cliente que menor lmite de crdito tenga.
-- DELETE FROM Clientes  
-- WHERE CodigoCliente = (  
--     SELECT CodigoCliente  
--     FROM Clientes  
--     ORDER BY LimiteCredito ASC  
--     LIMIT 1  
-- );

--posible borrarlo solo con una consulta? ¿Por qué? No, porque estoy usando la misma tabla para hacer una subconsulta.

--Inserta una oficina con sede en Granada y tres empleados que sean representantes de ventas y sin jefe asignado.
insert into Oficinas (CodigoOficina, Ciudad, Pais, CodigoPostal, Telefono, LineaDireccion1, LineaDireccion2)
VALUES ('G-D', 'Granada', 'España', '28923', '913333333', 'Calle Granada', 'Calle Granada 2');
insert into Empleados (CodigoEmpleado, Nombre, Apellido1, Apellido2, Extension, Email, CodigoOficina, CodigoJefe, Puesto)
VALUES (51, 'Juan', 'Pérez', 'Gómez', '1234', 'XXXXXXXXXXXXXXXXXXXXXXXX', 'G-D', NULL, 'Representante de ventas');
insert into Empleados (CodigoEmpleado, Nombre, Apellido1, Apellido2, Extension, Email, CodigoOficina, CodigoJefe, Puesto)
VALUES (52, 'Juan', 'Pérez', 'Gómez', '1234', 'XXXXXXXXXXXXXXXXXXXXXXXX', 'G-D', NULL, 'Representante de ventas');
insert into Empleados (CodigoEmpleado, Nombre, Apellido1, Apellido2, Extension, Email, CodigoOficina, CodigoJefe, Puesto)
VALUES (53, 'Juan', 'Pérez', 'Gómez', '1234', 'XXXXXXXXXXXXXXXXXXXXXXXX', 'G-D', NULL, 'Representante de ventas');

--Inserta tres clientes que tengan como representantes de ventas los empleados que hemos creado en el paso anterior.
insert into Clientes (CodigoCliente, NombreCliente, NombreContacto, ApellidoContacto, Telefono, Fax, LineaDireccion1, LineaDireccion2, Ciudad, Region, Pais, CodigoPostal, CodigoEmpleadoRepVentas, LimiteCredito)
VALUES (51, 'Cliente de ejemplo', 'Cliente', 'Ejemplo', '913333333', '913333333', 'Calle Granada', 'Calle Granada 2', 'Granada', 'España', 'España', '28923', 51, 10000);
insert into Clientes (CodigoCliente, NombreCliente, NombreContacto, ApellidoContacto, Telefono, Fax, LineaDireccion1, LineaDireccion2, Ciudad, Region, Pais, CodigoPostal, CodigoEmpleadoRepVentas, LimiteCredito)
VALUES (52, 'Cliente de ejemplo', 'Cliente', 'Ejemplo', '913333333', '913333333', 'Calle Granada', 'Calle Granada 2', 'Granada', 'España', 'España', '28923', 52, 10000);
insert into Clientes (CodigoCliente, NombreCliente, NombreContacto, ApellidoContacto, Telefono, Fax, LineaDireccion1, LineaDireccion2, Ciudad, Region, Pais, CodigoPostal, CodigoEmpleadoRepVentas, LimiteCredito)
VALUES (53, 'Cliente de ejemplo', 'Cliente', 'Ejemplo', '913333333', '913333333', 'Calle Granada', 'Calle Granada 2', 'Granada', 'España', 'España', '28923', 53, 10000);
