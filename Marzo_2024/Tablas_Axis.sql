--integracion_terceros.dbo.v_financiaciones
--integracion_terceros.dbo.V_CUOTASFINANCIACION_pre
--integracion_terceros.dbo.v_financiaciones_pre

select *from integracion_terceros.dbo.v_financiaciones_pre

select *from integracion_terceros.dbo.v_all_financiaciones

select *from integracion_terceros.dbo.v_detallefinanciacion_pre

select *from integracion_terceros.dbo.v_detallefinanciacion_pre_

select *from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre



--equivalencia en axis
--detalle_financiacion v_cuota_financiacion
--obligacion_financiacion v_detalle_financiacion


	
--id_trazabilidad_financiacion	autogenerada
--tipo_de_financiacion	?
--numero_de_convenio	v_financiaciones.numero_financiacion

 select *--numero_financiacion,fecha_de_convenio
 from integracion_terceros.dbo.v_financiaciones

--fecha_de_convenio	V_FINANCIACIONES.FECHA_REGISTRO
select FECHA_REGISTRO
 from integracion_terceros.dbo.v_financiaciones_pre
--where FECHA_REGISTRO between '2023-12-01' and '2024-02-26'

--estado_de_convenio	


--id_estado_de_incumplimiento	Valor de sogit


--cuotas_incumplidas	V_CUOTASFINANCIACION_pre.NRO_CUOTA

select NRO_CUOTA
from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre

--valor_cuotas_incumplidas	V_CUOTASFINANCIACION_pre.VALOR_CUOTA
select VALOR_CUOTA
from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre


--fecha_pago_oportuno	V_CUOTASFINANCIACION_pre.FECHA_VENCIMIENTO_CUOTA

select VENCIMIENTO_CUOTA
from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre

--id_financiacion	Consecutivos de sogit


--id_coactivo	Consecutivos de sogit


--fecha_registro_marcacion	Valor de sogit





--select *from integracion_terceros.dbo.v_financiaciones_pre


select *from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre --Por el lado de Axis



select *from integracion_terceros.dbo.v_financiaciones_pre

-------------------------------------




--id_trazabilidad_financiacion	autogenerada
--tipo_de_financiacion	?
--numero_de_convenio	v_financiaciones.numero_financiacion

 select *--numero_financiacion,FECHA_REGISTRO
 from integracion_terceros.dbo.v_financiaciones_pre

--estado_de_convenio	


--id_estado_de_incumplimiento	Valor de sogit




 select 
        1 as tipo_de_financiacion,
		a.numero_financiacion as numero_de_convenio,
		null as fecha_de_convenio,
		'INCUMPLIDO' as estado_de_convenio,
		2 as ID_ESTADO_DE_INCUMPLIMIENTO,
		0 AS CUOTAS_INCUMPLIDAS,
		0 AS VALOR_CUOTAS_INCUMPLIDAS,
		GETDATE() AS FECHA_PAGO_OPORTUNO,
		0 AS ID_FINANCIACION,
		NULL AS ID_COACTIVO,
		GETDATE() AS FECHA_REGISTRO_MARCACION
		--a.*,b.*--numero_financiacion,FECHA_REGISTRO
 from integracion_terceros.dbo.v_financiaciones_pre a INNER JOIN integracion_terceros.dbo.V_CUOTASFINANCIACION_pre B
      ON a.numero_financiacion = b.numero_financiacion





--cuotas_incumplidas	V_CUOTASFINANCIACION_pre.NRO_CUOTA

select distinct numero_financiacion--NRO_CUOTA,VALOR_CUOTA,VENCIMIENTO_CUOTA
from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre




-- select 
--        1 as tipo_de_financiacion,
--		a.numero_financiacion as numero_de_convenio INTO #TBLTEMPORAL
-- from integracion_terceros.dbo.v_financiaciones_pre a INNER JOIN integracion_terceros.dbo.V_CUOTASFINANCIACION_pre B
--      ON a.numero_financiacion = b.numero_financiacion
--WHERE 1= 0

select TOP 10 *-- distinct estado_de_convenio--distinct tipo_de_financiacion
from circulemos2.dbo.trazabilidad_financiacion_incumplida
order by id_financiacion desc



select * --into #tblTemporal--distinct estado_de_convenio--distinct tipo_de_financiacion
from circulemos2.dbo.trazabilidad_financiacion_incumplida
where 1= 0





