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
			   JOIN acta_resorteo ar
			     ON ar.id_funcionario=f.id_funcionario
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 6)                     AS nombreDelegado,

(select top 1 concat(per.nombre1,' ',per.nombre2,' ', per.apellido1,' ', per.apellido2 )
from acta_resorteo ar
join funcionario f on f.id_funcionario=ar.id_funcionario
join trazabilidad_proceso tp on ar.id_trazabilidad_proceso=tp.id_trazabilidad_proceso
join persona per on per.id_persona=f.id_persona) as nombre


FROM   proceso
WHERE  id_proceso=2833574   -- is not null  --= :idProceso 



--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,NOMBRE_FUNCIONARIO


-----------------------------------------------
select *from proceso 

select *from trazabilidad_proceso

select *from acta_resorteo


select tp.*
from proceso p
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso 
join acta_resorteo ar on tp.id_trazabilidad_proceso=ar.id_trazabilidad_proceso
------------------------------------------------

select *from funcionario

select *from persona

select *from acta_resorteo



--select ar.*, p.nombre1,p.nombre2, p.apellido1, p.apellido2 

select top 1 concat(per.nombre1,' ',per.nombre2,' ', per.apellido1,' ', per.apellido2 )
from acta_resorteo ar
join funcionario f on f.id_funcionario=ar.id_funcionario
join trazabilidad_proceso tp on ar.id_trazabilidad_proceso=tp.id_trazabilidad_proceso
join persona per on per.id_persona=f.id_persona


(SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = perd.id_persona) AS Firma





select top 1 p.id_proceso,f.titulo_obtenido, concat(f.titulo_obtenido,' ', per.nombre1,' ',per.nombre2,' ', per.apellido1,' ', per.apellido2 )
from acta_resorteo ar
join funcionario f on f.id_funcionario=ar.id_funcionario
join trazabilidad_proceso tp on ar.id_trazabilidad_proceso=tp.id_trazabilidad_proceso
join persona per on per.id_persona=f.id_persona

join proceso p on tp.id_proceso=p.id_proceso



select *from funcionario






select CONCAT(f.titulo_obtenido,' ',p.nombre1,' ',p.nombre2,' ',p.apellido1)
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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
				WHERE  tp.id_proceso=2833583
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
        WHERE  tp.id_proceso=2833583
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
WHERE  p.id_proceso =2833583 --:idProceso 
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------