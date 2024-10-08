--ACTA_POSESION_DEP 2623 73
--Primera revison 30-06-2024
--Necesita segunda revisi�n para solucionar
--https://www.youtube.com/watch?v=OeFKzBwB-i4

--ACTA_POSESION_DEP 2623                                    acomodar probar Ok  https://www.youtube.com/watch?v=OeFKzBwB-i4

--Order variables: FECHA_GENERACION,NOMBRE_DELEGADO, numero_consecutivo,N_DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,CARGO_DELEGADO,PROFESION

--1455864 0927016105 10398205
--10398155 0910643014 1455834
--10398133 0950306571 1455818
--10398211  0914932918  id_coactivo: 1455869 con est� se genero buen ejemplo
--0950614750 1455838 10398161
--numeroCoactivo: 10396484 0923220172 1455011 Dato fallido

--10398292 0903183945 1455917 
--nummro coactivo: 10396939 0928826304 1455416 exitoso


begin tran 
update documentos..plantilla set fecha_inicio='2024-08-13' where id_plantilla=2623
update documentos..plantilla set fecha_inicio='2024-08-11' where id_plantilla=2623
commit tran

select *from gestor_docs.dbo.version_data_documento
where codigo_documento=2461082--256317354
                     --256317354


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Getdate()                                               FECHA_GENERACION,
       CASE pf.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(f.titulo_obtenido, '' '', pf.nombre1, '' '', pf.nombre2,
                    '' '',
                           pf.apellido1,
                                 '' '', pf.apellido2))
       END                                                     AS
       NOMBRE_DEPOSITARIO,
       Concat(pro.numero_proceso, ''-'', Year(pro.fecha_inicio)) AS
       numero_consecutivo,
       pf.numero_identificacion,
       f.numero_firma                                          AS firma,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_final_vigencia IS NULL
               AND f.motivo = 3)                               AS
       datosNombramiento,
       (SELECT Max(fi.numero_imagen)
        FROM   firma_persona fi WITH(nolock)
               LEFT JOIN persona p WITH(nolock)
                      ON fi.id_persona = p.id_persona
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  f.id_cargo = 1
               AND fecha_final_vigencia IS NULL)               AS
       IMAGEN_FIRMA_DOS,
       (SELECT Concat (f.titulo_obtenido, '' '', Upper(
                       Concat (per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
                                                       per.apellido2)), '', Mgs'')
        FROM   funcionario f(nolock)
               INNER JOIN persona per(nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
               AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
                     AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector
       ,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 442)                         AS cargo_delegado
       ,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )              AS
       cargo_delegado_mayusculas,

	   (SELECT TOP 1 Concat(f.titulo_obtenido, '' '', Upper(
                                   Concat(per.nombre1, '' '', per.nombre2, '' '',
                                   per.apellido1, '' '',
per.apellido2)))
FROM   funcionario f (nolock)
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
WHERE  f.id_cargo = 1
AND f.estado = ''VIGENTE'')               AS nombre_abogado
FROM   coactivo c (nolock)
       JOIN proceso pro (nolock)
         ON c.id_proceso = pro.id_proceso
       JOIN embargo e (nolock)
         ON c.id_coactivo = e.id_coactivo
       JOIN funcionario f (nolock)
         ON e.id_funcionario = f.id_funcionario
       JOIN persona pf (nolock)
         ON f.id_persona = pf.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pf.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pf.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo = :idCoactivo
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo)'               
	   , orden_variables='FECHA_GENERACION,NOMBRE_DELEGADO, numero_consecutivo,N_DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,CARGO_DELEGADO,PROFESION,NOMBRE_AGENTE'
WHERE  id_plantilla_config=73

commit tran



SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro =442

--"DELEGADO DEL(LA) DIRECTOR(A) DE GESTI�N DE INFRACCIONES Y 
--SERVICIOS DE TR�NSITO DE LA EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL, EP."


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ACTA_POSESION_DEP';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

--FECHA_GENERACION,NOMBRE_DELEGADO, numero_consecutivo,N_DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,CARGO_DELEGADO,PROFESION

