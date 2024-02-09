-----------------------------------------INSERT-----------------------------------------------------------------------------

	   USE [Documentos]BEGIN TRANSACTION;BEGIN try
  INSERT INTO documentos.."plantilla_configuracion"
              (
                          "id_plantilla",
                          "consulta",
                          "orden_variables",
                          "parametros",
                          "id_plantilla_config_padre",
                          "ubicacion",
                          "parametros_ubicacion",
                          "nombre_grupo"
              )
              VALUES (2750,'SELECT Concat(numero_proceso, ''-'', Year(fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                                   Substring(f.titulo_obtenido, 2,
                                   Len(f.titulo_obtenido))), '' '',
                                   per.nombre1, '' '', per.nombre2, '' '',
                     per.apellido1,
                     '' '',
                                   per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
               JOIN cargo c
                 ON c.id_cargo = f.id_cargo
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 6)                     AS nombreDelegado
FROM   proceso
WHERE  id_proceso := idProceso ','NUMERO_EXPEDIENTE,NOMBRE_COMPLETO,IMAGEN_FIRMA','idProceso', NULL, '/c2/%s','0',null);

END try BEGIN catch
  SELECT Error_number()    AS ErrorNumber ,
         Error_severity()  AS ErrorSeverity ,
         Error_state()     AS ErrorState ,
         Error_procedure() AS ErrorProcedure ,
         Error_line()      AS ErrorLine ,
         Error_message()   AS ErrorMessage;
  
  IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION;
END catch;IF @@TRANCOUNT > 0
COMMIT TRANSACTION;go