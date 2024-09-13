USE [circulemos2]


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
          

commit tran

select top 20 *from trazabilidad_proceso
where id_proceso='2827493'
--fecha de inicio :24-05-2024:   2024-05-24
 --set id_estado_proceso='23', observacion='NOTIFICADO'
 --where id_proceso=2827493


--corregir el id_proceso, (es el mismo del ultimo update)
--fecha inicio '2024-04-16 08:06:17.0000000'
--fecha_fin 2024-04-16 08:06:17.0000000
--id_usuario = 1
--id_sede_proceso = 1
--id_sede_usuario = 1

-------------------------------------------------------

--ok, y ahora haga un update para actualizar la fecha_fin de registro que está en null
/*begin tran
update trazabilidad_proceso
set fecha_fin='2024-04-16 08:06:17.0000000'
where id_trazabilidad_proceso=18139971
commit tran*/


---------------------------------------------------------


USE [circulemos2]
GO

INSERT INTO [dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
           (<id_proceso, bigint,>
           ,<id_estado_proceso, int,>
           ,<fecha_inicio, datetime2(7),>
           ,<fecha_fin, datetime2(7),>
           ,<id_usuario, int,>
           ,<id_sede_proceso, int,>
           ,<id_sede_usuario, int,>)
GO

