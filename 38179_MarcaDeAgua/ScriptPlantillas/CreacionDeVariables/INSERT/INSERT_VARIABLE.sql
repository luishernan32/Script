USE [documentos]
GO

INSERT INTO [dbo].[variable]
           ([nombre_variable]
           ,[descripcion_variable]
           ,[id_tipo_variable]
           ,[valor_defecto]
           ,[longitud_variable]
           ,[formato_variable]
           ,[id_contexto_aplicacion]
           ,[id_proceso]
           ,[palabra_clave]
           ,[fecha_creacion]
           ,[imagen])
     VALUES
           ('TITULO_PLANTILLAS',
           'Cambio en el titulo de la plantilla',
           3,
           'Cambio',
           0,
           null,
           1,
           null,
           'Cambios',
           getdate(),
           null)
GO




