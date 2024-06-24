--OFICIO_EMBARGO 2625 74


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables='FECHA_GENERACION,NO_OFICIO,NUMERAL,NOMBRE_BIEN,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO,PROFESION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10146xxx

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'OFICIO_EMBARGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT      e.fecha_registro,      ob.numero_oficio,      pro.numero_proceso+'-'+TRY_CONVERT(VARCHAR(4),c.anio) numero_proceso,     eb.nombre entidad_bien,   case p2.id_tipo_identificacion when 2 then UPPER(perj.nombre_comercial) else UPPER(CONCAT(p2.nombre1,' ',p2.nombre2,' ',p2.apellido1,' ', p2.apellido2))  END deudor,   tip.nombre tipo_identificacion,      p2.numero_identificacion,      emb.monto_retenido,       emb.monto_retenido AS monto_letras,      tb.nombre tipo_bien,      b.numero_referencia,      CONCAT(ISNULL(f.titulo_obtenido,' '), p.nombre1,' ',ISNULL(p.nombre2,''),' ',p.apellido1,' ',ISNULL(p.apellido2,'')) AS funcionario,       p.numero_identificacion identificacion_funcionario,   (SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 438) AS cargo_delegado,   (UPPER((SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 434))) AS cargo_delegado_mayusculas     FROM coactivo c   JOIN     coactivo_oficio_bien cob ON c.id_coactivo = cob.id_coactivo   JOIN     oficio_bien ob ON ob.id_oficio_bien = cob.id_oficio_bien   JOIN     proceso pro ON c.id_proceso = pro.id_proceso   JOIN     bien b ON cob.id_bien = b.id_bien   JOIN     entidad_bien eb ON b.id_entidad_bien = eb.id_entidad_bien   JOIN     embargo e ON c.id_coactivo = e.id_coactivo   JOIN persona p2 ON c.id_deudor = p2.id_persona  left join persona_juridica perj on perj.id_persona_juridica = c.id_deudor JOIN     embargo_bien emb ON emb.id_embargo = e.id_embargo   AND emb.id_bien = b.id_bien   JOIN     tipo_bien tb ON b.id_tipo_bien = tb.id_tipo_bien   JOIN     funcionario f ON e.id_funcionario = f.id_funcionario   JOIN     persona p ON f.id_persona = p.id_persona   JOIN     tipo_identificacion_persona tip ON     p2.id_tipo_identificacion = tip.id_tipo_identificacion       WHERE c.id_coactivo = :idCoactivo and e.id_embargo = (  select max(ee.id_embargo) id_embargo from embargo ee   where ee.id_coactivo = c.id_coactivo )
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


--Query para ver datos

SELECT e.fecha_registro,
       ob.numero_oficio,
       pro.numero_proceso + '-'
       + Try_convert(Varchar(4), c.anio)          numero_proceso,
       eb.nombre                                  entidad_bien,
       CASE p2.id_tipo_identificacion
         WHEN 2 THEN Upper(perj.nombre_comercial)
         ELSE Upper(Concat(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ',
                    p2.apellido2))
       END                                        deudor,
       tip.nombre                                 tipo_identificacion,
       p2.numero_identificacion,
       emb.monto_retenido,
       emb.monto_retenido                         AS monto_letras,
       tb.nombre                                  tipo_bien,
       b.numero_referencia,
       Concat(Isnull(f.titulo_obtenido, ' '),
       p.nombre1, ' ', Isnull(p.nombre2, ''), ' ', p.apellido1, ' ',
       Isnull(p.apellido2, ''))                   AS funcionario,
       p.numero_identificacion                    identificacion_funcionario,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)            AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) ) AS cargo_delegado_mayusculas
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
                           WHERE  ee.id_coactivo = c.id_coactivo and f.id_funcionario is not null) 