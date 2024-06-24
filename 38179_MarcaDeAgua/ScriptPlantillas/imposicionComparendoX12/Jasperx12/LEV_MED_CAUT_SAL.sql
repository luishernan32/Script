--LEV_MED_CAUT_SAL 10127 2284 

SET     Language 'Spanish';  select     top 1 (SELECT UPPER(nombre) from entidad_bien where id_entidad_bien = :banco) as banco,     (      select         top 1 isnull(seg.consecutivo_oficio, '')       from         seguimiento_motivo_levantamiento seg       where         seg.id_proceso = p.id_proceso       order by         seg.fecha_registro desc    ) as numero_consecutivo,     CONCAT(      p.numero_proceso,       '-',       DATEPART(yy, p.fecha_inicio)    ) as numeroJuicio,     CONVERT(      VARCHAR,       DAY(        getdate()      )    ) + ' de ' + CONVERT(      VARCHAR,       DATENAME(        MONTH,         GETDATE()      )    ) + ' del ' + CONVERT(      VARCHAR,       YEAR(        GETDATE()      )    ) as FECHA_TEXTO,     CONCAT(      CONVERT(        VARCHAR,         DATEPART(          hour,           getdate()        )      ),       ':',       CONVERT(        VARCHAR,         CASE WHEN DATEPART(          minute,           getdate()        ) > 10 THEN CONVERT(          VARCHAR,           DATEPART(            minute,             getdate()          )        ) ELSE CONCAT(          '0',           CONVERT(            VARCHAR,             DATEPART(              minute,               getdate()            )          )        ) END      )    ) as hora,     case per.id_tipo_identificacion when 2 then UPPER(perj.nombre_comercial) else UPPER(      CONCAT(        per.nombre1, ' ', per.nombre2, ' ',         per.apellido1, ' ', per.apellido2      )    ) end as nombre,     per.numero_identificacion as 'Numero identificacion',         (      select         top 1 isnull(f.titulo_obtenido, 'Abg.') + Upper(          Concat(            ' ', p.nombre1, ' ', p.nombre2, '  ',             p.apellido1, ' ', p.apellido2          )        )       from         funcionario f         inner join firma_persona fp on fp.id_persona = f.id_persona         inner join persona p on p.id_persona = f.id_persona       WHERE         f.id_subcargo = 3    ) as abogAsignado,     (      select         top 1 isnull(f.titulo_obtenido, 'Abg.') + Upper(          Concat(            ' ', p.nombre1, ' ', p.nombre2, '  ',             p.apellido1, ' ', p.apellido2          )        )       from         funcionario f         inner join firma_persona fp on fp.id_persona = f.id_persona         inner join persona p on p.id_persona = f.id_persona       WHERE         f.id_cargo = 1         and f.fecha_final_vigencia is null    ) as abogado,     (      select         top 1           referencia_envio      from         envio_doc_impresion_embargo as env         INNER JOIN seguimiento_motivo_levantamiento seg on seg.id_seg_doc_impresion_embargo = env.id_seg_doc_impresion_embargo       where         seg.id_proceso = p.id_proceso       order by    env.id_envio_doc_impresion_embargo desc,         seg.fecha_registro desc    ) as numeroTramite,     (      select         top 1 fp.numero_imagen       from         funcionario f         inner join firma_persona fp on fp.id_persona = f.id_persona         inner join persona p on p.id_persona = f.id_persona       WHERE         f.id_subcargo = 3    ) as firmaAbogado,     (      select         top 1 fp.numero_imagen       from         funcionario f         inner join firma_persona fp on fp.id_persona = f.id_persona         inner join persona p on p.id_persona = f.id_persona       WHERE         f.id_cargo = 1         and f.fecha_final_vigencia is null    ) as firmaAbogado1,     segmt.idCodigoQR as codigoQR,     (      select         numero_imagen       from         imagen       where         id_tipo_imagen in(          SELECT             id_tipo_imagen           FROM             tipo_imagen           WHERE             codigo = 'LOGGO'        )         AND fecha_fin is null    ) logoATM,    ic.cuenta as 'Nro_cuenta'  from     coactivo co     inner join coactivo_proceso cop on cop.id_coactivo = co.id_coactivo    inner join impulso_coactivo ic on co.id_coactivo = ic.id_coactivo    inner join proceso p on p.id_proceso = cop.id_proceso     inner join trazabilidad_proceso tr on tr.id_proceso = p.id_proceso     and tr.id_estado_proceso in(29, 36, 37, 45, 52, 56, 27)     inner join persona per on per.id_persona = co.id_deudor     inner join tipo_identificacion_persona tpid on tpid.id_tipo_identificacion = per.id_tipo_identificacion     left join persona_juridica perj on perj.id_persona_juridica = co.id_deudor     inner join estado_proceso estp on estp.id_estado_proceso = p.id_estado_proceso     left join seguimiento_motivo_levantamiento segmt on segmt.id_proceso = p.id_proceso   where     year(p.fecha_inicio) = :anio    and p.numero_proceso = :numeroProceso
--BANCO,numero_consecutivo,NUMERO_JUICIO,FECHA_TEXTO,HORA,NOMBRE_COMPLETO,N_DOCUMENTO_INFRACTOR,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_TRAMITE,FIRMA_FUNCIONARIO_,FIRMA_AGENTE,CODIGO_QR,LogoATM_variable,NRO_CUENTA


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS




