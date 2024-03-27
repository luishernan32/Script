USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

set IDENTITY_INSERT seguridad.dbo.rol on 
insert into seguridad.dbo.rol 
(id_rol,nombre,descripcion,activo,id_aplicacion)
values(-40,'Director financiaciones','Tiene permiso para cambiar fechas',1,2)

set IDENTITY_INSERT seguridad.dbo.rol off

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

