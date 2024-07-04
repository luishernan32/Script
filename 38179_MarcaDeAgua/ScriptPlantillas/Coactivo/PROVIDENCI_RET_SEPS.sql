--PROVIDENCI_RET_SEPS 2620 10174


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(P.numero_proceso, ''-'', Year(P.fecha_inicio)) numero_coactivo,
       Getdate()                                           AS fecha_actual,
       Getdate()                                           AS hora_actual,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE
Upper(
       Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '', pe.apellido2))
       END                                                 AS nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       p.fecha_inicio                                      AS fechaGeneracion,
       cob.valor_proyectado                                AS valor_total,
       cob.valor_proyectado                                AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = pe.id_persona
                          AND fun.id_funcionario = 24)     AS firma,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, cob.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                           AND img.fecha_fin IS NULL ) ))  AS LogoATM_variable,
       (SELECT TOP 1
Upper(
Concat(f.titulo_obtenido, '' '', p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '', p.apellido2))
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = ''VIGENTE''
ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario,
(SELECT TOP 1 fm.numero_imagen
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = ''VIGENTE''
ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,
(SELECT valor_parametro_defecto
FROM   parametro(nolock)
WHERE  codigo_parametro = 437)                     AS cargo_delegado
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   oficio_bien ob (nolock)
JOIN coactivo_oficio_bien cob (nolock)
  ON cob.id_oficio_bien = ob.id_oficio_bien
JOIN coactivo c (nolock)
  ON c.id_coactivo = cob.id_coactivo
JOIN proceso p (nolock)
  ON c.id_proceso = p.id_proceso
JOIN solicitud_bien_entidad sbe (nolock)
  ON sbe.id_oficio_bien = ob.id_oficio_bien
JOIN configuracion_entidad ce (nolock)
  ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad
JOIN entidad_oficio e (nolock)
  ON e.id_entidad_oficio = ce.id_entidad_oficio
JOIN persona pe (nolock)
  ON pe.id_persona = c.id_deudor
LEFT JOIN persona_juridica pj (nolock)
       ON pj.id_persona_juridica = pe.id_persona
JOIN tipo_identificacion_persona tip (nolock)
  ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
WHERE  ob.id_oficio_bien is not null '               
	   , orden_variables='NUMERO_PROCESO,fecha_actual,hora_actual,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,FECHA_GENERACION,  VALOR_SALDO,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA, LogoATM_variable,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10174

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCI_RET_SEPS';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
SELECT Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,
       Getdate()                                           AS fecha_actual,
       Getdate()                                           AS hora_actual,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE
Upper(
       Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
       END                                                 AS nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       p.fecha_inicio                                      AS fechaGeneracion,
       cob.valor_proyectado                                AS valor_total,
       cob.valor_proyectado                                AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = pe.id_persona
                          AND fun.id_funcionario = 24)     AS firma,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, cob.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                           AND img.fecha_fin IS NULL ) ))  AS LogoATM_variable,
       (SELECT TOP 1
Upper(
Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = 'VIGENTE'
ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario,
(SELECT TOP 1 fm.numero_imagen
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = 'VIGENTE'
ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,
(SELECT valor_parametro_defecto
FROM   parametro(nolock)
WHERE  codigo_parametro = 437)                     AS cargo_delegado
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   oficio_bien ob (nolock)
JOIN coactivo_oficio_bien cob (nolock)
  ON cob.id_oficio_bien = ob.id_oficio_bien
JOIN coactivo c (nolock)
  ON c.id_coactivo = cob.id_coactivo
JOIN proceso p (nolock)
  ON c.id_proceso = p.id_proceso
JOIN solicitud_bien_entidad sbe (nolock)
  ON sbe.id_oficio_bien = ob.id_oficio_bien
JOIN configuracion_entidad ce (nolock)
  ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad
JOIN entidad_oficio e (nolock)
  ON e.id_entidad_oficio = ce.id_entidad_oficio
JOIN persona pe (nolock)
  ON pe.id_persona = c.id_deudor
LEFT JOIN persona_juridica pj (nolock)
       ON pj.id_persona_juridica = pe.id_persona
JOIN tipo_identificacion_persona tip (nolock)
  ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
WHERE  ob.id_oficio_bien is not null 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
SELECT CONCAT(P.NUMERO_PROCESO,'-',YEAR(P.FECHA_INICIO)) numero_coactivo,  GETDATE() AS fecha_actual, GETDATE() AS hora_actual,  CASE pe.id_tipo_identificacion     WHEN 2 THEN UPPER (pj.nombre_comercial)  ELSE UPPER(CONCAT(pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2))  END as nombreCompleto,  tip.codigo,  pe.numero_identificacion, p.fecha_inicio AS fechaGeneracion,  cob.valor_proyectado as valor_total, cob.valor_proyectado as valor_total_letras,  (SELECT max(fp.numero_imagen) FROM funcionario fun (NOLOCK) INNER JOIN firma_persona fp (NOLOCK) ON fp.id_persona = pe.id_persona  AND fun.id_funcionario = 24) AS firma,(SELECT img.numero_imagen FROM imagen img (NOLOCK) WHERE img.id_tipo_imagen = 1 AND ((img.fecha_inicio <= CONVERT(date, cob.fecha_registro) AND img.fecha_fin >= CONVERT(date, cob.fecha_registro)) OR (img.fecha_inicio <= CONVERT(date, cob.fecha_registro) AND img.fecha_fin IS NULL))) AS LogoATM_variable, (select TOP 1 UPPER(CONCAT(f.titulo_obtenido,' ',p.nombre1,' ',p.nombre2,' ',p.apellido1,' ',p.apellido2)) from funcionario  f inner join persona p on p.id_persona = f.id_persona inner join cargo c on c.id_cargo = f.id_cargo left join  firma_persona fm on fm.id_persona = p.id_persona  where c.id_cargo=1 and f.estado='VIGENTE' order by fm.fecha_registro desc) as nombre_funcionario, (select  top 1 fm.numero_imagen from funcionario  f inner join persona p on p.id_persona = f.id_persona inner join cargo c on c.id_cargo = f.id_cargo left join firma_persona fm on fm.id_persona = p.id_persona  where c.id_cargo=1 and f.estado='VIGENTE' order by fm.fecha_registro desc) firma_funcionario, (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=437) as cargo_delegado FROM oficio_bien ob (NOLOCK)  JOIN coactivo_oficio_bien cob (NOLOCK) ON cob.id_oficio_bien = ob.id_oficio_bien  JOIN coactivo c (NOLOCK) ON c.id_coactivo = cob.id_coactivo  JOIN proceso p (NOLOCK) ON c.id_proceso = p.id_proceso  JOIN solicitud_bien_entidad sbe (NOLOCK) ON sbe.id_oficio_bien = ob.id_oficio_bien  JOIN configuracion_entidad ce (NOLOCK) ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad  JOIN entidad_oficio e (NOLOCK) ON e.id_entidad_oficio = ce.id_entidad_oficio  JOIN persona pe (NOLOCK) ON pe.id_persona = c.id_deudor  LEFT JOIN persona_juridica pj (NOLOCK) ON pj.id_persona_juridica = pe.id_persona  JOIN tipo_identificacion_persona tip (NOLOCK) ON tip.id_tipo_identificacion = pe.id_tipo_identificacion  WHERE ob.id_oficio_bien is not null
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



--Quemado
SELECT top 10 Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,
       Getdate()                                           AS fecha_actual,
       Getdate()                                           AS hora_actual,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE
Upper(
       Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
       END                                                 AS nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       p.fecha_inicio                                      AS fechaGeneracion,
       cob.valor_proyectado                                AS valor_total,
       cob.valor_proyectado                                AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = pe.id_persona
                          AND fun.id_funcionario = 24)     AS firma,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, cob.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, cob.fecha_registro)
                           AND img.fecha_fin IS NULL ) ))  AS LogoATM_variable,
       (SELECT TOP 1
Upper(
Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = 'VIGENTE'
ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario,
(SELECT TOP 1 fm.numero_imagen
FROM   funcionario f
 INNER JOIN persona p
         ON p.id_persona = f.id_persona
 INNER JOIN cargo c
         ON c.id_cargo = f.id_cargo
 LEFT JOIN firma_persona fm
        ON fm.id_persona = p.id_persona
WHERE  c.id_cargo = 1
 AND f.estado = 'VIGENTE'
ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,
(SELECT valor_parametro_defecto
FROM   parametro(nolock)
WHERE  codigo_parametro = 437)                     AS cargo_delegado
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   oficio_bien ob (nolock)
JOIN coactivo_oficio_bien cob (nolock)
  ON cob.id_oficio_bien = ob.id_oficio_bien
JOIN coactivo c (nolock)
  ON c.id_coactivo = cob.id_coactivo
JOIN proceso p (nolock)
  ON c.id_proceso = p.id_proceso
JOIN solicitud_bien_entidad sbe (nolock)
  ON sbe.id_oficio_bien = ob.id_oficio_bien
JOIN configuracion_entidad ce (nolock)
  ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad
JOIN entidad_oficio e (nolock)
  ON e.id_entidad_oficio = ce.id_entidad_oficio
JOIN persona pe (nolock)
  ON pe.id_persona = c.id_deudor
LEFT JOIN persona_juridica pj (nolock)
       ON pj.id_persona_juridica = pe.id_persona
JOIN tipo_identificacion_persona tip (nolock)
  ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
WHERE  ob.id_oficio_bien is not null 



--cargo_delegado: Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Empresa Pública de Tránsito y Movilidad de Guayaquil, EP.