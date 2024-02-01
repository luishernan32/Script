
---------------------------------------------------------------------------------------------------------------------------
SELECT Concat(numero_proceso, '-', Year(fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                                   Substring(f.titulo_obtenido, 2,
                                   Len(f.titulo_obtenido))), ' ',
                                   per.nombre1, ' ', per.nombre2, ' ',
                     per.apellido1,
                     ' ',
                                   per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
               JOIN cargo c
                 ON c.id_cargo = f.id_cargo
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 6)                     AS nombreDelegado
FROM   proceso
WHERE  id_proceso = 2833576 
---------------------------------------------------------------------------------------------------------------------------
--ORDER VARIABLES
--NUMERO_EXPEDIENTE,NOMBRE_COMPLETO,IMAGEN_FIRMA


--FECHA_SENTAR_RAZON_FALLO, HORA_SENTAR_RAZON_FALLO, NOMBRE_INFRACTOR, , , NOMBRE_ABOGADO

--numero_consecutivo,,CORREO_ELECTRONICO_INFRACTOR,anio_apertura_proceso,NOMBRE_ABOGADO,PLACA_VEHICULO,NOMBRE_DELEGADO,  CARGO_DELEGADO,IMAGEN_FIRMA,MEMO_DELEGADO,FECHA_DELEGADO,TEXTO_NOMBRE_2
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------



(SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS
       nombrefuncionario


---------------------------------------------------------------------------------------------------------------------------


