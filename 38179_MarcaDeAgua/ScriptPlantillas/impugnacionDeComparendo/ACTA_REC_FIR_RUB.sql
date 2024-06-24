
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Day(Getdate())                            AS dias_letras,
       Cast(Datename(mm, Getdate()) AS VARCHAR)  AS dia_fecha,
       Year(Getdate())                           AS total_letras,
       Datepart(hour, Getdate())                 AS numero_autorizacion,
       Datepart(minute, Getdate())               AS numero_tramite,
       Upper(Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
             per.apellido2))                     AS nombre_funcionario,
       Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
       pe.apellido2))                            AS nombre_infractor,
       Upper(tip.nombre)                         AS t_documento_infractor,
       ( pe.numero_identificacion )              AS documento_infractor,
       ( p.fecha_inicio )                        AS fecha_solicitud,
       Getdate()                                 AS fecha_evaluacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = pe.id_persona)    AS imagen_firma,
       Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
       pe.apellido2))                            AS nombre_infractor_1,
       ( pe.numero_identificacion )              AS documento_infractor_1,
       fu.numero_firma                           AS firma_funcionario,
       Upper(Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
             per.apellido2))                     AS nombre_funcionario_1,
       c.nombre                                  AS cargo_1,
       Concat(fud.titulo_obtenido, '' '',perd.nombre1, '' '', perd.nombre2, '' '', perd.apellido1, '' '',
       perd.apellido2)                           AS nombreabogadofirma,
       card.nombre                               AS nombrecargo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = perd.id_persona) AS firma,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)           AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = pp.id_persona
       LEFT JOIN tipo_identificacion_persona tip
              ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
            AND tp.id_estado_proceso = 43
       JOIN usuario_persona up (nolock)
         ON up.id_usuario = tp.id_usuario
       JOIN persona per (nolock)
         ON per.id_persona = up.id_persona
       JOIN funcionario fud (nolock)
         ON fud.id_funcionario = (SELECT ei.id_funcionario
                                  FROM   evaluar_impugnacion ei
                                         INNER JOIN trazabilidad_proceso tp
                                                 ON tp.id_trazabilidad_proceso =
                                                    ei.id_trazabilidad_proceso
                                  WHERE  tp.id_proceso = p.id_proceso)
       JOIN cargo card (nolock)
         ON card.id_cargo = fud.id_cargo
       JOIN persona perd (nolock)
         ON perd.id_persona = fud.id_persona
       LEFT JOIN funcionario fu (nolock)
              ON fu.id_persona = per.id_persona
       LEFT JOIN cargo c (nolock)
              ON c.id_cargo = fu.id_cargo
WHERE  p.id_proceso = :idProceso
       AND pp.id_persona = (SELECT TOP 1 fp.id_persona
                            FROM   firma_persona fp
                            WHERE  fp.id_persona IN (SELECT id_persona
                                                     FROM   participante_proceso
                                                     WHERE
                                   id_proceso = p.id_proceso)
                            ORDER  BY fp.fecha_registro DESC)
ORDER  BY tp.id_trazabilidad_proceso DESC '               
	   --, orden_variables=''
WHERE  id_plantilla_config=10076

commit tran





--Modificado
SELECT Day(Getdate())                            AS dias_letras,
       Cast(Datename(mm, Getdate()) AS VARCHAR)  AS dia_fecha,
       Year(Getdate())                           AS total_letras,
       Datepart(hour, Getdate())                 AS numero_autorizacion,
       Datepart(minute, Getdate())               AS numero_tramite,
       Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
             per.apellido2))                     AS nombre_funcionario,
       Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
       pe.apellido2))                            AS nombre_infractor,
       Upper(tip.nombre)                         AS t_documento_infractor,
       ( pe.numero_identificacion )              AS documento_infractor,
       ( p.fecha_inicio )                        AS fecha_solicitud,
       Getdate()                                 AS fecha_evaluacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = pe.id_persona)    AS imagen_firma,
       Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
       pe.apellido2))                            AS nombre_infractor_1,
       ( pe.numero_identificacion )              AS documento_infractor_1,
       fu.numero_firma                           AS firma_funcionario,
       Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
             per.apellido2))                     AS nombre_funcionario_1,
       c.nombre                                  AS cargo_1,
       Concat(fud.titulo_obtenido, ' ',perd.nombre1, ' ', perd.nombre2, ' ', perd.apellido1, ' ',
       perd.apellido2)                           AS nombreabogadofirma,
       card.nombre                               AS nombrecargo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = perd.id_persona) AS firma,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)           AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = pp.id_persona
       LEFT JOIN tipo_identificacion_persona tip
              ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
            AND tp.id_estado_proceso = 43
       JOIN usuario_persona up (nolock)
         ON up.id_usuario = tp.id_usuario
       JOIN persona per (nolock)
         ON per.id_persona = up.id_persona
       JOIN funcionario fud (nolock)
         ON fud.id_funcionario = (SELECT ei.id_funcionario
                                  FROM   evaluar_impugnacion ei
                                         INNER JOIN trazabilidad_proceso tp
                                                 ON tp.id_trazabilidad_proceso =
                                                    ei.id_trazabilidad_proceso
                                  WHERE  tp.id_proceso = p.id_proceso)
       JOIN cargo card (nolock)
         ON card.id_cargo = fud.id_cargo
       JOIN persona perd (nolock)
         ON perd.id_persona = fud.id_persona
       LEFT JOIN funcionario fu (nolock)
              ON fu.id_persona = per.id_persona
       LEFT JOIN cargo c (nolock)
              ON c.id_cargo = fu.id_cargo