--Modifcada
-------------------------------------------------------------------------------------
--Modificad 11/08/2024
SELECT Getdate()                                               FECHA_GENERACION,
       CASE pf.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(f.titulo_obtenido, ' ', pf.nombre1, ' ', pf.nombre2,
                    ' ',
                           pf.apellido1,
                                 ' ', pf.apellido2))
       END                                                     AS
       NOMBRE_DEPOSITARIO,
       Concat(pro.numero_proceso, '-', Year(pro.fecha_inicio)) AS
       numero_consecutivo,
       pf.numero_identificacion,
       f.numero_firma                                          AS firma,
       (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(
                       Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS
                       VARCHAR(
                       50)))
        FROM   funcionario f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_final_vigencia IS NULL
               AND f.motivo = 3)                               AS
       datosNombramiento,
       (SELECT Max(fi.numero_imagen)
        FROM   firma_persona fi WITH(nolock)
               LEFT JOIN persona p WITH(nolock)
                      ON fi.id_persona = p.id_persona
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  f.id_cargo = 1
               AND fecha_final_vigencia IS NULL)               AS
       IMAGEN_FIRMA_DOS,
       (SELECT Concat (f.titulo_obtenido, ' ', Upper(
                       Concat (per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
                                                       per.apellido2)), ', Mgs')
        FROM   funcionario f(nolock)
               INNER JOIN persona per(nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
               AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
                     AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector
       ,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 442)                         AS cargo_delegado
       ,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )              AS
       cargo_delegado_mayusculas,

	   (SELECT TOP 1 Concat(f.titulo_obtenido, ' ', Upper(
                                   Concat(per.nombre1, ' ', per.nombre2, ' ',
                                   per.apellido1, ' ',
per.apellido2)))
FROM   funcionario f (nolock)
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
WHERE  f.id_cargo = 1
AND f.estado = 'VIGENTE')               AS nombre_abogado
FROM   coactivo c (nolock)
       JOIN proceso pro (nolock)
         ON c.id_proceso = pro.id_proceso
       JOIN embargo e (nolock)
         ON c.id_coactivo = e.id_coactivo
       JOIN funcionario f (nolock)
         ON e.id_funcionario = f.id_funcionario
       JOIN persona pf (nolock)
         ON f.id_persona = pf.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pf.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pf.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo = :idCoactivo
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 











--Modificada antigua
SELECT Getdate()                                               FECHA_GENERACION,
       CASE pf.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(f.titulo_obtenido,' ',pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ',
                    pf.apellido2))
       END                                                     AS
       NOMBRE_DEPOSITARIO,
       Concat(pro.numero_proceso, '-', Year(pro.fecha_inicio)) AS
       numero_consecutivo,
       pf.numero_identificacion,
       f.numero_firma                                          AS firma,
       (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(
                       Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS
                       VARCHAR(
                       50)))
        FROM   funcionario f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_final_vigencia IS NULL
               AND f.motivo = 3)                               AS
       datosNombramiento,
       (SELECT Max(fi.numero_imagen)
        FROM   firma_persona fi WITH(nolock)
               LEFT JOIN persona p WITH(nolock)
                      ON fi.id_persona = p.id_persona
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  f.id_cargo = 1
               AND fecha_final_vigencia IS NULL)               AS
       IMAGEN_FIRMA_DOS,
       (SELECT
Concat (f.titulo_obtenido, ' ', Upper(
Concat
(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2)), ', Mgs')
 FROM   funcionario f(nolock)
        INNER JOIN persona per(nolock)
                ON f.id_persona = per.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
        AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())
         OR ( f.id_cargo = 11
              AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
              AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 434)                         AS cargo_delegado,
( Upper((SELECT valor_parametro_defecto
         FROM   parametro(nolock)
         WHERE  codigo_parametro = 434)) )              AS
       cargo_delegado_mayusculas
