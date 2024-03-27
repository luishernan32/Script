
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
       per.apellido2) AS
       nombreDeudor,
       Concat(p.numero_obligacion, ''-'', Year(Sysdatetime()), ''-'',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                   WHERE
       id_periodo_precoactivo = :periodo), '' - '', (SELECT Count(*)
                                                   FROM   titulo_credito
                                                   WHERE
       id_periodo_precoactivo = :periodo))
       AS consecutivo,
       per.numero_identificacion,
       tp.fecha_inicio
       AS fechaActual,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast(''2022-01-11'' AS DATE) THEN
                 (SELECT
                      Concat(
               Substring(f.titulo_obtenido, 1, 1), Lower(
                    Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                      '' '',
                      per.nombre1,
                    '' ''
                  , per.nombre2, '' '', per.apellido1, '' '', per.apellido2)
                FROM   funcionario f,
                       persona per
                WHERE  per.id_persona = f.id_persona
                       AND f.fecha_final_vigencia IS NULL
                       AND id_cargo = 1)
                 WHEN tp.fecha_inicio < Cast(''2022-01-11'' AS DATE) THEN (SELECT
               Concat(Substring(f.titulo_obtenido, 1, 1), Lower(
               Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), '' '',
               per.nombre1,
               '' ''
               , per.nombre2, '' '', per.apellido1, '' '', per.apellido2)
               FROM   funcionario f,
                  persona per
               WHERE  per.id_persona = f.id_persona
                  AND id_funcionario = 53)
                 ELSE ''''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)
       AS nombrefuncionario,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast(''2021-12-28'' AS DATE) THEN
                 (SELECT
                      Concat(
               Substring(f.titulo_obtenido, 1, 1), Lower(
                    Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
                      '' '',
                      per.nombre1,
                    '' ''
                  , per.nombre2, '' '', per.apellido1, '' '', per.apellido2, '', Mgs''
                      )
                FROM   funcionario f,
                       persona per
                WHERE  f.id_cargo = 11
                       AND per.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                        OR ( f.id_cargo = 11
                             AND per.id_persona = f.id_persona
                             AND f.fecha_inicio_vigencia <=
                                 CONVERT(DATE, @FECHA)
                             AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast(''2021-12-28'' AS DATE) THEN (SELECT
               Concat(Substring(f.titulo_obtenido, 1, 1), Lower(
               Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))), '' '',
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
               AND id_proceso = t.idproceso)
       AS nombrefuncionario3,
       (SELECT CASE
                 WHEN tp.fecha_inicio >= Cast(''2021-12-28'' AS DATE) THEN
                 (SELECT Max(fp.numero_imagen)
                  FROM
                 funcionario f,
                 firma_persona fp
                                                                          WHERE
                 f.id_cargo = 11
                 AND fp.id_persona = f.id_persona
                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                  OR ( f.id_cargo = 11
                       AND fp.id_persona = f.id_persona
                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                       AND f.fecha_final_vigencia IS NULL ))
                 WHEN tp.fecha_inicio < Cast(''2021-12-28'' AS DATE) THEN
                 (SELECT Max(fp.numero_imagen)
                  FROM
                 funcionario f,
                 persona per,
                 firma_persona fp
                                                                         WHERE
                 fp.id_persona = f.id_persona
                 AND f.id_funcionario = 117)
                 ELSE ''''
               END AS funcionario
        FROM   trazabilidad_proceso tp
        WHERE  id_estado_proceso = 69
               AND id_proceso = t.idproceso)
       AS firma,
       (SELECT Max(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_periodo = :periodo)
       AS valorTotal,
       tp.fecha_inicio
       AS fechaActual2,
       p.fecha_ingreso,
       (SELECT numero_imagen
        FROM   "imagen"
        WHERE  "id_tipo_imagen" IN (SELECT id_tipo_imagen
                                    FROM   tipo_imagen
                                    WHERE  codigo = ''LOGGO'')
               AND fecha_fin IS NULL)
       logoATM,
       p.placa_vehiculo,
       (SELECT Max(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_periodo = :periodo)
       + p.recargos_moratorio
       AS suma,
       p.recargos_moratorio
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN titulo_credito t
               ON t.idcoactivo = c.id_coactivo
       INNER JOIN periodo_precoactivo peri
               ON peri.id_periodo = t.id_periodo_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       INNER JOIN trazabilidad_proceso tp (nolock)
               ON tp.id_proceso = c.id_proceso
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( ''activo'', ''inactivo'', ''ANULADO'',
                                    ''SUSPENDIDO'' )
       AND peri.estado_notificacion = ''enviado''
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69 '               
	   , orden_variables='CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,DOCUMENTO_AGENTE,FECHA_GENERACION,NOMBRE_ABOGADO,NOMBRE_AGENTE,IMAGEN_FIRMA,VALOR_INTERES,FECHA_INFRACCION,FECHA_INFRACCION2,Logo_ATM_Alcaldia,placa,VALOR_INTERES2,VALOR_DEUDA_CARTERA,CARGO_DELEGADO'
WHERE  id_plantilla_config=10117


commit tran



  (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436)                         AS cargo_delegado