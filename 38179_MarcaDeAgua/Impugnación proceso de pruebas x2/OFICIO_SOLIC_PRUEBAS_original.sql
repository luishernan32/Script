SELECT Concat(spb.consecutivo_documento, '-', Year(Getdate())),
       spb.destino_prueba_otro,
       pr.numero_proceso,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat
(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
END AS nombreCompleto,
pe.numero_identificacion,
c.numero_citacion,
spb.descripcion
FROM   proceso pr
       JOIN comparendo_proceso cpr
         ON cpr.id_proceso = pr.id_proceso
       JOIN comparendo c
         ON c.cicomparendo = cpr.cicomparendo
       JOIN trazabilidad_proceso tp
         ON tp.id_proceso = pr.id_proceso
       JOIN solicitud_pruebas_back spb
         ON spb.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       JOIN participante_proceso pp
         ON pp.id_proceso = pr.id_proceso
       JOIN persona pe
         ON pe.id_persona = pp.id_persona
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  pr.id_proceso = :idProceso
       AND spb.id_solicitud_pruebas_back = :idSolicitud
       AND pp.id_tipo_participante = 2 