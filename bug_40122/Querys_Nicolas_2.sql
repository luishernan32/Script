select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2022
--and ci.id_ordenamiento_pais=1
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and oc.valor_obligacion=425
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios>0
--and oc.valor_costas_procesales>0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
--and pe.numero_identificacion='0927804914'
order by p.fecha_inicio asc


--0918533597* 0958134421* 0958134421* 0926207671*  0919680033

---------------------------------------------------------------------

Select top 5 * from financiacion f
join proceso p on f.id_proceso=p.id_proceso 
where 1=1
--and valor_total_intereses_moratorios=0
--and id_tipo_financiacion in(3,4) 
--and id_estado_proceso=16
--and numero_financiacion=505166 
order by id_financiacion desc

--533476
-----------------------------------------------

Select top 100 * from integracion_terceros..it_recaudo order by 1 desc
update integracion_terceros..it_recaudo set numero_recaudo='5935442xx' where id_recaudo in(3310474)

--------------------------------------------------------------------

--QUERYS INCUMPLIMIENTO DE CONVENIOS
	select * from detalle_financiacion
	where id_financiacion=344969
 
	begin tran
	update circulemos2.dbo.detalle_financiacion
	set fecha_pago_oportuno = '2024-01-15'
	where id_detalle_financiacion = 1525734;
	commit

---------------------------------
--SPS para replica de pagos
exec integracion_terceros.dbo.dba_axis_info_v_pagos_pre
exec integracion_terceros.dbo.dba_axis_info_v_detalles_pagos_pre
exec integracion_terceros.dbo.obtenerPagos '11001'
------------------------------------------------------------------
Select top 100 * from integracion_terceros..it_recaudo order by 1 desc --Validar que el número de recaudo no se repita
Select top 100 * from integracion_terceros..it_recaudo where numero_recaudo='5935456' order by 1 desc
update integracion_terceros..it_recaudo set numero_recaudo='5935455xx' where id_recaudo in(3310479)


--0952171098


--****************************************************************************
---Query para hacer el envio de correo varias veces

select * from circulemos2.dbo.trazabilidad_financiacion_incumplida
where numero_de_convenio = 533487;


begin tran
delete circulemos2.dbo.trazabilidad_financiacion_incumplida
where  id_trazabilidad_financiacion=688322
commit tran

--****************************************************************************

--El error se va a guardar en está tabla Se va a insertar el error manualmente a está tabla
	select *from trazabilidad_error_financiacion_incumplida
	--where numero_de_convenio=533488
	order by 1 desc


update trazabilidad_error_financiacion_incumplida set numero_de_convenio=533491
where id_trazabilidad_error_financiacion_incumplida=124574


--*************************************************
select * from trazabilidad_proceso tp join estado_proceso ep on ep.id_estado_proceso=tp.id_estado_proceso where id_proceso in(select id_proceso from financiacion where id_financiacion=344973)
select * from acumulado_financiaciones where id_financiacion=344973 order by 3,4 asc
select * from detalle_financiacion where id_financiacion=344973
select * from obligacion_financiacion where id_financiacion=344973
select * from cartera where nombre in (select numero_obligacion from obligacion_financiacion where id_financiacion=344973)
select * from cartera where nombre in (select numero_financiacion from financiacion where id_financiacion=344973)

--*****************************************************************************************




 --Tablas involucradas en la query
		 --detalle_financiacion
		 --detalle_financiacion
		 --tipo_financiacion
		 --proceso
		 --financiacion

--Prueba Video Nicolas 0929734861 533490
--numero_financiacion=numero_de_convenio

select *from financiacion
where numero_financiacion=533490

--Se si el usuario ya pago por la fecha
select * from detalle_financiacion where id_financiacion=344972


--Contiene las notificaciones de la cuota "ver cuotas incumplidas" 
--Pasan 5 días habiles para que se intente liquidar el convenio
--El bug en general es que no se está guardando la informacion en está tabla <trazabilidad_financiacion_incumplida>
select *from trazabilidad_financiacion_incumplida  
where numero_de_convenio=533490

begin tran
delete trazabilidad_financiacion_incumplida
where id_trazabilidad_financiacion=688535
commit tran



--El error se va a guardar en está tabla Se va a insertar el error manualmente a está tabla
-- la sospecha es porque ocurrio un error en la tabla trazabilidad_error_financiacion_incumplida
	select *from trazabilidad_error_financiacion_incumplida
	where numero_de_convenio=533490
	order by 1 desc
----------------------------------------------------------------------------------
----------------------Simulando el error -----------------------------------------
	begin tran
INSERT INTO circulemos2.dbo.[trazabilidad_error_financiacion_incumplida]
           ([tipo_de_financiacion]
           ,[numero_de_convenio]
           ,[fecha_de_proceso]
           ,[error]
           ,[num_cuota])
values(2, 533490	, GETDATE(), 'Incidencia Simulada 16-02-2024', 1)
 
commit tran


begin tran 
update trazabilidad_error_financiacion_incumplida
set estado=1
where id_trazabilidad_error_financiacion_incumplida=124576
commit tran

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--La hipotesis es que el convenio 533490 no está ingrensando a la consulta al no estar ingresando no se procesa
--numero_financiacion=numero_de_convenio

SELECT TOP 10 
        d.id_detalle_financiacion,d.id_financiacion AS relacion,
        --d.numero_cuota,d.valor_total AS valorTotalDetalle,
        d.fecha_pago_oportuno,
		--d.valor_capital,
		--d.valor_intereses,
		--d.id_documento,
        --d.numero_volante,
		d.fecha_pago,d.valor_saldo_obligacion,
        d.nueva_fecha_pago, f.*
         FROM detalle_financiacion d
         INNER JOIN financiacion f ON d.id_financiacion = f.id_financiacion
         JOIN proceso p ON f.id_proceso = p.id_proceso
         WHERE id_detalle_financiacion IN (


        SELECT(
        SELECT id_detalle_financiacion
         FROM detalle_financiacion
         WHERE id_financiacion =344972 --df.id_financiacion
         AND numero_cuota = MIN(df.numero_cuota)
		 )
        
         FROM financiacion f INNER JOIN detalle_financiacion df ON f.id_financiacion = df.id_financiacion
         INNER JOIN tipo_financiacion tf ON f.id_tipo_financiacion = tf.id_tipo_financiacion
         WHERE df.fecha_pago IS NULL
         AND tf.id_tipo_financiacion=2-- is not null --= :tipoFinanciacion
         AND DATEDIFF(day, df.fecha_pago_oportuno, getdate())>0-- :fecha) > 0 
         and p.id_estado_proceso = 16
         GROUP BY df.id_financiacion

		 )

		 --Tablas involucradas en la query
		 --detalle_financiacion
		 --detalle_financiacion
		 --tipo_financiacion
		 --proceso
		 --financiacion

		 select getdate()