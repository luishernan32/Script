--ACTA_SEG_V_CUL 10102 4697

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, c.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                           AND img.fecha_fin IS NULL ) )) AS LogoATM_variable,
       dc.consecutivo                                     AS MEMO_ACTA,
       dc.fecha_registro                                  AS fecha_actual,
       ( CASE
           WHEN :tipoActa = 3 THEN ''ACTA DE CULMINACIÓN SATISFACTORIA''
           ELSE
             CASE
               WHEN :tipoActa = 4 THEN ''ACTA DE NO APROBACIÓN''
               ELSE ''ACTA DE ABANDONO,''
             END
         END )                                            AS PARRAFO_1,
       (SELECT Isnull(p.nombre1, '''') + '' ''
               + Isnull(p.nombre2, '''') + '' ''
               + Isnull(p.apellido1, '''') + '' ''
               + Isnull(p.apellido2, '''')
        FROM   persona p
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  id_cargo = 11
               AND fecha_final_vigencia IS NULL)          AS NOMBRE_ABOGADO,
       (SELECT Isnull(p.nombre1, '''') + '' ''
               + Isnull(p.nombre2, '''') + '' ''
               + Isnull(p.apellido1, '''') + '' ''
               + Isnull(p.apellido2, '''')
        FROM   persona p
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  id_cargo = 10
               AND fecha_final_vigencia IS NULL)          AS NOMBRE_SECRETARIO,
       ( CASE inf.id_tipo_identificacion
           WHEN 2 THEN pju.nombre_comercial
           ELSE ( Isnull(inf.nombre1, '''') + '' ''
                  + Isnull(inf.nombre2, '''') + '' ''
                  + Isnull(inf.apellido1, '''') + '' ''
                  + Isnull(inf.apellido2, '''') )
         END )                                            NOMBRE_INFRACTOR,
       ti_inf.nombre                                      AS
       T_DOCUMENTO_INFRACTOR,
       inf.numero_identificacion                          AS
       N_DOCUMENTO_INFRACTOR,
       c.fecha_registro                                   AS FECHA_CURSO,
       ( CASE
           WHEN :tipoActa = 3 THEN
''ha culminado satisfactoriamente el proceso de sustitución de multa por educación virtual,''
  ELSE
    CASE
      WHEN :tipoActa = 4 THEN
''no obtuvo la calificación mínima por segunda ocasión el cual genera la no aprobación del proceso de sustitución de multa por educación virtual,''
  ELSE
''ranscurrido los 14 días no realizó la culminación del curso virtual generando el abandono del proceso de sustitución de multa por educación virtual,''
END
END )                                              AS PARRAFO_2,
i.descripcion                                      AS DESCRIPCION_MULTAS,
(SELECT Max(fi.numero_imagen)
 FROM   firma_persona fi
        LEFT JOIN persona p
               ON fi.id_persona = p.id_persona
        LEFT JOIN funcionario f
               ON f.id_persona = p.id_persona
 WHERE  id_cargo = 10
        AND fecha_final_vigencia IS NULL)          AS IMAGEN_FIRMA
FROM   curso c
       LEFT JOIN persona inf
              ON inf.id_persona = c.id_persona
       LEFT JOIN tipo_identificacion_persona ti_inf
              ON ti_inf.id_tipo_identificacion = inf.id_tipo_identificacion
       LEFT JOIN persona_juridica pju WITH(nolock)
              ON inf.id_persona = pju.id_persona_juridica
       LEFT JOIN configuracion_infraccion i
              ON i.id_infraccion = c.id_infraccion
                 AND i.fecha_fin_vigencia IS NULL
       LEFT JOIN documento_curso dc
              ON dc.id_curso = c.id_curso
WHERE  c.id_curso = :idCurso '               
	   , orden_variables='LogoATM_variable,MEMO_FALLO,fecha_actual,PARRAFO_1,NOMBRE_ABOGADO,NOMBRE_SECRETARIO,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,FECHA_CURSO,PARRAFO_2,DESCRIPCION_MULTAS,IMAGEN_FIRMA'
WHERE  id_plantilla_config=10102

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ACTA_SEG_V_CUL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------

SELECT (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 1
               AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, c.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                           AND img.fecha_fin IS NULL ) )) AS LogoATM_variable,
       dc.consecutivo                                     AS MEMO_ACTA,
       dc.fecha_registro                                  AS fecha_actual,
       ( CASE
           WHEN :tipoActa = 3 THEN 'ACTA DE CULMINACIÓN SATISFACTORIA'
           ELSE
             CASE
               WHEN :tipoActa = 4 THEN 'ACTA DE NO APROBACIÓN'
               ELSE 'ACTA DE ABANDONO,'
             END
         END )                                            AS PARRAFO_1,
       (SELECT Isnull(p.nombre1, '') + ' '
               + Isnull(p.nombre2, '') + ' '
               + Isnull(p.apellido1, '') + ' '
               + Isnull(p.apellido2, '')
        FROM   persona p
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  id_cargo = 11
               AND fecha_final_vigencia IS NULL)          AS NOMBRE_ABOGADO,
       (SELECT Isnull(p.nombre1, '') + ' '
               + Isnull(p.nombre2, '') + ' '
               + Isnull(p.apellido1, '') + ' '
               + Isnull(p.apellido2, '')
        FROM   persona p
               LEFT JOIN funcionario f
                      ON f.id_persona = p.id_persona
        WHERE  id_cargo = 10
               AND fecha_final_vigencia IS NULL)          AS NOMBRE_SECRETARIO,
       ( CASE inf.id_tipo_identificacion
           WHEN 2 THEN pju.nombre_comercial
           ELSE ( Isnull(inf.nombre1, '') + ' '
                  + Isnull(inf.nombre2, '') + ' '
                  + Isnull(inf.apellido1, '') + ' '
                  + Isnull(inf.apellido2, '') )
         END )                                            NOMBRE_INFRACTOR,
       ti_inf.nombre                                      AS
       T_DOCUMENTO_INFRACTOR,
       inf.numero_identificacion                          AS
       N_DOCUMENTO_INFRACTOR,
       c.fecha_registro                                   AS FECHA_CURSO,
       ( CASE
           WHEN :tipoActa = 3 THEN
'ha culminado satisfactoriamente el proceso de sustitución de multa por educación virtual,'
  ELSE
    CASE
      WHEN :tipoActa = 4 THEN
'no obtuvo la calificación mínima por segunda ocasión el cual genera la no aprobación del proceso de sustitución de multa por educación virtual,'
  ELSE
'ranscurrido los 14 días no realizó la culminación del curso virtual generando el abandono del proceso de sustitución de multa por educación virtual,'
END
END )                                              AS PARRAFO_2,
i.descripcion                                      AS DESCRIPCION_MULTAS,
(SELECT Max(fi.numero_imagen)
 FROM   firma_persona fi
        LEFT JOIN persona p
               ON fi.id_persona = p.id_persona
        LEFT JOIN funcionario f
               ON f.id_persona = p.id_persona
 WHERE  id_cargo = 10
        AND fecha_final_vigencia IS NULL)          AS IMAGEN_FIRMA
FROM   curso c
       LEFT JOIN persona inf
              ON inf.id_persona = c.id_persona
       LEFT JOIN tipo_identificacion_persona ti_inf
              ON ti_inf.id_tipo_identificacion = inf.id_tipo_identificacion
       LEFT JOIN persona_juridica pju WITH(nolock)
              ON inf.id_persona = pju.id_persona_juridica
       LEFT JOIN configuracion_infraccion i
              ON i.id_infraccion = c.id_infraccion
                 AND i.fecha_fin_vigencia IS NULL
       LEFT JOIN documento_curso dc
              ON dc.id_curso = c.id_curso
WHERE  c.id_curso = :idCurso 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
select (SELECT img.numero_imagen FROM imagen img (NOLOCK) WHERE img.id_tipo_imagen = 1 and                      ((img.fecha_inicio <= CONVERT(date, c.fecha_registro)    AND img.fecha_fin >= CONVERT(date, c.fecha_registro))    OR (img.fecha_inicio <= CONVERT(date, c.fecha_registro)    AND img.fecha_fin IS NULL))    ) as LogoATM_variable,  dc.consecutivo AS MEMO_ACTA, dc.fecha_registro as fecha_actual,  (case when :tipoActa = 3 then 'ACTA DE CULMINACI?N SATISFACTORIA'   else  case when :tipoActa = 4 then 'ACTA DE NO APROBACI?N'   else 'ACTA DE ABANDONO,' end end)  as PARRAFO_1,  (select isnull(p.nombre1, '')+' '+isnull(p.nombre2, '')+' '+isnull(p.apellido1, '')+' '+isnull(p.apellido2, '') from persona p   left join funcionario f on f.id_persona=p.id_persona   where id_cargo=11 and fecha_final_vigencia is null) as NOMBRE_ABOGADO,  (select isnull(p.nombre1, '')+' '+isnull(p.nombre2, '')+' '+isnull(p.apellido1, '')+' '+isnull(p.apellido2, '') from persona p   left join funcionario f on f.id_persona=p.id_persona   where id_cargo=10 and fecha_final_vigencia is null) as NOMBRE_SECRETARIO,  (case inf.id_tipo_identificacion when 2 then pju.nombre_comercial else (isnull(inf.nombre1,'')+' '+isnull(inf.nombre2,'')+' '+isnull(inf.apellido1,'')+' '+isnull(inf.apellido2,'')) end)  NOMBRE_INFRACTOR,   ti_inf.nombre as T_DOCUMENTO_INFRACTOR, inf.numero_identificacion as N_DOCUMENTO_INFRACTOR, c.fecha_registro as FECHA_CURSO,   (case when :tipoActa = 3 then 'ha culminado satisfactoriamente el proceso de sustituci?n de multa por educaci?n virtual,'   else  case when :tipoActa = 4 then 'no obtuvo la calificaci?n m?nima por segunda ocasi?n el cual genera la no aprobaci?n del proceso de sustituci?n de multa por educaci?n virtual,'   else 'ranscurrido los 14 d?as no realiz? la culminaci?n del   curso virtual generando el abandono del proceso de sustituci?n de multa por educaci?n virtual,' end end)  as PARRAFO_2,  i.descripcion as DESCRIPCION_MULTAS,  (select max(fi.numero_imagen) from firma_persona fi   left join persona p on fi.id_persona=p.id_persona   left join funcionario f on f.id_persona=p.id_persona   where id_cargo=10 and fecha_final_vigencia is null) as IMAGEN_FIRMA  FROM curso c  left join persona inf on inf.id_persona=c.id_persona  left join tipo_identificacion_persona ti_inf on ti_inf.id_tipo_identificacion=inf.id_tipo_identificacion   LEFT JOIN persona_juridica pju with(nolock) on inf.id_persona = pju.id_persona_juridica   left join configuracion_infraccion i on i.id_infraccion=c.id_infraccion and i.fecha_fin_vigencia is null  left join documento_curso dc on dc.id_curso =  c.id_curso  where c.id_curso= :idCurso
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------