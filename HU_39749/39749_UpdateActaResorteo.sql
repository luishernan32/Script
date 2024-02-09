UPDATE "plantilla_configuracion" SET  "consulta"='SELECT Concat(numero_proceso, ''-'', Year(fecha_inicio)) AS numeroExpediente,
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
WHERE  id_proceso =:idProceso ', "orden_variables"='NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO', "parametros"='idProceso', "id_plantilla_config_padre"=NULL, "ubicacion"='/c2/%s', "parametros_ubicacion"='0', "nombre_grupo"=NULL WHERE "id_plantilla_config"=10202;


----------------------------------------------------------------------------------------------------------------------------------------------------
