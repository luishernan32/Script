--Omitir para validacion
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   
WHERE  id_plantilla_config=75

commit tran

-----------------------------------Alexander-------------------------------------------------------------------------------------------
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(numero_proceso, ''-'', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
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
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
fper.numero_imagen AS Firma,
		
Upper(Concat(perus.nombre1, '' '', perus.nombre2, '' '',
             perus.apellido1, '' '',
                   perus.apellido2))      AS nombreSecretario
		
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
-------------------------------------------------------------------------------
--IMAGEN_FIRMA,NOMBRE_FUNCIONARIO


SELECT Concat(numero_proceso, '-', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                     ' ',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
(SELECT Max(numero_imagen)
        FROM   
		acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				 join firma_persona fpe (nolock) on fpe.id_persona=per.id_persona
        WHERE  tp.id_proceso=:idProceso
		and tp.id_estado_proceso=139) AS Firma,
		Upper(Concat(perus.nombre1, ' ', perus.nombre2, ' ',
             perus.apellido1, ' ',
                   perus.apellido2))      AS nombreSecretario,
       fper.numero_imagen                 AS firmaSecretario
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
WHERE  p.id_proceso = :idProceso 


--:idProceso 





--Agregar el parametro manual

--Cambio a las plantillas de cierre de pruebes
select *from acta_resorteo
select *from estado_proceso

11840490

--------------------------------------------
--Query importante
select * from circulemos2.dbo.proceso p
where p.id_tipo_proceso = 1
and YEAR(p.fecha_inicio)=2024
and p.numero_proceso = '119'
---------------------------------------------







SELECT Concat(numero_proceso, '-', Year(fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                     ' ',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona)     AS nombreDelegado
FROM   proceso
WHERE  id_proceso = :idProceso 


-----02/02/2024 original query que se pidio probar-----------------------------------------------------------------------
SELECT Concat(numero_proceso, '-', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                     ' ',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
(SELECT Max(numero_imagen)
        FROM   
		acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				 join firma_persona fpe (nolock) on fpe.id_persona=per.id_persona
        WHERE  tp.id_proceso=:idProceso
		and tp.id_estado_proceso=139) AS Firma,
		Upper(Concat(perus.nombre1, ' ', perus.nombre2, ' ',
             perus.apellido1, ' ',
                   perus.apellido2))      AS nombreSecretario,
       fper.numero_imagen                 AS firmaSecretario
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
WHERE  p.id_proceso = :idProceso 


--------------------------------------------Con datos----------------------------------------------
--Query 02/02/2024 3:13 terminado para pruebas
SELECT Concat(numero_proceso, '-', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                     ' ',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				WHERE  tp.id_proceso=2833597
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
(SELECT Max(numero_imagen)
        FROM   
		acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				 join firma_persona fpe (nolock) on fpe.id_persona=per.id_persona
        WHERE  tp.id_proceso=2833597
		and tp.id_estado_proceso=139) AS Firma,
		Upper(Concat(perus.nombre1, ' ', perus.nombre2, ' ',
             perus.apellido1, ' ',
                   perus.apellido2))      AS nombreSecretario,
       fper.numero_imagen                 AS firmaSecretario
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
WHERE  p.id_proceso =2833597 --:idProceso 

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------Genera la plantilla sirvioo numero 1-------------------------
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(numero_proceso, ''-'', Year(fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
       (SELECT TOP 1 Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                     '' '',
                     per.apellido2)
        FROM   acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona)     AS nombreDelegado
FROM   proceso
WHERE  id_proceso = :idProceso '               
	   , orden_variables='NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO'
WHERE  id_plantilla_config=10202

commit tran
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------sirvio con Firma--numero2----------------------------------------------
-------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta= 'SELECT Concat(numero_proceso, ''-'', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
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
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
(SELECT Max(numero_imagen)
        FROM   
		acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				 join firma_persona fpe (nolock) on fpe.id_persona=per.id_persona
        WHERE  tp.id_proceso=:idProceso
		and tp.id_estado_proceso=139) AS Firma
		
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
	   , orden_variables='NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA'
WHERE  id_plantilla_config=10202

commit tran

--------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------sirvio con Firma--numero3-------------------------------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(numero_proceso, ''-'', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
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
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
(SELECT Max(numero_imagen)
        FROM   
		acta_resorteo ar
               JOIN funcionario f
                 ON f.id_funcionario = ar.id_funcionario
               JOIN trazabilidad_proceso tp
                 ON ar.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               JOIN persona per
                 ON per.id_persona = f.id_persona
				 join firma_persona fpe (nolock) on fpe.id_persona=per.id_persona
        WHERE  tp.id_proceso=:idProceso
		and tp.id_estado_proceso=139) AS Firma,
		
Upper(Concat(perus.nombre1, '' '', perus.nombre2, '' '',
             perus.apellido1, '' '',
                   perus.apellido2))      AS nombreSecretario
		
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

--------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------sirvio con Firma--numero3 trae el nombre del secretario ac-hot -------------------------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(numero_proceso, ''-'', Year(p.fecha_inicio)) AS numeroExpediente,
       Getdate()                                       AS fechaActual,
       Getdate()                                       AS horaActual,
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
				WHERE  tp.id_proceso= :idProceso
		and tp.id_estado_proceso=139 )     AS nombreDelegado,
fper.numero_imagen AS Firma,
		
Upper(Concat(perus.nombre1, '' '', perus.nombre2, '' '',
             perus.apellido1, '' '',
                   perus.apellido2))      AS nombreSecretario
		
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

--------------------------------------------------------------------------------------------------------------------