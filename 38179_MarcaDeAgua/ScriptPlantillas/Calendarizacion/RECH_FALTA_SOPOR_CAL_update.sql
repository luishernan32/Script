begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       Getdate()
       AS fechaActual,
       Getdate()
       AS horaActual,
       (SELECT Concat (per.nombre1, '' '', per.apellido1, '' '', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 3)
       AS nombre_coordinador,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
              pe.apellido2))
       END
       AS nombreInfractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(f.titulo_obtenido, '' '',per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 Concat(p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '',
                     p.apellido2)
        FROM   trazabilidad_proceso tp (nolock)
               INNER JOIN usuario_persona up (nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p (nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp (nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 79
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)
       AS nombreSecretario,
	   (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
            AND tpf.id_estado_proceso = 94
       LEFT JOIN evaluar_impugnacion eimp (nolock)
              ON eimp.id_trazabilidad_proceso = tpf.id_trazabilidad_proceso
       LEFT JOIN funcionario_calendarizacion fu (nolock)
              ON fu.id_funcionario = (SELECT TOP 1 ei.id_funcionario
                                      FROM   evaluar_impugnacion ei
                 INNER JOIN trazabilidad_proceso tp
                         ON tp.id_trazabilidad_proceso =
                            ei.id_trazabilidad_proceso
                                      WHERE  tp.id_proceso = pr.id_proceso
                                      ORDER  BY ei.id_evaluar_impugnacion DESC)
       LEFT JOIN funcionario f (nolock)
              ON f.id_funcionario = fu.id_funcionario
       LEFT JOIN cargo car (nolock)
              ON car.id_cargo = fu.id_cargo
       LEFT JOIN persona per (nolock)
              ON per.id_persona = f.id_persona
       LEFT JOIN trazabilidad_proceso tpf1
              ON tpf1.id_proceso = pr.id_proceso
                 AND tpf1.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,fecha_actual,hora_actual,NOMBRE_COMPLETO,MEMO_DELEGADO,FECHA_DELEGADO,NOMBRE_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,ABOGADO_PROYECTADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10154xxx

commit tran


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       Getdate()
       AS fechaActual,
       Getdate()
       AS horaActual,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 3)
       AS nombre_coordinador,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2))
       END
       AS nombreInfractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(f.titulo_obtenido, ' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp (nolock)
               INNER JOIN usuario_persona up (nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p (nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp (nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 79
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)
       AS nombreSecretario,
	   (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
            AND tpf.id_estado_proceso = 94
       LEFT JOIN evaluar_impugnacion eimp (nolock)
              ON eimp.id_trazabilidad_proceso = tpf.id_trazabilidad_proceso
       LEFT JOIN funcionario_calendarizacion fu (nolock)
              ON fu.id_funcionario = (SELECT TOP 1 ei.id_funcionario
                                      FROM   evaluar_impugnacion ei
                 INNER JOIN trazabilidad_proceso tp
                         ON tp.id_trazabilidad_proceso =
                            ei.id_trazabilidad_proceso
                                      WHERE  tp.id_proceso = pr.id_proceso
                                      ORDER  BY ei.id_evaluar_impugnacion DESC)
       LEFT JOIN funcionario f (nolock)
              ON f.id_funcionario = fu.id_funcionario
       LEFT JOIN cargo car (nolock)
              ON car.id_cargo = fu.id_cargo
       LEFT JOIN persona per (nolock)
              ON per.id_persona = f.id_persona
       LEFT JOIN trazabilidad_proceso tpf1
              ON tpf1.id_proceso = pr.id_proceso
                 AND tpf1.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--Original

SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       Getdate()
       AS fechaActual,
       Getdate()
       AS horaActual,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 3)
       AS nombre_coordinador,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2))
       END
       AS nombreInfractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp (nolock)
               INNER JOIN usuario_persona up (nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p (nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp (nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 79
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)
       AS nombreSecretario
FROM   proceso pr (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
            AND tpf.id_estado_proceso = 94
       LEFT JOIN evaluar_impugnacion eimp (nolock)
              ON eimp.id_trazabilidad_proceso = tpf.id_trazabilidad_proceso
       LEFT JOIN funcionario_calendarizacion fu (nolock)
              ON fu.id_funcionario = (SELECT TOP 1 ei.id_funcionario
                                      FROM   evaluar_impugnacion ei
                 INNER JOIN trazabilidad_proceso tp
                         ON tp.id_trazabilidad_proceso =
                            ei.id_trazabilidad_proceso
                                      WHERE  tp.id_proceso = pr.id_proceso
                                      ORDER  BY ei.id_evaluar_impugnacion DESC)
       LEFT JOIN funcionario f (nolock)
              ON f.id_funcionario = fu.id_funcionario
       LEFT JOIN cargo car (nolock)
              ON car.id_cargo = fu.id_cargo
       LEFT JOIN persona per (nolock)
              ON per.id_persona = f.id_persona
       LEFT JOIN trazabilidad_proceso tpf1
              ON tpf1.id_proceso = pr.id_proceso
                 AND tpf1.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------