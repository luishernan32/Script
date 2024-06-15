--PRIMER_AUTO

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT TOP 1 pr.numero_proceso,
             pr.fecha_inicio                               AS anio_apertura,
             ra.fecha_registro,
             CASE pe.id_tipo_identificacion
               WHEN ''2'' THEN pj.nombre_comercial
               ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                          pe.apellido1, '' '',
                    pe.apellido2))
             END                                           AS nombreInfractor,
             tip.nombre,
             pe.numero_identificacion,
             ra.fecha_registro                             AS fecha_solicitud,
             (SELECT TOP 1 Concat(p.nombre1, '' '', p.nombre2, '' '', p.apellido1,
                           '' '',
                           p.apellido2)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS nombreSecretario,
             (SELECT Max(fp.numero_imagen)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS firmaSecretario,
             (SELECT TOP 1 a.correos_notificados
              FROM   apelacion a (nolock)
              WHERE  a.id_proceso = pr.id_proceso
              ORDER  BY id_apelacion DESC)                 AS correos,
             (SELECT Max(fp.numero_imagen)
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = pab.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS numero_imagen,
             (SELECT TOP 1 Upper(Concat(fu.titulo_obtenido, '' '',pab.nombre1, '' '', pab.nombre2, '' '',
                                 pab.apellido1,
                                 '' '',
                                               pab.apellido2))
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS nombreAprobador,
             c.numero_citacion,
             c.fecha_infraccion,
             c.hora_infraccion
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN recurso_apelacion ra (nolock)
         ON ra.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY fecha_solicitud DESC '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,fecha_apertura_impug,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,FECHA_SOLICITUD,NOMBRE_SECRETARIO,IMAGEN_FIRMA_DOS,CORREO_ELECTRONICO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,numero_citacion,FECHA_DELEGADO,HORA_IMPOSICION_COMPARENDO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10093

commit tran











----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Modificar

SELECT TOP 1 pr.numero_proceso,
             pr.fecha_inicio                               AS anio_apertura,
             ra.fecha_registro,
             CASE pe.id_tipo_identificacion
               WHEN '2' THEN pj.nombre_comercial
               ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                          pe.apellido1, ' ',
                    pe.apellido2))
             END                                           AS nombreInfractor,
             tip.nombre,
             pe.numero_identificacion,
             ra.fecha_registro                             AS fecha_solicitud,
             (SELECT TOP 1 Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1,
                           ' ',
                           p.apellido2)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS nombreSecretario,
             (SELECT Max(fp.numero_imagen)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS firmaSecretario,
             (SELECT TOP 1 a.correos_notificados
              FROM   apelacion a (nolock)
              WHERE  a.id_proceso = pr.id_proceso
              ORDER  BY id_apelacion DESC)                 AS correos,
             (SELECT Max(fp.numero_imagen)
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = pab.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS numero_imagen,
             (SELECT TOP 1 Upper(Concat(fu.titulo_obtenido, ' ',pab.nombre1, ' ', pab.nombre2, ' ',
                                 pab.apellido1,
                                 ' ',
                                               pab.apellido2))
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS nombreAprobador,
             c.numero_citacion,
             c.fecha_infraccion,
             c.hora_infraccion
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN recurso_apelacion ra (nolock)
         ON ra.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY fecha_solicitud DESC 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--original
--numero_consecutivo,anio_apertura_proceso,fecha_apertura_impug,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,FECHA_SOLICITUD,NOMBRE_SECRETARIO,IMAGEN_FIRMA_DOS,CORREO_ELECTRONICO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,numero_citacion,FECHA_DELEGADO,HORA_IMPOSICION_COMPARENDO

SELECT TOP 1 pr.numero_proceso,
             pr.fecha_inicio                               AS anio_apertura,
             ra.fecha_registro,
             CASE pe.id_tipo_identificacion
               WHEN '2' THEN pj.nombre_comercial
               ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                          pe.apellido1, ' ',
                    pe.apellido2))
             END                                           AS nombreInfractor,
             tip.nombre,
             pe.numero_identificacion,
             ra.fecha_registro                             AS fecha_solicitud,
             (SELECT TOP 1 Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1,
                           ' ',
                           p.apellido2)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS nombreSecretario,
             (SELECT Max(fp.numero_imagen)
              FROM   funcionario f (nolock)
                     LEFT JOIN persona p (nolock)
                            ON p.id_persona = f.id_persona
                     LEFT JOIN firma_persona fp (nolock)
                            ON fp.id_persona = p.id_persona
              WHERE  f.id_funcionario = ra.id_funcionario) AS firmaSecretario,
             (SELECT TOP 1 a.correos_notificados
              FROM   apelacion a (nolock)
              WHERE  a.id_proceso = pr.id_proceso
              ORDER  BY id_apelacion DESC)                 AS correos,
             (SELECT Max(fp.numero_imagen)
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = pab.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS numero_imagen,
             (SELECT TOP 1 Upper(Concat(pab.nombre1, ' ', pab.nombre2, ' ',
                                 pab.apellido1,
                                 ' ',
                                               pab.apellido2))
              FROM   trazabilidad_proceso tpcrr (nolock)
                     LEFT JOIN usuario_persona up1 (nolock)
                            ON up1.id_usuario = tpcrr.id_usuario
                     LEFT JOIN persona pab (nolock)
                            ON pab.id_persona = up1.id_persona
                     LEFT JOIN funcionario fu (nolock)
                            ON fu.id_persona = pab.id_persona
              WHERE  tpcrr.id_proceso = pr.id_proceso
                     AND tpcrr.id_estado_proceso = 4)      AS nombreAprobador,
             c.numero_citacion,
             c.fecha_infraccion,
             c.hora_infraccion
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN recurso_apelacion ra (nolock)
         ON ra.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY fecha_solicitud DESC 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

