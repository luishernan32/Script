--RESOL_CULMI_VIRTU 10107 2232
--RESOL_CULMI_VIRTU

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language spanish;

SELECT TOP 1 ( CONVERT(VARCHAR, Day(Getdate())) + '' de ''
               + Lower(CONVERT(VARCHAR, Datename(month, Getdate())))
               + '' del '' + CONVERT(VARCHAR, Year(Getdate()))
               + '', a las ''
               + CONVERT(VARCHAR, Datepart(hour, Getdate()))
               + ''H''
               + CONVERT(VARCHAR, Datepart(minute, Getdate())) ) AS FECHA_TEXTO,
             Concat(:consecutivo, ''-'', Year(Getdate()))          AS
             numero_consecutivo,
             (SELECT img.numero_imagen
              FROM   imagen img (nolock)
              WHERE  img.id_tipo_imagen = 1
                     AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                             AND img.fecha_fin >=
                                 CONVERT(DATE, c.fecha_registro) )
                            OR ( img.fecha_inicio <=
                                 CONVERT(DATE, c.fecha_registro)
                                 AND img.fecha_fin IS NULL ) ))  AS
             LogoATM_variable,
             funcCur.memo_nombramiento                           AS
             MEMO_DELEGADO,
             ( CONVERT(VARCHAR, Day(funcCur.fecha_nombramiento))
               + '' de '' ) + Lower(CONVERT(VARCHAR,
                                  Datename(month, funcCur.fecha_nombramiento)))
             + '' de '' +
             CONVERT(VARCHAR, Year(funcCur.fecha_nombramiento))  AS
             FECHA_DELEGADO,
             ( CASE inf.id_tipo_identificacion
                 WHEN 2 THEN pju.nombre_comercial
                 ELSE ( Isnull(inf.nombre1, '''') + '' ''
                        + Isnull(inf.nombre2, '''') + '' ''
                        + Isnull(inf.apellido1, '''') + '' ''
                        + Isnull(inf.apellido2, '''') )
               END )                                             AS
             NOMBRE_INFRACTOR,
             inf.numero_identificacion                           AS
             N_DOCUMENTO_INFRACTOR,
             co.numero_citacion                                  AS
             numero_citacion,
             co.fecha_infraccion                                 AS
             F_IMPOSICION_COMPARENDO,
             (SELECT Isnull(f.titulo_obtenido, '''') + '' ''
                     + Isnull(p.nombre1, '''') + '' ''
                     + Isnull(p.nombre2, '''') + '' ''
                     + Isnull(p.apellido1, '''') + '' ''
                     + Isnull(p.apellido2, '''')
              FROM   persona p WITH(nolock)
                     LEFT JOIN funcionario f WITH(nolock)
                            ON f.id_persona = p.id_persona
              WHERE  f.id_cargo = 11
                     AND fecha_final_vigencia IS NULL)           AS
             NOMBRE_DIRECTOR_INFRACCIONES,
             (SELECT Max(fi.numero_imagen)
              FROM   firma_persona fi WITH(nolock)
                     INNER JOIN persona p WITH(nolock)
                             ON fi.id_persona = p.id_persona
                     INNER JOIN funcionario f
                             ON f.id_persona = p.id_persona
                     INNER JOIN funcionario_curso func
                             ON func.id_funcionario = f.id_funcionario
              WHERE  func.fecha_final_vigencia IS NULL)          AS IMAGEN_FIRMA
             ,
             (SELECT TOP 1 Isnull(pfsec.nombre1, '''') + '' ''
                           + Isnull(pfsec.nombre2, '''') + '' ''
                           + Isnull(pfsec.apellido1, '''') + '' ''
                           + Isnull(pfsec.apellido2, '''')
              FROM   persona pfsec
                     INNER JOIN funcionario f
                             ON pfsec.id_persona = f.id_persona
              WHERE  f.id_cargo = 4
                     AND f.fecha_final_vigencia IS NULL
                     AND f.id_funcionario IN ( 91, 148, 150, 160,
                                               169, 173, 176, 181 )
              ORDER  BY Newid())                                 AS
             NOMBRE_SECRETARIO,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, '''') + '' ''
                           + Isnull(p.nombre1, '''') + '' ''
                           + Isnull(p.nombre2, '''') + '' ''
                           + Isnull(p.apellido1, '''') + '' ''
                           + Isnull(p.apellido2, '''')
              FROM   persona p WITH(nolock)
                     INNER JOIN funcionario f WITH(nolock)
                             ON f.id_persona = p.id_persona
                     INNER JOIN funcionario_curso func
                             ON func.id_funcionario = f.id_funcionario
              WHERE  func.fecha_final_vigencia IS NULL)          AS
             NOMBRE_DELEGADO
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   curso c WITH(nolock)
       LEFT JOIN persona inf WITH(nolock)
              ON inf.id_persona = c.id_persona
       LEFT JOIN persona_juridica pju WITH(nolock)
              ON inf.id_persona = pju.id_persona_juridica
       LEFT JOIN funcionario_curso funcCur
              ON funcCur.fecha_final_vigencia IS NULL
                 AND funcCur.id_subcargo = 2
       LEFT JOIN funcionario func WITH(nolock)
              ON func.id_funcionario = funcCur.id_funcionario
       LEFT JOIN comparendo co WITH(nolock)
              ON c.id_factura_axis = co.id_factura_axis
       LEFT JOIN documento_curso dc WITH(nolock)
              ON dc.id_curso = c.id_curso
       LEFT JOIN secretario_curso_historico sch WITH(nolock)
              ON sch.id_documento_curso = dc.id_documento_curso
       LEFT JOIN funcionario fsec WITH(nolock)
              ON fsec.id_funcionario = sch.id_funcionario
       LEFT JOIN persona pfsec WITH(nolock)
              ON pfsec.id_persona = fsec.id_persona
WHERE  c.id_curso = :idCurso
       AND dc.id_documento_curso = :idDocumentoCurso '               
	   , orden_variables='FECHA_TEXTO,numero_consecutivo,LogoATM_variable,MEMO_DELEGADO,FECHA_DELEGADO,NOMBRE_INFRACTOR,N_DOCUMENTO_INFRACTOR,numero_citacion,F_IMPOSICION_COMPARENDO,NOMBRE_DIRECTOR_INFRACCIONES,IMAGEN_FIRMA,NOMBRE_SECRETARIO,NOMBRE_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10107

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'RESOL_CULMI_VIRTU';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
SET language spanish;

SELECT TOP 1 ( CONVERT(VARCHAR, Day(Getdate())) + ' de '
               + Lower(CONVERT(VARCHAR, Datename(month, Getdate())))
               + ' del ' + CONVERT(VARCHAR, Year(Getdate()))
               + ', a las '
               + CONVERT(VARCHAR, Datepart(hour, Getdate()))
               + 'H'
               + CONVERT(VARCHAR, Datepart(minute, Getdate())) ) AS FECHA_TEXTO,
             Concat(:consecutivo, '-', Year(Getdate()))          AS
             numero_consecutivo,
             (SELECT img.numero_imagen
              FROM   imagen img (nolock)
              WHERE  img.id_tipo_imagen = 1
                     AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                             AND img.fecha_fin >=
                                 CONVERT(DATE, c.fecha_registro) )
                            OR ( img.fecha_inicio <=
                                 CONVERT(DATE, c.fecha_registro)
                                 AND img.fecha_fin IS NULL ) ))  AS
             LogoATM_variable,
             funcCur.memo_nombramiento                           AS
             MEMO_DELEGADO,
             ( CONVERT(VARCHAR, Day(funcCur.fecha_nombramiento))
               + ' de ' ) + Lower(CONVERT(VARCHAR,
                                  Datename(month, funcCur.fecha_nombramiento)))
             + ' de ' +
             CONVERT(VARCHAR, Year(funcCur.fecha_nombramiento))  AS
             FECHA_DELEGADO,
             ( CASE inf.id_tipo_identificacion
                 WHEN 2 THEN pju.nombre_comercial
                 ELSE ( Isnull(inf.nombre1, '') + ' '
                        + Isnull(inf.nombre2, '') + ' '
                        + Isnull(inf.apellido1, '') + ' '
                        + Isnull(inf.apellido2, '') )
               END )                                             AS
             NOMBRE_INFRACTOR,
             inf.numero_identificacion                           AS
             N_DOCUMENTO_INFRACTOR,
             co.numero_citacion                                  AS
             numero_citacion,
             co.fecha_infraccion                                 AS
             F_IMPOSICION_COMPARENDO,
             (SELECT Isnull(f.titulo_obtenido, '') + ' '
                     + Isnull(p.nombre1, '') + ' '
                     + Isnull(p.nombre2, '') + ' '
                     + Isnull(p.apellido1, '') + ' '
                     + Isnull(p.apellido2, '')
              FROM   persona p WITH(nolock)
                     LEFT JOIN funcionario f WITH(nolock)
                            ON f.id_persona = p.id_persona
              WHERE  f.id_cargo = 11
                     AND fecha_final_vigencia IS NULL)           AS
             NOMBRE_DIRECTOR_INFRACCIONES,
             (SELECT Max(fi.numero_imagen)
              FROM   firma_persona fi WITH(nolock)
                     INNER JOIN persona p WITH(nolock)
                             ON fi.id_persona = p.id_persona
                     INNER JOIN funcionario f
                             ON f.id_persona = p.id_persona
                     INNER JOIN funcionario_curso func
                             ON func.id_funcionario = f.id_funcionario
              WHERE  func.fecha_final_vigencia IS NULL)          AS IMAGEN_FIRMA
             ,
             (SELECT TOP 1 Isnull(pfsec.nombre1, '') + ' '
                           + Isnull(pfsec.nombre2, '') + ' '
                           + Isnull(pfsec.apellido1, '') + ' '
                           + Isnull(pfsec.apellido2, '')
              FROM   persona pfsec
                     INNER JOIN funcionario f
                             ON pfsec.id_persona = f.id_persona
              WHERE  f.id_cargo = 4
                     AND f.fecha_final_vigencia IS NULL
                     AND f.id_funcionario IN ( 91, 148, 150, 160,
                                               169, 173, 176, 181 )
              ORDER  BY Newid())                                 AS
             NOMBRE_SECRETARIO,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, '') + ' '
                           + Isnull(p.nombre1, '') + ' '
                           + Isnull(p.nombre2, '') + ' '
                           + Isnull(p.apellido1, '') + ' '
                           + Isnull(p.apellido2, '')
              FROM   persona p WITH(nolock)
                     INNER JOIN funcionario f WITH(nolock)
                             ON f.id_persona = p.id_persona
                     INNER JOIN funcionario_curso func
                             ON func.id_funcionario = f.id_funcionario
              WHERE  func.fecha_final_vigencia IS NULL)          AS
             NOMBRE_DELEGADO
			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   curso c WITH(nolock)
       LEFT JOIN persona inf WITH(nolock)
              ON inf.id_persona = c.id_persona
       LEFT JOIN persona_juridica pju WITH(nolock)
              ON inf.id_persona = pju.id_persona_juridica
       LEFT JOIN funcionario_curso funcCur
              ON funcCur.fecha_final_vigencia IS NULL
                 AND funcCur.id_subcargo = 2
       LEFT JOIN funcionario func WITH(nolock)
              ON func.id_funcionario = funcCur.id_funcionario
       LEFT JOIN comparendo co WITH(nolock)
              ON c.id_factura_axis = co.id_factura_axis
       LEFT JOIN documento_curso dc WITH(nolock)
              ON dc.id_curso = c.id_curso
       LEFT JOIN secretario_curso_historico sch WITH(nolock)
              ON sch.id_documento_curso = dc.id_documento_curso
       LEFT JOIN funcionario fsec WITH(nolock)
              ON fsec.id_funcionario = sch.id_funcionario
       LEFT JOIN persona pfsec WITH(nolock)
              ON pfsec.id_persona = fsec.id_persona
WHERE  c.id_curso = :idCurso
       AND dc.id_documento_curso = :idDocumentoCurso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SET language spanish;  SELECT TOP 1 ( CONVERT(VARCHAR, Day(Getdate())) + ' de '                 + Lower(CONVERT(VARCHAR, Datename(month, Getdate())))                 + ' del ' + CONVERT(VARCHAR, Year(Getdate()))                 + ', a las '                 + CONVERT(VARCHAR, Datepart(hour, Getdate()))                 + 'H'                 + CONVERT(VARCHAR, Datepart(minute, Getdate())) ) AS FECHA_TEXTO,               Concat(:consecutivo, '-', Year(Getdate()))          AS numero_consecutivo,               (SELECT img.numero_imagen                FROM   imagen img (nolock)                WHERE  img.id_tipo_imagen = 1                       AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)                               AND img.fecha_fin >=                                   CONVERT(DATE, c.fecha_registro) )                              OR ( img.fecha_inicio <=                                   CONVERT(DATE, c.fecha_registro)                                   AND img.fecha_fin IS NULL ) ))  AS LogoATM_variable,               funcCur.memo_nombramiento                           AS MEMO_DELEGADO,               ( CONVERT(VARCHAR, Day(funcCur.fecha_nombramiento))                 + ' de ' ) + Lower(CONVERT(VARCHAR,                                    Datename(month, funcCur.fecha_nombramiento)))               + ' de ' +               CONVERT(VARCHAR, Year(funcCur.fecha_nombramiento))  AS FECHA_DELEGADO,               ( CASE inf.id_tipo_identificacion                   WHEN 2 THEN pju.nombre_comercial                   ELSE ( Isnull(inf.nombre1, '') + ' '                          + Isnull(inf.nombre2, '') + ' '                          + Isnull(inf.apellido1, '') + ' '                          + Isnull(inf.apellido2, '') )                 END )                                             AS NOMBRE_INFRACTOR,               inf.numero_identificacion                           AS N_DOCUMENTO_INFRACTOR,               co.numero_citacion                                  AS numero_citacion,       co.fecha_infraccion                                 AS F_IMPOSICION_COMPARENDO,               (SELECT Isnull(f.titulo_obtenido, '') + ' '                       + Isnull(p.nombre1, '') + ' '                       + Isnull(p.nombre2, '') + ' '                       + Isnull(p.apellido1, '') + ' '                       + Isnull(p.apellido2, '')                FROM   persona p WITH(nolock)                       LEFT JOIN funcionario f WITH(nolock)                              ON f.id_persona = p.id_persona                WHERE  f.id_cargo = 11                       AND fecha_final_vigencia IS NULL)           AS NOMBRE_DIRECTOR_INFRACCIONES      ,(SELECT Max(fi.numero_imagen)                FROM   firma_persona fi WITH(nolock)                       inner JOIN persona p WITH(nolock)                              ON fi.id_persona = p.id_persona                       inner JOIN funcionario f                              ON f.id_persona = p.id_persona       inner join funcionario_curso func         on func.id_funcionario=f.id_funcionario                WHERE  func.fecha_final_vigencia IS NULL)           AS IMAGEN_FIRMA               ,(SELECT top 1 Isnull(pfsec.nombre1, '') + ' '               + Isnull(pfsec.nombre2, '') + ' '               + Isnull(pfsec.apellido1, '') + ' '               + Isnull(pfsec.apellido2, '')        FROM PERSONA pfsec inner join funcionario f on      pfsec.id_persona= f.id_persona       where f.id_cargo =4 and f.fecha_final_vigencia is null       and f.id_funcionario in (91,148,150,160,169,173,176,181) order by newid())        AS NOMBRE_SECRETARIO      ,(SELECT top 1 Isnull(f.titulo_obtenido, '') + ' '                       + Isnull(p.nombre1, '') + ' '                       + Isnull(p.nombre2, '') + ' '                       + Isnull(p.apellido1, '') + ' '                       + Isnull(p.apellido2, '')                FROM   persona p WITH(nolock)                       inner JOIN funcionario f WITH(nolock)                              ON f.id_persona = p.id_persona       inner join funcionario_curso func        on func.id_funcionario = f.id_funcionario                WHERE func.fecha_final_vigencia IS NULL)   as NOMBRE_DELEGADO  FROM   curso c WITH(nolock)         LEFT JOIN persona inf WITH(nolock)                ON inf.id_persona = c.id_persona         LEFT JOIN persona_juridica pju WITH(nolock)                ON inf.id_persona = pju.id_persona_juridica         LEFT JOIN funcionario_curso funcCur                ON funcCur.fecha_final_vigencia IS NULL                   AND funcCur.id_subcargo = 2         LEFT JOIN funcionario func WITH(nolock)                ON func.id_funcionario = funcCur.id_funcionario         LEFT JOIN comparendo co WITH(nolock)                ON c.id_factura_axis = co.id_factura_axis         LEFT JOIN documento_curso dc WITH(nolock)                ON dc.id_curso = c.id_curso         LEFT JOIN secretario_curso_historico sch WITH(nolock)                ON sch.id_documento_curso = dc.id_documento_curso         LEFT JOIN funcionario fsec WITH(nolock)                ON fsec.id_funcionario = sch.id_funcionario         LEFT JOIN persona pfsec WITH(nolock)                ON pfsec.id_persona = fsec.id_persona  WHERE  c.id_curso = :idCurso         AND dc.id_documento_curso = :idDocumentoCurso
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------






--Variables de plantillas

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2290'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2232, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

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


--RESOL_CULMI_VIRTU
--http://10.6.30.176:8080/ComparendoWEB/rest/generarResolucionVirtual
--POSTMAN

--{
--    "estadoCurso": 3,
--    "consecutivo": null,
--    "idFacturaAxis": 13200134
--}