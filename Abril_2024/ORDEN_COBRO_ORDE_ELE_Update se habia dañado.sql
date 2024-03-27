begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = CASE c.id_tipo_coactivo
                        WHEN 3 THEN tp.fecha_inicio
                        ELSE p.fecha_inicio
                      END
FROM   coactivo c
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       INNER JOIN obligacion_coactivo oc
               ON oc.id_coactivo = c.id_coactivo
       LEFT JOIN trazabilidad_proceso tp
              ON tp.id_proceso = p.id_proceso
                 AND tp.id_estado_proceso = 24
WHERE  c.id_coactivo = :idCoactivo
       AND oc.numero_obligacion = :numeroObligacion
ORDER  BY tp.fecha_inicio DESC

SELECT (SELECT oc.consecutivo
        FROM   orden_cobro oc
        WHERE  oc.id_coactivo = c.id_coactivo
               AND oc.id_factura_axis = :numeroObligacion)     consecutivo,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario_coactivo f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))     delegado,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                     AS
       nombreInfractor,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN '' ruc ''
         ELSE '' cedula ''
       END                                                     AS tipoDoc,
       pe.numero_identificacion                                docInfractor,
       CASE com.codigo_medio_imposicion
         WHEN 1 THEN com.numero_citacion
         ELSE com.numero_citacion
       END                                                     TITULO,
       (SELECT ca.saldo_capital
        FROM   comparendo_cartera cc (nolock)
               JOIN cartera ca (nolock)
                 ON cc.id_cartera = ca.id_cartera
        WHERE  cc.cicomparendo = com.cicomparendo)             valorMulta,
       (SELECT CASE oc.total_recargo
                 WHEN NULL THEN 0
                 ELSE oc.total_recargo
               END
        FROM   orden_cobro oc
        WHERE  oc.id_coactivo = c.id_coactivo
               AND oc.id_factura_axis = :numeroObligacion)     totalRecargo,
       (SELECT Sum(ca.saldo_capital + oc.total_recargo)
        FROM   orden_cobro oc,
               comparendo_cartera cc
               JOIN cartera ca
                 ON cc.id_cartera = ca.id_cartera
                    AND cc.cicomparendo = com.cicomparendo
        WHERE  oc.id_coactivo = c.id_coactivo
               AND oc.id_factura_axis = :numeroObligacion)     TOTAL,
       (SELECT m.nombre
        FROM   municipio m
               JOIN direccion d
                 ON m.id_municipio = d.id_municipio
        WHERE  d.id_direccion = com.id_direccion_comparendo)   ciudadInfraccion,
       CONVERT(VARCHAR(10), com.fecha_infraccion, 103)         fecha_infraccion,
       CONVERT(VARCHAR(10), com.hora_infraccion, 108)          hora_infraccion,
       com.numero_citacion                                     numeroCitacion,
       (SELECT ci.descripcion
        FROM   configuracion_infraccion ci
               INNER JOIN infraccion i
                       ON i.id_infraccion = ci.id_infraccion
        WHERE  com.id_infraccion = i.id_infraccion
               AND ci.fecha_fin_vigencia IS NULL)
       descripcionInfraccion,
       (SELECT cv.placa_vehiculo
        FROM   comparendo_vehiculo cv
        WHERE  com.cicomparendo = cv.id_comparendo_vehiculo)   placaVehiculo,
       (SELECT d.complemento
        FROM   direccion d
        WHERE  com.id_direccion_comparendo = d.id_direccion)   lugarInfraccion,
       Upper(Concat(pa.nombre1, '' '', pa.nombre2, '' '', pa.apellido1, '' '',
             pa.apellido2))
                                                               nombreAgente,
       a.placa_agente_transito                                 placaAgente,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = pa.id_persona)                  AS firmaAgente,
       Cast(Format(@FECHA, ''dd \de MMMM \de yyyy'') AS VARCHAR) AS fechaProceso,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, @FECHA)
                       AND img.fecha_fin >= CONVERT(DATE, @FECHA) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, @FECHA)
                           AND img.fecha_fin IS NULL ) ))      AS logo,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))     AS
       FIRMA_FUNCIONARIO_,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)), '', Mgs'')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))     AS nombreDirector
       ,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436)                         AS cargo_delegado
       ,
       (SELECT nombre
        FROM   cargo(nolock)
        WHERE  id_cargo = 11)                                  AS cargo_director
FROM   coactivo c (nolock)
       INNER JOIN obligacion_coactivo oc
               ON oc.id_coactivo = c.id_coactivo
       JOIN persona pe (nolock)
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       INNER JOIN comparendo com (nolock)
               ON oc.numero_obligacion = com.id_factura_axis
       LEFT JOIN agente a (nolock)
              ON a.placa_agente_transito = com.placa_agente_transito
       LEFT JOIN persona pa (nolock)
              ON a.id_persona = pa.id_persona
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
WHERE  c.id_coactivo = :idCoactivo
       AND oc.numero_obligacion = :numeroObligacion '               
	   , orden_variables='CONSECUTIVO_ORDEN_COBRO, NOMBRE_DELEGADO, NOMBRE_INFRACTOR, T_DOCUMENTO_INFRACTOR, N_DOCUMENTO_INFRACTOR, TITULO, VALOR_MULTA, VALOR_RECARGOS, TOTAL_PENDIENTE, CIUDAD_INFRACCION, FECHA_INFRACCION, HORA, numero_citacion, DESCRIPCION_INFRACCION, PLACA_VEHICULO, DIRECCION_INFRACCION, NOMBRE_AGENTE, PLACA_AGENTE, FIRMA_AGENTE, FECHA_SOLICITUD, LogoATM_variable, FIRMA_FUNCIONARIO_,NOMBRE_COMPLETO,CARGO_DELEGADO,PROFESION'
WHERE  id_plantilla_config=10201


commit tran