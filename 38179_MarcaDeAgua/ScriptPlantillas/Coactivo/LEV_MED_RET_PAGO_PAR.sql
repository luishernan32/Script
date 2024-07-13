--LEV_MED_RET_PAGO_PAR 10169 2478

		
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @id_trazabilidad_proceso BIGINT;

SELECT TOP 1 @id_trazabilidad_proceso = id_trazabilidad_proceso
FROM   circulemos2.dbo.trazabilidad_proceso WITH (nolock)
WHERE  id_estado_proceso = 52
       AND id_proceso is not null
ORDER  BY id_trazabilidad_proceso DESC;

SELECT ''Superintendencia de bancos del Ecuador''             AS institucion,
       Concat (p.numero_proceso, ''-'', Year(p.fecha_inicio)) AS numero_coactivo,
       tp1.fecha_inicio                                     AS
       fecha_levantamiento,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN ( pj.nombre_comercial )
         ELSE Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
              pe.apellido2
              )
       END                                                  AS nombre_completo,
       pe.numero_identificacion,
       Iif(rpe.numero_cheque IN ( ''0'', '''', NULL ), rpe.numero_transferencia,
       rpe.numero_cheque)                                   AS
       numero_cheque_transferencia,
       Iif(rpe.valor_cheque IN ( 0, NULL ), rpe.valor_transferencia,
       rpe.valor_cheque)
                                                            AS
       valor_cheque_transferencia,
       edi.fecha_envio,
       e.fecha_registro,
       edi2.referencia_envio,
       ob.numero_oficio,
       (SELECT Concat (f1.titulo_obtenido,'' '',p1.nombre1, '' '', p1.apellido1, '' '', p1.apellido2)
        FROM   persona p1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON p1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS secretario_adhoc,
       (SELECT Max(fp1.numero_imagen)
        FROM   firma_persona fp1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON fp1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS
       firma_secretario_adhoc,
       (SELECT Concat (f2.titulo_obtenido,'' '',p2.nombre1, '' '', p2.apellido1, '' '', p2.apellido2)
        FROM   persona p2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON p2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS delegado,
       (SELECT Max(fp2.numero_imagen)
        FROM   firma_persona fp2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON fp2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS firma_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                      AS
       cargo_delegado_director,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441)                      AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 437)) )           AS
       cargo_delegado_mayusculas,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p WITH (nolock)
       JOIN trazabilidad_proceso tp WITH (nolock)
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 52
       JOIN trazabilidad_proceso tp1 WITH (nolock)
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 38
       JOIN coactivo c WITH (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe WITH (nolock)
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj WITH (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp WITH (nolock)
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea WITH (nolock)
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe WITH (nolock)
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e WITH (nolock)
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb WITH (nolock)
         ON eb.id_embargo = e.id_embargo
       JOIN bien b WITH (nolock)
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob WITH (nolock)
         ON c.id_coactivo = cob.id_coactivo
       JOIN oficio_bien ob WITH (nolock)
         ON cob.id_oficio_bien = ob.id_oficio_bien
       JOIN seg_doc_impre_reg_embargo sdi WITH (nolock)
         ON sdi.id_coactivo_oficio_bien = cob.id_coactivo_oficio_bien
       JOIN envio_doc_impresion_embargo edi WITH (nolock)
         ON edi.id_seg_doc_impresion_embargo = sdi.id_seg_doc_impresion_embargo
       JOIN seg_doc_impre_reg_embargo sdi1 WITH (nolock)
         ON sdi1.id_juicio_coactivo = p.numero_proceso
            AND sdi1.fecha_expediente = Year(p.fecha_inicio)
            AND sdi1.id_tipo_documento_proceso = 43
       JOIN envio_doc_impresion_embargo edi2 WITH (nolock)
         ON edi2.id_seg_doc_impresion_embargo =
            sdi1.id_seg_doc_impresion_embargo
WHERE  p.id_proceso is not null
       AND tp.id_trazabilidad_proceso = @id_trazabilidad_proceso '               
	   , orden_variables='BANCO,CONSECUTIVO_PRUEBAS,fecha_actual,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,NUMERO_PAGO,VALOR_INTERES,FECHA_INGRESO,FECHA_INGRESO2,NUMERO_TRAMITE,NUMERO_JUICIO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,PROFESION_PART,CARGO_DELEGADO,PROFESION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10169

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'LEV_MED_RET_PAGO_PAR';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

--Modificada
-------------------------------------------------------------------------------------


DECLARE @id_trazabilidad_proceso BIGINT;

SELECT TOP 1 @id_trazabilidad_proceso = id_trazabilidad_proceso
FROM   circulemos2.dbo.trazabilidad_proceso WITH (nolock)
WHERE  id_estado_proceso = 52
       AND id_proceso is not null
ORDER  BY id_trazabilidad_proceso DESC;

SELECT 'Superintendencia de bancos del Ecuador'             AS institucion,
       Concat (p.numero_proceso, '-', Year(p.fecha_inicio)) AS numero_coactivo,
       tp1.fecha_inicio                                     AS
       fecha_levantamiento,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN ( pj.nombre_comercial )
         ELSE Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2
              )
       END                                                  AS nombre_completo,
       pe.numero_identificacion,
       Iif(rpe.numero_cheque IN ( '0', '', NULL ), rpe.numero_transferencia,
       rpe.numero_cheque)                                   AS
       numero_cheque_transferencia,
       Iif(rpe.valor_cheque IN ( 0, NULL ), rpe.valor_transferencia,
       rpe.valor_cheque)
                                                            AS
       valor_cheque_transferencia,
       edi.fecha_envio,
       e.fecha_registro,
       edi2.referencia_envio,
       ob.numero_oficio,
       (SELECT Concat (f1.titulo_obtenido,' ',p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
        FROM   persona p1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON p1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS secretario_adhoc,
       (SELECT Max(fp1.numero_imagen)
        FROM   firma_persona fp1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON fp1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS
       firma_secretario_adhoc,
       (SELECT Concat (f2.titulo_obtenido,' ',p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)
        FROM   persona p2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON p2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS delegado,
       (SELECT Max(fp2.numero_imagen)
        FROM   firma_persona fp2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON fp2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS firma_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                      AS
       cargo_delegado_director,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                      AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 437)) )           AS
       cargo_delegado_mayusculas,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p WITH (nolock)
       JOIN trazabilidad_proceso tp WITH (nolock)
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 52
       JOIN trazabilidad_proceso tp1 WITH (nolock)
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 38
       JOIN coactivo c WITH (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe WITH (nolock)
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj WITH (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp WITH (nolock)
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea WITH (nolock)
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe WITH (nolock)
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e WITH (nolock)
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb WITH (nolock)
         ON eb.id_embargo = e.id_embargo
       JOIN bien b WITH (nolock)
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob WITH (nolock)
         ON c.id_coactivo = cob.id_coactivo
       JOIN oficio_bien ob WITH (nolock)
         ON cob.id_oficio_bien = ob.id_oficio_bien
       JOIN seg_doc_impre_reg_embargo sdi WITH (nolock)
         ON sdi.id_coactivo_oficio_bien = cob.id_coactivo_oficio_bien
       JOIN envio_doc_impresion_embargo edi WITH (nolock)
         ON edi.id_seg_doc_impresion_embargo = sdi.id_seg_doc_impresion_embargo
       JOIN seg_doc_impre_reg_embargo sdi1 WITH (nolock)
         ON sdi1.id_juicio_coactivo = p.numero_proceso
            AND sdi1.fecha_expediente = Year(p.fecha_inicio)
            AND sdi1.id_tipo_documento_proceso = 43
       JOIN envio_doc_impresion_embargo edi2 WITH (nolock)
         ON edi2.id_seg_doc_impresion_embargo =
            sdi1.id_seg_doc_impresion_embargo
WHERE  p.id_proceso is not null
       AND tp.id_trazabilidad_proceso = @id_trazabilidad_proceso 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

DECLARE @id_trazabilidad_proceso BIGINT;    SELECT TOP 1 @id_trazabilidad_proceso = id_trazabilidad_proceso  FROM   circulemos2.dbo.trazabilidad_proceso WITH (nolock)  WHERE  id_estado_proceso = 52         AND id_proceso is not null  ORDER  BY id_trazabilidad_proceso DESC;    SELECT 'Superintendencia de bancos del Ecuador'             AS institucion,         Concat (p.numero_proceso, '-', Year(p.fecha_inicio)) AS numero_coactivo,         tp1.fecha_inicio                                     AS         fecha_levantamiento,         CASE pe.id_tipo_identificacion           WHEN 2 THEN ( pj.nombre_comercial )           ELSE Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',                pe.apellido2                )         END                                                  AS nombre_completo,         pe.numero_identificacion,         Iif(rpe.numero_cheque IN ( '0', '', NULL ), rpe.numero_transferencia,         rpe.numero_cheque)                                   AS         numero_cheque_transferencia,         Iif(rpe.valor_cheque IN ( 0, NULL ), rpe.valor_transferencia,         rpe.valor_cheque)                                                              AS         valor_cheque_transferencia,         edi.fecha_envio,         e.fecha_registro,         edi2.referencia_envio,         ob.numero_oficio,         (SELECT Concat (p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)          FROM   persona p1 WITH (nolock)                 JOIN funcionario f1 WITH (nolock)                   ON p1.id_persona = f1.id_persona          WHERE  f1.id_cargo = 4                 AND f1.id_subcargo = 3                 AND f1.fecha_final_vigencia IS NULL)         AS secretario_adhoc,         (SELECT Max(fp1.numero_imagen)          FROM   firma_persona fp1 WITH (nolock)                 JOIN funcionario f1 WITH (nolock)                   ON fp1.id_persona = f1.id_persona          WHERE  f1.id_cargo = 4                 AND f1.id_subcargo = 3                 AND f1.fecha_final_vigencia IS NULL)         AS         firma_secretario_adhoc,         (SELECT Concat (p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)          FROM   persona p2 WITH (nolock)                 JOIN funcionario f2 WITH (nolock)                   ON p2.id_persona = f2.id_persona          WHERE  f2.id_cargo = 1                 AND f2.id_subcargo = 4                 AND f2.fecha_final_vigencia IS NULL)         AS delegado,         (SELECT Max(fp2.numero_imagen)          FROM   firma_persona fp2 WITH (nolock)                 JOIN funcionario f2 WITH (nolock)                   ON fp2.id_persona = f2.id_persona          WHERE  f2.id_cargo = 1                 AND f2.id_subcargo = 4                 AND f2.fecha_final_vigencia IS NULL)         AS firma_delegado,         (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 434)                      AS         cargo_delegado_director,         (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 437)                      AS cargo_delegado,         ( Upper((SELECT valor_parametro_defecto                  FROM   parametro(nolock)                  WHERE  codigo_parametro = 437)) )           AS         cargo_delegado_mayusculas      ,(SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS  FROM   proceso p WITH (nolock)         JOIN trazabilidad_proceso tp WITH (nolock)           ON p.id_proceso = tp.id_proceso              AND tp.id_estado_proceso = 52         JOIN trazabilidad_proceso tp1 WITH (nolock)           ON p.id_proceso = tp1.id_proceso              AND tp1.id_estado_proceso = 38         JOIN coactivo c WITH (nolock)           ON p.id_proceso = c.id_proceso         JOIN persona pe WITH (nolock)           ON c.id_deudor = pe.id_persona         LEFT JOIN persona_juridica pj WITH (nolock)                ON pj.id_persona_juridica = pe.id_persona         JOIN documento_proceso dp WITH (nolock)           ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso         JOIN registro_pago_embargo_doc_adjunto rpea WITH (nolock)           ON dp.numero_documento = rpea.numero_archivo         JOIN registro_pago_embargo rpe WITH (nolock)           ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo         JOIN embargo e WITH (nolock)           ON e.id_coactivo = c.id_coactivo         JOIN embargo_bien eb WITH (nolock)           ON eb.id_embargo = e.id_embargo         JOIN bien b WITH (nolock)           ON b.id_bien = eb.id_bien         JOIN coactivo_oficio_bien cob WITH (nolock)           ON c.id_coactivo = cob.id_coactivo         JOIN oficio_bien ob WITH (nolock)           ON cob.id_oficio_bien = ob.id_oficio_bien         JOIN seg_doc_impre_reg_embargo sdi WITH (nolock)           ON sdi.id_coactivo_oficio_bien = cob.id_coactivo_oficio_bien         JOIN envio_doc_impresion_embargo edi WITH (nolock)           ON edi.id_seg_doc_impresion_embargo = sdi.id_seg_doc_impresion_embargo         JOIN seg_doc_impre_reg_embargo sdi1 WITH (nolock)           ON sdi1.id_juicio_coactivo = p.numero_proceso              AND sdi1.fecha_expediente = Year(p.fecha_inicio)              AND sdi1.id_tipo_documento_proceso = 43         JOIN envio_doc_impresion_embargo edi2 WITH (nolock)           ON edi2.id_seg_doc_impresion_embargo =              sdi1.id_seg_doc_impresion_embargo  WHERE  p.id_proceso is not null         AND tp.id_trazabilidad_proceso = @id_trazabilidad_proceso 
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



--SCRIPT QUEMADO
DECLARE @id_trazabilidad_proceso BIGINT;

SELECT TOP 1 @id_trazabilidad_proceso = id_trazabilidad_proceso
FROM   circulemos2.dbo.trazabilidad_proceso WITH (nolock)
WHERE  id_estado_proceso = 52
       AND id_proceso is not null
ORDER  BY id_trazabilidad_proceso DESC;

SELECT 'Superintendencia de bancos del Ecuador'             AS institucion,
       Concat (p.numero_proceso, '-', Year(p.fecha_inicio)) AS numero_coactivo,
       tp1.fecha_inicio                                     AS
       fecha_levantamiento,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN ( pj.nombre_comercial )
         ELSE Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
              pe.apellido2
              )
       END                                                  AS nombre_completo,
       pe.numero_identificacion,
       Iif(rpe.numero_cheque IN ( '0', '', NULL ), rpe.numero_transferencia,
       rpe.numero_cheque)                                   AS
       numero_cheque_transferencia,
       Iif(rpe.valor_cheque IN ( 0, NULL ), rpe.valor_transferencia,
       rpe.valor_cheque)
                                                            AS
       valor_cheque_transferencia,
       edi.fecha_envio,
       e.fecha_registro,
       edi2.referencia_envio,
       ob.numero_oficio,
       (SELECT Concat (f1.titulo_obtenido,' ',p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
        FROM   persona p1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON p1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS secretario_adhoc,
       (SELECT Max(fp1.numero_imagen)
        FROM   firma_persona fp1 WITH (nolock)
               JOIN funcionario f1 WITH (nolock)
                 ON fp1.id_persona = f1.id_persona
        WHERE  f1.id_cargo = 4
               AND f1.id_subcargo = 3
               AND f1.fecha_final_vigencia IS NULL)         AS
       firma_secretario_adhoc,
       (SELECT Concat (f2.titulo_obtenido,' ',p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)
        FROM   persona p2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON p2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS delegado,
       (SELECT Max(fp2.numero_imagen)
        FROM   firma_persona fp2 WITH (nolock)
               JOIN funcionario f2 WITH (nolock)
                 ON fp2.id_persona = f2.id_persona
        WHERE  f2.id_cargo = 1
               AND f2.id_subcargo = 4
               AND f2.fecha_final_vigencia IS NULL)         AS firma_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                      AS
       cargo_delegado_director,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                      AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 437)) )           AS
       cargo_delegado_mayusculas,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                      AS TITULO_PLANTILLAS
FROM   proceso p WITH (nolock)
       JOIN trazabilidad_proceso tp WITH (nolock)
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 52
       JOIN trazabilidad_proceso tp1 WITH (nolock)
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 38
       JOIN coactivo c WITH (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe WITH (nolock)
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj WITH (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp WITH (nolock)
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea WITH (nolock)
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe WITH (nolock)
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e WITH (nolock)
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb WITH (nolock)
         ON eb.id_embargo = e.id_embargo
       JOIN bien b WITH (nolock)
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob WITH (nolock)
         ON c.id_coactivo = cob.id_coactivo
       JOIN oficio_bien ob WITH (nolock)
         ON cob.id_oficio_bien = ob.id_oficio_bien
       JOIN seg_doc_impre_reg_embargo sdi WITH (nolock)
         ON sdi.id_coactivo_oficio_bien = cob.id_coactivo_oficio_bien
       JOIN envio_doc_impresion_embargo edi WITH (nolock)
         ON edi.id_seg_doc_impresion_embargo = sdi.id_seg_doc_impresion_embargo
       JOIN seg_doc_impre_reg_embargo sdi1 WITH (nolock)
         ON sdi1.id_juicio_coactivo = p.numero_proceso
            AND sdi1.fecha_expediente = Year(p.fecha_inicio)
            AND sdi1.id_tipo_documento_proceso = 43
       JOIN envio_doc_impresion_embargo edi2 WITH (nolock)
         ON edi2.id_seg_doc_impresion_embargo =
            sdi1.id_seg_doc_impresion_embargo
WHERE  p.id_proceso is not null
       AND tp.id_trazabilidad_proceso = @id_trazabilidad_proceso 