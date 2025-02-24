-- 5) Borra las estadísticas de los jugadores sin procedencia.
SELECT * FROM estadisticas LEFT JOIN jugadores ON estadisticas.jugador = jugadores.codigo 
WHERE jugadores.procedencia IS NULL;
DELETE FROM estadisticas WHERE jugador in (select codigo from jugadores where procedencia is null);
-- 6) Borra los jugadores españoles.
DELETE FROM jugadores WHERE procedencia = 'España';
/*7) Borra los equipos de las ciudades que tienen una ‘o’ en la segunda
posición.*/
DELETE FROM equipos WHERE ciudad = '%o%';
-- 8) Borra todo lo relacionado con el equipo 76ers en la base de datos.
DELETE FROM partidos WHERE equipo_local = '76ers' OR equipo_visitante = '76ers';
DELETE FROM estadisticas WHERE jugador IN (SELECT codigo FROM jugadores WHERE nombre_equipo = '76ers');
DELETE FROM jugadores WHERE nombre_equipo = '76ers';
DELETE FROM equipos WHERE nombre = '76ers';