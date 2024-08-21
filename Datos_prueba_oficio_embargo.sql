---Importante para hacer mis consultas
--Datos

select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, codigo_medio_imposicion,* from proceso p

--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38

inner join coactivo c on p.id_proceso=c.id_proceso

inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo

inner join persona pe on c.id_deudor=pe.id_persona

inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion

inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion

inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais

--inner join cartera ca on ca.nombre=co.id_factura_axis

where p.id_estado_proceso in(29) and anio=2021

--and ci.id_ordenamiento_pais=1

and c.id_tipo_coactivo=1

and c.cantidad_obligaciones=1

--and c.fecha_notificacion is null

--and oc.valor_interes_moratorios0

--and oc.valor_costas_procesales0

and ci.fecha_fin_vigencia is null

--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)

and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)

order by p.fecha_inicio desc


--1455864 0927016105 10398205
--10398155 0910643014 1455834
--10398133 0950306571 1455818
--10398211  0914932918  1455869
--0950614750 1455838 10398161
