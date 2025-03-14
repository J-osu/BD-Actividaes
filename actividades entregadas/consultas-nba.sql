--1) ¿Qué jugadores juegan en la posición C?
select nombre from jugadores where posición = 'C';

--2)¿Qué equipos juegan en la división Atlantic?

select nombre from equipos where división = 'Atlantic';

--3)¿Qué nombre tienen las diferentes conferencias?

select distinct conferencia from equipos;

-- 4) ¿En qué temporada los Raptors metieron menos de 70 puntos como local?

select temporada from partidos 
where equipo_local = 'Raptors' or equipo_visitante = 'Raptors' 
and puntos_local > 70 or puntos_visitante > 70;

-- 5) Ordena el nombre de los equipos de mayor a menor.

select nombre from equipos order by nombre desc;

-- 6) Ordena en bloque el nombre de los equipos y división de menor a mayor.

select nombre, division from equipos order by nombre desc, division asc;

-- 7) Lista el nombre de los jugadores de procedencia española.

select nombre from jugadores where procedencia = 'Spain';

-- 8) Lista los jugadores del equipo de los Lakers.

select nombre from jugadores where equipo = 'Lakers';


--Saca el peso en kilogramos de los jugadores de la NBA que pesen entre 120 y 150 kilos. Una libra equivale a 0.4535 kilos.
select nombre, peso as peso_en_kg from jugadores where peso between 120 and 150;

--Saca el nombre y conferencia de los equipos que empiecen por ‘R’, que terminen por ‘s’ y que tengan 7 caracteres.

select nombre, conferencia from equipos where nombre like 'R_____S';

--Ahora aquellos equipos que aparezca en su nombre como segunda letra la ‘o’.

select nombre from equipos where nombre like '_o_%';

-- Ahora aquellos equipos que no tienen 6 caracteres o más.

select nombre from equipos where length(nombre) < 6;

-- ¿Cuánto pesa el jugador más pesado de cada equipo?

select nombre_equipo, max(peso) from jugadores group by nombre_equipo;

--¿Cuántos equipos tiene cada conferencia en la NBA?

select conferencia, count(*) from equipos group by conferencia;

--¿Cuánto pesan de media los jugadores de Spain, France & Italy?

select procedencia, avg(peso) from jugadores where procedencia in ('Spain', 'France', 'Italy') group by procedencia;

--1)¿Cuántas temporadas diferentes hay en la tabla estadísticas?

select count(distinct temporada) from estadisticas;

--2)¿Qué jugadores tuvieron más de 20 puntos por partido durante la temporada 00/01?

select nombre from jugadores where codigo in 
(select jugador from estadisticas where puntos_por_partido > 20 and temporada = '00/01');

--3)¿Cuántos equipos compiten según la conferencia y división y ordenando por división descente?

select conferencia, division, count(*) as total_equipos from equipos group by conferencia, division order by conferencia asc, division desc;

--4)¿Qué equipos anotaron más de 6000 puntos de local en total y la media durante la temporada 02/03 ordenados por nombre?

select equipo_local AS nombre, SUM(puntos_local) AS total_puntos, AVG(puntos_local) AS media_puntos
from partidos where temporada = '02/03' group by equipo_local having  SUM(puntos_local) > 6000
order by equipo_local;

-- 7) Nombre de los jugadores que tuvieron más de 4 rebotes durante la temporada 01/02.

select nombre from jugadores where codigo in (select jugador from estadisticas where rebotes_por_partido > 4 and temporada = '01/02');

-- 8)¿De qué ciudad es el equipo con el jugador más bajo?

select ciudad from equipos where nombre = (select nombre_equipo from jugadores order by altura asc limit 1);

-- 9)¿Qué jugador hizo más asistencias en alguna temporada y ordénalo por nombre completo descendente?

select jugador, asistencias_por_partido as asistencias from estadisticas order by asistencias 
desc, jugador desc limit 1;

-- 10)¿Qué equipos no tienen jugadores de España, Italia y Francia?

select nombre from equipos where nombre not in (select equipo from jugadores where nacionalidad in ('España', 'Italia', 'Francia'));

-- 11)Utiliza la UNION para extraer el nombre de los equipos que anotaron más de 100 puntos como local y ganaron sus partidos, junto con los equipos que tienen jugadores españoles.

select nombre from equipos where nombre in ( select equipo_local from partidos where puntos_local > 100 and puntos_local > puntos_visitante) 
union 
select nombre from equipos where nombre in ( select nombre_equipo from jugadores where procedencia = 'España');

-- 12)¿Qué jugadores y en qué equipo juegan en la división Atlantic?

select nombre, equipo from jugadores where equipo in (select nombre from equipos where division = 'Atlantic');

-- 13) Usando EXCEPT quita los jugadores españoles de NBA que están en los Lakers.

select nombre from jugadores where nombre_equipo = 'Lakers' and nombre not in (
select nombre from jugadores where procedencia = 'España');