WHERE  p.id_proceso = :idProceso
       AND pp.id_persona = (SELECT TOP 1 fp.id_persona
                            FROM   firma_persona fp
                            WHERE  fp.id_persona IN (SELECT id_persona
                                                     FROM   participante_proceso
                                                     WHERE
                                   id_proceso = p.id_proceso)
                            ORDER  BY fp.fecha_registro DESC)
ORDER  BY tp.id_trazabilidad_proceso DESC 


----------------------------------------------------------------------------------
---SCRIPT MEJORADO POR BRYAN
--Original
SELECT Day(Getdate())                            AS dias_letras,
       Cast(Datename(mm, Getdate()) AS VARCHAR)  AS dia_fecha,
       Year(Getdate())                           AS total_letras,
       Datepart(hour, Getdate())                 AS numero_autorizacion,
       Datepart(minute, Getdate())               AS numero_tramite,
       Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
             per.apellido2))                     AS nombre_funcionario,
       Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
       pe.apellido2))                            AS nombre_infractor,
       Upper(tip.nombre)                         AS t_documento_infractor,
       ( pe.numero_identificacion )              AS documento_infractor,
       ( p.fecha_inicio )                        AS fecha_solicitud,
       Getdate()                                 AS fecha_evaluacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = pe.id_persona)    AS imagen_firma,
       Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
       pe.apellido2))                            AS nombre_infractor_1,
       ( pe.numero_identificacion )              AS documento_infractor_1,
       fu.numero_firma                           AS firma_funcionario,
       Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
             per.apellido2))                     AS nombre_funcionario_1,
       c.nombre                                  AS cargo_1,
       Concat(perd.nombre1, ' ', perd.nombre2, ' ', perd.apellido1, ' ',
       perd.apellido2)                           AS nombreabogadofirma,
       card.nombre                               AS nombrecargo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = perd.id_persona) AS firma,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)           AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = pp.id_persona
       LEFT JOIN tipo_identificacion_persona tip
              ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
            AND tp.id_estado_proceso = 43
       JOIN usuario_persona up (nolock)
         ON up.id_usuario = tp.id_usuario
       JOIN persona per (nolock)
         ON per.id_persona = up.id_persona
       JOIN funcionario fud (nolock)
         ON fud.id_funcionario = (SELECT ei.id_funcionario
                                  FROM   evaluar_impugnacion ei
                                         INNER JOIN trazabilidad_proceso tp
                                                 ON tp.id_trazabilidad_proceso =
                                                    ei.id_trazabilidad_proceso
                                  WHERE  tp.id_proceso = p.id_proceso)
       JOIN cargo card (nolock)
         ON card.id_cargo = fud.id_cargo
       JOIN persona perd (nolock)
         ON perd.id_persona = fud.id_persona
       LEFT JOIN funcionario fu (nolock)
              ON fu.id_persona = per.id_persona
       LEFT JOIN cargo c (nolock)
              ON c.id_cargo = fu.id_cargo
WHERE  p.id_proceso = :idProceso
       AND pp.id_persona = (SELECT TOP 1 fp.id_persona
                            FROM   firma_persona fp
                            WHERE  fp.id_persona IN (SELECT id_persona
                                                     FROM   participante_proceso
                                                     WHERE
                                   id_proceso = p.id_proceso)
                            ORDER  BY fp.fecha_registro DESC)
