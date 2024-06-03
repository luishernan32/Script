
--COA_ORDEN_PAGO_P https://www.youtube.com/watch?v=evJbQ-vznzA


--CONSULTA QUE HACE EL JOB DE COACTIVO PATIOS
select distinct top(1000) p.*,per.*,t.idProceso, pp.id_periodo from precoactivo p 
inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo
inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo
inner join persona per on per.id_persona=p.id_deudor 
where /*t.fecha_notificacion is not null and*/ pp.estado_periodo in ('activo','inactivo')
/*and pp.fecha_notificacion_titulo is not null*/ and idCoactivo=0 and id_estado_vehiculo_patio=2
and cast(GETDATE() as date)>=(select dbo.sumar_dias_habiles(t.fecha_notificacion,8))
and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by fecha_fin_periodo desc) = 'activo'
order by p.id_precoactivo asc
update periodo_precoactivo set fecha_notificacion_titulo='2024-05-01' where id_periodo=46759
update titulo_credito set fecha_notificacion='2024-05-01' where id_periodo_precoactivo=46759
 
select top 1000 * from coactivo c
join proceso p on c.id_proceso=p.id_proceso 
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso and tp.id_estado_proceso=24 and tp.fecha_fin is null 
where id_tipo_coactivo=4 
--and tp.id_estado_proceso=70 
order by tp.fecha_inicio desc



-----------------------------------------------------------------------------------------
--CONSULTA QUE HACE EL JOB DE COACTIVO PATIOS
select distinct top(1000) p.*,per.*,t.idProceso, pp.id_periodo from precoactivo p 
inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo
inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo
inner join persona per on per.id_persona=p.id_deudor 
where t.fecha_notificacion is not null and pp.estado_periodo in ('activo','inactivo')
and pp.fecha_notificacion_titulo is not null and idCoactivo=0 and id_estado_vehiculo_patio=2
and cast(GETDATE() as date)>=(select dbo.sumar_dias_habiles(t.fecha_notificacion,8))
and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by fecha_fin_periodo desc) = 'activo'
order by p.id_precoactivo asc