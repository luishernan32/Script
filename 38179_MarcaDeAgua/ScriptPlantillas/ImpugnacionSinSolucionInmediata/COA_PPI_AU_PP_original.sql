--MODIFICAR
SELECT CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat
(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
END                                                                           AS
       nombreCompleto,
pr.numero_proceso,
tip.codigo,
pe.numero_identificacion,
pr.fecha_inicio,
Year(pr.fecha_inicio)                                                         AS
       anio_proceso,
c.fecha_infraccion,
c.hora_infraccion,
CASE i.numeral_infraccion
WHEN ' ' THEN Concat('Art√culo ', ci.articulo, ' - ', nm.nombre)
ELSE
Concat('Art√culo ', ci.articulo, ', numeral ', i.numeral_infraccion, ' - ', nm.nombre)
END                                                                           AS
       infraccion,
ci.descripcion,
mp.descripcion_hechos,
eimp.consideracion_juridica,
ec.nombre,
c.numero_citacion,
tpf.id_trazabilidad_proceso,
cv.placa_vehiculo,
fu.memo_nombramiento,
fu.fecha_nombramiento,
Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2) AS
nombreAbogadoFirma,
car.nombre                                                                    AS
       NombreCargo,
(SELECT Max(numero_imagen)
FROM   firma_persona fpe (nolock)
WHERE  fpe.id_persona = per.id_persona)                                      AS
       Firma,
(SELECT TOP 1 cp.correo_electronico
FROM   correo_persona cp (nolock)
WHERE  cp.estado = 1
 AND cp.id_persona = pe.id_persona
ORDER  BY cp.fecha_registro DESC)                                            AS
       correos
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv (nolock)
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN estado_comparendo ec (nolock)
         ON ec.id_estado_comparendo = c.id_estado_comparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN evaluar_impugnacion eimp (nolock)
              ON eimp.id_trazabilidad_proceso = tpf.id_trazabilidad_proceso
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = (SELECT ei.id_funcionario
                                 FROM   evaluar_impugnacion ei
                                        INNER JOIN trazabilidad_proceso tp
                                                ON tp.id_trazabilidad_proceso =
                                                   ei.id_trazabilidad_proceso
                                 WHERE  tp.id_proceso = pr.id_proceso)
       JOIN cargo car (nolock)
         ON car.id_cargo = fu.id_cargo
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 

-----------------------------------------------
--ORIGINAL
SELECT CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat
(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
END                                                                           AS
       nombreCompleto,
pr.numero_proceso,
tip.codigo,
pe.numero_identificacion,
pr.fecha_inicio,
Year(pr.fecha_inicio)                                                         AS
       anio_proceso,
c.fecha_infraccion,
c.hora_infraccion,
CASE i.numeral_infraccion
WHEN ' ' THEN Concat('Art√culo ', ci.articulo, ' - ', nm.nombre)
ELSE
Concat('Art√culo ', ci.articulo, ', numeral ', i.numeral_infraccion, ' - ', nm.nombre)
END                                                                           AS
       infraccion,
ci.descripcion,
mp.descripcion_hechos,
eimp.consideracion_juridica,
ec.nombre,
c.numero_citacion,
tpf.id_trazabilidad_proceso,
cv.placa_vehiculo,
fu.memo_nombramiento,
fu.fecha_nombramiento,
Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2) AS
nombreAbogadoFirma,
car.nombre                                                                    AS
       NombreCargo,
(SELECT Max(numero_imagen)
FROM   firma_persona fpe (nolock)
WHERE  fpe.id_persona = per.id_persona)                                      AS
       Firma,
(SELECT TOP 1 cp.correo_electronico
FROM   correo_persona cp (nolock)
WHERE  cp.estado = 1
 AND cp.id_persona = pe.id_persona
ORDER  BY cp.fecha_registro DESC)                                            AS
       correos
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv (nolock)
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN estado_comparendo ec (nolock)
         ON ec.id_estado_comparendo = c.id_estado_comparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tpf (nolock)
         ON tpf.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN evaluar_impugnacion eimp (nolock)
              ON eimp.id_trazabilidad_proceso = tpf.id_trazabilidad_proceso
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = (SELECT ei.id_funcionario
                                 FROM   evaluar_impugnacion ei
                                        INNER JOIN trazabilidad_proceso tp
                                                ON tp.id_trazabilidad_proceso =
                                                   ei.id_trazabilidad_proceso
                                 WHERE  tp.id_proceso = pr.id_proceso)
       JOIN cargo car (nolock)
         ON car.id_cargo = fu.id_cargo
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  pr.id_proceso = :idProceso
ORDER  BY tpf.id_trazabilidad_proceso DESC 