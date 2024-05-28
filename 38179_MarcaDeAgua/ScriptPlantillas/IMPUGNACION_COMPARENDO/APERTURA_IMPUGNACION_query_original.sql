




SELECT DISTINCT pr.numero_proceso,
                c.numero_citacion,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                             pe.apellido1, ' ',
                       pe.apellido2))
                END                                             AS
                nombreInfractor,
                pr.fecha_inicio                                 AS anio_apertura
                ,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)           fijo,
                dbo.Telefonopersona(pe.id_persona, 2)           celular,
                dbo.Correopersona(pe.id_persona)                correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT)    direccion,
                di.complemento                                  AS
                direccionInfraccion,
                mp.descripcion_hechos,
                CASE i.numeral_infraccion
                  WHEN ' ' THEN Concat('Artículo ', ci.articulo, ' - ',
                                nm.nombre)
                  ELSE Concat('Artículo ', ci.articulo, ', numeral ',
                       i.numeral_infraccion,
                       ' - ',
                              nm.nombre)
                END                                             AS infraccion,
                ci.descripcion,
                c.fecha_infraccion,
                CASE peter.id_tipo_identificacion
                  WHEN '2' THEN pjter.nombre_comercial
                  ELSE Upper(Concat (peter.nombre1, ' ', peter.nombre2, ' ',
                             peter.apellido1,
                             ' ',
                                          peter.apellido2))
                END                                             AS
                nombreCompletoTer,
                tipter.codigo                                   AS codigoTer,
                peter.numero_identificacion                     AS numeroTer,
                dbo.Telefonopersona(peter.id_persona, 1)        AS telefonoTer,
                dbo.Telefonopersona(peter.id_persona, 2)        AS celularTer,
                dbo.Correopersona(peter.id_persona)             AS correoTer,
                dbo.Direccionpersona(peter.id_persona, DEFAULT) AS direccionTer,
                CASE
                  WHEN peter.id_persona IS NULL THEN
                    CASE pe.id_tipo_identificacion
                      WHEN '2' THEN pj.nombre_comercial
                      ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                                 pe.apellido1, ' ',
                           pe.apellido2))
                    END
                  ELSE
                    CASE peter.id_tipo_identificacion
                      WHEN '2' THEN pjter.nombre_comercial
                      ELSE Upper(Concat (peter.nombre1, ' ', peter.nombre2, ' ',
                                 peter.apellido1, ' ',
                                              peter.apellido2))
                    END
                END                                             AS
                nombreCompletoFirma,
                CASE
                  WHEN peter.id_persona IS NULL THEN tip.codigo
                  ELSE tipter.codigo
                END                                             AS
                identificacionFirma,
                CASE
                  WHEN peter.id_persona IS NULL THEN pe.numero_identificacion
                  ELSE peter.numero_identificacion
                END                                             AS
                nombreCompleto,
                cv.placa_vehiculo,
                ecv.nombre_estado_civil,
                pe.edad,
                pro.nombre                                      AS profesion,
                mp.pruebas_aportadas                            AS
                pruebasAportadas,
                mp.otros,
                ecvter.nombre_estado_civil                      AS
                estadoCivilTer,
                peter.edad                                      AS edadTer,
                proter.nombre                                   AS profesionTer,
                Isnull(ivai.codigo_operador_agente, '')         codigoAgente,
                Upper(Concat (pas.nombre1, ' ', pas.nombre2, ' ', pas.apellido1,
                      ' ',
                      pas.apellido2))                           AS nombreAsesor,
                tpf.fecha_inicio                                AS
                fechaSolicitud,
                tpf.fecha_inicio                                AS horaSolicitud
                ,
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN 'PRESCRIPCIÓN'
                  ELSE 'IMPUGNACIÓN'
                END                                             AS
                origen_impugnacion,
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN 'Origen de impugnación:'
                  ELSE ' '
                END                                             AS
                origen_impugnacion_formulario_2,
                CASE mp.id_origen_impugnacion
                  WHEN 35 THEN 'Prescripción'
                  ELSE ' '
                END                                             AS Prescripcion2
FROM   proceso pr (nolock)
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN impugnacion impg (nolock)
              ON impg.id_proceso = pr.id_proceso
       LEFT JOIN pruebas_aportadas pat(nolock)
              ON pat.id_pruebas_aportadas = mp.id_pruebas_aportadas
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv (nolock)
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
       LEFT JOIN participante_proceso ppter (nolock)
              ON ppter.id_proceso = pr.id_proceso
                 AND ppter.id_tipo_participante = 1
       LEFT JOIN persona peter (nolock)
              ON ppter.id_persona = peter.id_persona
       LEFT JOIN estado_civil ecvter (nolock)
              ON ecvter.id_estado_civil = peter.id_estado_civil
       LEFT JOIN profesion proter (nolock)
              ON proter.id_profesion = peter.id_profesion
       LEFT JOIN persona_juridica pjter (nolock)
              ON pjter.id_persona_juridica = peter.id_persona
       LEFT JOIN tipo_identificacion_persona tipter (nolock)
              ON peter.id_tipo_identificacion = tipter.id_tipo_identificacion
       LEFT JOIN direccion_persona dpter (nolock)
              ON dpter.id_persona = peter.id_persona
       LEFT JOIN direccion dirter (nolock)
              ON dirter.id_direccion = dpter.id_direccion
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
WHERE  pr.id_proceso = :idProceso 