ORDER  BY tp.id_trazabilidad_proceso DESC 









----------------------------------------------------------------------------------------------
--Script antiguos
-----------------------------------------------------------------------------

--Modificada
SELECT    Day(Getdate())                                                                  AS dias_letras,
          Cast(Datename(mm, Getdate()) AS VARCHAR)                                        AS dia_fecha,
          Year(Getdate())                                                                 AS total_letras,
          Datepart(hour,Getdate())                                                        AS numero_autorizacion,
          Datepart(minute,Getdate())                                                      AS numero_tramite,
          Upper(Concat (per.nombre1,' ',per.nombre2,' ',per.apellido1,' ',per.apellido2)) AS nombre_funcionario,
          Upper(Concat (pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2))     AS nombre_infractor,
          Upper(tip.nombre)                                                               AS t_documento_infractor,
          (pe.numero_identificacion)                                                      AS documento_infractor,
          (p.fecha_inicio)                                                                AS fecha_solicitud,
          Getdate()                                                                       AS fecha_evaluacion,
          (
                 SELECT Max(fp.numero_imagen)
                 FROM   firma_persona fp (nolock)
                 WHERE  fp.id_persona = pe.id_persona)                                          AS imagen_firma,
          Upper(Concat (pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2))           AS nombre_infractor_1,
          (pe.numero_identificacion)                                                            AS documento_infractor_1,
          fu.numero_firma                                                                       AS firma_funcionario,
          Upper(Concat (per.nombre1,' ',per.nombre2,' ',per.apellido1,' ',per.apellido2))       AS nombre_funcionario_1,
          c.nombre                                                                              AS cargo_1,
                    Concat(perd.nombre1,' ',perd.nombre2,' ',perd.apellido1,' ',perd.apellido2) AS nombreabogadofirma,
          card.nombre                                                                           AS nombrecargo,
          (
                 SELECT Max(numero_imagen)
                 FROM   firma_persona fpe (nolock)
                 WHERE  fpe.id_persona = perd.id_persona) AS firma,
          (
                 SELECT valor_parametro_defecto
                 FROM   Parametro(nolock)
                 WHERE  codigo_parametro = 439) AS titulo_plantillas
FROM      proceso p (nolock)
JOIN      participante_proceso pp (nolock)
ON        pp.id_proceso = p.id_proceso
JOIN      persona pe (nolock)
ON        pe.id_persona = pp.id_persona
LEFT JOIN tipo_identificacion_persona tip
ON        pe.id_tipo_identificacion = tip.id_tipo_identificacion
LEFT JOIN persona_juridica pj (nolock)
ON        pj.id_persona_juridica = pe.id_persona
JOIN      trazabilidad_proceso tp (nolock)
ON        tp.id_proceso = p.id_proceso
AND       tp.id_estado_proceso = 43
JOIN      usuario_persona up (nolock)
ON        up.id_usuario = tp.id_usuario
JOIN      persona per (nolock)
ON        per.id_persona = up.id_persona
JOIN      funcionario fud (nolock)
ON        fud.id_funcionario =
          (
                     SELECT     ei.id_funcionario
                     FROM       evaluar_impugnacion ei
                     INNER JOIN trazabilidad_proceso tp
                     ON         tp.id_trazabilidad_proceso = ei.id_trazabilidad_proceso
                     WHERE      tp.id_proceso = p.id_proceso)
JOIN      cargo card (nolock)
ON        card.id_cargo = fud.id_cargo
JOIN      persona perd (nolock)
ON        perd.id_persona = fud.id_persona
LEFT JOIN funcionario fu (nolock)
ON        fu.id_persona = per.id_persona
LEFT JOIN cargo c (nolock)
ON        c.id_cargo = fu.id_cargo
WHERE     p.id_proceso = :idProceso
AND       pp.id_persona = ( -- La ultima firma corresponde a la persona que se presento al proceso de desestimiento    SELECT TOP 1        fp.id_persona      FROM firma_persona fp WHERE fp.id_persona IN (SELECT id_persona FROM participante_proceso WHERE id_proceso = p.id_proceso)  ORDER BY fp.fecha_registro desc  )  ORDER BY tp.id_trazabilidad_proceso DESC











