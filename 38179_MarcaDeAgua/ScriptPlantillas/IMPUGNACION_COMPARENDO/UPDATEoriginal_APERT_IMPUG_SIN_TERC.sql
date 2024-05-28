
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT DISTINCT pr.numero_proceso,
                c.numero_citacion,
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
                COALESCE(Stuff(impg.correos_notificados,
                                  Len(impg.correos_notificados) -
                                  Charindex('','',
                                  Reverse(impg.correos_notificados)) + 1, 1, '' ''
                         )
                , impg.correos_notificados)                        correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT)       direccion,
                di.complemento                                     AS
                direccionInfraccion,
                mp.descripcion_hechos,
                CASE i.numeral_infraccion
                  WHEN '' '' THEN Concat(''Artículo '', ci.articulo, '' - '',
                                nm.nombre)
                  ELSE Concat(''Artículo '', ci.articulo, '', numeral '',
                       i.numeral_infraccion,
                       '' - '',
                              nm.nombre)
                END                                                AS infraccion
                ,
                ci.descripcion,
                c.fecha_infraccion,
                CASE pe.id_tipo_identificacion
                  WHEN ''2'' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                             pe.apellido1, '' '',
                       pe.apellido2))
                END                                                AS
                nombreCompleto,
                cv.placa_vehiculo,
                ecv.nombre_estado_civil,
                pe.edad,
                pro.nombre                                         AS profesion,
                mp.pruebas_aportadas                               AS
                pruebasAportadas,
                mp.otros,
                Isnull(ivai.codigo_operador_agente, '''')            codigoAgente,
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
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN ''PRESCRIPCIÓN''
                  ELSE ''IMPUGNACIÓN''
                END                                                AS
                origen_impugnacion,
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN ''Origen de impugnación:''
                  ELSE '' ''
                END                                                AS
                origen_impugnacion_formulario,
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN ''Prescripción''
                  ELSE '' ''
                END                                                AS
                prescripcion_texto
FROM   proceso pr (nolock)
       JOIN impugnacion impg (nolock)
         ON impg.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN pruebas_aportadas pat (nolock)
              ON pat.id_pruebas_aportadas = mp.id_pruebas_aportadas
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
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
       LEFT JOIN direccion di (nolock)
              ON di.id_direccion = c.id_direccion_comparendo
       LEFT JOIN integracion_terceros..v_all_infracciones ivai (nolock)
              ON c.id_factura_axis = ivai.numero_factura
                 AND c.numero_citacion = ivai.numero_citacion
                 AND c.codigo_medio_imposicion = 1
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
	   , orden_variables='numero_consecutivo,numero_citacion,NOMBRE_INFRACTOR,anio_apertura_proceso,fecha_apertura_impug,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,NUMERO_CELULAR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,DIRECCION_INFRACCION,desc_motivacion,ARTICULO,DESCRIPCION_INFRACCION,fecha_imposicion,NOMBRE_COMPLETO,PLACA_VEHICULO,ESTADO_CIVIL,EDAD,PROFESION,PRUEBAS_APORTADAS,OTROS_COA,CODIGO_AGENTE,NOMBRE_SECRETARIO,FECHA_SOLICITUD,HORA_SOLICITUD,LogoATM_variable,origen_impugnacion,origen_impugnacion_formulario,prescripcion_texto'
WHERE  id_plantilla_config=54xx

commit tran