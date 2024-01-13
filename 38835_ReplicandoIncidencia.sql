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