---------------------------------------------------------------------------------------
--Original
SELECT    Day(Getdate())                                                                  AS dias_letras,
          Cast(Datename(mm, Getdate()) AS VARCHAR)                                        AS dia_fecha,
          Year(Getdate())                                                                 AS total_letras,
          Datepart(hour,Getdate())                                                        AS numero_autorizacion,
          Datepart(minute,Getdate())                                                      AS numero_tramite,
          Upper(Concat (per.nombre1,' ',per.nombre2,' ',per.apellido1,' ',per.apellido2)) AS nombre_funcionario,
          Upper(Concat (pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2))     AS nombre_infractor,
          Upper(tip.nombre)                                                               AS t_documento_infractor,
          (pe.numero_identificacion)                                                      AS documento_infractor,
          (p.fecha_inicio)                                                                AS fecha_solicitud,
          Getdate()                                                                       AS fecha_evaluacion,
          (
                 SELECT Max(fp.numero_imagen)
                 FROM   firma_persona fp (nolock)
                 WHERE  fp.id_persona = pe.id_persona)                                          AS imagen_firma,
          Upper(Concat (pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2))           AS nombre_infractor_1,
          (pe.numero_identificacion)                                                            AS documento_infractor_1,
          fu.numero_firma                                                                       AS firma_funcionario,
          Upper(Concat (per.nombre1,' ',per.nombre2,' ',per.apellido1,' ',per.apellido2))       AS nombre_funcionario_1,
          c.nombre                                                                              AS cargo_1,
                    Concat(perd.nombre1,' ',perd.nombre2,' ',perd.apellido1,' ',perd.apellido2) AS nombreabogadofirma,
          card.nombre                                                                           AS nombrecargo,
          (
                 SELECT Max(numero_imagen)
                 FROM   firma_persona fpe (nolock)
                 WHERE  fpe.id_persona = perd.id_persona) AS firma,
          (
                 SELECT valor_parametro_defecto
                 FROM   Parametro(nolock)
                 WHERE  codigo_parametro = 439) AS titulo_plantillas
FROM      proceso p (nolock)
JOIN      participante_proceso pp (nolock)
ON        pp.id_proceso = p.id_proceso
JOIN      persona pe (nolock)
ON        pe.id_persona = pp.id_persona
LEFT JOIN tipo_identificacion_persona tip
ON        pe.id_tipo_identificacion = tip.id_tipo_identificacion
LEFT JOIN persona_juridica pj (nolock)
ON        pj.id_persona_juridica = pe.id_persona
JOIN      trazabilidad_proceso tp (nolock)
ON        tp.id_proceso = p.id_proceso
AND       tp.id_estado_proceso = 43
JOIN      usuario_persona up (nolock)
ON        up.id_usuario = tp.id_usuario
JOIN      persona per (nolock)
ON        per.id_persona = up.id_persona
JOIN      funcionario fud (nolock)
ON        fud.id_funcionario =
          (
                     SELECT     ei.id_funcionario
                     FROM       evaluar_impugnacion ei
                     INNER JOIN trazabilidad_proceso tp
                     ON         tp.id_trazabilidad_proceso = ei.id_trazabilidad_proceso
                     WHERE      tp.id_proceso = p.id_proceso)
JOIN      cargo card (nolock)
ON        card.id_cargo = fud.id_cargo
JOIN      persona perd (nolock)
ON        perd.id_persona = fud.id_persona
LEFT JOIN funcionario fu (nolock)
ON        fu.id_persona = per.id_persona
LEFT JOIN cargo c (nolock)
ON        c.id_cargo = fu.id_cargo
WHERE     p.id_proceso = :idProceso
AND       pp.id_persona = ( -- La ultima firma corresponde a la persona que se presento al proceso de desestimiento    SELECT TOP 1        fp.id_persona      FROM firma_persona fp WHERE fp.id_persona IN (SELECT id_persona FROM participante_proceso WHERE id_proceso = p.id_proceso)  ORDER BY fp.fecha_registro desc  )  ORDER BY tp.id_trazabilidad_proceso DESC



-- Order variables
--DIAS_LETRAS,DIA_FECHA,TOTAL_LETRAS,NUMERO_AUTORIZACION,NUMERO_TRAMITE,NOMBRE_FUNCIONARIO,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,  DOCUMENTO_INFRACTOR,FECHA_SOLICITUD,FECHA_EVALUACION,IMAGEN_FIRMA,NOMBRE_INFRACTOR_1,DOCUMENTO_INFRACTOR_1,  IMAGEN_FIRMA_1,NOMBRE_FUNCIONARIO_1,cargo_1,NOMBRE_DELEGADO,CARGO_DELEGADO,IMAGEN_FIRMA_DOS,TITULO_PLANTILLAS,TITULO_PLANTILLAS