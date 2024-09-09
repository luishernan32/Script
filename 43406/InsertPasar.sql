----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]


INSERT INTO circulemos2.[dbo]..[proceso]
           ([id_tipo_proceso]
           ,[numero_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[observacion]
           ,[id_estado_proceso])
     VALUES
	        (4,'304104','2023-12-06 06:04:07.0000000','2023-12-06 06:04:07.0000000','COACTIVO ANULADO',31)
----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO circulemos2.[dbo].[coactivo]
           ([codigo_organismo]
           ,[id_deudor]
           ,[id_configuracion_coactivo]
           ,[id_cargue_coactivo]
           ,[id_proceso]
           ,[id_funcionario]
           ,[id_direccion]
           ,[id_tramite]
           ,[anio]
           ,[cantidad_obligaciones]
           ,[fecha_notificacion]
           ,[numero_coactivo]
           ,[valor_total_obligaciones]
           ,[valor_total_costas_procesales]
           ,[id_tipo_notificacion_coactivo]
           ,[id_tipo_coactivo])
     VALUES
           (11001,126941,4,null,'id_proceso',42,null,15449879,2024,1,null,'13531331',127.5,0,null,1)

GO


----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO circulemos2.[dbo].[obligacion_coactivo]
           ([id_coactivo]
           ,[codigo_tipo_obligacion]
           ,[numero_obligacion]
           ,[fecha_obligacion]
           ,[valor_costas_procesales]
           ,[valor_obligacion]
           ,[valor_interes_moratorios]
           ,[id_cartera]
           ,[id_estado_obligacion_coactivo])
     VALUES
	      (null,'Autoin',1,'Pendiente','Pendiente',0,127.5,'Pendiente','Pendiente',1)

           
GO
----------------------------------------------------------------------------------------------------------------------------------------------------

USE [circulemos2]
GO

INSERT INTO circulemos2.[dbo].[comparendo_proceso]
           ([cicomparendo]
           ,[id_proceso])
     VALUES
	           ('pendiete','Insertar')

          
GO
----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES

	 ('Insertar',31,'pendiente','pendiente',126941,'pendiente','pendiente')

           
GO

--------------------------------------------------------------

select top 10 *from comparendo_proceso

select top 10 *from trazabilidad_proceso