--LEV_MED_CAUT_SAL 10127 2284
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language ''Spanish'';

SELECT TOP 1 (SELECT Upper(nombre)
              FROM   entidad_bien
              WHERE  id_entidad_bien = :banco)                           AS
             banco,
             (SELECT TOP 1 Isnull(seg.consecutivo_oficio, '''')
              FROM   seguimiento_motivo_levantamiento seg
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY seg.fecha_registro DESC)                         AS
             numero_consecutivo,
             Concat(p.numero_proceso, ''-'', Datepart(yy, p.fecha_inicio)) AS
             numeroJuicio,
             CONVERT( VARCHAR, Day( Getdate() ) ) + '' de ''
             + CONVERT( VARCHAR, Datename( month, Getdate() ) )
             + '' del '' + CONVERT( VARCHAR, Year( Getdate() ) )           AS
             FECHA_TEXTO,
             Concat(CONVERT(VARCHAR, Datepart(hour, Getdate())), '':'',
             CONVERT(VARCHAR, CASE
                                WHEN Datepart(minute, Getdate()) > 10 THEN
                                CONVERT(VARCHAR, Datepart(minute,
                                                 Getdate()))
                                ELSE Concat(''0'', CONVERT(VARCHAR, Datepart(
                                                 minute, Getdate())
                                                 ))
                              END))                                      AS hora
             ,
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(Concat(per.nombre1, '' '', per.nombre2, '' '',
                          per.apellido1, '' '',
                                 per.apellido2))
             END                                                         AS
             nombre,
             per.numero_identificacion                                   AS
             ''Numero identificacion'',
             (SELECT TOP 1 Isnull(f.titulo_obtenido, ''Abg.'')
                           + Upper( Concat( '' '', p.nombre1, '' '', p.nombre2, ''  ''
                           ,
                           p.apellido1, '' '',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             abogAsignado,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, ''Abg.'')
                           + Upper( Concat( '' '', p.nombre1, '' '', p.nombre2, ''  ''
                           ,
                           p.apellido1, '' '',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             abogado,
             (SELECT TOP 1 referencia_envio
              FROM   envio_doc_impresion_embargo AS env
                     INNER JOIN seguimiento_motivo_levantamiento seg
                             ON seg.id_seg_doc_impresion_embargo =
                                env.id_seg_doc_impresion_embargo
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY env.id_envio_doc_impresion_embargo DESC,
                        seg.fecha_registro DESC)                         AS
             numeroTramite,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             firmaAbogado,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             firmaAbogado1,
             segmt.idcodigoqr                                            AS
             codigoQR,
             (SELECT numero_imagen
              FROM   imagen
              WHERE  id_tipo_imagen IN(SELECT id_tipo_imagen
                                       FROM   tipo_imagen
                                       WHERE  codigo = ''LOGGO'')
                     AND fecha_fin IS NULL)                              logoATM
             ,
             ic.cuenta
             AS ''Nro_cuenta''

			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo co
       INNER JOIN coactivo_proceso cop
               ON cop.id_coactivo = co.id_coactivo
       INNER JOIN impulso_coactivo ic
               ON co.id_coactivo = ic.id_coactivo
       INNER JOIN proceso p
               ON p.id_proceso = cop.id_proceso
       INNER JOIN trazabilidad_proceso tr
               ON tr.id_proceso = p.id_proceso
                  AND tr.id_estado_proceso IN( 29, 36, 37, 45,
                                               52, 56, 27 )
       INNER JOIN persona per
               ON per.id_persona = co.id_deudor
       INNER JOIN tipo_identificacion_persona tpid
               ON tpid.id_tipo_identificacion = per.id_tipo_identificacion
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = co.id_deudor
       INNER JOIN estado_proceso estp
               ON estp.id_estado_proceso = p.id_estado_proceso
       LEFT JOIN seguimiento_motivo_levantamiento segmt
              ON segmt.id_proceso = p.id_proceso
WHERE  Year(p.fecha_inicio) = :anio
       AND p.numero_proceso = :numeroProceso '               
	   , orden_variables='BANCO,numero_consecutivo,NUMERO_JUICIO,FECHA_TEXTO,HORA,NOMBRE_COMPLETO,N_DOCUMENTO_INFRACTOR,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_TRAMITE,FIRMA_FUNCIONARIO_,FIRMA_AGENTE,CODIGO_QR,LogoATM_variable,NRO_CUENTA,TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10127 

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'LEV_MED_CAUT_SAL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)


-----------------------------------------------------
--order variables: BANCO,numero_consecutivo,NUMERO_JUICIO,FECHA_TEXTO,HORA,NOMBRE_COMPLETO,N_DOCUMENTO_INFRACTOR,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_TRAMITE,FIRMA_FUNCIONARIO_,FIRMA_AGENTE,CODIGO_QR,LogoATM_variable,NRO_CUENTA

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2287'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2284, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from documentos..variable_plantilla
where id_plantilla='2258'


-------------------------------------------------------------------------------------

-----------------------------------------------------
--

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2287'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2258, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from documentos..variable_plantilla
where id_plantilla='2258'


-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
--Modificada

SET language 'Spanish';

SELECT TOP 1 (SELECT Upper(nombre)
              FROM   entidad_bien
              WHERE  id_entidad_bien = :banco)                           AS
             banco,
             (SELECT TOP 1 Isnull(seg.consecutivo_oficio, '')
              FROM   seguimiento_motivo_levantamiento seg
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY seg.fecha_registro DESC)                         AS
             numero_consecutivo,
             Concat(p.numero_proceso, '-', Datepart(yy, p.fecha_inicio)) AS
             numeroJuicio,
             CONVERT( VARCHAR, Day( Getdate() ) ) + ' de '
             + CONVERT( VARCHAR, Datename( month, Getdate() ) )
             + ' del ' + CONVERT( VARCHAR, Year( Getdate() ) )           AS
             FECHA_TEXTO,
             Concat(CONVERT(VARCHAR, Datepart(hour, Getdate())), ':',
             CONVERT(VARCHAR, CASE
                                WHEN Datepart(minute, Getdate()) > 10 THEN
                                CONVERT(VARCHAR, Datepart(minute,
                                                 Getdate()))
                                ELSE Concat('0', CONVERT(VARCHAR, Datepart(
                                                 minute, Getdate())
                                                 ))
                              END))                                      AS hora
             ,
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(Concat(per.nombre1, ' ', per.nombre2, ' ',
                          per.apellido1, ' ',
                                 per.apellido2))
             END                                                         AS
             nombre,
             per.numero_identificacion                                   AS
             'Numero identificacion',
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             abogAsignado,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             abogado,
             (SELECT TOP 1 referencia_envio
              FROM   envio_doc_impresion_embargo AS env
                     INNER JOIN seguimiento_motivo_levantamiento seg
                             ON seg.id_seg_doc_impresion_embargo =
                                env.id_seg_doc_impresion_embargo
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY env.id_envio_doc_impresion_embargo DESC,
                        seg.fecha_registro DESC)                         AS
             numeroTramite,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             firmaAbogado,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             firmaAbogado1,
             segmt.idcodigoqr                                            AS
             codigoQR,
             (SELECT numero_imagen
              FROM   imagen
              WHERE  id_tipo_imagen IN(SELECT id_tipo_imagen
                                       FROM   tipo_imagen
                                       WHERE  codigo = 'LOGGO')
                     AND fecha_fin IS NULL)                              logoATM
             ,
             ic.cuenta
             AS 'Nro_cuenta'

			 ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo co
       INNER JOIN coactivo_proceso cop
               ON cop.id_coactivo = co.id_coactivo
       INNER JOIN impulso_coactivo ic
               ON co.id_coactivo = ic.id_coactivo
       INNER JOIN proceso p
               ON p.id_proceso = cop.id_proceso
       INNER JOIN trazabilidad_proceso tr
               ON tr.id_proceso = p.id_proceso
                  AND tr.id_estado_proceso IN( 29, 36, 37, 45,
                                               52, 56, 27 )
       INNER JOIN persona per
               ON per.id_persona = co.id_deudor
       INNER JOIN tipo_identificacion_persona tpid
               ON tpid.id_tipo_identificacion = per.id_tipo_identificacion
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = co.id_deudor
       INNER JOIN estado_proceso estp
               ON estp.id_estado_proceso = p.id_estado_proceso
       LEFT JOIN seguimiento_motivo_levantamiento segmt
              ON segmt.id_proceso = p.id_proceso
WHERE  Year(p.fecha_inicio) = :anio
       AND p.numero_proceso = :numeroProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SET language 'Spanish';

SELECT TOP 1 (SELECT Upper(nombre)
              FROM   entidad_bien
              WHERE  id_entidad_bien = :banco)                           AS
             banco,
             (SELECT TOP 1 Isnull(seg.consecutivo_oficio, '')
              FROM   seguimiento_motivo_levantamiento seg
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY seg.fecha_registro DESC)                         AS
             numero_consecutivo,
             Concat(p.numero_proceso, '-', Datepart(yy, p.fecha_inicio)) AS
             numeroJuicio,
             CONVERT( VARCHAR, Day( Getdate() ) ) + ' de '
             + CONVERT( VARCHAR, Datename( month, Getdate() ) )
             + ' del ' + CONVERT( VARCHAR, Year( Getdate() ) )           AS
             FECHA_TEXTO,
             Concat(CONVERT(VARCHAR, Datepart(hour, Getdate())), ':',
             CONVERT(VARCHAR, CASE
                                WHEN Datepart(minute, Getdate()) > 10 THEN
                                CONVERT(VARCHAR, Datepart(minute,
                                                 Getdate()))
                                ELSE Concat('0', CONVERT(VARCHAR, Datepart(
                                                 minute, Getdate())
                                                 ))
                              END))                                      AS hora
             ,
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(Concat(per.nombre1, ' ', per.nombre2, ' ',
                          per.apellido1, ' ',
                                 per.apellido2))
             END                                                         AS
             nombre,
             per.numero_identificacion                                   AS
             'Numero identificacion',
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             abogAsignado,
             (SELECT TOP 1 Isnull(f.titulo_obtenido, 'Abg.')
                           + Upper( Concat( ' ', p.nombre1, ' ', p.nombre2, '  '
                           ,
                           p.apellido1, ' ',
                           p.apellido2 ) )
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             abogado,
             (SELECT TOP 1 referencia_envio
              FROM   envio_doc_impresion_embargo AS env
                     INNER JOIN seguimiento_motivo_levantamiento seg
                             ON seg.id_seg_doc_impresion_embargo =
                                env.id_seg_doc_impresion_embargo
              WHERE  seg.id_proceso = p.id_proceso
              ORDER  BY env.id_envio_doc_impresion_embargo DESC,
                        seg.fecha_registro DESC)                         AS
             numeroTramite,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)                                  AS
             firmaAbogado,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_cargo = 1
                     AND f.fecha_final_vigencia IS NULL)                 AS
             firmaAbogado1,
             segmt.idcodigoqr                                            AS
             codigoQR,
             (SELECT numero_imagen
              FROM   imagen
              WHERE  id_tipo_imagen IN(SELECT id_tipo_imagen
                                       FROM   tipo_imagen
                                       WHERE  codigo = 'LOGGO')
                     AND fecha_fin IS NULL)                              logoATM
             ,
             ic.cuenta
             AS 'Nro_cuenta'
FROM   coactivo co
       INNER JOIN coactivo_proceso cop
               ON cop.id_coactivo = co.id_coactivo
       INNER JOIN impulso_coactivo ic
               ON co.id_coactivo = ic.id_coactivo
       INNER JOIN proceso p
               ON p.id_proceso = cop.id_proceso
       INNER JOIN trazabilidad_proceso tr
               ON tr.id_proceso = p.id_proceso
                  AND tr.id_estado_proceso IN( 29, 36, 37, 45,
                                               52, 56, 27 )
       INNER JOIN persona per
               ON per.id_persona = co.id_deudor
       INNER JOIN tipo_identificacion_persona tpid
               ON tpid.id_tipo_identificacion = per.id_tipo_identificacion
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = co.id_deudor
       INNER JOIN estado_proceso estp
               ON estp.id_estado_proceso = p.id_estado_proceso
       LEFT JOIN seguimiento_motivo_levantamiento segmt
              ON segmt.id_proceso = p.id_proceso
WHERE  Year(p.fecha_inicio) = :anio
       AND p.numero_proceso = :numeroProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------