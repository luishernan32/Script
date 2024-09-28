--El coactivo no ha sido notificado

BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('326305-2023','326309-2023','322737-2023','322739-2023',
                     '322740-2023','3010-2024','3011-2024','3013-2024',
                     '3014-2024','3015-2024','317073-2023','15583-2024',
                     '15587-2024','38283-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo

----------------------------------------------------------------------
--El proceso coactivo está repetido para la misma persona Identificacion

update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('21833-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo




----------------------------------------------------------------------
--El proceso coactivo no existe

BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('326305-2023','326309-2023','322737-2023','322739-2023',
                     '322740-2023','3010-2024','3011-2024','3013-2024',
                     '3014-2024','3015-2024','317073-2023','15583-2024',
                     '15587-2024','38283-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo



BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('322749-2023','3007-2024','15582-2024','16547-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo

----------------------------------------------------------------------
----------------------------------------------------------------------