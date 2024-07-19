--AUTO_PAGO_PATIO_V2 2641

begin tran --10116
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       CASE per.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                    '' '',
                           per.apellido2))
       END                                                 AS nombreCompleto,
       Concat (p.numero_obligacion, ''-'', Year(Sysdatetime()), ''-'',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                    WHERE
       id_periodo_precoactivo = :periodo), ''-'', (SELECT Count(*)
                                                 FROM   titulo_credito
                                                 WHERE
       id_periodo_precoactivo = :periodo))                 AS consecutivo,
       per.numero_identificacion,
       dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,
       tp.fecha_inicio                                     AS fechaActual,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               '' '',
                       per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
               per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,
       (SELECT Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
               per.apellido2)
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 4
               AND f.id_subcargo = 3)                      AS nombrefuncionario2
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS firma,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.fecha_final_vigencia IS NULL
               AND fu.id_cargo = 4
               AND fu.id_subcargo = 3)                     AS firma2,
       ti.codigo,
       (SELECT Sum(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_precoactivo = p.id_precoactivo
               AND estado_periodo <> ''ANULADO'')            AS v,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)
                                             FROM   periodo_precoactivo
                                             WHERE
               id_precoactivo = p.id_precoactivo
               AND estado_periodo <> ''ANULADO''),
               ''''))                                        AS valorTotalLetras,
       (SELECT f.memo_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS memo,
       (SELECT f.fecha_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,
       tp.fecha_inicio                                     AS fecha3,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast(''2021-12-28'' AS DATE) THEN (SELECT
                 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                 Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), '' '',
                 per.nombre1,
                 '' ''
                                                                            ,
                 per.nombre2, '' '',
                 per.apellido1, '' '', per.apellido2, '', Mgs'')
                                                                          FROM
                 funcionario f,
                 persona per
                                                                          WHERE
                 f.id_cargo = 11
                 AND per.id_persona = f.id_persona
                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                  OR ( f.id_cargo = 11
                       AND per.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast(''2021-12-28'' AS DATE) THEN (SELECT
                 Concat (
                 Substring(f.titulo_obtenido, 1, 1), Lower(
                      Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                 '' '',
                 per.nombre1,
                      '' ''
                    , per.nombre2, '' '', per.apellido1, '' '', per.apellido2)
                  FROM   funcionario f,
                         persona per
                  WHERE  per.id_persona = f.id_persona
                         AND f.id_funcionario = 117)
                 ELSE ''''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)               AS nombrefuncionario3
       ,
       p.placa_vehiculo                                    AS placa,
       tim.nombre                                          AS motivoRetencion,
       CASE
         WHEN tim.articulo IS NULL THEN ''''
         WHEN tim.articulo <> '''' THEN Concat (''dispuesto en el '', tim.articulo,
                                      '', '')
         ELSE ''''
       END                                                 AS articulo,
       peri.numero_periodo,
       peri.fecha_inicio_periodo,
       peri.fecha_fin_periodo,
       peri.valor_tasa,
       (SELECT ( valor_parametro_defecto )
        FROM   parametro
        WHERE  codigo_parametro = 434)                     AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN trazabilidad_proceso tp(nolock)
               ON tp.id_proceso = c.id_proceso
       INNER JOIN periodo_precoactivo peri
               ON peri.id_precoactivo = p.id_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo tim
               ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion
       INNER JOIN titulo_credito t
               ON t.id_periodo_precoactivo = peri.id_periodo
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( ''activo'', ''inactivo'' )
       AND peri.estado_notificacion = ''enviado''
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69
       AND peri.id_periodo = :periodo'               
	   , orden_variables='CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,N_DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_GENERACION,NOMBRE_DELEGADO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,IMAGEN_FIRMA_DOS,T_DOCUMENTO_INFRACTOR,VALOR_INTERES,VALOR_TOTAL_LETRAS,TEXTO_NOTIFICACION,FECHA_EVALUACION,hora_actual,ABOGADO_PROYECTADO,placa,TEXTO_NOMBRE_1,ARTICULO,NUMERO_FACTURA,FECHA_INFRACCION,FECHA_INFRACCION2,VALOR_INTERES2,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10116

commit tran


begin tran --10149
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       CASE per.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                    '' '',
                           per.apellido2))
       END                                                 AS nombreCompleto,
       Concat (p.numero_obligacion, ''-'', Year(Sysdatetime()), ''-'',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                    WHERE
       id_periodo_precoactivo = :periodo), ''-'', (SELECT Count(*)
                                                 FROM   titulo_credito
                                                 WHERE
       id_periodo_precoactivo = :periodo))                 AS consecutivo,
       per.numero_identificacion,
       dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,
       tp.fecha_inicio                                     AS fechaActual,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               '' '',
                       per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
               per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,
       (SELECT Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
               per.apellido2)
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 4
               AND f.id_subcargo = 3)                      AS nombrefuncionario2
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS firma,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.fecha_final_vigencia IS NULL
               AND fu.id_cargo = 4
               AND fu.id_subcargo = 3)                     AS firma2,
       ti.codigo,
       (SELECT Sum(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_precoactivo = p.id_precoactivo
               AND estado_periodo <> ''ANULADO'')            AS v,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)
                                             FROM   periodo_precoactivo
                                             WHERE
               id_precoactivo = p.id_precoactivo
               AND estado_periodo <> ''ANULADO''),
               ''''))                                        AS valorTotalLetras,
       (SELECT f.memo_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS memo,
       (SELECT f.fecha_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,
       tp.fecha_inicio                                     AS fecha3,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast(''2021-12-28'' AS DATE) THEN (SELECT
                 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                 Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), '' '',
                 per.nombre1,
                 '' ''
                                                                            ,
                 per.nombre2, '' '',
                 per.apellido1, '' '', per.apellido2, '', Mgs'')
                                                                          FROM
                 funcionario f,
                 persona per
                                                                          WHERE
                 f.id_cargo = 11
                 AND per.id_persona = f.id_persona
                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                  OR ( f.id_cargo = 11
                       AND per.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast(''2021-12-28'' AS DATE) THEN (SELECT
                 Concat (
                 Substring(f.titulo_obtenido, 1, 1), Lower(
                      Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                 '' '',
                 per.nombre1,
                      '' ''
                    , per.nombre2, '' '', per.apellido1, '' '', per.apellido2)
                  FROM   funcionario f,
                         persona per
                  WHERE  per.id_persona = f.id_persona
                         AND f.id_funcionario = 117)
                 ELSE ''''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)               AS nombrefuncionario3
       ,
       p.placa_vehiculo                                    AS placa,
       tim.nombre                                          AS motivoRetencion,
       CASE
         WHEN tim.articulo IS NULL THEN ''''
         WHEN tim.articulo <> '''' THEN Concat (''dispuesto en el '', tim.articulo,
                                      '', '')
         ELSE ''''
       END                                                 AS articulo,
       peri.numero_periodo,
       peri.fecha_inicio_periodo,
       peri.fecha_fin_periodo,
       peri.valor_tasa,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436)                     AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN trazabilidad_proceso tp(nolock)
               ON tp.id_proceso = c.id_proceso
       INNER JOIN periodo_precoactivo peri
               ON peri.id_precoactivo = p.id_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo tim
               ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion
       INNER JOIN titulo_credito t
               ON t.id_periodo_precoactivo = peri.id_periodo
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( ''activo'', ''inactivo'' )
       AND peri.estado_notificacion = ''enviado''
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69
       AND peri.id_periodo = :periodo '               
	   , orden_variables='CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,N_DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_GENERACION,NOMBRE_DELEGADO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,IMAGEN_FIRMA_DOS,T_DOCUMENTO_INFRACTOR,VALOR_INTERES,VALOR_TOTAL_LETRAS,TEXTO_NOTIFICACION,FECHA_EVALUACION,hora_actual,ABOGADO_PROYECTADO,placa,TEXTO_NOMBRE_1,ARTICULO,NUMERO_FACTURA,FECHA_INFRACCION,FECHA_INFRACCION2,VALOR_INTERES2,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10149

commit tran
-------------------------------------------------------

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'AUTO_PAGO_PATIO_V2';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada id_config=10116 
--order variables=CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,N_DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_GENERACION,NOMBRE_DELEGADO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,IMAGEN_FIRMA_DOS,T_DOCUMENTO_INFRACTOR,VALOR_INTERES,VALOR_TOTAL_LETRAS,TEXTO_NOTIFICACION,FECHA_EVALUACION,hora_actual,ABOGADO_PROYECTADO,placa,TEXTO_NOMBRE_1,ARTICULO,NUMERO_FACTURA,FECHA_INFRACCION,FECHA_INFRACCION2,VALOR_INTERES2,CARGO_DELEGADO
-------------------------------------------------------------------------------------
DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       CASE per.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                    ' ',
                           per.apellido2))
       END                                                 AS nombreCompleto,
       Concat (p.numero_obligacion, '-', Year(Sysdatetime()), '-',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                    WHERE
       id_periodo_precoactivo = :periodo), '-', (SELECT Count(*)
                                                 FROM   titulo_credito
                                                 WHERE
       id_periodo_precoactivo = :periodo))                 AS consecutivo,
       per.numero_identificacion,
       dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,
       tp.fecha_inicio                                     AS fechaActual,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' ',
                       per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
               per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,
       (SELECT Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
               per.apellido2)
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 4
               AND f.id_subcargo = 3)                      AS nombrefuncionario2
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS firma,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.fecha_final_vigencia IS NULL
               AND fu.id_cargo = 4
               AND fu.id_subcargo = 3)                     AS firma2,
       ti.codigo,
       (SELECT Sum(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO')            AS v,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)
                                             FROM   periodo_precoactivo
                                             WHERE
               id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO'),
               ''))                                        AS valorTotalLetras,
       (SELECT f.memo_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS memo,
       (SELECT f.fecha_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,
       tp.fecha_inicio                                     AS fecha3,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast('2021-12-28' AS DATE) THEN (SELECT
                 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                 Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), ' ',
                 per.nombre1,
                 ' '
                                                                            ,
                 per.nombre2, ' ',
                 per.apellido1, ' ', per.apellido2, ', Mgs')
                                                                          FROM
                 funcionario f,
                 persona per
                                                                          WHERE
                 f.id_cargo = 11
                 AND per.id_persona = f.id_persona
                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                  OR ( f.id_cargo = 11
                       AND per.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast('2021-12-28' AS DATE) THEN (SELECT
                 Concat (
                 Substring(f.titulo_obtenido, 1, 1), Lower(
                      Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                 ' ',
                 per.nombre1,
                      ' '
                    , per.nombre2, ' ', per.apellido1, ' ', per.apellido2)
                  FROM   funcionario f,
                         persona per
                  WHERE  per.id_persona = f.id_persona
                         AND f.id_funcionario = 117)
                 ELSE ''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)               AS nombrefuncionario3
       ,
       p.placa_vehiculo                                    AS placa,
       tim.nombre                                          AS motivoRetencion,
       CASE
         WHEN tim.articulo IS NULL THEN ''
         WHEN tim.articulo <> '' THEN Concat ('dispuesto en el ', tim.articulo,
                                      ', ')
         ELSE ''
       END                                                 AS articulo,
       peri.numero_periodo,
       peri.fecha_inicio_periodo,
       peri.fecha_fin_periodo,
       peri.valor_tasa,
       (SELECT ( valor_parametro_defecto )
        FROM   parametro
        WHERE  codigo_parametro = 434)                     AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN trazabilidad_proceso tp(nolock)
               ON tp.id_proceso = c.id_proceso
       INNER JOIN periodo_precoactivo peri
               ON peri.id_precoactivo = p.id_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo tim
               ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion
       INNER JOIN titulo_credito t
               ON t.id_periodo_precoactivo = peri.id_periodo
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( 'activo', 'inactivo' )
       AND peri.estado_notificacion = 'enviado'
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69
       AND peri.id_periodo = :periodo 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
DECLARE @FECHA DATE    SELECT TOP 1 @FECHA = tp.fecha_inicio  FROM   coactivo c(nolock)         JOIN proceso p(nolock)           ON p.id_proceso = c.id_proceso         JOIN trazabilidad_proceso tp(nolock)           ON tp.id_proceso = c.id_proceso              AND tp.id_estado_proceso = 69  WHERE  c.id_coactivo = :idCoactivo  ORDER  BY c.id_coactivo DESC    SELECT c.numero_coactivo,         CASE per.id_tipo_identificacion           WHEN '2' THEN pj.nombre_comercial           ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,                      ' ',                             per.apellido2))         END                                                 AS nombreCompleto,         Concat (p.numero_obligacion, '-', Year(Sysdatetime()), '-',         (SELECT Max(t.numero_proceso)          FROM         titulo_credito t                                                                      WHERE         id_periodo_precoactivo = :periodo), '-', (SELECT Count(*)                                                   FROM   titulo_credito                                                   WHERE         id_periodo_precoactivo = :periodo))                 AS consecutivo,         per.numero_identificacion,         dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,         tp.fecha_inicio                                     AS fechaActual,         (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(                         Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),                 ' ',                         per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',                 per.apellido2)          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,         (SELECT Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',                 per.apellido2)          FROM   funcionario f,                 persona per          WHERE  per.id_persona = f.id_persona                 AND f.fecha_final_vigencia IS NULL                 AND f.id_cargo = 4                 AND f.id_subcargo = 3)                      AS nombrefuncionario2         ,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp(nolock)                 INNER JOIN funcionario_coactivo f(nolock)                         ON f.id_persona = fp.id_persona          WHERE  f.id_cargo = 1                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS firma,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp(nolock)                 INNER JOIN funcionario fu(nolock)                         ON fu.id_persona = fp.id_persona          WHERE  fu.fecha_final_vigencia IS NULL                 AND fu.id_cargo = 4                 AND fu.id_subcargo = 3)                     AS firma2,         ti.codigo,         (SELECT Sum(valor_tasa)          FROM   periodo_precoactivo          WHERE  id_precoactivo = p.id_precoactivo                 AND estado_periodo <> 'ANULADO')            AS v,         (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)                                               FROM   periodo_precoactivo                                               WHERE                 id_precoactivo = p.id_precoactivo                 AND estado_periodo <> 'ANULADO'),                 ''))                                        AS valorTotalLetras,         (SELECT f.memo_nombramiento          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS memo,         (SELECT f.fecha_nombramiento          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,         tp.fecha_inicio                                     AS fecha3,         (SELECT CASE                   WHEN tp.fecha_inicio >= Cast('2021-12-28' AS DATE) THEN (SELECT                   Concat (Substring(f.titulo_obtenido, 1, 1), Lower(                   Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), ' ',                   per.nombre1,                   ' '                                                                              ,                   per.nombre2, ' ',                   per.apellido1, ' ', per.apellido2, ', Mgs')                                                                            FROM                   funcionario f,                   persona per                                                                            WHERE                   f.id_cargo = 11                   AND per.id_persona = f.id_persona                   AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                   AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                    OR ( f.id_cargo = 11                         AND per.id_persona = f.id_persona                         AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                         AND f.fecha_final_vigencia IS NULL ))                   WHEN tp.fecha_inicio < Cast('2021-12-28' AS DATE) THEN (SELECT                   Concat (                   Substring(f.titulo_obtenido, 1, 1), Lower(                        Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),                   ' ',                   per.nombre1,                        ' '                      , per.nombre2, ' ', per.apellido1, ' ', per.apellido2)                    FROM   funcionario f,                           persona per                    WHERE  per.id_persona = f.id_persona                           AND f.id_funcionario = 117)                   ELSE ''                 END AS funcionario          FROM   trazabilidad_proceso tp          WHERE  id_estado_proceso = 69                 AND id_proceso = t.idproceso)               AS nombrefuncionario3         ,         p.placa_vehiculo                                    AS placa,         tim.nombre                                          AS motivoRetencion,         CASE           WHEN tim.articulo IS NULL THEN ''           WHEN tim.articulo <> '' THEN Concat ('dispuesto en el ', tim.articulo,                                        ', ')           ELSE ''         END                                                 AS articulo,         peri.numero_periodo,         peri.fecha_inicio_periodo,         peri.fecha_fin_periodo,         peri.valor_tasa,         (select (valor_parametro_defecto) from parametro  where codigo_parametro=434)                     AS cargo_delegado  FROM   precoactivo p         INNER JOIN coactivo c                 ON c.id_deudor = p.id_deudor         INNER JOIN trazabilidad_proceso tp(nolock)                 ON tp.id_proceso = c.id_proceso         INNER JOIN periodo_precoactivo peri                 ON peri.id_precoactivo = p.id_precoactivo         INNER JOIN persona per                 ON per.id_persona = p.id_deudor         INNER JOIN tipo_identificacion_persona ti                 ON per.id_tipo_identificacion = ti.id_tipo_identificacion         LEFT JOIN persona_juridica pj(nolock)                ON pj.id_persona_juridica = per.id_persona         INNER JOIN motivo_inmovilizacion_vehiculo tim                 ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion         INNER JOIN titulo_credito t                 ON t.id_periodo_precoactivo = peri.id_periodo  WHERE  peri.fecha_notificacion_titulo IS NOT NULL         AND peri.estado_periodo IN ( 'activo', 'inactivo' )         AND peri.estado_notificacion = 'enviado'         AND p.id_deudor = :deudor         AND c.id_coactivo = :idCoactivo         AND tp.id_estado_proceso = 69         AND peri.id_periodo = :periodo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


--Modifcada id_config=10149
--order variables=CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,N_DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_GENERACION,NOMBRE_DELEGADO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,IMAGEN_FIRMA_DOS,T_DOCUMENTO_INFRACTOR,VALOR_INTERES,VALOR_TOTAL_LETRAS,TEXTO_NOTIFICACION,FECHA_EVALUACION,hora_actual,ABOGADO_PROYECTADO,placa,TEXTO_NOMBRE_1,ARTICULO,NUMERO_FACTURA,FECHA_INFRACCION,FECHA_INFRACCION2,VALOR_INTERES2,CARGO_DELEGADO
-------------------------------------------------------------------------------------
DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       CASE per.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                    ' ',
                           per.apellido2))
       END                                                 AS nombreCompleto,
       Concat (p.numero_obligacion, '-', Year(Sysdatetime()), '-',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                    WHERE
       id_periodo_precoactivo = :periodo), '-', (SELECT Count(*)
                                                 FROM   titulo_credito
                                                 WHERE
       id_periodo_precoactivo = :periodo))                 AS consecutivo,
       per.numero_identificacion,
       dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,
       tp.fecha_inicio                                     AS fechaActual,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' ',
                       per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
               per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,
       (SELECT Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
               per.apellido2)
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 4
               AND f.id_subcargo = 3)                      AS nombrefuncionario2
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS firma,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.fecha_final_vigencia IS NULL
               AND fu.id_cargo = 4
               AND fu.id_subcargo = 3)                     AS firma2,
       ti.codigo,
       (SELECT Sum(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO')            AS v,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)
                                             FROM   periodo_precoactivo
                                             WHERE
               id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO'),
               ''))                                        AS valorTotalLetras,
       (SELECT f.memo_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS memo,
       (SELECT f.fecha_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,
       tp.fecha_inicio                                     AS fecha3,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast('2021-12-28' AS DATE) THEN (SELECT
                 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                 Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), ' ',
                 per.nombre1,
                 ' '
                                                                            ,
                 per.nombre2, ' ',
                 per.apellido1, ' ', per.apellido2, ', Mgs')
                                                                          FROM
                 funcionario f,
                 persona per
                                                                          WHERE
                 f.id_cargo = 11
                 AND per.id_persona = f.id_persona
                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                  OR ( f.id_cargo = 11
                       AND per.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast('2021-12-28' AS DATE) THEN (SELECT
                 Concat (
                 Substring(f.titulo_obtenido, 1, 1), Lower(
                      Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                 ' ',
                 per.nombre1,
                      ' '
                    , per.nombre2, ' ', per.apellido1, ' ', per.apellido2)
                  FROM   funcionario f,
                         persona per
                  WHERE  per.id_persona = f.id_persona
                         AND f.id_funcionario = 117)
                 ELSE ''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)               AS nombrefuncionario3
       ,
       p.placa_vehiculo                                    AS placa,
       tim.nombre                                          AS motivoRetencion,
       CASE
         WHEN tim.articulo IS NULL THEN ''
         WHEN tim.articulo <> '' THEN Concat ('dispuesto en el ', tim.articulo,
                                      ', ')
         ELSE ''
       END                                                 AS articulo,
       peri.numero_periodo,
       peri.fecha_inicio_periodo,
       peri.fecha_fin_periodo,
       peri.valor_tasa,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436)                     AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN trazabilidad_proceso tp(nolock)
               ON tp.id_proceso = c.id_proceso
       INNER JOIN periodo_precoactivo peri
               ON peri.id_precoactivo = p.id_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo tim
               ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion
       INNER JOIN titulo_credito t
               ON t.id_periodo_precoactivo = peri.id_periodo
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( 'activo', 'inactivo' )
       AND peri.estado_notificacion = 'enviado'
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69
       AND peri.id_periodo = :periodo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
DECLARE @FECHA DATE    SELECT TOP 1 @FECHA = tp.fecha_inicio  FROM   coactivo c(nolock)         JOIN proceso p(nolock)           ON p.id_proceso = c.id_proceso         JOIN trazabilidad_proceso tp(nolock)           ON tp.id_proceso = c.id_proceso              AND tp.id_estado_proceso = 69  WHERE  c.id_coactivo = :idCoactivo  ORDER  BY c.id_coactivo DESC    SELECT c.numero_coactivo,         CASE per.id_tipo_identificacion           WHEN '2' THEN pj.nombre_comercial           ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,                      ' '                             , per.apellido2))         END                                                 AS nombreCompleto,         Concat (p.numero_obligacion, '-', Year(Sysdatetime()), '-',         (SELECT Max(t.numero_proceso)          FROM         titulo_credito t                                                                      WHERE         id_periodo_precoactivo = :periodo), '-', (SELECT Count(*)                                                   FROM   titulo_credito                                                   WHERE         id_periodo_precoactivo = :periodo))                 AS consecutivo,         per.numero_identificacion,         dbo.Direccionpersona(per.id_persona, DEFAULT)       AS direccionDuedor,         tp.fecha_inicio                                     AS fechaActual,         (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(                         Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),                 ' '                         , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '                 , per.apellido2)          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS nombrefuncionario,         (SELECT Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '                 , per.apellido2)          FROM   funcionario f,                 persona per          WHERE  per.id_persona = f.id_persona                 AND f.fecha_final_vigencia IS NULL                 AND f.id_cargo = 4                 AND f.id_subcargo = 3)                      AS nombrefuncionario2         ,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp(nolock)                 INNER JOIN funcionario_coactivo f(nolock)                         ON f.id_persona = fp.id_persona          WHERE  f.id_cargo = 1                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS firma,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp(nolock)                 INNER JOIN funcionario fu(nolock)                         ON fu.id_persona = fp.id_persona          WHERE  fu.fecha_final_vigencia IS NULL                 AND fu.id_cargo = 4                 AND fu.id_subcargo = 3)                     AS firma2,         ti.codigo,         (SELECT Sum(valor_tasa)          FROM   periodo_precoactivo          WHERE  id_precoactivo = p.id_precoactivo                 AND estado_periodo <> 'ANULADO')            AS v,         (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)                                               FROM   periodo_precoactivo                                               WHERE                 id_precoactivo = p.id_precoactivo                 AND estado_periodo <> 'ANULADO'),                 ''))                                        AS valorTotalLetras,         (SELECT f.memo_nombramiento          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS memo,         (SELECT f.fecha_nombramiento          FROM   funcionario_coactivo f,                 persona per          WHERE  f.id_cargo = 1                 AND per.id_persona = f.id_persona                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND per.id_persona = f.id_persona                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL )) AS fechaMemo,         tp.fecha_inicio                                     AS fecha3,         (SELECT CASE                   WHEN tp.fecha_inicio >= Cast('2021-12-28' AS DATE) THEN (SELECT                   Concat (Substring(f.titulo_obtenido, 1, 1), Lower(                   Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), ' '                   , per.nombre1,                   ' '         , per.nombre2, ' ',         per.apellido1, ' ', per.apellido2, ', Mgs')         FROM   funcionario f,              persona per         WHERE         f.id_cargo = 11         AND per.id_persona = f.id_persona         AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)         AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)         OR ( f.id_cargo = 11         AND per.id_persona = f.id_persona         AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)         AND f.fecha_final_vigencia IS NULL ))         WHEN tp.fecha_inicio < Cast('2021-12-28' AS DATE) THEN (SELECT         Concat (         Substring(f.titulo_obtenido, 1, 1), Lower(         Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), ' '         , per.nombre1,         ' '         , per.nombre2, ' ', per.apellido1, ' ', per.apellido2)         FROM   funcionario f,         persona per         WHERE  per.id_persona = f.id_persona         AND f.id_funcionario = 117)         ELSE ''         END AS funcionario          FROM   trazabilidad_proceso tp          WHERE  id_estado_proceso = 69                 AND id_proceso = t.idproceso)               AS nombrefuncionario3         ,         p.placa_vehiculo                                    AS placa,         tim.nombre                                          AS motivoRetencion,         CASE           WHEN tim.articulo IS NULL THEN ''           WHEN tim.articulo <> '' THEN Concat ('dispuesto en el ', tim.articulo,                                        ', ')           ELSE ''         END                                                 AS articulo,         peri.numero_periodo,         peri.fecha_inicio_periodo,         peri.fecha_fin_periodo,         peri.valor_tasa,    (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 436)                         AS cargo_delegado      FROM   precoactivo p         INNER JOIN coactivo c                 ON c.id_deudor = p.id_deudor         INNER JOIN trazabilidad_proceso tp(nolock)                 ON tp.id_proceso = c.id_proceso         INNER JOIN periodo_precoactivo peri                 ON peri.id_precoactivo = p.id_precoactivo         INNER JOIN persona per                 ON per.id_persona = p.id_deudor         INNER JOIN tipo_identificacion_persona ti                 ON per.id_tipo_identificacion = ti.id_tipo_identificacion         LEFT JOIN persona_juridica pj(nolock)                ON pj.id_persona_juridica = per.id_persona         INNER JOIN motivo_inmovilizacion_vehiculo tim                 ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion         INNER JOIN titulo_credito t                 ON t.id_periodo_precoactivo = peri.id_periodo  WHERE  peri.fecha_notificacion_titulo IS NOT NULL         AND peri.estado_periodo IN ( 'activo', 'inactivo' )         AND peri.estado_notificacion = 'enviado'         AND p.id_deudor = :deudor         AND c.id_coactivo = :idCoactivo         AND tp.id_estado_proceso = 69         AND peri.id_periodo = :periodo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------




--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------