select pr.numero_proceso, year(pr.fecha_inicio) año, pr.fecha_inicio, tp.fecha_inicio fecha_estado  ,tp.id_estado_proceso, ep.nombre estado_proceso , tdp.nombre tipo_documento ,

dpl.id_proceso, dpl.nombre_plantilla, upe.login, dpl.codigo_plantilla

from proceso pr

join trazabilidad_proceso tp on pr.id_proceso = tp.id_proceso

join documento_proceso dp on tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso

join tipo_documento_proceso tdp on  dp.id_tipo_documento_proceso = tdp.id_tipo_documento_proceso

join [documentos].[dbo].[documento] dd on dd.consecutivo_documento = dp.numero_documento

join [documentos].[dbo].[plantilla]   dpl on dpl.id_plantilla = dd.id_plantilla

join usuario_persona upe on upe.id_usuario = tp.id_usuario

join estado_proceso ep on tp.id_estado_proceso = ep.id_estado_proceso

where pr.id_tipo_proceso = 4

--and tp.id_estado_proceso in (6,10)

--and pr.numero_proceso = '15266'

--and year(pr.fecha_inicio) ='2023'

and pr.id_proceso=1911300

order by tp.id_trazabilidad_proceso;


---------------------------------------------

select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2022  --27
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