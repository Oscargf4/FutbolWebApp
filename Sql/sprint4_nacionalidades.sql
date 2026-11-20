-- =====================================================================
-- FutbolWebApp - Sprint 4: nacionalidades con CodeMast / CodeType
-- ---------------------------------------------------------------------
-- 1) Crea el tipo de codigo NACION en CodeType.
-- 2) Crea en CodeMast un codigo por nacionalidad (codigos FIFA, max. 10
--    caracteres, porque CodeMast.Code es varchar(10)); la nacionalidad
--    completa va en Description (varchar(30)).
-- 3) Cambia los datos actuales de jugador y entrenador: de texto
--    ("Español") al codigo ("ESP"). El combo de la app muestra la
--    descripcion, asi que el usuario sigue viendo "Español".
--
-- Ejecutar con: --default-character-set=utf8mb4 (por las tildes)
-- Se puede ejecutar mas de una vez sin duplicar datos.
-- =====================================================================

START TRANSACTION;

-- 1) Tipo de codigo
INSERT INTO codetype (Type, Description, Comment)
VALUES ('NACION', 'Nacionalidades', 'Nacionalidades de jugadores y entrenadores (codigos FIFA)')
ON DUPLICATE KEY UPDATE Description = VALUES(Description), Comment = VALUES(Comment);

-- 2) Codigos de nacionalidad
INSERT INTO codemast (Type, Code, Description) VALUES
('NACION', 'GER', 'Alemán'),
('NACION', 'ARG', 'Argentino'),
('NACION', 'BEL', 'Belga'),
('NACION', 'BRA', 'Brasileño'),
('NACION', 'COL', 'Colombiano'),
('NACION', 'EGY', 'Egipcio'),
('NACION', 'SCO', 'Escocés'),
('NACION', 'SVN', 'Esloveno'),
('NACION', 'ESP', 'Español'),
('NACION', 'FRA', 'Francés'),
('NACION', 'HUN', 'Húngaro'),
('NACION', 'ENG', 'Inglés'),
('NACION', 'ITA', 'Italiano'),
('NACION', 'MOZ', 'Mozambiqueño'),
('NACION', 'NED', 'Neerlandés'),
('NACION', 'NOR', 'Noruego'),
('NACION', 'POL', 'Polaco'),
('NACION', 'POR', 'Portugués'),
('NACION', 'URU', 'Uruguayo')
ON DUPLICATE KEY UPDATE Description = VALUES(Description);

-- 3) Datos actuales: texto -> codigo
--    (ELSE Nacionalidad deja intacto cualquier valor no previsto)
UPDATE jugador SET Nacionalidad = CASE Nacionalidad
    WHEN 'Alemán' THEN 'GER'       WHEN 'Argentino' THEN 'ARG'
    WHEN 'Belga' THEN 'BEL'        WHEN 'Brasileño' THEN 'BRA'
    WHEN 'Colombiano' THEN 'COL'   WHEN 'Egipcio' THEN 'EGY'
    WHEN 'Escocés' THEN 'SCO'      WHEN 'Esloveno' THEN 'SVN'
    WHEN 'Español' THEN 'ESP'      WHEN 'Francés' THEN 'FRA'
    WHEN 'Húngaro' THEN 'HUN'      WHEN 'Inglés' THEN 'ENG'
    WHEN 'Italiano' THEN 'ITA'     WHEN 'Mozambiqueño' THEN 'MOZ'
    WHEN 'Neerlandés' THEN 'NED'   WHEN 'Noruego' THEN 'NOR'
    WHEN 'Polaco' THEN 'POL'       WHEN 'Portugués' THEN 'POR'
    WHEN 'Uruguayo' THEN 'URU'
    ELSE Nacionalidad END
WHERE Nacionalidad IS NOT NULL;

UPDATE entrenador SET Nacionalidad = CASE Nacionalidad
    WHEN 'Alemán' THEN 'GER'       WHEN 'Argentino' THEN 'ARG'
    WHEN 'Belga' THEN 'BEL'        WHEN 'Brasileño' THEN 'BRA'
    WHEN 'Colombiano' THEN 'COL'   WHEN 'Egipcio' THEN 'EGY'
    WHEN 'Escocés' THEN 'SCO'      WHEN 'Esloveno' THEN 'SVN'
    WHEN 'Español' THEN 'ESP'      WHEN 'Francés' THEN 'FRA'
    WHEN 'Húngaro' THEN 'HUN'      WHEN 'Inglés' THEN 'ENG'
    WHEN 'Italiano' THEN 'ITA'     WHEN 'Mozambiqueño' THEN 'MOZ'
    WHEN 'Neerlandés' THEN 'NED'   WHEN 'Noruego' THEN 'NOR'
    WHEN 'Polaco' THEN 'POL'       WHEN 'Portugués' THEN 'POR'
    WHEN 'Uruguayo' THEN 'URU'
    ELSE Nacionalidad END
WHERE Nacionalidad IS NOT NULL;

COMMIT;

-- Comprobacion: todas las nacionalidades deben ser codigos de 3 letras
-- y "Sin codigo" debe salir vacio.
SELECT Code, Description FROM codemast WHERE Type = 'NACION' ORDER BY Description;
SELECT DISTINCT Nacionalidad FROM jugador UNION SELECT DISTINCT Nacionalidad FROM entrenador ORDER BY 1;
SELECT 'Sin codigo' AS Aviso, Nacionalidad FROM jugador
 WHERE Nacionalidad IS NOT NULL AND Nacionalidad NOT IN (SELECT Code FROM codemast WHERE Type = 'NACION')
UNION ALL
SELECT 'Sin codigo', Nacionalidad FROM entrenador
 WHERE Nacionalidad IS NOT NULL AND Nacionalidad NOT IN (SELECT Code FROM codemast WHERE Type = 'NACION');
