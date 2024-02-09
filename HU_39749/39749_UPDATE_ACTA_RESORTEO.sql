begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(numero_proceso, ''-'', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                         AS fechaActual,
       Getdate()                                         AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                     '' '',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  tp.id_proceso = :idProceso
               AND tp.id_estado_proceso = 139)           AS nombreDelegado,
       fper.numero_imagen                                AS Firma,
       Upper(Concat(perus.nombre1, '' '', perus.nombre2, '' '', perus.apellido1, '' ''
             ,
                   perus.apellido2))                     AS nombreSecretario
FROM   proceso p
       INNER JOIN trazabilidad_proceso tp (nolock)
               ON tp.id_proceso = p.id_proceso
                  AND tp.id_estado_proceso = 13
       INNER JOIN usuario_persona up (nolock)
               ON up.id_usuario = tp.id_usuario
       INNER JOIN persona perus (nolock)
               ON perus.id_persona = up.id_persona
       LEFT JOIN (SELECT Max(numero_imagen) AS numero_imagen,
                         id_persona
                  FROM   firma_persona (nolock)
                  GROUP  BY id_persona) AS fper
              ON fper.id_persona = perus.id_persona
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA,NOMBRE_FUNCIONARIO'
WHERE  id_plantilla_config=10202

commit tran