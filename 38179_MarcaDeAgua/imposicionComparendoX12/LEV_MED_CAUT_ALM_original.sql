SET language 'Spanish';

SELECT TOP 1 (SELECT Upper(nombre)
              FROM   entidad_bien
              WHERE  id_entidad_bien = :banco)                           AS
             banco,
             (SELECT TOP 1 Isnull(seg.consecutivo_oficio, '')
              FROM   seguimiento_motivo_levantamiento seg
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY seg.fecha_registro DESC)                         AS
             numero_consecutivo,
             Concat(p.numero_proceso, '-', Datepart(yy, p.fecha_inicio)) AS
             numeroJuicio,
             CONVERT( VARCHAR, Day( Getdate() ) ) + ' de '
             + CONVERT( VARCHAR, Datename( month, Getdate() ) )
             + ' del ' + CONVERT( VARCHAR, Year( Getdate() ) )           AS
             FECHA_TEXTO,
             Concat(CONVERT(VARCHAR, Datepart(hour, Getdate())), ':',
             CONVERT(VARCHAR, CASE
                                WHEN Datepart(minute, Getdate()) > 10 THEN
                                CONVERT(VARCHAR, Datepart(minute,
                                                 Getdate()))
                                ELSE Concat('0', CONVERT(VARCHAR, Datepart(
                                                 minute, Getdate())
                                                 ))
                              END))                                      AS hora
             ,
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(Concat(per.nombre1, ' ', per.nombre2, ' ',
                          per.apellido1, ' ',
                                 per.apellido2))
             END                                                         AS
             nombre,
             per.numero_identificacion                                   AS
             'Numero identificacion',
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             abogAsignado,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             abogado,
             (SELECT TOP 1 referencia_envio
              FROM   envio_doc_impresion_embargo AS env
                     INNER JOIN seguimiento_motivo_levantamiento seg
                             ON seg.id_seg_doc_impresion_embargo =
                                env.id_seg_doc_impresion_embargo
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY env.id_envio_doc_impresion_embargo DESC,
                        seg.fecha_registro DESC)                         AS
             numeroTramite,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             firmaAbogado,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             firmaAbogado1,
             segmt.idcodigoqr                                            AS
             codigoQR,
             (SELECT numero_imagen
              FROM   imagen
              WHERE  id_tipo_imagen IN(SELECT id_tipo_imagen
                                       FROM   tipo_imagen
                                       WHERE  codigo = 'LOGGO')
                     AND fecha_fin IS NULL)                              logoATM
             ,
             ic.cuenta
             AS 'Nro_cuenta'
FROM   coactivo co
       INNER JOIN coactivo_proceso cop
               ON cop.id_coactivo = co.id_coactivo
       INNER JOIN impulso_coactivo ic
               ON co.id_coactivo = ic.id_coactivo
       INNER JOIN proceso p
               ON p.id_proceso = cop.id_proceso
       INNER JOIN trazabilidad_proceso tr
               ON tr.id_proceso = p.id_proceso
                  AND tr.id_estado_proceso IN( 29, 36, 37, 45,
                                               52, 56, 27 )
       INNER JOIN persona per
               ON per.id_persona = co.id_deudor
       INNER JOIN tipo_identificacion_persona tpid
               ON tpid.id_tipo_identificacion = per.id_tipo_identificacion
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = co.id_deudor
       INNER JOIN estado_proceso estp
               ON estp.id_estado_proceso = p.id_estado_proceso
       LEFT JOIN seguimiento_motivo_levantamiento segmt
              ON segmt.id_proceso = p.id_proceso
WHERE  Year(p.fecha_inicio) = :anio
       AND p.numero_proceso = :numeroProceso 



--BANCO,numero_consecutivo,NUMERO_JUICIO,FECHA_TEXTO,HORA,NOMBRE_COMPLETO,N_DOCUMENTO_INFRACTOR,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_TRAMITE,FIRMA_FUNCIONARIO_,FIRMA_AGENTE,CODIGO_QR,LogoATM_variable,NRO_CUENTA