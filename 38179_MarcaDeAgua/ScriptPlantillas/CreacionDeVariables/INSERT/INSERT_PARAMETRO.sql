USE [circulemos2]
GO

INSERT INTO [dbo].[parametro]
           ([codigo_parametro]
           ,[codigo_modulo]
           ,[nombre_parametro]
           ,[codigo_tipo_variable]
           ,[valor_parametro_defecto]
           ,[codigo_unidad_parametro]
           ,[formato]
           ,[editable_organismo])
     VALUES
           (439,
           4
           ,'Texto empresa publica'
           ,4
           ,'EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.'
           ,NULL
           ,NULL
           ,1)
GO



USE [circulemos2]
GO

INSERT INTO [dbo].[parametro]
           ([codigo_parametro]
           ,[codigo_modulo]
           ,[nombre_parametro]
           ,[codigo_tipo_variable]
           ,[valor_parametro_defecto]
           ,[codigo_unidad_parametro]
           ,[formato]
           ,[editable_organismo])
     VALUES
           (<codigo_parametro, int,>
           ,<codigo_modulo, int,>
           ,<nombre_parametro, varchar(70),>
           ,<codigo_tipo_variable, int,>
           ,<valor_parametro_defecto, varchar(500),>
           ,<codigo_unidad_parametro, int,>
           ,<formato, varchar(50),>
           ,<editable_organismo, smallint,>)
GO

