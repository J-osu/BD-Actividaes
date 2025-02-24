create database if not exists Actividad1;
use Actividad1;
create table cliente (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15)
);
create table vendedor (
    id int auto_increment primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15)
);
create table Marca(
    id int auto_increment primary key,
    nombre varchar(20)
);
create table Modelo(
    id int auto_increment primary key,
    nombre varchar(20),
    id_marca int,
    foreign key (id_marca) references Marca(id) on update cascade
);
create table Version(
    id int auto_increment primary key,
    nombre varchar(20),
    pontencia int,
    precio_base decimal(15, 2) not null,
    tipo_cobustible varchar(20),
    id_modelo int,
    foreign key (id_modelo) references Modelo(id) on update cascade
);
create table Extra(
    id int auto_increment primary key,
    nombre varchar(20),
    descripcion varchar(20)  
);
create table Tiene(
    precio decimal(15, 2) not null
    id_version int,
    id_extra int,
    primary key (id_version, id_extra),
    foreign key (id_version) references Version(id) on update cascade,
    foreign key (id_extra) references Extra(id) on update cascade
);
create table Coche_usado(
    id int auto_increment primary key,
    nombre varchar(20),
    matricula varchar(20),
    precio_tasacion decimal(15, 2) not null,
    fecha_entrega date,
    id_cliente int,
    foreign key (id_cliente) references cliente(id) on update cascade
);
create table Coche_nuevo(
    id int auto_increment primary key,
    matricula varchar(20),
    id_version int,
    foreign key (id_version) references Version(id) on update cascade
);
create table Compra (
    fecha date not null,
    id_cliente int not null,
    id_vendedor int not null,
    id_coche_nuevo int,
    primary key (id_cliente, id_vendedor, id_coche_nuevo),
    foreign key (id_cliente) references cliente(id),
    foreign key (id_vendedor) references vendedor(id),
    foreign key (id_coche_nuevo) references Coche_nuevo(id)
);
create table Tiene2(
    id_extra int,
    id_coche_nuevo int,
    primary key (id_extra, id_coche_nuevo),
    foreign key (id_extra) references Extra(id),
    foreign key (id_coche_nuevo) references Coche_nuevo(id)
)