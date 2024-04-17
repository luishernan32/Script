
--PRECOACTIVOS VÁLIDOS PARA COURIER - TÍTULO CRÉDITO

select pp.*, t.* from precoactivo p

inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo

inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo

where  p.id_estado_vehiculo_patio=2

and pp.estado_periodo in('activo','inactivo')

and t.fecha_notificacion is null 

and fecha_notificacion_titulo is null

and exists (select * from integracion_terceros..ubicabilidad_courier_validada u where u.id_persona=p.id_deudor)

and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by id_periodo desc) = 'activo' 

order by pp.id_precoactivo desc
