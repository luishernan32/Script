begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT f.id_financiacion,
       f.numero_financiacion,
       CASE p.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(
       Concat (p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '', p.apellido2))
       END                                         AS nombreCompleto,
       tip.codigo,
       p.numero_identificacion,
       dbo.Telefonopersona(p.id_persona, 1)        fijo,
       dbo.Correopersona(p.id_persona)             correo,
       dbo.Direccionpersona(p.id_persona, DEFAULT) AS Direccion,
       m.nombre,
       f.numero_cuotas,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.justificacion
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       LEFT JOIN persona p
              ON p.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = p.id_persona
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = p.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN organismo_transito o
         ON o.codigo_organismo = p.codigo_organismo
       JOIN municipio m
         ON m.id_municipio = o.id_municipio
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = p.id_tipo_identificacion
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='ID_FINANCIACION,NUMERO_FINANCIACION,PRIMER_NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,CIUDAD_INFRACTOR,NUMERO_TOTAL_CUOTAS,TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,JUSTIFICACION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=7

commit tran



---------------------------------------------------------------------------------------------------------------------------------------------------

--Query modificado

SELECT f.id_financiacion,
       f.numero_financiacion,
       CASE p.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(
       Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
       END                                         AS nombreCompleto,
       tip.codigo,
       p.numero_identificacion,
       dbo.Telefonopersona(p.id_persona, 1)        fijo,
       dbo.Correopersona(p.id_persona)             correo,
       dbo.Direccionpersona(p.id_persona, DEFAULT) AS Direccion,
       m.nombre,
       f.numero_cuotas,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.justificacion
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       LEFT JOIN persona p
              ON p.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = p.id_persona
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = p.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN organismo_transito o
         ON o.codigo_organismo = p.codigo_organismo
       JOIN municipio m
         ON m.id_municipio = o.id_municipio
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = p.id_tipo_identificacion
WHERE  f.id_financiacion = :idFinanciacion 
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
--Query original

SELECT f.id_financiacion,
       f.numero_financiacion,
       CASE p.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(
       Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
       END                                         AS nombreCompleto,
       tip.codigo,
       p.numero_identificacion,
       dbo.Telefonopersona(p.id_persona, 1)        fijo,
       dbo.Correopersona(p.id_persona)             correo,
       dbo.Direccionpersona(p.id_persona, DEFAULT) AS Direccion,
       m.nombre,
       f.numero_cuotas,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.justificacion
FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       LEFT JOIN persona p
              ON p.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = p.id_persona
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = p.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN organismo_transito o
         ON o.codigo_organismo = p.codigo_organismo
       JOIN municipio m
         ON m.id_municipio = o.id_municipio
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = p.id_tipo_identificacion
WHERE  f.id_financiacion = :idFinanciacion 
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
