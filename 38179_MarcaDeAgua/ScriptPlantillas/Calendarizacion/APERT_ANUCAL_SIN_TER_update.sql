begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT DISTINCT pr.numero_proceso,
                CASE pe.id_tipo_identificacion
                  WHEN ''2'' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                             pe.apellido1, '' '',
                       pe.apellido2))
                END                                                AS
                nombreInfractor,
                pr.fecha_inicio                                    AS
                anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)              fijo,
                dbo.Telefonopersona(pe.id_persona, 2)              celular,
                impg.correos_notificados                           correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT)       direccion,
                impg.descripcion_hechos
                descripcion_hechos,
                CASE pe.id_tipo_identificacion
                  WHEN ''2'' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                             pe.apellido1, '' '',
                       pe.apellido2))
                END                                                AS
                nombreCompleto,
                CASE
                  WHEN pe.id_estado_civil IS NULL THEN ''No registra''
                  ELSE ecv.nombre_estado_civil
                END                                                AS
                nombre_estado_civil,
                pe.edad,
                pro.nombre                                         AS profesion,
                impg.pruebas_aportadas                             AS
                pruebasAportadas,
                NULL                                               otros,
                Upper(Concat (pas.nombre1, '' '', pas.nombre2, '' '', pas.apellido1,
                      '' '',
                      pas.apellido2))                              AS
                nombreAsesor,
                tpf.fecha_inicio                                   AS
                fechaSolicitud,
                tpf.fecha_inicio                                   AS
                horaSolicitud,
                (SELECT img.numero_imagen
                 FROM   imagen img (nolock)
                 WHERE  img.id_tipo_imagen = 1
                        AND ( ( img.fecha_inicio <=
                                CONVERT(DATE, pr.fecha_inicio)
                                AND img.fecha_fin >=
                                    CONVERT(DATE, pr.fecha_inicio) )
                               OR ( img.fecha_inicio <=
                                    CONVERT(DATE, pr.fecha_inicio)
                                    AND img.fecha_fin IS NULL ) )) AS logo,
                muc.numero_factura                                 numeroFactura
                ,
                muc.fecha_emision
                fechaImposicion,
                (SELECT Max(numero_imagen)
                 FROM   firma_persona fpe (nolock)
                 WHERE  fpe.id_persona = pe.id_persona)            AS
                Firma_persona,
                muc.placa_vehiculo,
				(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN solicitud_anula_calendarizacion impg (nolock)
         ON impg.id_proceso = pr.id_proceso
       JOIN multa_calendarizacion muc (nolock)
         ON muc.id_multa_calendarizacion = impg.id_multa_calendarizacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,NOMBRE_INFRACTOR,anio_apertura_proceso,fecha_apertura_impug,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,NUMERO_CELULAR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,desc_motivacion,NOMBRE_COMPLETO,ESTADO_CIVIL,EDAD,PROFESION,PRUEBAS_APORTADAS,OTROS_COA,NOMBRE_FUNCIONARIO,FECHA_SOLICITUD,HORA_SOLICITUD,LogoATM_variable,NUMERO_FACTURA,fecha_imposicion,IMAGEN_FIRMA,placa,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10144xxx

commit tran




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Para modificar y probar
SELECT DISTINCT pr.numero_proceso,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                             pe.apellido1, ' ',
                       pe.apellido2))
                END                                                AS
                nombreInfractor,
                pr.fecha_inicio                                    AS
                anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)              fijo,
                dbo.Telefonopersona(pe.id_persona, 2)              celular,
                impg.correos_notificados                           correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT)       direccion,
                impg.descripcion_hechos
                descripcion_hechos,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                             pe.apellido1, ' ',
                       pe.apellido2))
                END                                                AS
                nombreCompleto,
                CASE
                  WHEN pe.id_estado_civil IS NULL THEN 'No registra'
                  ELSE ecv.nombre_estado_civil
                END                                                AS
                nombre_estado_civil,
                pe.edad,
                pro.nombre                                         AS profesion,
                impg.pruebas_aportadas                             AS
                pruebasAportadas,
                NULL                                               otros,
                Upper(Concat (pas.nombre1, ' ', pas.nombre2, ' ', pas.apellido1,
                      ' ',
                      pas.apellido2))                              AS
                nombreAsesor,
                tpf.fecha_inicio                                   AS
                fechaSolicitud,
                tpf.fecha_inicio                                   AS
                horaSolicitud,
                (SELECT img.numero_imagen
                 FROM   imagen img (nolock)
                 WHERE  img.id_tipo_imagen = 1
                        AND ( ( img.fecha_inicio <=
                                CONVERT(DATE, pr.fecha_inicio)
                                AND img.fecha_fin >=
                                    CONVERT(DATE, pr.fecha_inicio) )
                               OR ( img.fecha_inicio <=
                                    CONVERT(DATE, pr.fecha_inicio)
                                    AND img.fecha_fin IS NULL ) )) AS logo,
                muc.numero_factura                                 numeroFactura
                ,
                muc.fecha_emision
                fechaImposicion,
                (SELECT Max(numero_imagen)
                 FROM   firma_persona fpe (nolock)
                 WHERE  fpe.id_persona = pe.id_persona)            AS
                Firma_persona,
                muc.placa_vehiculo,
				(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN solicitud_anula_calendarizacion impg (nolock)
         ON impg.id_proceso = pr.id_proceso
       JOIN multa_calendarizacion muc (nolock)
         ON muc.id_multa_calendarizacion = impg.id_multa_calendarizacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Original
SELECT DISTINCT pr.numero_proceso,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                             pe.apellido1, ' ',
                       pe.apellido2))
                END                                                AS
                nombreInfractor,
                pr.fecha_inicio                                    AS
                anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)              fijo,
                dbo.Telefonopersona(pe.id_persona, 2)              celular,
                impg.correos_notificados                           correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT)       direccion,
                impg.descripcion_hechos
                descripcion_hechos,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                             pe.apellido1, ' ',
                       pe.apellido2))
                END                                                AS
                nombreCompleto,
                CASE
                  WHEN pe.id_estado_civil IS NULL THEN 'No registra'
                  ELSE ecv.nombre_estado_civil
                END                                                AS
                nombre_estado_civil,
                pe.edad,
                pro.nombre                                         AS profesion,
                impg.pruebas_aportadas                             AS
                pruebasAportadas,
                NULL                                               otros,
                Upper(Concat (pas.nombre1, ' ', pas.nombre2, ' ', pas.apellido1,
                      ' ',
                      pas.apellido2))                              AS
                nombreAsesor,
                tpf.fecha_inicio                                   AS
                fechaSolicitud,
                tpf.fecha_inicio                                   AS
                horaSolicitud,
                (SELECT img.numero_imagen
                 FROM   imagen img (nolock)
                 WHERE  img.id_tipo_imagen = 1
                        AND ( ( img.fecha_inicio <=
                                CONVERT(DATE, pr.fecha_inicio)
                                AND img.fecha_fin >=
                                    CONVERT(DATE, pr.fecha_inicio) )
                               OR ( img.fecha_inicio <=
                                    CONVERT(DATE, pr.fecha_inicio)
                                    AND img.fecha_fin IS NULL ) )) AS logo,
                muc.numero_factura                                 numeroFactura
                ,
                muc.fecha_emision
                fechaImposicion,
                (SELECT Max(numero_imagen)
                 FROM   firma_persona fpe (nolock)
                 WHERE  fpe.id_persona = pe.id_persona)            AS
                Firma_persona,
                muc.placa_vehiculo
FROM   proceso pr (nolock)
       JOIN solicitud_anula_calendarizacion impg (nolock)
         ON impg.id_proceso = pr.id_proceso
       JOIN multa_calendarizacion muc (nolock)
         ON muc.id_multa_calendarizacion = impg.id_multa_calendarizacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso 


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------