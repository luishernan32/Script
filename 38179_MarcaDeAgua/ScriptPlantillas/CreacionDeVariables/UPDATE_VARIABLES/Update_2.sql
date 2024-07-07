USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

update parametro
set valor_parametro_defecto= 'DELEGADO DEL (A) DIRECTOR (A) DE GESTI�N DE INFRACCIONES Y SERVICIOS DE TR�NSITO PARA EL EJERCICIO DE LA JURISDICCI�N COACTIVA DE LA EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL,EP.'
where codigo_parametro = 434



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
