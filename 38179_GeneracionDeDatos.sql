select *from curso
where id_factura_axis=12253910

select *from curso_acta_virtual
where id_curso=7356


select *from documentos..documento
where consecutivo_documento=15971931


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
--and ci.id_ordenamiento_pais=2
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and oc.valor_obligacion=425
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios>0
--and oc.valor_costas_procesales>0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
order by p.fecha_inicio desc


--Financiaciones 

select top 10000 *from financiacion f
join proceso p on f.id_proceso=p.id_proceso
where 1=1
order by id_financiacion desc
--344926

select *from detalle_financiacion
where id_financiacion=344928


update circulemos2.dbo.detalle_financiacion
set fecha_pago_oportuno='2023-12-15'
where id_detalle_financiacion=1515527

select top 10 *from trazabilidad_financiacion_incumplida
where numero_de_convenio='533441'
order by 1 desc


select top 100 *from trazabilidad_error_financiacion_incumplida
order by 1 desc



update trazabilidad_financiacion_incumplida
set fecha_registro_marcacion='2023-12-15 11:21:41.5210000'
where numero_de_convenio=533441


exec('begin
update cp_detalles_convenios
set fecha_inicio=to_date(''15/12/2023'',''DD/MM/RRRR'')
where id_convenio=533441
and nro_cuota=1;
end;') at SRVPRATM



-----------------------------

--QUERYS INCUMPLIMIENTO DE CONVENIOS
	select * from detalle_financiacion
	where id_financiacion=344923
 
	begin tran
	update circulemos2.dbo.detalle_financiacion
	set fecha_pago_oportuno = '2023-12-15'
	where id_detalle_financiacion = 1515507;
	commit
 
	SELECT top 400 * FROM trazabilidad_financiacion_incumplida tfi1
	WHERE 1=1
	--and tipo_de_financiacion=1
	--and tfi1.numero_de_convenio=408947
	order by 1 desc;
	select * from estado_de_incumplimiento
 
	begin tran
	update trazabilidad_financiacion_incumplida
	set fecha_registro_marcacion = '2023-12-15 11:20:04.3260000'--2021-11-24 11:20:04.3260000
	where numero_de_convenio=533434
	commit
 
	EXEC ('begin
	update cp_detalles_convenios
	set fecha_inicio = to_date(''15/12/2023'', ''DD/MM/RRRR'')
	where id_convenio = 533434
	and nro_cuota = 1;
	end;') at SRVPRATM
 
	select * from trazabilidad_error_financiacion_incumplida
	where numero_de_convenio = 505166 
	order by 1 desc
	select * from trazabilidad_error_financiacion_incumplida where error like '%Para Excluir%'
	update trazabilidad_error_financiacion_incumplida set estado=1 where error like '%Para Excluir%'
 
	begin tran
	update trazabilidad_error_financiacion_incumplida
	set estado=0
	where numero_de_convenio = 505166
	commit



	--sps para repolica de pagos 
	
exec integracion_terceros.dbo.dba_axis_info_v_pagos_pre
exec integracion_terceros.dbo.dba_axis_info_v_detalles_pagos_pre
exec integracion_terceros.dbo.obtenerPagos '11001'

--5935429
select top 10 *from integracion_terceros..it_recaudo 
where numero_recaudo='5935431' 
order by 1 desc

update integracion_terceros.dbo.it_recaudo
set numero_recaudo='5935430xx'
where id_recaudo=3310467
