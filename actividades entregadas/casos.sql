create database if not exists caso1;
use caso1;
create table Proveedor(
    codigo int auto_increment primary key,
    nombre varchar(20) not null,
    direccion varchar(20),
    provincia varchar(20),
    telefono varchar(15)
);
create table Categoria(
    codigo int auto_increment primary key,
    nombre varchar(20) not null
);
create table Pieza(
    codigo int auto_increment primary key,
    nombre varchar(20) not null
    color varchar(20),
    precio int,
    id_categoria int,
    foreign key (id_categoria) references Categoria(codigo)
);
create table Suministra(
    id_proveedor int,
    id_pieza int,
    primary key (id_proveedor, id_pieza),
    foreign key (id_proveedor) references Proveedor(codigo),
    foreign key (id_pieza) references Pieza(codigo)
)

--=============================================================================================

create database if not exists caso2;
use caso2;
create table Profesor(
    id int auto_increment primary key
);
create table Alumno(
    id int auto_increment primary key
);
create table Practica(
    id int auto_increment primary key
);
create table Examen_Teorico(
    id int auto_increment primary key,
    id_profesor int,
    foreign key (id_profesor) references Profesor(id)
);
create  table Realiza(
    id_alumno int,
    id_practica int,
    primary key (id_alumno, id_practica),
    foreign key (id_alumno) references Alumno(id),
    foreign key (id_practica) references Practica(id)
);
create table Diseña(
    id_profesor int,
    id_practica int,
    primary key (id_profesor, id_practica),
    foreign key (id_profesor) references Profesor(id),
    foreign key (id_practica) references Practica(id)
);
create table Hace(
    id_alumno int,
    id_examen_teorico int,
    primary key (id_alumno, id_examen_teorico),
    foreign key (id_alumno) references Alumno(id),
    foreign key (id_examen_teorico) references Examen_Teorico(id) int
);

--=================================================================================================
create database if not exists caso3;
use caso3;
create table sucursal (
    codigo int auto_increment primary key,
    direccion varchar(20) not null,
    telefono varchar(15),
    ciudad varchar(20),
    provincia varchar(20)
);
create table empleado (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    puesto varchar(20),
    id_sucursal int,
    foreign key (id_sucursal) references sucursal(id)
);
create table Revista(
    id int auto_increment primary key,
    titulo varchar(20) not null,
    periodicidad varchar(20)
);
create table Sucursal_Publica_Revista(
    codigo_sucursal int not null,
    id_revista int not null,
    primary key (codigo_sucursal, id_revista),
    foreign key (codigo_sucursal) references sucursal(codig),
    foreign key (id_revista) references Revista(id)
);
create table Periodista(
    id int primary key,
    nombre varchar(20) not null,
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(15),
    especialidad varchar(20)
);
create table Periodista_escribe_Revista(
    id_periodista int not null,
    id_revista int not null,
    primary key (id_periodista, id_revista),
    foreign key (id_periodista) references Periodista(id),
    foreign key (id_revista) references Revista(id)
);
create table Seccion(
    id int auto_increment primary key,
    titulo varchar(20) not null,
    extension varchar(20),
    numero_registro_revista int,
    foreign key (numero_registro_revista) references Revista(id)
);
create table Ejemplar(
    id int auto_increment primary key,
    numero_ejemplares int,
    numero_paginas int,
    fecha date,
    numero_registro_revista int,
    foreign key (numero_registro_revista) references Revista(id)
);

--============================================================================================

create database if not exists caso4;
use caso4;
create table agencia (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    direccion varchar(20),
    telefono varchar(15)
);
create table Propietario(
    id int auto_increment primary key,
    nombre varchar(20) not null,
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15)
);
create table Vivienda(
    id int auto_increment primary key,
    descripcion varchar(20),
    numero int,
    codigo_postal int,
    poblacion varchar(20),
    piso varchar(20),
    id_agencia int,
    id_propietario int,
    foreign key (id_propietario) references Propietario(id),
    foreign key (id_agencia) references agencia(id)
);
create table Inquilino(
    id int auto_increment primary key,
    nombre varchar(20) not null,
    apellido1 varchar(20),
    apellido2 varchar(20),
    direccion varchar(20),
    telefono varchar(15),
    fecha_nacimiento date
);
create table alquiler (
    id int auto_increment primary key,
    fecha_inicio date not null,
    fecha_fin date not null,
    fehca_firma date,
    fianza int,
    importe int,
    id_inquilino int,
    id_vivienda int,
    foreign key (id_inquilino) references Inquilino(id),
    foreign key (id_vivienda) references Vivienda(id)
);
create table Renovada(
    id int primary key,
    id_alquiler int,
    foreign key (id_alquiler) references alquiler(id)
);

--======================================================================================
create database if not exists caso5;
use caso5;
create table Alumno(
    numero_matricula int primary key auto_increment,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(20),
    fecha_nacimiento date
);
create table Curso(
    id int primary key auto_increment,
    ano_inicio int,
    ano_fin int
);
create table Asignatura(
    codigo int primary key auto_increment,
    nombre varchar(20),
    numero_horas int,
    id_profesor int,
    foreign key (id_profesor) references Profesor(id) on update cascade
);
create table Profesor(
    id int primary key auto_increment,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(20),
    direccion varchar(20),
    tipo varchar(20)
);
create table Matricula(
    numero_matricula int.
    id_curso_escolar int,
    codigo_asignatura int,
    foreign key (numero_matricula) references Alumno(numero_matricula) on update cascade,
    foreign key (id_curso_escolar) references Curso(id) on update cascade,
    foreign key (id_asignatura) references Asignatura(codigo) on update cascade
);

--========================================================================================
create database if not exists caso6;
use caso6;
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

