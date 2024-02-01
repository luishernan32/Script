USE [Documentos]

BEGIN TRANSACTION;

BEGIN try
insert into tipo_documento_proceso (id_tipo_documento_proceso,codigo,nombre,estado,descripcion) values(56,'56','ACTA RESORTEO',1,'ACTA RESORTEO')   
END try

BEGIN catch
    SELECT Error_number()    AS ErrorNumber,
           Error_severity()  AS ErrorSeverity,
           Error_state()     AS ErrorState,
           Error_procedure() AS ErrorProcedure,
           Error_line()      AS ErrorLine,
           Error_message()   AS ErrorMessage;

    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION;
END catch;

IF @@TRANCOUNT > 0
  COMMIT TRANSACTION;

go