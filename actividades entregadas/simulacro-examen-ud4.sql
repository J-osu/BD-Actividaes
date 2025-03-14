-- ¿Cuánto pesa el jugador más pesado de cada equipo?

select nombre_equipo, max(peso) from jugadores group by nombre_equipo;

--¿Qué equipos anotaron más de 6000 puntos de local en total y la media durante la temporada 02/03 ordenados por nombre?

select equipo_local AS nombre, SUM(puntos_local) AS total_puntos, AVG(puntos_local) AS media_puntos
from partidos where temporada = '02/03' group by equipo_local having  SUM(puntos_local) > 6000
order by equipo_local;

--¿De qué ciudad es el equipo con el jugador más bajo?

select ciudad from equipos where nombre = (select nombre_equipo from jugadores order by altura asc limit 1);

-- 11)Utiliza la UNION para extraer el nombre de los equipos que anotaron más de 100 puntos como local y ganaron sus partidos, junto con los equipos que tienen jugadores españoles.

select nombre from equipos where nombre in ( select equipo_local from partidos where puntos_local > 100 and puntos_local > puntos_visitante) 
union 
select nombre from equipos where nombre in ( select nombre_equipo from jugadores where procedencia = 'España');

-- ¿Qué media de rebotes tienen los jugadores de la conferencia este?

select avg(e.rebotes_por_partido) as media_rebotes, j.nombre from estadisticas e
join jugadores j on e.jugador = j.codigo join equipos eq on j.nombre_equipo = eq.nombre
where eq.conferencia = 'East' group by j.nombre;

-- ¿Cuántos jugadores juegan en la posición G en cada equipo de la conferencia este? Ordénalos por el total de manera descendente y en caso de empate por nombre de equipo ascendente.

select count(j.codigo) as total, j.nombre_equipo from jugadores j
join equipos eq on j.nombre_equipo = eq.nombre
where eq.conferencia = 'East' and j.posicion = 'G' group by j.nombre_equipo
order by total desc, j.nombre_equipo asc;