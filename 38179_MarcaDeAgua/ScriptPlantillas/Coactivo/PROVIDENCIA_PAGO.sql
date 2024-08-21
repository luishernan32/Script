--PROVIDENCIA_PAGO 61 2634
--Va a la par con PROVIDENCIA_ANULAR
--La variable del delegado se presenta en código por ello fue mejor traerla en el Script para mejor manipulación


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
        WHERE  codigo_parametro = 437) AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS,
		(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS FIRMA,
			   (SELECT TOP 1 Concat(fun.titulo_obtenido, '' '', pf.nombre1, '' '',
                     pf.nombre2, '' '',
                     pf.apellido1,
                                   '' '', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS NOMBRE_DELEGADO
FROM   proceso p
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo '               
	   , orden_variables='numero_consecutivo,NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,CARGO_DELEGADO,TITULO_PLANTILLAS,IMAGEN_FIRMA,NOMBRE_DELEGADO'
WHERE  id_plantilla_config=61

commit tran

        --order variables: numero_consecutivo,NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,CARGO_DELEGADO,TITULO_PLANTILLAS


begin tran 
update documentos..plantilla set fecha_inicio='2024-07-29' where id_plantilla=4765
update documentos..plantilla set fecha_inicio='2024-07-31' where id_plantilla=4765
update documentos..plantilla set fecha_fin=null where id_plantilla=4762
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_PAGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='4765'--'2634'--2634

--230 1376
INSERT INTO documentos..variable_plantilla
SELECT 2634, 230

INSERT INTO documentos..variable_plantilla
SELECT 2634, 1376

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
        WHERE  codigo_parametro = 437) AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS,
		(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS FIRMA,
			   (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS NOMBRE_DELEGADO

		(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                     AS cargo_delegado
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