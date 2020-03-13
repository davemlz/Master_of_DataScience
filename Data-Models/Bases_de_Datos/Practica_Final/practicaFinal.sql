-- PRACTICA FINAL.
-- MASTER EN DATA SCIENCE

-- DAVID MONTERO LOAIZA

-- 1. Crea una nueva tabla para almacenar las temporadas de las series.
-- La primary key ha de ser el par de campos “idSerie, numTemporada”.
-- La descripción de la tabla es la siguiente: (2 ptos)
CREATE TABLE TEMPORADAS(

    idserie INT,
    numTemporada INT,    
    fechaEstreno DATE NOT NULL,
    fechaRegistro DATE NOT NULL,
    disponible BOOLEAN NOT NULL,
    
    PRIMARY KEY(idserie,numTemporada),
    FOREIGN KEY (idserie) REFERENCES SERIES(idSerie),    
    CHECK(fechaRegistro > fechaEstreno),
    CHECK(disponible IN (0,1))

);

-- 2. Añadir una nueva columna a la tabla "generos" para almacenar un campo denominado "descripcion" (0.25 ptos).
ALTER TABLE GENEROS ADD descripcion CHAR;

-- 3. Crea un índice sobre el par de campos “titulo” y “anyoFin” de las series (0.25 ptos)
CREATE INDEX idx_tituloafin ON SERIES (titulo DESC,anyoFin);

-- 4. Mostrar el “idserie”, “titulo”, “titulo original” y “sinopsis” de todas las series,
-- ordenadas por título descendentemente (0.5 ptos)
SELECT s.idSerie, s.titulo, s.tituloOriginal, s.sinopsis
FROM SERIES s
ORDER BY s.titulo DESC;

-- 5. Retornar los datos de los usuarios franceses o noruegos (0.5 ptos)
SELECT * FROM USUARIOS
WHERE pais IN ('Francia','Noruega');

-- 6. Mostrar los datos de los actores junto con los datos de las series en las que actúan (0.75 ptos)
SELECT a.*, s.* FROM ACTORES a
JOIN REPARTO r ON a.idActor = r.idActor
JOIN SERIES s ON r.idSerie = s.idSerie;

-- 7. Mostrar los datos de los usuarios que no hayan realizado nunca ninguna valoración (0.75 ptos)
SELECT u.* FROM USUARIOS u
WHERE u.idUsuario NOT IN
(SELECT u.idUsuario FROM USUARIOS u
NATURAL JOIN VALORACIONES v);

-- 8. Mostrar los datos de los usuarios junto con los datos de su profesión,
-- incluyendo las profesiones que no estén asignadas a ningún usuario (0.75 ptos)
SELECT p.*, u.* FROM PROFESIONES p
LEFT JOIN USUARIOS u ON u.idProfesion = p.idProfesion;

-- 9. Retornar los datos de las series que estén en idioma español, y cuyo título comience por E o G (1 pto)
SELECT s.* FROM SERIES s
NATURAL JOIN IDIOMAS i
WHERE i.idioma LIKE 'Español' AND s.titulo LIKE 'E%' or s.titulo LIKE 'G%';

-- 10. Retornar los “idserie”, “titulo” y “sinopsis” de todas las series junto con la puntuación media,
-- mínima y máxima de sus valoraciones (1 pto)
SELECT s.idSerie, s.titulo, s.sinopsis,
AVG(v.puntuacion) puntmedia, MIN(v.puntuacion) puntmin, MAX(v.puntuacion) puntmax
FROM SERIES s
NATURAL JOIN VALORACIONES v
GROUP BY s.idSerie, s.titulo, s.sinopsis;

-- 11. Actualiza al valor 'Sin sinopsis' la sinopsis de todas las series
-- cuya sinopsis sea nula y cuyo idioma sea el inglés (1 pto)
UPDATE SERIES SET sinopsis = 'Sin sinopsis'
WHERE idIdioma IN
(SELECT i.idIdioma FROM IDIOMAS i
WHERE i.idioma = 'Inglés');

-- 12. Utilizando funciones ventana, muestra los datos de las valoraciones
-- junto al nombre y apellidos (concatenados) de los usuarios que las realizan,
-- y en la misma fila, el valor medio de las puntuaciones realizadas por el usuario (1.25 ptos)
SELECT v.*, u.nombre || ' ' || u.apellido1 || ' ' || u.apellido2 as nombre,
AVG(v.puntuacion) OVER (PARTITION BY nombre) AS puntmed
FROM USUARIOS u
NATURAL JOIN VALORACIONES v;