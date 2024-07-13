--PROVIDENCIA_PAGO_EMB 2626 10152


-- 07-07-2024

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(p.numero_proceso, ''-'', c.anio)                AS NUMERO_JUICIO,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                  AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND f.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND f.fecha_final_vigencia IS NULL ))  AS firma_funcionario
       ,
       (SELECT Concat(fd.titulo_obtenido, '' '', Upper(
                       Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                       '' '',
                                                       per.apellido2)))
        FROM   funcionario fd (nolock)
               INNER JOIN persona per (nolock)
                       ON fd.id_persona = per.id_persona
        WHERE  fd.id_cargo = 1
               AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND fd.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( fd.id_cargo = 1
                     AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND fd.fecha_final_vigencia IS NULL )) AS delegado_coactiva
       ,
       (SELECT Substring(valor_parametro_defecto, 0, (
                       Charindex(''Tránsito'', valor_parametro_defecto, 0)
                                                       + Len(''Tránsito'') ))
        FROM   parametro
        WHERE  codigo_parametro = 437)                      AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo IS NOT NULL '               
	   , orden_variables='NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10152

commit tran




----------------------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(p.numero_proceso, ''-'', c.anio)                AS NUMERO_JUICIO,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                  AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND f.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( f.id_cargo = 1
                     --AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND f.fecha_final_vigencia IS NULL ))  AS firma_funcionario
       ,
       (SELECT Concat(fd.titulo_obtenido, '' '', Upper(
                       Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                       '' '',
                                                       per.apellido2)))
        FROM   funcionario fd (nolock)
               INNER JOIN persona per (nolock)
                       ON fd.id_persona = per.id_persona
        WHERE  fd.id_cargo = 1
               AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND fd.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( fd.id_cargo = 1
                     AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND fd.fecha_final_vigencia IS NULL )) AS delegado_coactiva
       ,
       (SELECT Substring(valor_parametro_defecto, 0, (
                       Charindex(''Tránsito'', valor_parametro_defecto, 0)
                                                       + Len(''Tránsito'') ))
        FROM   parametro
        WHERE  codigo_parametro = 437)                      AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo is not null '               
	   , orden_variables='NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10152

commit tran




begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(p.numero_proceso, ''-'', c.anio)                AS NUMERO_JUICIO,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                  AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND f.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND f.fecha_final_vigencia IS NULL ))  AS firma_funcionario
       ,
       (SELECT Concat(fd.titulo_obtenido, '' '', Upper(
                       Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                       '' '',
                                                       per.apellido2)))
        FROM   funcionario fd (nolock)
               INNER JOIN persona per (nolock)
                       ON fd.id_persona = per.id_persona
        WHERE  fd.id_cargo = 1
               AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND fd.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( fd.id_cargo = 1
                     AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND fd.fecha_final_vigencia IS NULL )) AS delegado_coactiva
       ,
       (SELECT Substring(valor_parametro_defecto, 0, (
                       Charindex(''Tránsito'', valor_parametro_defecto, 0)
                                                       + Len(''Tránsito'') ))
        FROM   parametro
        WHERE  codigo_parametro = 437)                      AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo is not null'               
	   , orden_variables='NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10152

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_PAGO_EMB';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
SELECT Concat(p.numero_proceso, '-', c.anio)                AS NUMERO_JUICIO,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                                  AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND f.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND f.fecha_final_vigencia IS NULL ))  AS firma_funcionario
       ,
       (SELECT Concat(fd.titulo_obtenido, ' ', Upper(
                       Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                       ' ',
                                                       per.apellido2)))
        FROM   funcionario fd (nolock)
               INNER JOIN persona per (nolock)
                       ON fd.id_persona = per.id_persona
        WHERE  fd.id_cargo = 1
               AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
               AND fd.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)
                OR ( fd.id_cargo = 1
                     AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)
                     AND fd.fecha_final_vigencia IS NULL )) AS delegado_coactiva
       ,
       (SELECT Substring(valor_parametro_defecto, 0, (
                       Charindex('Tránsito', valor_parametro_defecto, 0)
                                                       + Len('Tránsito') ))
        FROM   parametro
        WHERE  codigo_parametro = 441)                      AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo IS NOT NULL 
-------------------------------------------------------------------------------------
--Modificada 2


-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT  CONCAT(p.numero_proceso, '-', c.anio) as NUMERO_JUICIO ,  CASE pe.id_tipo_identificacion  WHEN 2 THEN UPPER(pj.nombre_comercial)  ELSE UPPER(CONCAT(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))  END AS nombreCompleto,  pe.numero_identificacion,  (SELECT  MAX(fp.numero_imagen)  FROM firma_persona fp (NOLOCK)  INNER JOIN funcionario f (NOLOCK)  ON f.id_persona = fp.id_persona  WHERE f.id_cargo = 1  AND f.fecha_inicio_vigencia <= CONVERT(date, p.fecha_fin)  AND f.fecha_final_vigencia >= CONVERT(date, p.fecha_fin)  OR (f.id_cargo = 1  AND f.fecha_inicio_vigencia <= CONVERT(date, p.fecha_fin)  AND f.fecha_final_vigencia IS NULL))  AS firma_funcionario,  (SELECT  Concat(fd.titulo_obtenido, ' ', UPPER(Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2)))  FROM funcionario fd (NOLOCK)  INNER JOIN persona per (NOLOCK)  ON fd.id_persona = per.id_persona  WHERE fd.id_cargo = 1  AND fd.fecha_inicio_vigencia <= CONVERT(date, p.fecha_fin)  AND fd.fecha_final_vigencia >= CONVERT(date, p.fecha_fin)  OR (fd.id_cargo = 1  AND fd.fecha_inicio_vigencia <= CONVERT(date, p.fecha_fin)  AND fd.fecha_final_vigencia IS NULL))  AS delegado_coactiva,  (select SUBSTRING(valor_parametro_defecto,0, (CHARINDEX('Tránsito',valor_parametro_defecto,0)+LEN('Tránsito'))) from parametro where codigo_parametro=437) as cargo_delegado  FROM proceso p (NOLOCK)  JOIN coactivo c (NOLOCK)  ON c.id_proceso = p.id_proceso  JOIN persona pe (NOLOCK)  ON pe.id_persona = c.id_deudor  LEFT JOIN persona_juridica pj (NOLOCK)  ON pj.id_persona_juridica = pe.id_persona  WHERE c.id_coactivo is not null
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------