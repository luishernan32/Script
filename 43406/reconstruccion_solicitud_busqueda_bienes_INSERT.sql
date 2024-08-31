select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null
--------------------------------------------------------------------------


USE [circulemos2]
GO
begin tran
INSERT INTO [dbo].[reconstruccion_solicitud_busqueda_bienes]
           ([numero_juicio]
           ,[valor_proyectado]
           ,[numero_oficio]
           ,[fecha_creacion_oficio]
           ,[documento_1]
           ,[documento_2]
           ,[documento_3]
           ,[procesado]
           ,[error]
           ,[path_documento_1]
           ,[path_documento_2]
           ,[path_documento_3])
     VALUES
           ('314769-2023','27.47','3433','04-01-2024 14:38','873422-314769-2023-1.pdf','873422-314769-2023-2.pdf','873422-314769-2023-3.pdf',0,'El coactivo no ha sido NOTIFICADO',null,null,null)
GO





<numero_juicio>,<valor_proyectado>,<numero_oficio>,<fecha_creacion_oficio>,<documento_1>,<documento_2>,<documento_3>,<procesado>,<error>,<path_documento_1>,<path_documento_2>,<path_documento_3>

('314769-2023','27.47','3433','04-01-2024 14:38','873422-314769-2023-1.pdf','873422-314769-2023-2.pdf','873422-314769-2023-3.pdf',0,'El coactivo no ha sido NOTIFICADO',null,null,null)






---------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO [dbo].[reconstruccion_solicitud_busqueda_bienes]
           ([numero_juicio]
           ,[valor_proyectado]
           ,[numero_oficio]
           ,[fecha_creacion_oficio]
           ,[documento_1]
           ,[documento_2]
           ,[documento_3]
           ,[procesado]
           ,[error]
           ,[path_documento_1]
           ,[path_documento_2]
           ,[path_documento_3])
     VALUES
           (<numero_juicio, varchar(20),>
           ,<valor_proyectado, varchar(20),>
           ,<numero_oficio, varchar(20),>
           ,<fecha_creacion_oficio, varchar(80),>
           ,<documento_1, varchar(100),>
           ,<documento_2, varchar(100),>
           ,<documento_3, varchar(100),>
           ,<procesado, smallint,>
           ,<error, varchar(250),>
           ,<path_documento_1, varchar(255),>
           ,<path_documento_2, varchar(255),>
           ,<path_documento_3, varchar(255),>)
GO

