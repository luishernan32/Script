USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

insert into tipo_fuente_informacion 
(codigo_fuente_informacion,nombre,codigo,sigla,descripcion,estado,id_score_ubicabilidad)
values(32,'ANT-Web',32,null,null,1,4)

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