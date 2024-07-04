--SENTAR_RAZON_CUMPLE 

SET Language 'Spanish';  select  proceso.expediente,    proceso.nombre_infractor,    proceso.doc,    proceso.tipoDoc,    delegado.nombre,    'SECRETARIA AD-HOC' as CARGO_DELEGADO,    (select im.numero_imagen from imagen im where im.id_tipo_imagen = 1 and fecha_fin is null) logoATM,    delegado.firmaAgente,    CONVERT(VARCHAR,DAY(getdate())) + ' de ' +       CONVERT(VARCHAR,DATENAME(MONTH, GETDATE())) + ' de ' +       CONVERT(VARCHAR,YEAR(GETDATE())) + '.' as fechaGeneracion  from   (      select pr.id_proceso,       convert(varchar,pr.numero_proceso) +' - '+ convert(varchar,year(pr.fecha_inicio)) as expediente,       CASE pe.id_tipo_identificacion WHEN '2' THEN pj.nombre_comercial ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2)) END as nombre_infractor,       pe.numero_identificacion doc,       tipoid.codigo tipoDoc    from  proceso pr (nolock) inner join      participante_proceso ppr (nolock) on ppr.id_proceso = pr.id_proceso left join      persona pe  (nolock) on pe.id_persona = ppr.id_persona left join      persona_juridica pj (nolock)                 ON pj.id_persona_juridica = pe.id_persona  left join      tipo_identificacion_persona tipoid on tipoid.id_tipo_identificacion = pe.id_tipo_identificacion          where pr.id_proceso = :idproceso  ) proceso ,  (  SELECT     top 1 fa.numero_imagen firmaAgente,    Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ', apellido2))  as nombre  FROM   PERSONA p (nolock) LEFT JOIN  firma_persona fa (nolock) on fa.id_persona = p.id_persona  WHERE    p.ID_PERSONA = (case when :idpersona = 1 then (select  TOP 1 ID_PERSONA from funcionario (nolock) where id_cargo = 4 and fecha_final_vigencia is null  ORDER BY NEWID() ) else :idpersona end)  order by fa.fecha_registro desc  ) delegado
--NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,N_DOCUMENTO_INFRACTOR,T_DOCUMENTO_INFRACTOR,DELEGADO_TITULONOMBRE_,CARGO_DELEGADO,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_GENERACION



,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS











--SENTAR_RAZON_CUMPLE 10113
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10113 

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'SENTAR_RAZON_CUMPLE';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

-------------------------------------------------------------------------------------
--Modificada

SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       proceso.doc,
       proceso.tipodoc,
       delegado.nombre,
       'SECRETARIA AD-HOC'            AS CARGO_DELEGADO,
       (SELECT im.numero_imagen
        FROM   imagen im
        WHERE  im.id_tipo_imagen = 1
               AND fecha_fin IS NULL) logoATM,
       delegado.firmaagente,
       CONVERT(VARCHAR, Day(Getdate())) + ' de '
       + CONVERT(VARCHAR, Datename(month, Getdate()))
       + ' de ' + CONVERT(VARCHAR, Year(Getdate()))
       + '.'                          AS fechaGeneracion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor,
               pe.numero_identificacion                  doc,
               tipoid.codigo                             tipoDoc
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
               LEFT JOIN tipo_identificacion_persona tipoid
                      ON tipoid.id_tipo_identificacion =
                         pe.id_tipo_identificacion
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p (nolock)
               LEFT JOIN firma_persona fa (nolock)
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona = ( CASE
                                  WHEN :idpersona = 1 THEN
                                  (SELECT TOP 1 id_persona
                                   FROM   funcionario (nolock)
                                   WHERE  id_cargo = 4
                                          AND fecha_final_vigencia IS
                                              NULL
                                   ORDER  BY Newid())
                                  ELSE :idpersona
                                END )
        ORDER  BY fa.fecha_registro DESC) delegado 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       proceso.doc,
       proceso.tipodoc,
       delegado.nombre,
       'SECRETARIA AD-HOC'            AS CARGO_DELEGADO,
       (SELECT im.numero_imagen
        FROM   imagen im
        WHERE  im.id_tipo_imagen = 1
               AND fecha_fin IS NULL) logoATM,
       delegado.firmaagente,
       CONVERT(VARCHAR, Day(Getdate())) + ' de '
       + CONVERT(VARCHAR, Datename(month, Getdate()))
       + ' de ' + CONVERT(VARCHAR, Year(Getdate()))
       + '.'                          AS fechaGeneracion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor,
               pe.numero_identificacion                  doc,
               tipoid.codigo                             tipoDoc
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
               LEFT JOIN tipo_identificacion_persona tipoid
                      ON tipoid.id_tipo_identificacion =
                         pe.id_tipo_identificacion
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p (nolock)
               LEFT JOIN firma_persona fa (nolock)
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona = ( CASE
                                  WHEN :idpersona = 1 THEN
                                  (SELECT TOP 1 id_persona
                                   FROM   funcionario (nolock)
                                   WHERE  id_cargo = 4
                                          AND fecha_final_vigencia IS
                                              NULL
                                   ORDER  BY Newid())
                                  ELSE :idpersona
                                END )
        ORDER  BY fa.fecha_registro DESC) delegado 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------