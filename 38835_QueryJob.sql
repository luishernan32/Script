--consulta job convenios incumplidos
declare @fecha datetime, @dias int, @tipo int
set @fecha = CONVERT(datetime, '11-01-2024')
set @dias = 6
set @tipo = 2
 
SELECT TOP 10000 d.id_detalle_financiacion,d.id_financiacion AS relacion,
        d.numero_cuota,d.valor_total AS valorTotalDetalle,
        d.fecha_pago_oportuno,d.valor_capital,d.valor_intereses,d.id_documento,
        d.numero_volante,d.fecha_pago,d.valor_saldo_obligacion,
        d.nueva_fecha_pago, f.*
         FROM detalle_financiacion d
         INNER JOIN financiacion f ON d.id_financiacion = f.id_financiacion
         JOIN proceso p ON f.id_proceso = p.id_proceso
         WHERE id_detalle_financiacion IN (
        SELECT(
        SELECT id_detalle_financiacion
         FROM detalle_financiacion
         WHERE id_financiacion = df.id_financiacion
         AND numero_cuota = MIN(df.numero_cuota)
        )
        FROM financiacion f INNER JOIN detalle_financiacion df ON f.id_financiacion = df.id_financiacion
         INNER JOIN tipo_financiacion tf ON f.id_tipo_financiacion = tf.id_tipo_financiacion
         WHERE df.fecha_pago IS NULL
         AND tf.id_tipo_financiacion = @tipo
         AND DATEDIFF(day, df.fecha_pago_oportuno, @fecha) > @dias
         AND p.id_estado_proceso = 16
         GROUP BY df.id_financiacion)
                 AND f.numero_financiacion NOT IN (SELECT tef.numero_de_convenio FROM trazabilidad_error_financiacion_incumplida tef where tef.numero_de_convenio = f.numero_financiacion AND tef.num_cuota = d.numero_cuota AND tef.estado = 1) 
         AND f.numero_financiacion NOT IN (SELECT tfi1.numero_de_convenio FROM trazabilidad_financiacion_incumplida tfi1 WHERE tfi1.id_estado_de_incumplimiento <> 2) 
         AND f.numero_financiacion IN (SELECT tfi1.numero_de_convenio FROM trazabilidad_financiacion_incumplida tfi1 WHERE tfi1.id_estado_de_incumplimiento = 2 AND tfi1.cuotas_incumplidas = d.numero_cuota ) 
         AND DATEDIFF(day,(SELECT TOP 1 tfi1.fecha_registro_marcacion  FROM trazabilidad_financiacion_incumplida tfi1  WHERE tfi1.numero_de_convenio =f.numero_financiacion AND tfi1.id_estado_de_incumplimiento = 2
         AND tfi1.cuotas_incumplidas = d.numero_cuota ORDER BY tfi1.fecha_registro_marcacion desc) , @fecha) >=@dias