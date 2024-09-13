--Actualizar el número de proceso al registro de abajo

	select po.id_proceso,po.numero_proceso, co.numero_coactivo,oc.numero_obligacion, concat(po.numero_proceso,'-',year(po.fecha_inicio)) as juicio
	from coactivo co
	inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
	inner join proceso po on po.id_proceso=co.id_proceso
	--inner join comparendo com on com.id_factura_axis=oc.numero_obligacion
	--inner join comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
	--inner join proceso po on isnumeric(po.id_proceso)=cp.id_proceso
	where po.numero_proceso in('21833')
	and year(po.fecha_inicio)='2024'

/*
 begin tran
 update proceso
 set numero_proceso='21833x'
 where id_proceso=2827494
 commit tran

*/


/*
 begin tran
 update proceso
 set id_estado_proceso='23', observacion='NOTIFICADO'
 where id_proceso=2827493
 commit tran

*/


--hagale update
 
--pongale el mismo numero_proceso con una x al finalk
 

select top 2 *from proceso
select top 2 *from obligacion_coactivo
select top 2 *from coactivo

select top 2 *from trazabilidad_proceso
--fecha de inicio :24-05-2024:   2024-05-24
 --set id_estado_proceso='23', observacion='NOTIFICADO'
 --where id_proceso=2827493


select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in('21833')


select top 20 *from trazabilidad_proceso
where id_proceso='2827493'


