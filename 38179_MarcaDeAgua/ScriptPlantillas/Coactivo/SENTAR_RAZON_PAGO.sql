--SENTAR_RAZON_PAGO 2617 83 --SENTAR_RAZON_PAGO


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language ''Spanish'';

SELECT Concat(P.numero_proceso, ''-'', Year(P.fecha_inicio)) numero_coactivo,
       Dateadd(day, -2, Getdate())                         AS fecha_actual,
       Dateadd(day, -2, Getdate())                         AS hora_actual,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                 AS nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       p.fecha_inicio                                      AS fechaGeneracion,
       cob.valor_proyectado                                AS valor_total,
       cob.valor_proyectado                                AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = pe.id_persona
                          AND fun.id_funcionario = 24)     AS firma,
       Upper(Concat(pfs.nombre1, '' '', pfs.nombre2, '' '', pfs.apellido1, '' '',
             pfs.apellido2))                               NOMBRE_SECRETARIO,
       (SELECT TOP 1 Upper(Concat(f.titulo_obtenido, '' '', p.nombre1, '' '',
                           p.nombre2,
                           '' '',
                                         p.apellido1, '' '',
                                               p.apellido2))
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = ''VIGENTE''
        ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario
       ,
       (SELECT TOP 1 fm.numero_imagen
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = ''VIGENTE''
        ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = ''VIGENTE'')                   AS nombre_abogado,
       (SELECT TOP 1 f.memo_nombramiento
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = ''VIGENTE''
        ORDER  BY fm.fecha_registro DESC)                  AS memo_abogado,
       (SELECT TOP 1 ( CONVERT(VARCHAR, Day(f.fecha_nombramiento))
                       + '' de ''
                       + CONVERT(VARCHAR, Datename(month, f.fecha_nombramiento))
                       + '' de ''
                       + CONVERT(VARCHAR, Year(f.fecha_nombramiento)) ) AS
                     fecha_nombramiento
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = ''VIGENTE''
        ORDER  BY fm.fecha_registro DESC)                  AS fecha_abogado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441)                     AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                     AS
       cargo_delegado_ejecutor,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                     AS TITULO_PLANTILLAS
