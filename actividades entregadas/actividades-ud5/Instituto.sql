create database instituto;
use instituto;

create table Alumno(
    id int primary key not null auto_increment,
    nif varchar(10),
    nombre varchar(10),
    apellido1 varchar(20),
    apellido2 varchar(20),  
    grupo varchar(10)
);
insert into Alumno(id, nif, nombre, apellido1, apellido2, grupo) values(1, '12345678A', 'Juan', 'Perez', 'Garcia', 'mañana');
insert into Alumno(id, nif, nombre, apellido1, apellido2, grupo) values(2, '12345678B', 'Maria', 'Gomez', 'Lopez', 'tarde');
insert into Alumno(id, nif, nombre, apellido1, apellido2, grupo) values(3, '12345678C', 'Ana', 'Martinez', 'Rodriguez', 'mañana');
insert into Alumno(id, nif, nombre, apellido1, apellido2, grupo) values(4, '12345678D', 'Pedro', 'Garcia', 'Fernandez', 'tarde');

create table Practica(
    id int primary key not null auto_increment,
    dificultad varchar(10),
    titulo varchar(10)
);
insert into Practica(id, dificultad, titulo) values(1, 'baja', 'FOL');
insert into Practica(id, dificultad, titulo) values(2, 'media', 'REDES');
insert into Practica(id, dificultad, titulo) values(3, 'media', 'LMSGI');
insert into Practica(id, dificultad, titulo) values(4, 'alta', 'GBD');

create table Profesor(
    id int primary key not null auto_increment,
    nif varchar(10),
    nombre varchar(10),
    apellido1 varchar(20),
    apellido2 varchar(20)
);
insert into Profesor(id, nif, nombre, apellido1, apellido2) values(1, '12345678E', 'Luis', 'Garcia', 'Lopez');
insert into Profesor(id, nif, nombre, apellido1, apellido2) values(2, '12345678F', 'Maria', 'Perez', 'Gonzalez');
insert into Profesor(id, nif, nombre, apellido1, apellido2) values(3, '12345678G', 'Ana', 'Martinez', 'Rodriguez');
insert into Profesor(id, nif, nombre, apellido1, apellido2) values(4, '12345678H', 'Pedro', 'Gomez', 'Fernandez');

create table Examen_Teorico(
    id int primary key not null auto_increment,
    titulo varchar(10),
    numero_preguntas int,
    fecha date,
    id_profesor int,
    foreign key (id_profesor) references Profesor(id)
);
insert into Examen_Teorico(id, titulo, numero_preguntas, fecha, id_profesor) values(1, 'FOL', 10, '2019-12-19', 1);
insert into Examen_Teorico(id, titulo, numero_preguntas, fecha, id_profesor) values(2, 'REDES', 10, '2019-12-19', 2);
insert into Examen_Teorico(id, titulo, numero_preguntas, fecha, id_profesor) values(3, 'LMSGI', 10, '2019-12-25', 3);
insert into Examen_Teorico(id, titulo, numero_preguntas, fecha, id_profesor) values(4, 'GBD', 10, '2019-12-25', 4);

create table Realiza(
    fecha date,
    nota int,
    id_alumno int,
    id_practica int,
    foreign key (id_alumno) references Alumno(id),
    foreign key (id_practica) references Practica(id)
);
insert into Realiza(fecha, nota, id_alumno, id_practica) values('2019-12-19', 10, 1, 1);
insert into Realiza(fecha, nota, id_alumno, id_practica) values('2019-12-19', 8, 2, 2);
insert into Realiza(fecha, nota, id_alumno, id_practica) values('2019-12-25', 5, 3, 3);
insert into Realiza(fecha, nota, id_alumno, id_practica) values('2019-12-25', 7, 4, 4);

create table Hace(
    nota int,
    id_alumno int,
    id_examen_teorico int,
    foreign key (id_alumno) references Alumno(id),
    foreign key (id_examen_teorico) references Examen_Teorico(id)
);
insert into Hace(nota, id_alumno, id_examen_teorico) values(10, 1, 1);
insert into Hace(nota, id_alumno, id_examen_teorico) values(2, 2, 2);
insert into Hace(nota, id_alumno, id_examen_teorico) values(8, 3, 3);
insert into Hace(nota, id_alumno, id_examen_teorico) values(5, 4, 4);

create table Diseña(
    fecha date,
    id_profesor int,
    id_practica int,
    foreign key (id_profesor) references Profesor(id),
    foreign key (id_practica) references Practica(id)
);
insert into Diseña(fecha, id_profesor, id_practica) values('2019-12-19', 1, 1);
insert into Diseña(fecha, id_profesor, id_practica) values('2019-12-19', 2, 2);
insert into Diseña(fecha, id_profesor, id_practica) values('2019-12-25', 3, 3);
insert into Diseña(fecha, id_profesor, id_practica) values('2019-12-25', 4, 4);


--==========================================================
--¿Qué alumnos han aprobado el examen de GBD?
SELECT Alumno.nombre, Alumno.apellido1, Alumno.apellido2 FROM Alumno JOIN Hace ON Alumno.id = Hace.id_alumno JOIN Examen_Teorico ON Hace.id_examen_teorico = Examen_Teorico.id WHERE Examen_Teorico.titulo = 'GBD' AND Hace.nota >= 5;

-- ¿Qué alumno tiene la nota más alta en LMSGI?
SELECT Alumno.nombre, Alumno.apellido1, Alumno.apellido2, Hace.nota FROM Alumno JOIN Hace ON Alumno.id = Hace.id_alumno JOIN Examen_Teorico ON Hace.id_examen_teorico = Examen_Teorico.id WHERE Examen_Teorico.titulo = 'LMSGI' ORDER BY Hace.nota;

--¿Qué profesor hace las prácticas de FOL?
SELECT Profesor.nombre, Profesor.apellido1, Profesor.apellido2 FROM Profesor JOIN Diseña ON Profesor.id = Diseña.id_profesor JOIN Practica ON Diseña.id_practica = Practica.id WHERE Practica.titulo = 'FOL';

--¿Cambia el profesor de prácticas de FOL por el de REDES?
UPDATE Diseña SET id_profesor = (SELECT id FROM Profesor WHERE nombre = 'Maria' AND apellido1 = 'Perez' AND apellido2 = 'Gonzalez') WHERE id_practica = (SELECT id FROM Practica WHERE titulo = 'FOL');

--Borra los alumnos del grupo de tarde.
DELETE FROM Realiza WHERE id_alumno IN (SELECT id FROM Alumno WHERE grupo = 'tarde');
DELETE FROM HACE WHERE id_alumno IN (SELECT id FROM Alumno WHERE grupo = 'tarde')
DELETE FROM Alumno WHERE grupo = 'tarde';