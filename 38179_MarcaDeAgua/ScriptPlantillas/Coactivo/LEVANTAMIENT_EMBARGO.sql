--LEVANTAMIENT_EMBARGO 10171 2631

--Se hizo un update a lo siguiente codigo_parametro='437' Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Empresa Pública de Tránsito y Movilidad de Guayaquil, EP.

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'LEVANTAMIENT_EMBARGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)



--Variable: CARGO_DELEGADO
--Variables de plantillas

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

select *from circulemos2..parametro
where codigo_parametro='437'


--************************************************************************************************************************************************************************
--Importanteeeeeeeee
begin tran
update parametro
set valor_parametro_defecto='Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Empresa Pública de Tránsito y Movilidad de Guayaquil, EP.'
where codigo_parametro='437'
commit tran
--Antiguo 
--Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Autoridad de Tránsito Municipal
--El que tiene que quedar
--Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Empresa Pública de Tránsito y Movilidad de Guayaquil, EP.

--************************************************************************************************************************************************************************


select *from variable
where nombre_variable='CARGO_DELEGADO'

select *from documentos..variable_plantilla
where id_plantilla='2290'


select *from variable
where id_variable='1435'--1435
-------------------------------------------------------------------------------------
--Ver las variables
select nombre_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='2290'

----------------------------------

-----------------------------------------------------
--Abg. Esp. FRANCISCO22222 ROJAS ESTEVES
--------------------------------------------------------
--ABG.
select nombre1,nombre2, id_funcionario,titulo_obtenido
from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1='Andrea ' 
--and nombre2 ='Xavier' 
--------------------------------------------------------

begin tran
update funcionario 
set titulo_obtenido='Abg.'
where id_funcionario=42
commit  tran
--------------------------------------------------




		
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
             (SELECT Concat (f1.titulo_obtenido,'' '',p1.nombre1, '' '', p1.apellido1, '' '', p1.apellido2)
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
             (SELECT Concat (f2.titulo_obtenido,'' '',p2.nombre1, '' '', p2.apellido1, '' '', p2.apellido2)
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
              WHERE  codigo_parametro = 441)                     AS
             cargo_delegado,
             ( Upper((SELECT valor_parametro_defecto
                      FROM   parametro(nolock)
                      WHERE  codigo_parametro = 441)) )          AS
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
WHERE  p.id_proceso is not null '               
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
             (SELECT Concat (f1.titulo_obtenido,' ',p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
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
             (SELECT Concat (f2.titulo_obtenido,' ',p2.nombre1, ' ', p2.apellido1, ' ', p2.apellido2)
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
WHERE  p.id_proceso is not null 
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
WHERE  p.id_proceso is not null 

-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



----------------------------------------
--Dato quemado

SELECT TOP 1 'Superintendencia de bancos del Ecuador'            AS institucion,
             Concat(p.numero_proceso, '-', Year(p.fecha_inicio)) AS
             numero_coactivo,
             tp1.fecha_inicio                                    AS
             fecha_levantamiento,
             tp1.fecha_inicio                                    AS hora_actual,
             CASE pe.id_tipo_identificacion
               WHEN 2 THEN pj.nombre_comercial
               ELSE Concat (pe.nombre1, '8888 ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2
                    )
             END                                                 AS
             nombre_completo,
             pe.numero_identificacion,
             ob.numero_oficio,
             (SELECT Concat (f1.titulo_obtenido,' 9999',p1.nombre1, ' ', p1.apellido1, ' ', p1.apellido2)
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
             (SELECT Concat (f2.titulo_obtenido,' ',p2.nombre1, '22222 ', p2.apellido1, ' ', p2.apellido2)
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
             cargo_delegado_mayusculas,
             (SELECT valor_parametro_defecto
              FROM   parametro(nolock)
              WHERE  codigo_parametro = 439)                     AS
             TITULO_PLANTILLAS
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
WHERE  p.id_proceso is not null 