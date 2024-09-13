 
 use circulemos2
 begin tran
 
 update proceso
 set numero_proceso='21833x'
 where id_proceso=2827494


------------------------------------------------------------------------------------------------


 update proceso
 set id_estado_proceso='23', observacion='NOTIFICADO'
 where id_proceso=2827493


------------------------------------------------------------------------------------------------


INSERT INTO [dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
			(2827493,23,'2024-04-16 08:06:17.0000000','2024-04-16 08:06:17.0000000',1,1,1)

------------------------------------------------------------------------------------------------


update trazabilidad_proceso
set fecha_fin='2024-04-16 08:06:17.0000000'
where id_trazabilidad_proceso=18139971

------------------------------------------------------------------------------------------------

update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('21833-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo




------------------------------------------------------------------------------------------------

