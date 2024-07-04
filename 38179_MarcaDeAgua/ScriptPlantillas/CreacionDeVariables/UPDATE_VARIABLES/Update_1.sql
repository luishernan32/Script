USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY


update parametro
set valor_parametro_defecto='Delegado Funcionario Ejecutor del(la) Director(a) de Gesti�n de Infracciones y Servicios de Tr�nsito de la Empresa P�blica de Tr�nsito y Movilidad de Guayaquil, EP.'
where codigo_parametro='437'


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