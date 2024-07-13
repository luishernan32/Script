--ORDEN_EMBARGO 2624 72

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT pro.numero_proceso + ''-''
       + Try_convert(Varchar(4), c.anio)               numero_proceso,
       e.fecha_registro,
       e.fecha_registro                                AS hora_registro,
       CASE p2.id_tipo_identificacion
         WHEN 2 THEN Upper(perj.nombre_comercial)
         ELSE Upper(Concat(p2.nombre1, '' '', p2.nombre2, '' '', p2.apellido1, '' '',
                    p2.apellido2))
       END                                             deudor,
       ob.numero_oficio,
       eb.nombre                                       AS entidad_bien,
       emb.monto_retenido                              AS monto,
       emb.monto_retenido                              AS monto_letras,
       tb.nombre                                       AS tipo_bien,
       b.numero_referencia,
       Concat(Isnull(f.titulo_obtenido, '' ''), p.nombre1, '' '',
       Isnull(p.nombre2, ''''),
       '' '', p.apellido1, '' '', Isnull(p.apellido2, '''')) AS funcionario,
       p2.numero_identificacion,
       (SELECT TOP 1 com.numero_citacion
        FROM   comparendo com
               INNER JOIN comparendo_proceso comp
                       ON comp.cicomparendo = com.cicomparendo
        WHERE  comp.id_proceso = pro.id_proceso)       AS numero_citacion,
       p.numero_identificacion                         documento_funcionario,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 437)) )      AS
       cargo_delegado_mayusculas
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo c
       JOIN coactivo_oficio_bien cob
         ON c.id_coactivo = cob.id_coactivo
       JOIN oficio_bien ob
         ON ob.id_oficio_bien = cob.id_oficio_bien
       JOIN proceso pro
         ON c.id_proceso = pro.id_proceso
       JOIN bien b
         ON cob.id_bien = b.id_bien
       JOIN entidad_bien eb
         ON b.id_entidad_bien = eb.id_entidad_bien
       JOIN embargo e
         ON c.id_coactivo = e.id_coactivo
       JOIN persona p2
         ON c.id_deudor = p2.id_persona
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = c.id_deudor
       JOIN embargo_bien emb
         ON emb.id_embargo = e.id_embargo
            AND emb.id_bien = b.id_bien
       JOIN tipo_bien tb
         ON b.id_tipo_bien = tb.id_tipo_bien
       JOIN funcionario f
         ON e.id_funcionario = f.id_funcionario
       JOIN persona p
         ON f.id_persona = p.id_persona
       JOIN tipo_identificacion_persona tip
         ON p2.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo is not null
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) '               
	   , orden_variables='NUMERAL,FECHA_GENERACION, HORA_IMPOSICION_COMPARENDO, NOMBRE_INFRACTOR, NO_OFICIO,NOMBRE_BIEN,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,N_DOCUMENTO_INFRACTOR,numero_citacion,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=72

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ORDEN_EMBARGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------

