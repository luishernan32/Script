

-----------------------
--  1
-----------------------
------------------------------------------------------------------------------------------------------
--Hay que revisar que no esté generado mas de una vez
SELECT * FROM trazabilidad_financiacion_incumplida tef WHERE tef.numero_de_convenio = 526695
order by 1 asc
------------------------------------------------------------------------------------------------------
-----------------------
--BORRADO
-----------------------
begin tran
delete trazabilidad_financiacion_incumplida 
WHERE id_trazabilidad_financiacion=614952--614947--614946--614945  
                                         -- 614943--614927--614688--614686--614685
										 --614684--614683--614214--614181
commit tran
------------------------------------------------------------------------------------------------------


-----------------------
--  2
-----------------------

------------------------------------------------------------------------------------------------------
--Está tabla se consulto y se hizo borrado porque estaba trayendo otro # de convenio
------------------------------------------------------------------------------------------------------

select *from trazabilidad_error_financiacion_incumplida
WHERE numero_de_convenio = 614945

-----------------------
--BORRADO
-----------------------
begin tran
delete trazabilidad_error_financiacion_incumplida
WHERE id_trazabilidad_error_financiacion_incumplida=77719 --Estaba trayendo esté número de convenio
commit tran
---------------------------------------------------


-----------------------
--  3  ver los correos
-----------------------
select *from trazabilidad_incumplimiento_email
where numero_financiacion=526695
--Agregar el campo numero de cuota
--Ingresar el numero de cuota que se esta modificando
---------------------------------------------------
begin tran
delete trazabilidad_incumplimiento_email
where id_trazabilidad_incumplimiento_email in(118559,118562,118557,118558)
commit tran
---------------------------------------------------


SELECT * FROM trazabilidad_financiacion_incumplida 
inner join coactivo co
on co.numero_coactivo=

  --Para notificar


             SELECT  d.id_detalle_financiacion,d.id_financiacion AS relacion,
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
        AND tf.id_tipo_financiacion = 1
        AND DATEDIFF(day, df.fecha_pago_oportuno, convert(date, getdate())) > 0 
        and p.id_estado_proceso = 16
        GROUP BY df.id_financiacion)
      AND (SELECT COUNT(*) FROM trazabilidad_error_financiacion_incumplida tef WHERE tef.numero_de_convenio = f.numero_financiacion) = 0
AND f.numero_financiacion NOT IN (SELECT tf.numero_de_convenio FROM trazabilidad_financiacion_incumplida tf WHERE tf.numero_de_convenio = f.numero_financiacion AND  d.numero_cuota = tf.cuotas_incumplidas)


select *from parametro
where codigo_parametro=322


select *from parametro_organismo
where codigo_parametro=322

---------------------------------------------------
select *from trazabilidad_incumplimiento_email
where numero_financiacion=526695
--Agregar el campo numero de cuota
--Ingresar el numero de cuota que se esta modificando
---------------------------------------------------




begin tran
delete trazabilidad_financiacion_incumplida 
WHERE id_trazabilidad_financiacion=614688--614686--614685--614684--614683--614214--614181
commit tran