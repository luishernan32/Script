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