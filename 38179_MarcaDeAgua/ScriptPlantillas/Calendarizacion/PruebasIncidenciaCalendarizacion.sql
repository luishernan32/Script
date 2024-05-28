SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       Getdate()
       AS fechaActual,
       Getdate()
       AS horaActual,
       pe.numero_identificacion,
       mc.placa_vehiculo,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 11)
       AS nombre_director,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       fc.motivo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       Concat(fu.titulo_obtenido, ' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo
FROM   proceso pr (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       JOIN solicitud_anula_calendarizacion sac (nolock)
         ON sac.id_proceso = pr.id_proceso
       JOIN multa_calendarizacion mc (nolock)
         ON mc.id_multa_calendarizacion = sac.id_multa_calendarizacion
       JOIN fallo_calendarizacion fc (nolock)
         ON fc.id_trazabilidad_proceso =
            (SELECT TOP 1 tp.id_trazabilidad_proceso
             FROM   trazabilidad_proceso tp
             WHERE  tp.id_proceso = pr.id_proceso
                    AND tp.id_estado_proceso = 82
             ORDER  BY tp.fecha_inicio DESC)
       LEFT JOIN funcionario_calendarizacion fu (nolock)
              ON fu.id_funcionario = fc.id_funcionario
       LEFT JOIN funcionario f (nolock)
              ON f.id_funcionario = fu.id_funcionario
       LEFT JOIN cargo car (nolock)
              ON car.id_cargo = fu.id_cargo
       LEFT JOIN persona per (nolock)
              ON per.id_persona = f.id_persona
WHERE  pr.id_proceso is not null 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pr.numero_proceso,
       Year(pr.fecha_inicio)
       anio_proceso,
       Getdate()
       AS fechaActual,
       Getdate()
       AS horaActual,
       pe.numero_identificacion,
       mc.placa_vehiculo,
       (SELECT Concat (per.nombre1, ' ', per.apellido1, ' ', per.apellido2)
        FROM   funcionario f
               JOIN persona per
                 ON per.id_persona = f.id_persona
        WHERE  f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 11)
       AS nombre_director,
       fu.memo_nombramiento,
       fu.fecha_nombramiento,
       fc.motivo,
       (SELECT Max(numero_imagen)
        FROM   firma_persona fpe (nolock)
        WHERE  fpe.id_persona = per.id_persona)
       AS Firma,
       (select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null) AS
       nombreAbogadoFirma,
       car.nombre
       AS NombreCargo
FROM   proceso pr (nolock)
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       JOIN solicitud_anula_calendarizacion sac (nolock)
         ON sac.id_proceso = pr.id_proceso
       JOIN multa_calendarizacion mc (nolock)
         ON mc.id_multa_calendarizacion = sac.id_multa_calendarizacion
       JOIN fallo_calendarizacion fc (nolock)
         ON fc.id_trazabilidad_proceso =
            (SELECT TOP 1 tp.id_trazabilidad_proceso
             FROM   trazabilidad_proceso tp
             WHERE  tp.id_proceso = pr.id_proceso
                    AND tp.id_estado_proceso = 82
             ORDER  BY tp.fecha_inicio DESC)
       LEFT JOIN funcionario_calendarizacion fu (nolock)
              ON fu.id_funcionario = fc.id_funcionario
       LEFT JOIN funcionario f (nolock)
              ON f.id_funcionario = fu.id_funcionario
       LEFT JOIN cargo car (nolock)
              ON car.id_cargo = fu.id_cargo
       LEFT JOIN persona per (nolock)
              ON per.id_persona = f.id_persona
WHERE  pr.id_proceso is not null 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Ab. ERIKA JAQUELINE ZAMBRANO REYNA
--ERIKA ZAMBRANO REYNA
--Abg. FELIPE HIPOLITO LARREATEGUI AVILES 12
select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona order by 1 desc


select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo is not null and fecha_final_vigencia is null


update funcionario

'Abg.'


