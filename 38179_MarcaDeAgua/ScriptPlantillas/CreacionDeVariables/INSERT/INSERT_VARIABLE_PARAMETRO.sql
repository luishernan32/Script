USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

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
           (441
           ,4
           ,'Texto Cargo Delegado Director'
           ,4
           ,'DELEGADO DEL (A) DIRECTOR (A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL,EP.'
           ,null
           ,null
           ,1)
GO



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
