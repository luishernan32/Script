

-- Exitosos
select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 1
and convert(date,fecha_procesamiento)>=convert(date,'2024-08-01')

-- Errores SON LOS QUE TENEMOS QUE REVISAR

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


select *from #tmp_reporte_reconstr_sol_bienes rs
where erro_presentacion='El proceso se encuentra CERRADO, y la fecha de Oficio de Bienes es mayor a la fecha de estado Cerrado'


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





--Todo es a partir de esta tabla, la tabla puede cambiar y el sp y el proceso seguira siendo el mismo
--'reconstruccion_solicitud_busqueda_bienes' Es la tabla dónde inicialmente cargo los registros







--Inicialemente se tienen que cargar los registros
--Esta informacioón es dada por un proveedor
select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs