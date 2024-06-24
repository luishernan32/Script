--------------------------------------------------------
--ABG.
select 
--nombre1,nombre2, id_funcionario,apellido1,titulo_obtenido
*from funcionario_coactivo f
join persona p on f.id_persona=p.id_persona
where nombre1='Francisco ' and nombre2 ='Xavier' 
--------------------------------------------------------

begin tran
update funcionario_coactivo 
set titulo_obtenido='Abg. Esp.'
where id_funcionario=24--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------


USE [circulemos2]

BEGIN TRANSACTION; 
  
BEGIN TRY

– INSTRUCCION

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
