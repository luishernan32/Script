--PROVIDENCIA_PAGO_EMB 2626 10152  4774
--PROVIDENCIA_PAGO_EMB
--10349377
--
--Video:https://www.youtube.com/watch?v=M-1sI2atJNM

-----Datos para pruebas----
--10349309 11725712 id_coactivo: 1446853 0950133959
--id_coactivo: 1446927, 1446524
--(1446523,1446522,1446520,1446519,1446518,1446516)

select *from coactivo
where id_coactivo=1446927
-------------------------------------------------------------------------------------
--https://base64.guru/converter/decode/file
--https://tomeko.net/online_tools/hex_to_file.php?lang=en
--https://www.dpriver.com/pp/sqlformat.htm
-------------------------------------------------------------------------------------
begin tran 
update documentos..plantilla set fecha_fin='2024-08-16' where id_plantilla=4775--4774
update documentos..plantilla set fecha_inicio='2024-08-18' where id_plantilla=4775--4775
update documentos..plantilla set fecha_inicio='2024-08-20' where id_plantilla=4775--4775---4774
commit tran
-------------------------------------------------------------------------------------

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
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                      AS
       cargo_delegado_mayusculas,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo'               
	   , orden_variables='NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10152

commit tran

--NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO

-------------------------------------------------------------------------------------
begin tran 
update documentos..plantilla set fecha_fin='2024-08-17' where id_plantilla=4775--4774-4775--4774
update documentos..plantilla set fecha_inicio='2024-08-20' where id_plantilla=4777--4775--4776--4775--4775
update documentos..plantilla set fecha_inicio='2024-08-21' where id_plantilla=4777--4775--4775---4774
commit tran
-------------------------------------------------------------------------------------


--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla in(2)--(4743,4742,2619)--(2652,2648,2645,4743,2619,4742,4744,2639)--(4744,2639,2638,2623,2662,4764)--(2324,2581)   --=2325--2582--2581--
																																 -- *
select top 20 *from [documentos].[dbo].[documento] order by 1 desc																	 --*
--**************************************************************************************************************************************

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_PAGO_EMB'-----PROVIDENCIA_PAGO_EMB';--AUTO_PAGO_PATIO PROVIDENCIA_PAGO_EMB
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

--NUMERO_COACTIVO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO

		-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
--where id_plantilla in(2612,2611,2610,2609)
where id_plantilla in(4776)--(2616,2617,2618,2619,2620,2621,2622,2623,2624,2625,2626,2627,2628,2629,2630,2631,2632,2633,2634,2635,2636,2637,2638,2639,2640,2641,2642)

commit tran




select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2290'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2290, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from variable
where nombre_variable='CARGO_DELEGADO'

select *from documentos..variable_plantilla
where id_plantilla='2290'


select *from variable
where id_variable='1435'--1435
-------------------------------------------------------------------------------------


--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='4776'




---Update original

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(p.numero_proceso, ''-'', c.anio)                AS NUMERO_COACTIVO,
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
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo '               
	   , orden_variables='NUMERO_COACTIVO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO'
WHERE  id_plantilla_config=10152

commit tran











--Datos de prueba usados exitosos
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

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
        WHERE  codigo_parametro = 437)                      AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT Concat(p.numero_proceso, '-', c.anio)                AS NUMERO_JUICIO,         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper(pj.nombre_comercial)           ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',                      pe.apellido2))         END                                                  AS nombreCompleto,         pe.numero_identificacion,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp (nolock)                 INNER JOIN funcionario f (nolock)                         ON f.id_persona = fp.id_persona          WHERE  f.id_cargo = 1                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)                 AND f.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)                  OR ( f.id_cargo = 1                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)                       AND f.fecha_final_vigencia IS NULL ))  AS firma_funcionario         ,         (SELECT Concat(fd.titulo_obtenido, ' ', Upper(                         Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,                         ' ',                                                         per.apellido2)))          FROM   funcionario fd (nolock)                 INNER JOIN persona per (nolock)                         ON fd.id_persona = per.id_persona          WHERE  fd.id_cargo = 1                 AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)                 AND fd.fecha_final_vigencia >= CONVERT(DATE, p.fecha_fin)                  OR ( fd.id_cargo = 1                       AND fd.fecha_inicio_vigencia <= CONVERT(DATE, p.fecha_fin)                       AND fd.fecha_final_vigencia IS NULL )) AS delegado_coactiva         ,         (SELECT Substring(valor_parametro_defecto, 0, (                         Charindex('Tránsito', valor_parametro_defecto, 0)                                                         + Len('Tránsito') ))          FROM   parametro          WHERE  codigo_parametro = 437)                      AS cargo_delegado    ,(SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS  FROM   proceso p (nolock)         JOIN coactivo c (nolock)           ON c.id_proceso = p.id_proceso         JOIN persona pe (nolock)           ON pe.id_persona = c.id_deudor         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pe.id_persona  WHERE  c.id_coactivo = :idProceso 
-------------------------------------------------------------------------------------
--order variables: NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
---Datos para probar está plantilla

--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2024-08-16' ,'08:08:00.0000000',6767676892214, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,1042.04, --total pago
NULL,NULL,1,10396465, --factura finan --4007661 3087948
1042.04, --total pago
0, --cuota
'02', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
1042.04) ---total_tcr


--

-----------------------------------------------------------------
--Update original Bryan
--
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
        WHERE  codigo_parametro = 437)                      AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p (nolock)
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = :idCoactivo'               
	   , orden_variables='NUMERO_JUICIO,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10152

commit tran




------------------------------------------------------------------







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
WHERE  c.id_coactivo = :idProceso '               
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