--==========================================================================
create database if not exists caso7;
use caso7;
create table profesor (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    apellido1 varchar(20) not null,
    apellido2 varchar(20),
    despacho varchar(20),
    telefono varchar(15),
    tipo enum('doctor', 'no_doctor') not null
);
create table proyecto_investigacion (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    programa_id varchar(20),
    descripcion text,
    fecha_inicio date not null,
    fecha_fin date,
    presupuesto decimal(15, 2),
    id_doctor int,
    foreign key (id_doctor) references profesor(id)
);
create table profesor_trabaja_proyecto (
    id_profesor int,
    id_proyecto int,
    fecha_inicio date not null,
    fecha_fin date,
    primary key (id_profesor, id_proyecto),
    foreign key (id_profesor) references profesor(id),
    foreign key (id_proyecto) references proyecto_investigacion(id)
);
create table doctor_supervisa_no_doctor (
    id_doctor int,
    id_no_doctor int,
    fecha_inicio date not null,
    fecha_fin date,
    primary key (id_doctor, id_no_doctor),
    foreign key (id_doctor) references profesor(id),
    foreign key (id_no_doctor) references profesor(id)
);
create table publicacion (
    id int auto_increment primary key,
    titulo varchar(20) not null,
    tipo enum('revista', 'congreso') not null
);
create table revista (
    id int primary key,
    volumen int not null,
    numero int not null,
    pagina_inicio int not null,
    pagina_fin int not null,
    foreign key (id) references publicacion(id)
);
create table congreso (
    id int primary key,
    tipo varchar(20) not null,
    ciudad varchar(20) not null,
    pais varchar(20) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    foreign key (id) references publicacion(id)
);
create table profesor_escribe_publicacion (
    id_profesor int,
    id_publicacion int,
    primary key (id_profesor, id_publicacion),
    foreign key (id_profesor) references profesor(id),
    foreign key (id_publicacion) references publicacion(id)
);

--==================================================================================

create database if not exists caso8;
use caso8;
create table Cliente(
    id int primary key auto_increment,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    telefono varchar(20),
    direccion varchar(20),
    email varchar(20)
);
create table Autor(
    id int primary key auto_increment,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20),
    _url varchar(20),
    email varchar(20)
);
create table Editorial(
    id int primary key auto_increment,
    nombre varchar(20),
    _url varchar(20),
    email varchar(20),
    telefono varchar(20),
    direccion varchar(20)
);
create table Almacen(
    id int primary key auto_increment,
    telefono varchar(20),
    direccion varchar(20)
);
create table Cesta(
    id int primary key auto_increment,
    fecha_compra date,
    id_cliente int,
    foreign key (id_cliente) references Cliente(id) on update cascade
);
create table Libro(
    id int primary key auto_increment,
    titulo varchar(20),
    sbn varchar(20),
    ano_publicacion date,
    descripcion varchar(20)
);
create table Almacena(
    stock int,
    id_almacen int,
    id_libro int,
    foreign key (id_almacen) references Almacen(id) on update cascade,
    foreign key (id_libro) references Libro(id) on update cascade
);
create table Contiene(
    cantidad int,
    id_cesta int,
    id_libro int,
    foreign key (id_cesta) references Cesta(id) on update cascade,
    foreign key (id_libro) references Libro(id) on update cascade
);
create table Escribe(
    id_autor int,
    id_libro int,
    foreign key (id_autor) references Autor(id) on update cascade,
    foreign key (id_libro) references Libro(id) on update cascade
);
create table Papel(
    fecha_impresion date,
    precio float,
    lugar_impresion varchar(20),
    id_libro int,
    foreign key (id_libro) references Libro(id) on update cascade
);
create table Digital(
    tamano float,
    precio float,
    id_libro int,
    foreign key (id_libro) references Libro(id) on update cascade
);
create table Publica(
    id_libro int,
    id_editorial int,
    foreign key (id_libro) references Libro(id) on update cascade,
    foreign key (id_editorial) references Editorial(id) on update cascade
);
create table Provincia(
    id int primary key,
    nombre varchar (20),
    id_localidad int,
    foreign key (id_localidad) references Localidad(id) on update cascade
);
create table Localidad(
    id int primary key,
    nombre varchar(20),
    id_cliente int,
    id_autor int,
    id_editorial int,
    id_almacen int,
    foreign key (id_cliente) references Cliente(id) on update cascade,
    foreign key (id_autor) references Autor(id) on update cascade,
    foreign key (id_editorial) references Editorial(id) on update cascade,
    foreign key (id_almacen) references Almacen(id) on update cascade
);

--===========================================================

create database if not exists caso9;
use caso9;
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

--=============================================================================================

create database if not exists caso10;
use caso10;
create table playlist (
    id int auto_increment primary key,
    nombre varchar(20) not null
);
create table cancion (
    id int auto_increment primary key,
    titulo varchar(20) not null,
    duracion time not null,
    genero varchar(20)
);
create table artista (
    id int auto_increment primary key,
    nombre varchar(20) not null,
    nacionalidad varchar(20)
);
create table album (
    id int auto_increment primary key,
    titulo varchar(20) not null,
    fecha_lanzamiento date not null,
    id_artista int not null,
    foreign key (id_artista) references artista(id)
);
create table cancion_album (
    id_cancion int not null,
    id_album int not null,
    primary key (id_cancion, id_album),
    foreign key (id_cancion) references cancion(id),
    foreign key (id_album) references album(id)
);
create table cancion_playlist (
    id_cancion int not null,
    id_playlist int not null,
    primary key (id_cancion, id_playlist),
    foreign key (id_cancion) references cancion(id),
    foreign key (id_playlist) references playlist(id)
);
