create database Revista;

use Revista;

create table sucursal (
    codigo int primary key,
    direccion varchar(20),
    telefono varchar(15),
    ciudad varchar(20),
    provincia varchar(20)
);

insert into sucursal (codigo, direccion, telefono, ciudad, provincia) values (1, 'Calle 1', '123456789', 'Madrid', 'Madrid');
insert into sucursal (codigo, direccion, telefono, ciudad, provincia) values (2, 'Calle 2', '987654321', 'Barcelona', 'Barcelona');
insert into sucursal (codigo, direccion, telefono, ciudad, provincia) values (3, 'Calle 3', '555555555', 'Valencia', 'Valencia');
insert into sucursal (codigo, direccion, telefono, ciudad, provincia) values (4, 'Calle 4', '111111111', 'Almeria', 'Almeria');


create table empleado (
    id int primary key,
    nombre varchar(20),
    puesto varchar(20),
    id_sucursal int,
    foreign key (id_sucursal) references sucursal(codigo)
);

insert into empleado (id, nombre, puesto, id_sucursal) values (1, 'Juan', 'Editor', 1);
insert into empleado (id, nombre, puesto, id_sucursal) values (2, 'Ana', 'Periodista', 2);
insert into empleado (id, nombre, puesto, id_sucursal) values (3, 'Carlos', 'Editor', 3);
insert into empleado (id, nombre, puesto, id_sucursal) values (4, 'Laura', 'Periodista', 4);


create table Revista(
    id int primary key,
    titulo varchar(20),
    tipo varchar(20),
    periodicidad varchar(20)
);

insert into Revista (id, titulo, tipo, periodicidad) values (1, 'Revista 1', 'seccion', 'Mensual');
insert into Revista (id, titulo, tipo, periodicidad) values (2, 'Revista 2', 'ejemplar', 'Anual');
insert into Revista (id, titulo, tipo, periodicidad) values (3, 'Revista 3', 'ejemplar', 'Semanal');
insert into Revista (id, titulo, tipo, periodicidad) values (4, 'Revista 4', 'seccion', 'Mensual');

create table Sucursal_Publica_Revista(
    codigo_sucursal int not null,
    id_revista int not null,
    primary key (codigo_sucursal, id_revista),
    foreign key (codigo_sucursal) references sucursal(codigo),
    foreign key (id_revista) references Revista(id)
);

insert into Sucursal_Publica_Revista (codigo_sucursal, id_revista) values (1, 1);
insert into Sucursal_Publica_Revista (codigo_sucursal, id_revista) values (2, 2);
insert into Sucursal_Publica_Revista (codigo_sucursal, id_revista) values (3, 3);
insert into Sucursal_Publica_Revista (codigo_sucursal, id_revista) values (4, 4);


create table Periodista(
    id int primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(15),
    especialidad varchar(20)
);

insert into Periodista (id, nombre, apellido1, apellido2, telefono, especialidad) values (1, 'Pedro', 'Garcia', 'Lopez', '123456789', 'Periodista');
insert into Periodista (id, nombre, apellido1, apellido2, telefono, especialidad) values (2, 'Maria', 'Gonzalez', 'Martinez', '987654321', 'Periodista');
insert into Periodista (id, nombre, apellido1, apellido2, telefono, especialidad) values (3, 'Ana', 'Fernandez', 'Gomez', '555555555', 'Periodista');
insert into Periodista (id, nombre, apellido1, apellido2, telefono, especialidad) values (4, 'Luis', 'Rodriguez', 'Perez', '111111111', 'Periodista');


create table Periodista_escribe_Revista(
    id_periodista int not null,
    id_revista int not null,
    primary key (id_periodista, id_revista),
    foreign key (id_periodista) references Periodista(id),
    foreign key (id_revista) references Revista(id)
);

insert into Periodista_escribe_Revista (id_periodista, id_revista) values (1, 1);
insert into Periodista_escribe_Revista (id_periodista, id_revista) values (1, 2);
insert into Periodista_escribe_Revista (id_periodista, id_revista) values (4, 3);
insert into Periodista_escribe_Revista (id_periodista, id_revista) values (2, 4);


create table Seccion(
    id int primary key,
    titulo varchar(20),
    extension varchar(20),
    numero_registro_revista int,
    foreign key (numero_registro_revista) references Revista(id)
);

insert into Seccion (id, titulo, extension, numero_registro_revista) values (1, 'Seccion 1', '100', 1);
insert into Seccion (id, titulo, extension, numero_registro_revista) values (2, 'Seccion 2', '200', 1);
insert into Seccion (id, titulo, extension, numero_registro_revista) values (3, 'Seccion 3', '300', 2);
insert into Seccion (id, titulo, extension, numero_registro_revista) values (4, 'Seccion 4', '400', 4);


create table Ejemplar(
    id int primary key,
    numero_ejemplares int,
    numero_paginas int,
    fecha date,
    numero_registro_revista int,
    foreign key (numero_registro_revista) references Revista(id)
);

insert into Ejemplar (id, numero_ejemplares, numero_paginas, fecha, numero_registro_revista) values (1, 10, 100, '2020-01-01', 1);
insert into Ejemplar (id, numero_ejemplares, numero_paginas, fecha, numero_registro_revista) values (2, 20, 200, '2020-01-02', 3);
insert into Ejemplar (id, numero_ejemplares, numero_paginas, fecha, numero_registro_revista) values (3, 30, 300, '2020-01-03', 3);
insert into Ejemplar (id, numero_ejemplares, numero_paginas, fecha, numero_registro_revista) values (4, 40, 400, '2020-01-04', 1);


--================================================

--¿Qué revista tiene más secciones y más ejemplares? (UNION)
SELECT id, titulo, total, tipo FROM (
    SELECT R.id, R.titulo, COUNT(S.id) AS total, 'Secciones' AS tipo
    FROM Revista R
    JOIN Seccion S ON R.id = S.numero_registro_revista
    GROUP BY R.id, R.titulo
    ORDER BY total DESC
    LIMIT 1
) AS SeccionesMax

UNION

SELECT id, titulo, total, tipo FROM (
    SELECT R.id, R.titulo, COUNT(E.id) AS total, 'Ejemplares' AS tipo
    FROM Revista R
    JOIN Ejemplar E ON R.id = E.numero_registro_revista
    GROUP BY R.id, R.titulo
    ORDER BY total DESC
    LIMIT 1
) AS EjemplaresMax;

--Pon “corazón” en la especialidad de los periodistas.
UPDATE Periodista SET especialidad = 'corazón' WHERE especialidad = 'periodista';

--¿Qué empleados están en una sucursal de Almería?
SELECT E.nombre, E.puesto FROM Empleado E
JOIN Sucursal S ON E.id_sucursal = S.codigo
WHERE S.ciudad = 'Almeria';

--Comprueba si hay revistas escritas por más de 2 periodistas.
SELECT R.titulo, COUNT(DISTINCT P.id) AS num_periodistas FROM Revista R
JOIN Periodista_escribe_Revista PER ON R.id = PER.id_revista
JOIN Periodista P ON PER.id_periodista = P.id
GROUP BY R.titulo;

--Borra los periodistas que no han escrito nada.
DELETE FROM Periodista WHERE id NOT IN (
    SELECT DISTINCT id_periodista FROM Periodista_escribe_Revista
);