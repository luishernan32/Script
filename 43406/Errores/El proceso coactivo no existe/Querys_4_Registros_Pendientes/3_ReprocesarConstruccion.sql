BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('322749-2023','3007-2024','15582-2024','16547-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo