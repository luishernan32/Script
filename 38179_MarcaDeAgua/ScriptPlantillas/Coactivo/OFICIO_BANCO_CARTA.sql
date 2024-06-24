--OFICIO_BANCO_CARTA 59 2616

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat(P.numero_proceso, ''-'', Year(P.fecha_inicio)) numero_coactivo,
       ob.numero_oficio,
       e.nombre,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                 AS nombreCompleto,
       pe.numero_identificacion,
       Isnull(cob.valor_proyectado, 0)                     AS valor_total,
       Isnull(cob.valor_proyectado, 0)                     AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS FIRMA,
       (SELECT TOP 1 Concat(fun.titulo_obtenido, '' '', pf.nombre1, '' '',
                     pf.nombre2, '' '',
                     pf.apellido1,
                                   '' '', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS NOMBRE_DELEGADO,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                     AS cargo_delegado
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
WHERE  ob.id_oficio_bien = :idSolicitud '               
	   , orden_variables='NUMERO_EXPEDIENTE,numero_consecutivo,NOMBRE_ENTIDAD,NOMBRE_INFRACTOR,DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=59

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'OFICIO_BANCO_CARTA';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
SELECT Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,
       ob.numero_oficio,
       e.nombre,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                                 AS nombreCompleto,
       pe.numero_identificacion,
       Isnull(cob.valor_proyectado, 0)                     AS valor_total,
       Isnull(cob.valor_proyectado, 0)                     AS valor_total_letras
       ,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS FIRMA,
       (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS NOMBRE_DELEGADO,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437)                     AS cargo_delegado
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
WHERE  ob.id_oficio_bien = :idSolicitud 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT Concat(P.numero_proceso, '-', Year(P.fecha_inicio)) numero_coactivo,         ob.numero_oficio,         e.nombre,         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper (pj.nombre_comercial)           ELSE  Upper(         Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))         END                                                 AS nombreCompleto,         pe.numero_identificacion,         ISNULL(cob.valor_proyectado,0)                               AS valor_total,         ISNULL(cob.valor_proyectado ,0)                               AS valor_total_letras         ,         (SELECT Max(fp.numero_imagen)          FROM   funcionario fun (nolock)                 INNER JOIN firma_persona fp (nolock)                         ON fp.id_persona = fun.id_persona          WHERE  fun.id_cargo = 1                 AND fun.estado = 'Vigente')                 AS FIRMA,         (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',                       pf.nombre2, ' ',                       pf.apellido1,                                     ' ', pf.apellido2)          FROM   persona pf                 INNER JOIN funcionario fun                         ON pf.id_persona = fun.id_persona          WHERE  fun.id_cargo = 1                 AND fun.estado = 'Vigente')                 AS NOMBRE_DELEGADO,    (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=437) as cargo_delegado  FROM   oficio_bien ob (nolock)         JOIN coactivo_oficio_bien cob (nolock)           ON cob.id_oficio_bien = ob.id_oficio_bien         JOIN coactivo c (nolock)           ON c.id_coactivo = cob.id_coactivo         JOIN proceso p (nolock)           ON c.id_proceso = p.id_proceso         JOIN solicitud_bien_entidad sbe (nolock)           ON sbe.id_oficio_bien = ob.id_oficio_bien         JOIN configuracion_entidad ce (nolock)           ON ce.id_configuracion_entidad = sbe.id_configuracion_entidad         JOIN entidad_oficio e (nolock)           ON e.id_entidad_oficio = ce.id_entidad_oficio         JOIN persona pe (nolock)           ON pe.id_persona = c.id_deudor         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pe.id_persona         JOIN tipo_identificacion_persona tip (nolock)           ON tip.id_tipo_identificacion = pe.id_tipo_identificacion  WHERE  ob.id_oficio_bien = :idSolicitud
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------