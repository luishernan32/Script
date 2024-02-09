select *from proceso

USE [documentos]
GO

INSERT INTO [dbo].[proceso]
           ([id_proceso]
           ,[nombre_proceso]
           ,[descripcion_proceso]
           ,[id_proceso_padre]
           ,[codigo_proceso])
     VALUES
           (<id_proceso, bigint,>
           ,<nombre_proceso, varchar(70),>
           ,<descripcion_proceso, varchar(250),>
           ,<id_proceso_padre, bigint,>
           ,<codigo_proceso, varchar(10),>)
GO

-------------------------------------------------------

INSERT INTO [dbo].[proceso]
           ([id_proceso]
           ,[nombre_proceso]
           ,[descripcion_proceso]
           ,[id_proceso_padre]
           ,[codigo_proceso])
     VALUES
           (25,
           'Acta de Resorteo',
           'Acta de Resorteo',
		   null,
           '25')
GO




------------------------------------------------------
INSERT INTO [dbo].[proceso]
           ([id_proceso]
           ,[nombre_proceso]
           ,[descripcion_proceso]
           ,[id_proceso_padre]
           ,[codigo_proceso])
     VALUES
           (<id_proceso, bigint,>
           ,<nombre_proceso, varchar(70),>
           ,<descripcion_proceso, varchar(250),>
           ,<id_proceso_padre, bigint,>
           ,<codigo_proceso, varchar(10),>)
GO


