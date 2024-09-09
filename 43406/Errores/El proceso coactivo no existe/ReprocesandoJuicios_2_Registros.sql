BEGIN TRAN
 
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
 
set error = null
 
where procesado = 0
 
and error is not null
 
and numero_juicio in('307377-2024','26863-2024')
 
COMMIT TRAN
 
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo