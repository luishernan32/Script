 
 SELECT TOP 10 d.id_detalle_financiacion,d.id_financiacion AS relacion,
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
         AND tf.id_tipo_financiacion is not null --= :tipoFinanciacion
         AND DATEDIFF(day, df.fecha_pago_oportuno, getdate())>0-- :fecha) > 0 
         and p.id_estado_proceso = 16
         GROUP BY df.id_financiacion

		 )



	





		 SELECT id_detalle_financiacion
         FROM detalle_financiacion
         WHERE id_financiacion = df.id_financiacion
         AND numero_cuota = MIN(df.numero_cuota)
 
 
 SELECT TOP " + numRegistros + " d.id_detalle_financiacion,d.id_financiacion AS relacion,
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
        sql.append(")
        FROM financiacion f INNER JOIN detalle_financiacion df ON f.id_financiacion = df.id_financiacion
         INNER JOIN tipo_financiacion tf ON f.id_tipo_financiacion = tf.id_tipo_financiacion
         WHERE df.fecha_pago IS NULL
         AND tf.id_tipo_financiacion = :tipoFinanciacion
         AND DATEDIFF(day, df.fecha_pago_oportuno, :fecha) > 0 
         and p.id_estado_proceso = 16
         GROUP BY df.id_financiacion