FROM   coactivo c (nolock)
       JOIN proceso pro (nolock)
         ON c.id_proceso = pro.id_proceso
       JOIN embargo e (nolock)
         ON c.id_coactivo = e.id_coactivo
       JOIN funcionario f (nolock)
         ON e.id_funcionario = f.id_funcionario
       JOIN persona pf (nolock)
         ON f.id_persona = pf.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pf.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pf.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo is not null
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT Getdate()                                               FECHA_GENERACION,         CASE pf.id_tipo_identificacion           WHEN 2 THEN Upper (pj.nombre_comercial)           ELSE Upper(Concat(pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ',                      pf.apellido2))         END                                                     AS         NOMBRE_DEPOSITARIO,         Concat(pro.numero_proceso, '-', Year(pro.fecha_inicio)) AS         numero_consecutivo,         pf.numero_identificacion,         f.numero_firma                                          AS firma,         (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(                         Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS                         VARCHAR(                         50)))          FROM   funcionario f (nolock)          WHERE  f.id_cargo = 1                 AND f.fecha_final_vigencia IS NULL                 AND f.motivo = 3)                               AS         datosNombramiento,  (SELECT Max(fi.numero_imagen)  FROM firma_persona fi WITH(nolock)  LEFT JOIN persona p WITH(nolock)  ON fi.id_persona = p.id_persona  LEFT JOIN funcionario f  ON f.id_persona = p.id_persona  WHERE  f.id_cargo = 1  AND fecha_final_vigencia IS NULL       ) AS IMAGEN_FIRMA_DOS   ,(    SELECT CONCAT (f.titulo_obtenido,' ',Upper(CONCAT (per.nombre1,' ',per.nombre2,' ',per.apellido1,' ',per.apellido2)),', Mgs')    FROM funcionario f(NOLOCK)    INNER JOIN persona per(NOLOCK) ON f.id_persona = per.id_persona    WHERE f.id_cargo = 11     AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())     AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())     OR (      f.id_cargo = 11      AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())      AND f.fecha_final_vigencia IS NULL      )    ) AS nombreDirector,    (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=434) as cargo_delegado,    (UPPER((SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 434))) AS cargo_delegado_mayusculas  FROM   coactivo c (nolock)         JOIN proceso pro (nolock)           ON c.id_proceso = pro.id_proceso         JOIN embargo e (nolock)           ON c.id_coactivo = e.id_coactivo         JOIN funcionario f (nolock)           ON e.id_funcionario = f.id_funcionario         JOIN persona pf (nolock)           ON f.id_persona = pf.id_persona         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pf.id_persona         JOIN tipo_identificacion_persona tip (nolock)           ON pf.id_tipo_identificacion = tip.id_tipo_identificacion  WHERE  c.id_coactivo is not null         AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo                             FROM   embargo ee                             WHERE  ee.id_coactivo = c.id_coactivo) 
-------------/-----------------------------------------------------------------------
--Original: 11/08/2024
SELECT Getdate()                                               FECHA_GENERACION,         CASE pf.id_tipo_identificacion           WHEN 2 THEN Upper (pj.nombre_comercial)           ELSE Upper(Concat(f.titulo_obtenido,' ',pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ',                      pf.apellido2))         END                                                     AS         NOMBRE_DEPOSITARIO,         Concat(pro.numero_proceso, '-', Year(pro.fecha_inicio)) AS         numero_consecutivo,         pf.numero_identificacion,         f.numero_firma                                          AS firma,         (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(                         Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS                         VARCHAR(                         50)))          FROM   funcionario f (nolock)          WHERE  f.id_cargo = 1                 AND f.fecha_final_vigencia IS NULL                 AND f.motivo = 3)                               AS         datosNombramiento,         (SELECT Max(fi.numero_imagen)          FROM   firma_persona fi WITH(nolock)                 LEFT JOIN persona p WITH(nolock)                        ON fi.id_persona = p.id_persona                 LEFT JOIN funcionario f                        ON f.id_persona = p.id_persona          WHERE  f.id_cargo = 1                 AND fecha_final_vigencia IS NULL)               AS         IMAGEN_FIRMA_DOS,         (SELECT  Concat (f.titulo_obtenido, ' ', Upper(  Concat  (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2)), ', Mgs')   FROM   funcionario f(nolock)          INNER JOIN persona per(nolock)                  ON f.id_persona = per.id_persona   WHERE  f.id_cargo = 11          AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())          AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())           OR ( f.id_cargo = 11                AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())                AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector,  (SELECT valor_parametro_defecto   FROM   parametro(nolock)   WHERE  codigo_parametro = 434)                         AS cargo_delegado,  ( Upper((SELECT valor_parametro_defecto           FROM   parametro(nolock)           WHERE  codigo_parametro = 434)) )              AS         cargo_delegado_mayusculas  FROM   coactivo c (nolock)         JOIN proceso pro (nolock)           ON c.id_proceso = pro.id_proceso         JOIN embargo e (nolock)           ON c.id_coactivo = e.id_coactivo         JOIN funcionario f (nolock)           ON e.id_funcionario = f.id_funcionario         JOIN persona pf (nolock)           ON f.id_persona = pf.id_persona         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pf.id_persona         JOIN tipo_identificacion_persona tip (nolock)           ON pf.id_tipo_identificacion = tip.id_tipo_identificacion  WHERE  c.id_coactivo = :idCoactivo         AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo                             FROM   embargo ee                             WHERE  ee.id_coactivo = c.id_coactivo) 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------






--Variables de plantillas

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2290'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2290, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='NOMBRE_AUTORIDAD'

select *from documentos..variable_plantilla
where id_plantilla='2290'


select *from variable
where id_variable='1435'--1435
-------------------------------------------------------------------------------------
--Ver las variables
select nombre_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='2623'

----------------------------------
--quemado 1

SELECT top 50000 Getdate()                                               FECHA_GENERACION,
       CASE pf.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ',
                    pf.apellido2))
       END                                                     AS
       NOMBRE_DEPOSITARIO,
       Concat(pro.numero_proceso, '-', Year(pro.fecha_inicio)) AS
       numero_consecutivo,
       pf.numero_identificacion,
       f.numero_firma                                          AS firma,
       (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(
                       Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS
                       VARCHAR(
                       50)))
        FROM   funcionario f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_final_vigencia IS NULL
               AND f.motivo = 3)                               AS
       datosNombramiento,
       (SELECT Max(fi.numero_imagen)
        FROM   firma_persona fi WITH(nolock)
               LEFT JOIN persona p WITH(nolock)
                      ON fi.id_persona = p.id_persona
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  f.id_cargo = 1
               AND fecha_final_vigencia IS NULL)               AS
       IMAGEN_FIRMA_DOS,
       (SELECT
Concat (f.titulo_obtenido, ' ', Upper(
Concat
('Prueba',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2)), ', Mgs')
 FROM   funcionario f(nolock)
        INNER JOIN persona per(nolock)
                ON f.id_persona = per.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
        AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())
         OR ( f.id_cargo = 11
              AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
              AND f.fecha_final_vigencia IS NULL )
			  --AND per.nombre1='Francisco'
			  )     AS nombreDirector,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 434)                         AS cargo_delegado,
