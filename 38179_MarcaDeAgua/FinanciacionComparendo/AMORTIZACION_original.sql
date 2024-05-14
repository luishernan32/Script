SELECT f.id_financiacion,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1) telefono,
       dbo.Correopersona(pe.id_persona)      correo,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total_costas_procesales,
       f.valor_total,
       f.valor_total_financiar_interes,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE
Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2)
       END                                   AS nombreInfractor,
       dpc.porcentaje_cuota_inicial
FROM   financiacion f (nolock)
       JOIN persona pe (nolock)
         ON pe.id_persona = f.id_deudor
       INNER JOIN configuracion_financiacion cf
               ON cf.id_configuracion_financiacion =
                  f.id_configuracion_financiacion
       INNER JOIN detalle_porcentaje_cuota_inici dpc
               ON dpc.id_configuracion_financiacion =
                  cf.id_configuracion_financiacion
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN persona_juridica pj (nolock)
              ON pe.id_persona = pj.id_persona_juridica
WHERE  f.id_financiacion = :idFinanciacion 