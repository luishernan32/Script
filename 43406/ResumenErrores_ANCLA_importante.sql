

-- Exitosos
select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 1

-- Errores

select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null

select  COUNT(rs.id_consecutivo_reconstruccion) from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null

-- resumen de errores
--Vamos a ver el detalle del error


select  *,
case when error  like '%UNIQUE KEY%' then 'Incidencia al Registrar Datos Documento' else error end erro_presentacion
into #tmp_reporte_reconstr_sol_bienes
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null

select * from #tmp_reporte_reconstr_sol_bienes

select  rs.erro_presentacion, COUNT (id_consecutivo_reconstruccion) cantidad from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
group by rs.erro_presentacion
order by COUNT (id_consecutivo_reconstruccion) desc


select MAX(fecha_procesamiento) from #tmp_reporte_reconstr_sol_bienes

/*
--- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
COMMIT TRAN

exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo

*/


/*
--- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error like 'Incidencia al Registrar Datos Documento'
COMMIT TRAN

exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo
*/


select *from  circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes


BEGIN TRAN

update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes

set error = null

where procesado = 0

and error is not null

and error like '%UNIQUE%'

and numero_juicio in('307377-2024','26863-2024')

COMMIT TRAN

exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo


select 
  CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) 
  from circulemos2.dbo.proceso p
  where id_tipo_proceso = 4
  and p.numero_juicio in('307377','26863')
  and CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) 

 



select *from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
where procesado = 0
and error like 'Incidencia al Registrar Datos Documento'

select COUNT(1) AS exitosos from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 1
AND CONVERT(date, fecha_procesamiento)>=CONVERT(date, '2024-08-22')

select COUNT(1) AS Errores from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
AND CONVERT(date, fecha_procesamiento)>=CONVERT(date, '2024-08-22')
and error is not null

select COUNT(1) AS Pendiente_Procesar from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is null