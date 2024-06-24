--LEVANTAMIENT_EMBARGO 10171 2631


		
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT TOP 1 ''Superintendencia de bancos del Ecuador''            AS institucion,
             Concat(p.numero_proceso, ''-'', Year(p.fecha_inicio)) AS
             numero_coactivo,
             tp1.fecha_inicio                                    AS
             fecha_levantamiento,
             tp1.fecha_inicio                                    AS hora_actual,
             CASE pe.id_tipo_identificacion
               WHEN 2 THEN pj.nombre_comercial
               ELSE Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2
                    )
             END                                                 AS
             nombre_completo,
             pe.numero_identificacion,
             ob.numero_oficio,
             (SELECT Concat (p1.nombre1, '' '', p1.apellido1, '' '', p1.apellido2)
              FROM   persona p1
                     JOIN funcionario f1
                       ON p1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             secretario_adhoc,
             (SELECT Max(fp1.numero_imagen)
              FROM   firma_persona fp1
                     JOIN funcionario f1
                       ON fp1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             firma_secretario_adhoc,
             (SELECT Concat (p2.nombre1, '' '', p2.apellido1, '' '', p2.apellido2)
              FROM   persona p2
                     JOIN funcionario f2
                       ON p2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS delegado,
             (SELECT Max(fp2.numero_imagen)
              FROM   firma_persona fp2
                     JOIN funcionario f2
                       ON fp2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS
             firma_delegado,
             (SELECT valor_parametro_defecto
              FROM   parametro(nolock)
              WHERE  codigo_parametro = 437)                     AS
             cargo_delegado,
             ( Upper((SELECT valor_parametro_defecto
                      FROM   parametro(nolock)
                      WHERE  codigo_parametro = 437)) )          AS
             cargo_delegado_mayusculas
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN trazabilidad_proceso tp
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 46
       JOIN trazabilidad_proceso tp1
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 27
       JOIN coactivo c
         ON p.id_proceso = c.id_proceso
       JOIN persona pe
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb
         ON eb.id_embargo = e.id_embargo
       JOIN bien b
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob
         ON c.id_coactivo = cob.id_coactivo
            AND cob.id_bien = b.id_bien
       JOIN oficio_bien ob
         ON cob.id_oficio_bien = ob.id_oficio_bien
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='BANCO,CONSECUTIVO_PRUEBAS,fecha_actual,hora_actual,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,NUMERO_JUICIO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,CARGO_DELEGADO,PROFESION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10171

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'LEVANTAMIENT_EMBARGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

------------------------------------------------------------------------------------------------------------------------------
--Modificar
-------------------------------------------------------------------------------------
SELECT TOP 1 'Superintendencia de bancos del Ecuador'            AS institucion,
             Concat(p.numero_proceso, '-', Year(p.fecha_inicio)) AS
             numero_coactivo,
             tp1.fecha_inicio                                    AS
             fecha_levantamiento,
             tp1.fecha_inicio                                    AS hora_actual,
             CASE pe.id_tipo_identificacion
               WHEN 2 THEN pj.nombre_comercial
               ELSE Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2
                    )
             END                                                 AS
             nombre_completo,
             pe.numero_identificacion,
             ob.numero_oficio,
             (SELECT Concat (p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
              FROM   persona p1
                     JOIN funcionario f1
                       ON p1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             secretario_adhoc,
             (SELECT Max(fp1.numero_imagen)
              FROM   firma_persona fp1
                     JOIN funcionario f1
                       ON fp1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             firma_secretario_adhoc,
             (SELECT Concat (p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)
              FROM   persona p2
                     JOIN funcionario f2
                       ON p2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS delegado,
             (SELECT Max(fp2.numero_imagen)
              FROM   firma_persona fp2
                     JOIN funcionario f2
                       ON fp2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS
             firma_delegado,
             (SELECT valor_parametro_defecto
              FROM   parametro(nolock)
              WHERE  codigo_parametro = 437)                     AS
             cargo_delegado,
             ( Upper((SELECT valor_parametro_defecto
                      FROM   parametro(nolock)
                      WHERE  codigo_parametro = 437)) )          AS
             cargo_delegado_mayusculas
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN trazabilidad_proceso tp
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 46
       JOIN trazabilidad_proceso tp1
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 27
       JOIN coactivo c
         ON p.id_proceso = c.id_proceso
       JOIN persona pe
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb
         ON eb.id_embargo = e.id_embargo
       JOIN bien b
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob
         ON c.id_coactivo = cob.id_coactivo
            AND cob.id_bien = b.id_bien
       JOIN oficio_bien ob
         ON cob.id_oficio_bien = ob.id_oficio_bien
WHERE  p.id_proceso = :idProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SELECT TOP 1 'Superintendencia de bancos del Ecuador'            AS institucion,
             Concat(p.numero_proceso, '-', Year(p.fecha_inicio)) AS
             numero_coactivo,
             tp1.fecha_inicio                                    AS
             fecha_levantamiento,
             tp1.fecha_inicio                                    AS hora_actual,
             CASE pe.id_tipo_identificacion
               WHEN 2 THEN pj.nombre_comercial
               ELSE Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2
                    )
             END                                                 AS
             nombre_completo,
             pe.numero_identificacion,
             ob.numero_oficio,
             (SELECT Concat (p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
              FROM   persona p1
                     JOIN funcionario f1
                       ON p1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             secretario_adhoc,
             (SELECT Max(fp1.numero_imagen)
              FROM   firma_persona fp1
                     JOIN funcionario f1
                       ON fp1.id_persona = f1.id_persona
              WHERE  f1.id_cargo = 4
                     AND f1.id_subcargo = 3
                     AND f1.fecha_final_vigencia IS NULL)        AS
             firma_secretario_adhoc,
             (SELECT Concat (p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)
              FROM   persona p2
                     JOIN funcionario f2
                       ON p2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS delegado,
             (SELECT Max(fp2.numero_imagen)
              FROM   firma_persona fp2
                     JOIN funcionario f2
                       ON fp2.id_persona = f2.id_persona
              WHERE  f2.id_cargo = 1
                     AND f2.id_subcargo = 4
                     AND f2.fecha_final_vigencia IS NULL)        AS
             firma_delegado,
             (SELECT valor_parametro_defecto
              FROM   parametro(nolock)
              WHERE  codigo_parametro = 437)                     AS
             cargo_delegado,
             ( Upper((SELECT valor_parametro_defecto
                      FROM   parametro(nolock)
                      WHERE  codigo_parametro = 437)) )          AS
             cargo_delegado_mayusculas
FROM   proceso p
       JOIN trazabilidad_proceso tp
         ON p.id_proceso = tp.id_proceso
            AND tp.id_estado_proceso = 46
       JOIN trazabilidad_proceso tp1
         ON p.id_proceso = tp1.id_proceso
            AND tp1.id_estado_proceso = 27
       JOIN coactivo c
         ON p.id_proceso = c.id_proceso
       JOIN persona pe
         ON c.id_deudor = pe.id_persona
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
       JOIN documento_proceso dp
         ON tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
       JOIN registro_pago_embargo_doc_adjunto rpea
         ON dp.numero_documento = rpea.numero_archivo
       JOIN registro_pago_embargo rpe
         ON rpea.id_registro_pago_embargo = rpe.id_registro_pago_embargo
       JOIN embargo e
         ON e.id_coactivo = c.id_coactivo
       JOIN embargo_bien eb
         ON eb.id_embargo = e.id_embargo
       JOIN bien b
         ON b.id_bien = eb.id_bien
       JOIN coactivo_oficio_bien cob
         ON c.id_coactivo = cob.id_coactivo
            AND cob.id_bien = b.id_bien
       JOIN oficio_bien ob
         ON cob.id_oficio_bien = ob.id_oficio_bien
WHERE  p.id_proceso = :idProceso 

-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------