--1)¿Cuántas temporadas diferentes hay en la tabla estadísticas?
use nba;
select distinct temporada from estadisticas;

/*2)¿Qué jugadores tuvieron más de 20 puntos por partido durante la
temporada 00/01?*/


/*3)¿Cuántos equipos compiten según la conferencia y división y ordenando
por división descente?*/
select conferencia, division, count(nombre) as total from equipos 
group by conferencia, division order by division desc;

/*4)¿Qué equipos anotaron más de 6000 puntos de local en total y la media
durante la temporada 02/03 ordenados por nombre?*/
select equipo_local, temporada, sum(puntos_local), avg(puntos_local)
from partidos where temporada='02/03' group by equipo_local, temporada
 having sum(puntos_local)>6000 order by equipo_local;

 --5)El código de oficina y la ciudad donde hay oficinas en EEUU.

 
--6)Cuántos empleados hay en la compañía.
--7)Cuántos clientes tiene cada país.
/*8)Cuál fue el pago medio en 2008 (pista: Usar la función YEAR de MySQL o
la función to-char(fecha,'yyyy') de Oracle o LIKE).*/
/*9)Cuántos pedidos están en cada estado y ordena esta cuenta de manera
descendente.*/
--10)El precio del producto más caro y del más barato.