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
           (439
           ,4
           ,'Texto empresa publica'
           ,4
           ,'EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL. EP.'
           ,null,null,1)

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
