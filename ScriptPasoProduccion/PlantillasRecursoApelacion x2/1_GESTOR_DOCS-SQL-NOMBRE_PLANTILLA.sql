USE [gestor_docs]
BEGIN TRANSACTION;  
  
BEGIN TRY  


INSERT INTO "data_documento" ( "nombre", "folder", "extension", "nombre_real", "Registro_BD") VALUES ( 'ACT_PERSONA_JUR.jasper', '/plantillas/jasper/ACT_PERSONA_JUR_4', '.jasper', 'ACT_PERSONA_JUR', 'False');
INSERT INTO "data_documento" ( "nombre", "folder", "extension", "nombre_real", "Registro_BD") VALUES ( 'ACT_PERSONA_JUR_IMAGEN_FIRMA.jasper', '/plantillas/jasper/ACT_PERSONA_JUR_4', '.jasper', 'ACT_PERSONA_JUR_IMAGEN_FIRMA', 'False');


INSERT INTO "version_data_documento" ("codigo_documento", "contenido_binario", "fecha", "version") VALUES ((select max(gdd.codigo_documento) from gestor_docs..data_documento gdd where gdd.nombre = 'ACT_PERSONA_JUR.jasper') , 0xaced00096c6572, '2022-03-11 10:57:41.5840000', 30);


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

