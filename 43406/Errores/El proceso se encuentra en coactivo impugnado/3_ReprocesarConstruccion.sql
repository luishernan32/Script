BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('274477-2023','287643-2023','269279-2023','284591-2023','276972-2023','284544-2023','290353-2023','287470-2023')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo