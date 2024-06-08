USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

SET IDENTITY_INSERT [dbo].[variable] ON;
INSERT INTO [dbo].[variable]
           (id_variable, [nombre_variable]
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
           (1448,
		    'TITULO_PLANTILLAS'
           ,'Cambio en el titulo de la plantilla'
           ,3
           ,'Cambio'
           ,0
           ,null
           ,1
           ,null
           ,'Cambios'
           ,getdate()
           ,null)

SET IDENTITY_INSERT [dbo].[variable] off;

END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
