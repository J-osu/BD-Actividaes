--1)Extrae el código y dirección de los proveedores.
select codigo, direccion from proveedores;

--2)Extrae las piezas que son de color rojo.
select nombre from pieza where color = 'rojo';

--3)Extrae las piezas que son del proveedor ‘X’.
select P.*  from Pieza P join Suministra S on P.codigo = S.id_pieza join Proveedor PR on S.id_proveedor = PR.codigo where PR.nombre = 'X';

--4)Extrae las piezas que son del proveedor ‘X’ y categoría ‘Y’.
select p.* from pieza p join categoria c on p.codigo_categoria = c.codigo join suministra s on p.codigo = s.codigo_pieza join proveedor pr on s.codigo_proveedor = pr.codigo where pr.nombre = 'X' and c.nombre = 'Y';