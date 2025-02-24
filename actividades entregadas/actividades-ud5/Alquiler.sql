create database Alquiler;

use Alquiler;

create table Agencia (
    id int primary key,
    nombre varchar(20),
    direccion varchar(20),
    telefono varchar(15)
);

insert into agencia values (1, 'Agencia 1', 'calle-direcion1', '123456789');
insert into agencia values (2, 'Agencia 2', 'Calle-direcion2', '987654321');
insert into agencia values (3, 'Agencia 3', 'Calle-direcion3', '456789123');
insert into agencia values (4, 'Agencia 4', 'Calle-direcion4', '321654987');

create table Propietario(
    id int primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15)
);

insert into Propietario values (1, 'Juan', 'Apellido 1', 'Apellido 2', 'Calle-direcion1', '123456789');
insert into Propietario values (2, 'Ana', 'Apellido 1', 'Apellido 2', 'Calle-direcion2', '987654321');
insert into Propietario values (3, 'Pepe', 'Apellido 1', 'Apellido 2', 'Calle-direcion3', '456789123');
insert into Propietario values (4, 'Mario', 'Apellido 1', 'Apellido 2', 'Calle-direcion4', '321654987');

create table Vivienda(
    id int primary key,
    descripcion varchar(20),
    numero int,
    codigo_postal int,
    poblacion varchar(20),
    piso varchar(20),
    id_agencia int,
    id_propietario int,
    foreign key (id_propietario) references Propietario(id) on update cascade,
    foreign key (id_agencia) references agencia(id) on update cascade
);

insert into Vivienda values (1, 'Vivienda 1', 1, 12345, 'Almeria', 'Piso 1', 1, 1);
insert into Vivienda values (2, 'Vivienda 2', 2, 54321, 'Albox', 'Piso 2', 2, 1);
insert into Vivienda values (3, 'Vivienda 3', 3, 98765, 'Huelva', 'Piso 3', 1, 3);
insert into Vivienda values (4, 'Vivienda 4', 4, 67890, 'Almeria', 'Piso 4', 2, 4);

create table Inquilino(
    id int primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15),
    fecha_nacimiento date
);

insert into Inquilino values (1, 'Isa', 'Apellido 1', 'Apellido 2', 'Calle 1', '123456789', '1990-01-01');
insert into Inquilino values (2, 'Pablo', 'Apellido 1', 'Apellido 2', 'Calle 2', '987654321', '1991-02-02');
insert into Inquilino values (3, 'Tomas', 'Apellido 1', 'Apellido 2', 'Calle 3', '456789123', '1992-03-03');
insert into Inquilino values (4, 'Isma', 'Apellido 1', 'Apellido 2', 'Calle 4', '321654987', '1993-04-04');

create table Alquiler (
    id int primary key,
    fecha_inicio date,
    fecha_fin date,
    fehca_firma date,
    fianza int,
    importe int,
    id_inquilino int,
    id_vivienda int,
    foreign key (id_inquilino) references Inquilino(id) on update cascade,
    foreign key (id_vivienda) references Vivienda(id) on update cascade
);

insert into Alquiler values (1, '2020-01-01', '2020-12-31', '2020-01-01', 1000, 1000, 1, 1);
insert into Alquiler values (2, '2021-01-01', '2021-12-31', '2021-01-01', 250, 600, 2, 2);
insert into Alquiler values (3, '2022-01-01', '2022-12-31', '2022-01-01', 600, 380, 3, 3);
insert into Alquiler values (4, '2023-01-01', '2023-12-31', '2023-01-01', 400, 400, 4, 4);

create table Renovada(
    id int primary key,
    id_alquiler int,
    foreign key (id_alquiler) references alquiler(id) on update cascade
);

insert into Renovada values (1, 1);
insert into Renovada values (2, 1);
insert into Renovada values (3, 3);
insert into Renovada values (4, 2);


-- Obtener los alquileres que han sido renovados.
select * from renovada;

--¿Qué propietario tiene más viviendas?
-- SELECT nombre 
-- FROM Propietario 
-- WHERE id = (
--     SELECT id_propietario 
--     FROM Vivienda 
--     GROUP BY id_propietario 
--     ORDER BY COUNT(*) desc
--     limit 1
-- );

--¿Qué agencia oferta viviendas de Almería?
select id from vivienda where poblacion = 'Almeria';

--Sube el importe del alquiler un 2’5 %
update alquiler set importe = importe * 1.025;

--Borra las agencias que no ofertan viviendas
delete from agencia where id not in (select id_agencia from vivienda);

--Cambia el ID de un propietario.
--(esto es antes para ver cómo estba antes)
select id, nombre from propietario;
--(después)
update propietario set id = 5 where id = 1;

--Extrae la información de las viviendas que tienen un alquiler superior a 500€.
select * from alquiler where importe > 500;

--De cada alquiler, extrae extrae quién lo alquiló y por cuánto tiempo lo hizo.
select id_inquilino, fecha_fin - fecha_inicio from alquiler;

--Borra los propietarios que no tienen viviendas en Albox.
alter table vivienda drop foreign key vivienda_ibfk_2;
alter table vivienda add foreign key (id_propietario) references propietario(id) on update cascade on delete cascade;
delete from propietario where id not in (select id_propietario from vivienda where poblacion = 'Albox');

--Incrementa un 21% el importe de todos los alquileres con importe inverior a 500€.
update alquiler set importe = importe * 1.21 where importe < 500;