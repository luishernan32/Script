SELECT f.numero_financiacion,
       CASE p.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(
       Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
       END AS nombreCompleto,
       tip.codigo,
       p.numero_identificacion,
       CASE df.numero_cuota
         WHEN 0 THEN NULL
         ELSE ' '
       END AS comentario,
       CASE df.numero_cuota
         WHEN 0 THEN 'Cuota inicial'
         ELSE Cast(df.numero_cuota AS VARCHAR)
       END,
       df.fecha_pago_oportuno,
       df.valor_total,
       df.valor_capital,
       df.valor_intereses,
       ep.nombre,
       f.id_tramite
FROM   detalle_financiacion df
       JOIN financiacion f
         ON f.id_financiacion = df.id_financiacion
       JOIN proceso pr
         ON pr.id_proceso = f.id_proceso
       JOIN trazabilidad_proceso tpo
         ON tpo.id_proceso = pr.id_proceso
            AND tpo.fecha_fin IS NULL
       JOIN estado_proceso ep
         ON ep.id_estado_proceso = tpo.id_estado_proceso
       JOIN persona p
         ON p.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = p.id_persona
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = p.id_tipo_identificacion
WHERE  df.id_detalle_financiacion = :idCuota 