( Upper((SELECT valor_parametro_defecto
         FROM   parametro(nolock)
         WHERE  codigo_parametro = 434)) )              AS
       cargo_delegado_mayusculas
FROM   coactivo c (nolock)
       JOIN proceso pro (nolock)
         ON c.id_proceso = pro.id_proceso
       JOIN embargo e (nolock)
         ON c.id_coactivo = e.id_coactivo
       JOIN funcionario f (nolock)
         ON e.id_funcionario = f.id_funcionario
       JOIN persona pf (nolock)
         ON f.id_persona = pf.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pf.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pf.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo is not null
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 
----------------------------------------------------------------











---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
--Update antiguo

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Getdate()                                               FECHA_GENERACION,
       CASE pf.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(f.titulo_obtenido,'' '',pf.nombre1, '' '', pf.nombre2, '' '', pf.apellido1, '' '',
                    pf.apellido2))
       END                                                     AS
       NOMBRE_DEPOSITARIO,
       Concat(pro.numero_proceso, ''-'', Year(pro.fecha_inicio)) AS
       numero_consecutivo,
       pf.numero_identificacion,
       f.numero_firma                                          AS firma,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_final_vigencia IS NULL
               AND f.motivo = 3)                               AS
       datosNombramiento,
       (SELECT Max(fi.numero_imagen)
        FROM   firma_persona fi WITH(nolock)
               LEFT JOIN persona p WITH(nolock)
                      ON fi.id_persona = p.id_persona
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  f.id_cargo = 1
               AND fecha_final_vigencia IS NULL)               AS
       IMAGEN_FIRMA_DOS,
       (SELECT
Concat (f.titulo_obtenido, '' '', Upper(
Concat
(per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '', per.apellido2)), '', Mgs'')
 FROM   funcionario f(nolock)
        INNER JOIN persona per(nolock)
                ON f.id_persona = per.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
        AND f.fecha_final_vigencia >= CONVERT(DATE, Getdate())
         OR ( f.id_cargo = 11
              AND f.fecha_inicio_vigencia <= CONVERT(DATE, Getdate())
              AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 434)                         AS cargo_delegado,
( Upper((SELECT valor_parametro_defecto
         FROM   parametro(nolock)
         WHERE  codigo_parametro = 434)) )              AS
       cargo_delegado_mayusculas
FROM   coactivo c (nolock)
       JOIN proceso pro (nolock)
         ON c.id_proceso = pro.id_proceso
       JOIN embargo e (nolock)
         ON c.id_coactivo = e.id_coactivo
       JOIN funcionario f (nolock)
         ON e.id_funcionario = f.id_funcionario
       JOIN persona pf (nolock)
         ON f.id_persona = pf.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pf.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pf.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo is not null
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) '               
	   --, orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=73

commit tran
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------















SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro in(434,435,436,437,438,439,440,441,442)  

SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro =442

--"DELEGADO DEL(LA) DIRECTOR(A) DE GESTI�N DE INFRACCIONES Y 
--SERVICIOS DE TR�NSITO DE LA EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL, EP."


DELEGADO DEL(LA) DIRECTOR(A) DE GESTI�N DE INFRACCIONES Y 
SERVICIOS DE TR�NSITO DE LA EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL, EP.


DELEGADO DEL(LA) DIRECTOR(A) DE GESTI�N DE INFRACCIONES Y SERVICIOS DE TR�NSITO

DELEGADO DEL (A) DIRECTOR (A) DE GESTI�N DE INFRACCIONES Y SERVICIOS DE TR�NSITO PARA EL EJERCICIO DE LA JURISDICCI�N COACTIVA DE LA EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL,EP.