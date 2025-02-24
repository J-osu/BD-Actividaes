create database if not exists Actividad2;
use Actividad2;
create table Curso(
    id int primary key auto_increment,
    nombre varchar(20),
    descripcion varchar(20),
    duracion varchar(20),
    coste int
);
create table Es_prerrequisito(
    es_obligatosio char(2),
    id_curso int,
    id_curso_prerrequisito int,
    foreign key (id_curso) references Curso(id) on update cascade,
    foreign key (id_curso_prerrequisito) references Curso(id) on update cascade
);
create table Edicion(
    id int primary key auto_increment,
    fecha_inicio date,
    fecha_fin date,
    horario varchar(20),
    lugar varchar(20),
    id_curso int,
    id_capacitado int,
    foreign key (id_curso) references Curso(id) on update cascade,
    foreign key (id_capacitado) references Capacitado(id) on update cascade
);
create table Empleado(
    id int primary key auto_increment,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(20),
    direccion varchar(20),
    tipo varchar(20)
);
create table Recibe(
    id_empleado int,
    id_edicion int,
    foreign key (id_empleado) references Empleado(id) on update cascade,
    foreign key (id_edicion) references Edicion(id) on update cascade
);
create table Capacitado(
    id_empleado int,
    id_curso int,
    foreign key (id_empleado) references Empleado(id) on update cascade,
    foreign key (id_curso) references Curso(id) on update cascade
);

--====================================================================
/*Crea la tabla Capacitado con la clave id y un campo certificado como varchar(20). Esto hará
que cambies la FK en Edición.*/
alter table Capacitado add column certificado varchar(20);
alter table Edicion drop foreign key Edicion_ibfk_2;

--• Renombra la tabla Edición por Ediciones
alter table Edicion rename to Ediciones;

/*Inserta una columna en Ediciones llamada “nombre” que sea un varchar(20) y que esté entre
id y fecha_inicio.
*/
alter table Ediciones add column nombre varchar(20) after id;

--Haz una copia exacta de la tabla Curso y llámala copiaCurso
create table copiaCurso like Curso;

--Borra la columna descripción en Curso
alter table Curso drop column descripcion;

/*Vuelve a insertar donde estaba la columna descripción y añade además las restricciones de
NOT NULL y un valor por defecto “calle”
*/
alter table Curso add column descripcion varchar(20) not null default 'calle';

/*Borra la referencia externa de Edición y añade una nueva que contemple el caso de on delete
para que borre en cascada
*/
alter table Ediciones drop foreign key Ediciones_ibfk_1;
alter table Ediciones add foreign key (id_curso) references Curso(id) on update cascade on delete cascade;

--Borra la clave primaria de Ediciones y crea otra con id e id_capacitado
alter table Ediciones drop primary key;
alter table Ediciones add primary key (id,id_capacitado);

--Cambia el tipo de dato de fecha_inicio a varchar(10)
alter table Ediciones modify column fecha_inicio varchar(10);

--Crea un índice sobre la tabla Curso por los campos id y coste
create index index_curso on Curso(id, coste);

/*Crea una vista sobre la tabla Ediciones que ejecute la consulta: select id, nombre, lugar from
Ediciones
*/
create view vistaEdiciones as select id, nombre, lugar from Ediciones;