--SOLIC_IMPUGNACION  OK
SET Language 'Spanish';    select  proceso.expediente,      proceso.nombre_infractor,      (select CONCAT('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ', pf.apellido2)) )  as nombre   from funcionario f inner join firma_persona fp on fp.id_persona = f.id_persona  inner join persona pf on pf.id_persona= f.id_persona    WHERE f.id_cargo =11  and f.fecha_final_vigencia is null   ) as funcionario,      'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' as CARGO_DELEGADO,      delegado.nombre,      (select im.numero_imagen from imagen im where im.id_tipo_imagen = 1 and fecha_fin is null) logoATM,      delegado.firmaAgente,      CONVERT(VARCHAR,DAY(getdate())) + ' de ' +       CONVERT(VARCHAR,DATENAME(MONTH, GETDATE())) + ' de ' +       CONVERT(VARCHAR,YEAR(GETDATE())) + ', a las ' +       CONVERT(VARCHAR,DATEPART(hour, getdate())) + 'h' +       CONVERT(VARCHAR,DATEPART(minute, getdate())) as fechaSolicitud,        (SELECT top 1 mi.documento_faltante FROM trazabilidad_proceso trz INNER JOIN motivacion_impugnacion mi on mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso  WHERE trz.id_proceso= proceso.id_proceso order by fecha_inicio DESC) desc_motivacion    from   (      select pr.id_proceso,       convert(varchar,pr.numero_proceso) +' - '+ convert(varchar,year(pr.fecha_inicio)) as expediente,       CASE pe.id_tipo_identificacion WHEN '2' THEN pj.nombre_comercial ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2)) END as nombre_infractor    from  proceso pr (nolock) inner join      participante_proceso ppr (nolock) on ppr.id_proceso = pr.id_proceso left join      persona pe  (nolock) on pe.id_persona = ppr.id_persona left join      persona_juridica pj (nolock)                 ON pj.id_persona_juridica = pe.id_persona     where pr.id_proceso = :idproceso  ) proceso ,    (SELECT     top 1 fa.numero_imagen firmaAgente,       Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ', apellido2))  as nombre  FROM    PERSONA p LEFT JOIN   firma_persona fa on fa.id_persona = p.id_persona  WHERE p.ID_PERSONA IN (select  TOP 1 ID_PERSONA from funcionario where id_cargo = 6 and fecha_final_vigencia is null  ORDER BY NEWID() )  order by fa.fecha_registro desc  ) delegado
--NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS


update documentos..xml_plantilla
--SOLIC_IMPUGNACION 2237 *    12
set contenido_xml_plantilla=
where id_xml_plantilla=2237



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SOLIC_IMPUGNACION 10111 2237
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language ''Spanish'';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat(''Ab. '', Upper(Concat (pf.nombre1, '' '', pf.nombre2, '' '',
                                    pf.apellido1, '' ''
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN firma_persona fp
                       ON fp.id_persona = f.id_persona
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
''DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO'' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + '' de ''
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ '' de '' + CONVERT(VARCHAR, Year(Getdate()))
+ '', a las ''
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ ''h''
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + '' - ''
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN ''2'' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                            pe.apellido1, '' ''
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
			   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, '' '', nombre2, '' '', apellido1, '' '',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado '               
	   , orden_variables='NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion,TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10111

commit tran

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'SOLIC_IMPUGNACION';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

-------------------------------------------------------------------------------------
--Modificada
SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN firma_persona fp
                       ON fp.id_persona = f.id_persona
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
			   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN firma_persona fp
                       ON fp.id_persona = f.id_persona
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------