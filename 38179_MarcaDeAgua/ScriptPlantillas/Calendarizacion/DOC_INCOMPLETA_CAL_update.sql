begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       tpf1.fecha_inicio
       AS fechaSolicitud,
       tpf1.fecha_inicio
       AS horaSolicitud,
       (SELECT Concat (per.nombre1, '' '', per.apellido1, '' '', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 11)
       AS nombre_director,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
              pe.apellido2))
       END
       AS nombreInfractor,
       pe.numero_identificacion,
       eimp.consideracion_juridica,
       Concat(p_ah.nombre1, '' '', p_ah.nombre2, '' '', p_ah.apellido1, '' '',
       p_ah.apellido2)
       AS nombre_secretario_adhoc,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(f.titulo_obtenido, '' '',per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 correo_electronico
        FROM   correo_persona
        WHERE  id_persona = pe.id_persona
        ORDER  BY fecha_actualizacion DESC,
                  id_correo_persona DESC)
       AS correo_electronico_infractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = p_ah.id_persona)
       AS firma_secretario_adhoc,
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
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
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
       LEFT JOIN usuario_persona up_ah
              ON up_ah.id_usuario = tpf.id_usuario
       LEFT JOIN persona p_ah
              ON p_ah.id_persona = up_ah.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,fecha_actual,hora_actual,NOMBRE_COMPLETO,MEMO_DELEGADO,FECHA_DELEGADO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,TEXTO_NOMBRE_1,NOMBRE_SECRETARIO,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,CORREO_ELECTRONICO_INFRACTOR,IMAGEN_FIRMA_DOS,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10153xxx

commit tran


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Modificado
SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       tpf1.fecha_inicio
       AS fechaSolicitud,
       tpf1.fecha_inicio
       AS horaSolicitud,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 11)
       AS nombre_director,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2))
       END
       AS nombreInfractor,
       pe.numero_identificacion,
       eimp.consideracion_juridica,
       Concat(p_ah.nombre1, ' ', p_ah.nombre2, ' ', p_ah.apellido1, ' ',
       p_ah.apellido2)
       AS nombre_secretario_adhoc,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(f.titulo_obtenido, ' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 correo_electronico
        FROM   correo_persona
        WHERE  id_persona = pe.id_persona
        ORDER  BY fecha_actualizacion DESC,
                  id_correo_persona DESC)
       AS correo_electronico_infractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = p_ah.id_persona)
       AS firma_secretario_adhoc,
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
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
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
       LEFT JOIN usuario_persona up_ah
              ON up_ah.id_usuario = tpf.id_usuario
       LEFT JOIN persona p_ah
              ON p_ah.id_persona = up_ah.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Original

SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       tpf1.fecha_inicio
       AS fechaSolicitud,
       tpf1.fecha_inicio
       AS horaSolicitud,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 11)
       AS nombre_director,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2))
       END
       AS nombreInfractor,
       pe.numero_identificacion,
       eimp.consideracion_juridica,
       Concat(p_ah.nombre1, ' ', p_ah.nombre2, ' ', p_ah.apellido1, ' ',
       p_ah.apellido2)
       AS nombre_secretario_adhoc,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo,
       (SELECT TOP 1 correo_electronico
        FROM   correo_persona
        WHERE  id_persona = pe.id_persona
        ORDER  BY fecha_actualizacion DESC,
                  id_correo_persona DESC)
       AS correo_electronico_infractor,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = p_ah.id_persona)
       AS firma_secretario_adhoc
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
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
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
       LEFT JOIN usuario_persona up_ah
              ON up_ah.id_usuario = tpf.id_usuario
       LEFT JOIN persona p_ah
              ON p_ah.id_persona = up_ah.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------