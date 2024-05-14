begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @DIAS_COBRO INT

SELECT TOP 1 @DIAS_COBRO = 8

SELECT f.id_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE
Upper(
       Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '', pe.apellido2))
       END                                          AS NombreInfractor,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1)        telefono,
       dbo.Correopersona(pe.id_persona)             correo,
       dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       @DIAS_COBRO                                  AS diasCobro,
	   (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS

FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       JOIN persona pe
         ON pe.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = f.id_deudor
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN proceso p
         ON p.id_proceso = f.id_proceso
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='ID_FINANCIACION,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,TASA_INTERES,VALOR_INT,VALOR_OBLIGACIONES,VALOR_TOTAL,TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,NUMERO_CUOTAS,NUMERO_PAGO,numero_consecutivo,DIAS_COBRO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=29

commit tran





