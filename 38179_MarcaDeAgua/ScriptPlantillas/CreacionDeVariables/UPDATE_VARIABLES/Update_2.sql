USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

update parametro
set valor_parametro_defecto= 'DELEGADO DEL (A) DIRECTOR (A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL,EP.'
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