SELECT pro.numero_proceso + '-'
       + Try_convert(Varchar(4), c.anio)               numero_proceso,
       e.fecha_registro,
       e.fecha_registro                                AS hora_registro,
       CASE p2.id_tipo_identificacion
         WHEN 2 THEN Upper(perj.nombre_comercial)
         ELSE Upper(Concat(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ',
                    p2.apellido2))
       END                                             deudor,
       ob.numero_oficio,
       eb.nombre                                       AS entidad_bien,
       emb.monto_retenido                              AS monto,
       emb.monto_retenido                              AS monto_letras,
       tb.nombre                                       AS tipo_bien,
       b.numero_referencia,
       Concat(Isnull(f.titulo_obtenido, ' '), p.nombre1, ' ',
       Isnull(p.nombre2, ''),
       ' ', p.apellido1, ' ', Isnull(p.apellido2, '')) AS funcionario,
       p2.numero_identificacion,
       (SELECT TOP 1 com.numero_citacion
        FROM   comparendo com
               INNER JOIN comparendo_proceso comp
                       ON comp.cicomparendo = com.cicomparendo
        WHERE  comp.id_proceso = pro.id_proceso)       AS numero_citacion,
       p.numero_identificacion                         documento_funcionario,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 437)) )      AS
       cargo_delegado_mayusculas
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo c
       JOIN coactivo_oficio_bien cob
         ON c.id_coactivo = cob.id_coactivo
       JOIN oficio_bien ob
         ON ob.id_oficio_bien = cob.id_oficio_bien
       JOIN proceso pro
         ON c.id_proceso = pro.id_proceso
       JOIN bien b
         ON cob.id_bien = b.id_bien
       JOIN entidad_bien eb
         ON b.id_entidad_bien = eb.id_entidad_bien
       JOIN embargo e
         ON c.id_coactivo = e.id_coactivo
       JOIN persona p2
         ON c.id_deudor = p2.id_persona
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = c.id_deudor
       JOIN embargo_bien emb
         ON emb.id_embargo = e.id_embargo
            AND emb.id_bien = b.id_bien
       JOIN tipo_bien tb
         ON b.id_tipo_bien = tb.id_tipo_bien
       JOIN funcionario f
         ON e.id_funcionario = f.id_funcionario
       JOIN persona p
         ON f.id_persona = p.id_persona
       JOIN tipo_identificacion_persona tip
         ON p2.id_tipo_identificacion = tip.id_tipo_identificacion
WHERE  c.id_coactivo is not null
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
--06-07-2024
SELECT    pro.numero_proceso + '-' + TRY_CONVERT(varchar(4), c.anio) numero_proceso,    e.fecha_registro,    e.fecha_registro AS hora_registro,    CASE p2.id_tipo_identificacion      WHEN 2 THEN UPPER(perj.nombre_comercial)      ELSE UPPER(CONCAT(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ', p2.apellido2))    END deudor,    ob.numero_oficio,    eb.nombre AS entidad_bien,    emb.monto_retenido AS monto,    emb.monto_retenido AS monto_letras,    tb.nombre AS tipo_bien,    b.numero_referencia,    CONCAT(ISNULL(f.titulo_obtenido, ' '), p.nombre1, ' ', ISNULL(p.nombre2, ''), ' ', p.apellido1, ' ', ISNULL(p.apellido2, '')) AS funcionario,    p2.numero_identificacion,    (SELECT TOP 1      com.numero_citacion    FROM comparendo com    INNER JOIN comparendo_proceso comp      ON comp.cicomparendo = com.cicomparendo    WHERE comp.id_proceso = pro.id_proceso)    AS numero_citacion,    p.numero_identificacion documento_funcionario,   (UPPER((SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 434))) AS cargo_delegado_mayusculas  FROM coactivo c  JOIN coactivo_oficio_bien cob    ON c.id_coactivo = cob.id_coactivo  JOIN oficio_bien ob    ON ob.id_oficio_bien = cob.id_oficio_bien  JOIN proceso pro    ON c.id_proceso = pro.id_proceso  JOIN bien b    ON cob.id_bien = b.id_bien  JOIN entidad_bien eb    ON b.id_entidad_bien = eb.id_entidad_bien  JOIN embargo e    ON c.id_coactivo = e.id_coactivo  JOIN persona p2    ON c.id_deudor = p2.id_persona  LEFT JOIN persona_juridica perj    ON perj.id_persona_juridica = c.id_deudor  JOIN embargo_bien emb    ON emb.id_embargo = e.id_embargo    AND emb.id_bien = b.id_bien  JOIN tipo_bien tb    ON b.id_tipo_bien = tb.id_tipo_bien  JOIN funcionario f    ON e.id_funcionario = f.id_funcionario  JOIN persona p    ON f.id_persona = p.id_persona  JOIN tipo_identificacion_persona tip    ON p2.id_tipo_identificacion = tip.id_tipo_identificacion  WHERE c.id_coactivo is not null  AND e.id_embargo = (SELECT    MAX(ee.id_embargo) id_embargo  FROM embargo ee  WHERE ee.id_coactivo = c.id_coactivo)
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------