create database if not exists Formacion;
use Formacion;
create table Curso(
    id int primary key,
    nombre varchar(20),
    descripcion varchar(20),
    duracion varchar(20),
    coste int
);

insert into Curso(id, nombre, descripcion, duracion, coste) values (1, 'GBD', 'Descripcion 1', '1 año', 90);
insert into Curso(id, nombre, descripcion, duracion, coste) values (2, 'PROG', 'Descripcion 2', '2 años', 28);
insert into Curso(id, nombre, descripcion, duracion, coste) values (3, 'LMSGI', 'Descripcion 3', '3 años', 66);
insert into Curso(id, nombre, descripcion, duracion, coste) values (4, 'ENT', 'Descripcion 4', '4 años', 100);


create table Es_prerrequisito(
    PRIMARY KEY (id_curso, id_curso_prerrequisito),
    es_obligatorio char(2),
    id_curso int,
    id_curso_prerrequisito int,
    foreign key (id_curso) references Curso(id) on delete cascade,
    foreign key (id_curso_prerrequisito) references Curso(id) on delete cascade
);

insert into Es_prerrequisito(es_obligatorio, id_curso, id_curso_prerrequisito)
values ('SI', 1, 2);
insert into Es_prerrequisito(es_obligatorio, id_curso, id_curso_prerrequisito)
values ('SI', 2, 3);
insert into Es_prerrequisito(es_obligatorio, id_curso, id_curso_prerrequisito)
values ('SI', 3, 4);
insert into Es_prerrequisito(es_obligatorio, id_curso, id_curso_prerrequisito)
values ('NO', 4, 1);

create table Empleado(
    id int primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(20),
    direccion varchar(20),
    tipo varchar(20)
);

insert into Empleado(id, nombre, apellido1, apellido2, telefono, direccion, tipo)
values (1, 'Pol', 'Apellido 1', 'Apellido 2', 'Telefono 1', 'Direccion 1', 'Capacitado');
insert into Empleado(id, nombre, apellido1, apellido2, telefono, direccion, tipo)
values (2, 'Paola', 'Apellido 1', 'Apellido 2', 'Telefono 2', 'Direccion 2', 'No_Capacitado');
insert into Empleado(id, nombre, apellido1, apellido2, telefono, direccion, tipo)
values (3, 'Maria', 'Apellido 1', 'Apellido 2', 'Telefono 3', 'Direccion 3', 'Capacitado');
insert into Empleado(id, nombre, apellido1, apellido2, telefono, direccion, tipo)
values (4, 'Pepe', 'Apellido 1', 'Apellido 2', 'Telefono 4', 'Direccion 4', 'Capacitado');

create table Edicion(
    id int primary key,
    fecha_inicio date,
    fecha_fin date,
    horario varchar(20),
    lugar varchar(20),
    id_curso int,
    id_empleado_capacitado int,
    foreign key (id_empleado_capacitado) references Empleado(id) on delete cascade,
    foreign key (id_curso) references Curso(id) on delete cascade
);

insert into Edicion(id, fecha_inicio, fecha_fin, horario, lugar, id_curso, id_empleado_capacitado)
values (1, '2020-01-01', '2020-01-06', '9:00', 'Lugar 1', 1, 4);
insert into Edicion(id, fecha_inicio, fecha_fin, horario, lugar, id_curso, id_empleado_capacitado)
values (2, '2020-01-02', '2020-04-07', '10:00', 'Lugar 2', 4, 1);
insert into Edicion(id, fecha_inicio, fecha_fin, horario, lugar, id_curso, id_empleado_capacitado)
values (3, '2020-01-03', '2020-02-04', '11:00', 'Lugar 3', 1, 3);
insert into Edicion(id, fecha_inicio, fecha_fin, horario, lugar, id_curso, id_empleado_capacitado)
values (4, '2020-01-04', '2020-01-05', '12:00', 'Lugar 4', 4, 4);

create table empleado_recibe_edicion(
    PRIMARY KEY (id_empleado, id_edicion),
    id_empleado int,
    id_edicion int,
    foreign key (id_empleado) references Empleado(id) on delete cascade,
    foreign key (id_edicion) references Edicion(id) on delete cascade
);

insert into empleado_recibe_edicion(id_empleado, id_edicion)
values (2, 1);
insert into empleado_recibe_edicion(id_empleado, id_edicion)
values (1, 2);
insert into empleado_recibe_edicion(id_empleado, id_edicion)
values (3, 3);
insert into empleado_recibe_edicion(id_empleado, id_edicion)
values (2, 4);


--=================================

--¿Qué cursos ha impartido el empleado Pepe?
SELECT c.nombre FROM Empleado e, Edicion ed, Curso c WHERE e.nombre = 'Pepe' AND e.id = ed.id_empleado_capacitado AND ed.id_curso = c.id;

--¿Cuántos cursos tiene cada edición? (no entendí muy bien lo que quiere decir pero asumo que es esto)
select count(id_curso) from Edicion;

--Cambiar la fecha de fin a mañana del curso GBD
update Edicion set fecha_fin = '2020-02-22' where id_curso = 1;

--Borra los cursos con coste inferior a 50€.
delete from Curso where coste < 50;