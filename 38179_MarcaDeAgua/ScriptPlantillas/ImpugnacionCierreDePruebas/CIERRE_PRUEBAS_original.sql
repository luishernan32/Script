SELECT p.numero_proceso,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2))
       END                                       AS nombreCompleto,
       dbo.Correopersona(pe.id_persona)          AS correos,
       p.fecha_inicio,
       (SELECT Upper(Concat(PER.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                     ' ',
                             per.apellido2))
        FROM   trazabilidad_proceso tp (nolock)
               JOIN usuario_persona up (nolock)
                 ON up.id_usuario = tp.id_usuario
               JOIN persona per (nolock)
                 ON up.id_persona = per.id_persona
        WHERE  tp.id_estado_proceso = 6
               AND tp.id_proceso = :idProceso)   AS nombreUsuario,
       cv.placa_vehiculo,
       Concat(perd.nombre1, ' ', perd.nombre2, ' ', perd.apellido1, ' ',
       perd.apellido2)                           AS nombreAbogadoFirma,
       car.nombre                                AS NombreCargo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = perd.id_persona) AS Firma,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       (SELECT Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ',
               p.apellido1, ' ',
                       p.apellido2)
        FROM   funcionario f (nolock)
               JOIN persona p (nolock)
                 ON f.id_persona = p.id_persona
        WHERE  id_cargo = 11
               AND fecha_final_vigencia IS NULL) AS nombreDirector
FROM   proceso p (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = p.id_proceso
       JOIN comparendo co (nolock)
         ON co.cicomparendo = cp.cicomparendo
       LEFT JOIN comparendo_vehiculo cv (nolock)
              ON cv.id_comparendo_vehiculo = co.cicomparendo
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = pp.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
       JOIN usuario_persona up (nolock)
         ON up.id_usuario = tp.id_usuario
       JOIN persona per (nolock)
         ON per.id_persona = up.id_persona
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = (SELECT id_funcionario
                                 FROM   evaluar_impugnacion (nolock)
                                 WHERE  id_trazabilidad_proceso =
                                        (SELECT trei.id_trazabilidad_proceso
                                         FROM   evaluar_impugnacion eimp (nolock
                                                )
                                        INNER JOIN trazabilidad_proceso trei
                                                ON trei.id_trazabilidad_proceso
                                                   =
                                                   eimp.id_trazabilidad_proceso
                                                                   WHERE
                                        trei.id_trazabilidad_proceso = (SELECT
                                        fiei.*
                                                                        FROM
                                        (SELECT
                                Max(tpei2.id_trazabilidad_proceso) AS
                                idTraza
                                                                FROM
                                evaluar_impugnacion eimp2 (nolock)
                                INNER JOIN trazabilidad_proceso tpei2
                                ON tpei2.id_trazabilidad_proceso =
                                eimp2.id_trazabilidad_proceso
                                INNER JOIN proceso pei
                                ON pei.id_proceso = tpei2.id_proceso
                                WHERE  pei.id_proceso =
                                     :idProceso) fiei
                                )))
       JOIN cargo car (nolock)
         ON car.id_cargo = fu.id_cargo
       JOIN persona perd (nolock)
         ON perd.id_persona = fu.id_persona
WHERE  p.id_proceso = :idProceso
       AND co.id_estado_comparendo != 14
       AND tp.id_estado_proceso = 10
       AND pp.id_tipo_participante = 2 