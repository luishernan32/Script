--PROVIDENCIA_PAGO 61 2634



begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT numero_proceso,
       Concat (p.numero_proceso, ''-'', c.anio),
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                             AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Upper(Concat(valor_parametro_defecto,
                     '' PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA''))
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo'               
	   , orden_variables='numero_consecutivo,NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=61

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_PAGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
SELECT numero_proceso,
       Concat (p.numero_proceso, '-', c.anio),
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                             AS nombreCompleto,
       pe.numero_identificacion,
       (SELECT Upper(Concat(valor_parametro_defecto,
                     ' PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA'))
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT numero_proceso,         Concat (p.numero_proceso, '-', c.anio),         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper (pj.nombre_comercial)           ELSE  Upper(         Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))         END AS nombreCompleto,         pe.numero_identificacion,      (SELECT upper(concat(valor_parametro_defecto,' PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA'))          FROM   parametro(nolock)          WHERE  codigo_parametro = 434) AS cargo_delegado  FROM   proceso p         JOIN coactivo c (nolock)           ON c.id_proceso = p.id_proceso         JOIN persona pe           ON pe.id_persona = c.id_deudor         LEFT JOIN persona_juridica pj                ON pj.id_persona_juridica = pe.id_persona  WHERE  c.id_coactivo = :idCoactivo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------