FROM   oficio_bien ob (nolock)
       JOIN coactivo_oficio_bien cob (nolock)
         ON cob.id_oficio_bien = ob.id_oficio_bien
       JOIN coactivo c (nolock)
         ON c.id_coactivo = cob.id_coactivo
       JOIN proceso p (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN solicitud_bien_entidad sbe (nolock)
         ON sbe.id_oficio_bien = ob.id_oficio_bien
       JOIN configuracion_entidad ce (nolock)
         ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad
       JOIN entidad_oficio e (nolock)
         ON e.id_entidad_oficio = ce.id_entidad_oficio
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN funcionario fs (nolock)
              ON fs.id_funcionario = cob.id_funcionario_secah
       LEFT JOIN persona pfs (nolock)
              ON pfs.id_persona = fs.id_persona
WHERE  ob.id_oficio_bien= :idSolicitud '               
	   , orden_variables='NUMERO_PROCESO,FECHA_SOLICITUD,hora_actual,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,FECHA_GENERACION,VALOR_SALDO,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA,NOMBRE_SECRETARIO,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,MEMO_DELEGADO,FECHA_DELEGADO,CARGO_DELEGADO,PROFESION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=83

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'SENTAR_RAZON_PAGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------

SET language 'Spanish';

SELECT Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,
       Dateadd(day, -2, Getdate())                         AS fecha_actual,
       Dateadd(day, -2, Getdate())                         AS hora_actual,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                                 AS nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       p.fecha_inicio                                      AS fechaGeneracion,
       cob.valor_proyectado                                AS valor_total,
       cob.valor_proyectado                                AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = pe.id_persona
                          AND fun.id_funcionario = 24)     AS firma,
       Upper(Concat(pfs.nombre1, ' ', pfs.nombre2, ' ', pfs.apellido1, ' ',
             pfs.apellido2))                               NOMBRE_SECRETARIO,
       (SELECT TOP 1 Upper(Concat(f.titulo_obtenido, ' ', p.nombre1, ' ',
                           p.nombre2,
                           ' ',
                                         p.apellido1, ' ',
                                               p.apellido2))
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = 'VIGENTE'
        ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario
       ,
       (SELECT TOP 1 fm.numero_imagen
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = 'VIGENTE'
        ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,
       (SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = 'VIGENTE')                   AS nombre_abogado,
       (SELECT TOP 1 f.memo_nombramiento
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = 'VIGENTE'
        ORDER  BY fm.fecha_registro DESC)                  AS memo_abogado,
       (SELECT TOP 1 ( CONVERT(VARCHAR, Day(f.fecha_nombramiento))
                       + ' de '
                       + CONVERT(VARCHAR, Datename(month, f.fecha_nombramiento))
                       + ' de '
                       + CONVERT(VARCHAR, Year(f.fecha_nombramiento)) ) AS
                     fecha_nombramiento
        FROM   funcionario f
               INNER JOIN persona p
                       ON p.id_persona = f.id_persona
               INNER JOIN cargo c
                       ON c.id_cargo = f.id_cargo
               LEFT JOIN firma_persona fm
                      ON fm.id_persona = p.id_persona
        WHERE  c.id_cargo = 1
               AND f.estado = 'VIGENTE'
        ORDER  BY fm.fecha_registro DESC)                  AS fecha_abogado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441)                     AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                     AS
       cargo_delegado_ejecutor
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   oficio_bien ob (nolock)
       JOIN coactivo_oficio_bien cob (nolock)
         ON cob.id_oficio_bien = ob.id_oficio_bien
       JOIN coactivo c (nolock)
         ON c.id_coactivo = cob.id_coactivo
       JOIN proceso p (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN solicitud_bien_entidad sbe (nolock)
         ON sbe.id_oficio_bien = ob.id_oficio_bien
       JOIN configuracion_entidad ce (nolock)
         ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad
       JOIN entidad_oficio e (nolock)
         ON e.id_entidad_oficio = ce.id_entidad_oficio
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN funcionario fs (nolock)
              ON fs.id_funcionario = cob.id_funcionario_secah
       LEFT JOIN persona pfs (nolock)
              ON pfs.id_persona = fs.id_persona
WHERE  ob.id_oficio_bien is not null 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SET language 'Spanish';    SELECT Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,         Dateadd(day, -2, Getdate())                         AS fecha_actual,         Dateadd(day, -2, Getdate())                         AS hora_actual,         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper (pj.nombre_comercial)           ELSE  Upper(         Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))         END                                                 AS nombreCompleto,         tip.codigo,         pe.numero_identificacion,         p.fecha_inicio                                      AS fechaGeneracion,         cob.valor_proyectado                                AS valor_total,         cob.valor_proyectado                                AS valor_total_letras         ,         (SELECT Max(fp.numero_imagen)          FROM   funcionario fun (nolock)                 INNER JOIN firma_persona fp (nolock)                         ON fp.id_persona = pe.id_persona                            AND fun.id_funcionario = 24)     AS firma,         Upper(  Concat(pfs.nombre1, ' ', pfs.nombre2, ' ', pfs.apellido1, ' ', pfs.apellido2))                                                      NOMBRE_SECRETARIO,  (SELECT TOP 1  Upper(  Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))   FROM   funcionario f          INNER JOIN persona p                  ON p.id_persona = f.id_persona          INNER JOIN cargo c                  ON c.id_cargo = f.id_cargo          LEFT JOIN firma_persona fm                 ON fm.id_persona = p.id_persona   WHERE  c.id_cargo = 1          AND f.estado = 'VIGENTE'   ORDER  BY fm.fecha_registro DESC)                  AS nombre_funcionario,  (SELECT TOP 1 fm.numero_imagen   FROM   funcionario f          INNER JOIN persona p                  ON p.id_persona = f.id_persona          INNER JOIN cargo c                  ON c.id_cargo = f.id_cargo          LEFT JOIN firma_persona fm                 ON fm.id_persona = p.id_persona   WHERE  c.id_cargo = 1          AND f.estado = 'VIGENTE'   ORDER  BY fm.fecha_registro DESC)                  firma_funcionario,         (SELECT Concat(f.titulo_obtenido, ' ', Upper(                 Concat(per.nombre1, ' ', per.nombre2, ' ',                         per.apellido1, ' ',                 per.apellido2)))          FROM   funcionario f (nolock)                 INNER JOIN persona per (nolock)                         ON f.id_persona = per.id_persona          WHERE  f.id_cargo = 11                 AND f.estado = 'VIGENTE') AS nombre_abogado,  (SELECT TOP 1 f.memo_nombramiento   FROM   funcionario f          INNER JOIN persona p                  ON p.id_persona = f.id_persona          INNER JOIN cargo c                  ON c.id_cargo = f.id_cargo          LEFT JOIN firma_persona fm                 ON fm.id_persona = p.id_persona   WHERE  c.id_cargo = 1          AND f.estado = 'VIGENTE'   ORDER  BY fm.fecha_registro DESC)                  AS memo_abogado,  (SELECT TOP 1 ( CONVERT(VARCHAR, Day(f.fecha_nombramiento))                  + ' de '                  + CONVERT(VARCHAR, Datename(month, f.fecha_nombramiento))                  + ' de '                  + CONVERT(VARCHAR, Year(f.fecha_nombramiento)) ) AS                fecha_nombramiento   FROM   funcionario f          INNER JOIN persona p                  ON p.id_persona = f.id_persona          INNER JOIN cargo c                  ON c.id_cargo = f.id_cargo          LEFT JOIN firma_persona fm                 ON fm.id_persona = p.id_persona   WHERE  c.id_cargo = 1          AND f.estado = 'VIGENTE'   ORDER  BY fm.fecha_registro DESC)                  AS fecha_abogado,    (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=434) as cargo_delegado,    (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=437) as cargo_delegado_ejecutor  FROM   oficio_bien ob (nolock)         JOIN coactivo_oficio_bien cob (nolock)           ON cob.id_oficio_bien = ob.id_oficio_bien         JOIN coactivo c (nolock)           ON c.id_coactivo = cob.id_coactivo         JOIN proceso p (nolock)           ON c.id_proceso = p.id_proceso         JOIN solicitud_bien_entidad sbe (nolock)           ON sbe.id_oficio_bien = ob.id_oficio_bien         JOIN configuracion_entidad ce (nolock)           ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad         JOIN entidad_oficio e (nolock)           ON e.id_entidad_oficio = ce.id_entidad_oficio         JOIN persona pe (nolock)           ON pe.id_persona = c.id_deudor         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pe.id_persona         JOIN tipo_identificacion_persona tip (nolock)           ON tip.id_tipo_identificacion = pe.id_tipo_identificacion         LEFT JOIN funcionario fs (nolock)                ON fs.id_funcionario = cob.id_funcionario_secah         LEFT JOIN persona pfs (nolock)                ON pfs.id_persona = fs.id_persona  WHERE  ob.id_oficio_bien is not null
-------------------------------------------------------------------------------------
--NUMERO_PROCESO,FECHA_SOLICITUD,hora_actual,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,FECHA_GENERACION,VALOR_SALDO,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA,NOMBRE_SECRETARIO,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,MEMO_DELEGADO,FECHA_DELEGADO,CARGO_DELEGADO,PROFESION,TITULO_PLANTILLAS
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------