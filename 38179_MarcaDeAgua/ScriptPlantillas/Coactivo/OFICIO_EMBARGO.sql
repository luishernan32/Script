--OFICIO_EMBARGO 2625 74  4772
begin tran 
update documentos..plantilla set fecha_inicio='2024-08-12' where id_plantilla=4772
update documentos..plantilla set fecha_inicio='2024-08-10' where id_plantilla=4772
commit tran

--1455864 0927016105 10398205
--10398155 0910643014 Es el que sirve id_coactivo=1455834
--10398133 0950306571 1455818
--10398211  0914932918  1455869
--0950614750 1455838 10398161

--10398292 0903183945 1455917 Exitoso 

--Delegado Funcionario Ejecutor-Coactiva Del(la) Director(a) de Infracciones y Servicios de Tránsito de la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil EP
--Delegado Funcionario Ejecutor-Coactiva Del(la) Director(a) de Infracciones y Servicios de Tránsito de la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil EP
SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro=438

select *from gestor_docs.dbo.version_data_documento
where codigo_documento=2461082--256317354
                     --256317354

(SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro=438) AS CARGO_DELEGADO


(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS FIRMA


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT (SELECT upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)                 AS cargo_delegado,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS FIRMA,
       (SELECT TOP 1 Concat(f.titulo_obtenido, '' '', Upper(
                                   Concat(per.nombre1, '' '', per.nombre2, '' '',
                                   per.apellido1, '' '',
per.apellido2)))
FROM   funcionario f (nolock)
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
WHERE  f.id_cargo = 1
AND f.estado = ''VIGENTE'')               AS nombre_abogado,
e.fecha_registro,
ob.numero_oficio,
pro.numero_proceso + ''-''
+ Try_convert(Varchar(4), c.anio)               numero_proceso,
eb.nombre                                       entidad_bien,
CASE p2.id_tipo_identificacion
WHEN 2 THEN Upper(perj.nombre_comercial)
ELSE Upper(Concat(p2.nombre1, '' '', p2.nombre2, '' '', p2.apellido1, '' '',
p2.apellido2))
END                                             deudor,
tip.nombre                                      tipo_identificacion,
p2.numero_identificacion,
emb.monto_retenido,
emb.monto_retenido                              AS monto_letras,
tb.nombre                                       tipo_bien,
b.numero_referencia,
Concat(Isnull(f.titulo_obtenido, '' ''), p.nombre1, '' '', Isnull(p.nombre2, ''''),
'' '', p.apellido1, '' '', Isnull(p.apellido2, '''')) AS funcionario,
p.numero_identificacion                         identificacion_funcionario,

(SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro=438) AS CARGO_DELEGADO

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
WHERE  c.id_coactivo = :idCoactivo
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) '               
	   , orden_variables='PROFESION,IMAGEN_FIRMA,NOMBRE_DELEGADO,FECHA_GENERACION,NO_OFICIO,NUMERAL,NOMBRE_BIEN,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO'
WHERE  id_plantilla_config=74

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
SELECT (SELECT upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)                 AS cargo_delegado,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS FIRMA,
       (SELECT TOP 1 Concat(f.titulo_obtenido, ' ', Upper(
                                   Concat(per.nombre1, ' ', per.nombre2, ' ',
                                   per.apellido1, ' ',
per.apellido2)))
FROM   funcionario f (nolock)
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
WHERE  f.id_cargo = 1
AND f.estado = 'VIGENTE')               AS nombre_abogado,
e.fecha_registro,
ob.numero_oficio,
pro.numero_proceso + '-'
+ Try_convert(Varchar(4), c.anio)               numero_proceso,
eb.nombre                                       entidad_bien,
CASE p2.id_tipo_identificacion
WHEN 2 THEN Upper(perj.nombre_comercial)
ELSE Upper(Concat(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ',
p2.apellido2))
END                                             deudor,
tip.nombre                                      tipo_identificacion,
p2.numero_identificacion,
emb.monto_retenido,
emb.monto_retenido                              AS monto_letras,
tb.nombre                                       tipo_bien,
b.numero_referencia,
Concat(Isnull(f.titulo_obtenido, ' '), p.nombre1, ' ', Isnull(p.nombre2, ''),
' ', p.apellido1, ' ', Isnull(p.apellido2, '')) AS funcionario,
p.numero_identificacion                         identificacion_funcionario
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
WHERE  c.id_coactivo = :idCoactivo
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT      e.fecha_registro,      ob.numero_oficio,      pro.numero_proceso+'-'+TRY_CONVERT(VARCHAR(4),c.anio) numero_proceso,     eb.nombre entidad_bien,   case p2.id_tipo_identificacion when 2 then UPPER(perj.nombre_comercial) else UPPER(CONCAT(p2.nombre1,' ',p2.nombre2,' ',p2.apellido1,' ', p2.apellido2))  END deudor,   tip.nombre tipo_identificacion,      p2.numero_identificacion,      emb.monto_retenido,       emb.monto_retenido AS monto_letras,      tb.nombre tipo_bien,      b.numero_referencia,      CONCAT(ISNULL(f.titulo_obtenido,' '), p.nombre1,' ',ISNULL(p.nombre2,''),' ',p.apellido1,' ',ISNULL(p.apellido2,'')) AS funcionario,       p.numero_identificacion identificacion_funcionario,   (SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 438) AS cargo_delegado,   (UPPER((SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 434))) AS cargo_delegado_mayusculas     FROM coactivo c   JOIN     coactivo_oficio_bien cob ON c.id_coactivo = cob.id_coactivo   JOIN     oficio_bien ob ON ob.id_oficio_bien = cob.id_oficio_bien   JOIN     proceso pro ON c.id_proceso = pro.id_proceso   JOIN     bien b ON cob.id_bien = b.id_bien   JOIN     entidad_bien eb ON b.id_entidad_bien = eb.id_entidad_bien   JOIN     embargo e ON c.id_coactivo = e.id_coactivo   JOIN persona p2 ON c.id_deudor = p2.id_persona  left join persona_juridica perj on perj.id_persona_juridica = c.id_deudor JOIN     embargo_bien emb ON emb.id_embargo = e.id_embargo   AND emb.id_bien = b.id_bien   JOIN     tipo_bien tb ON b.id_tipo_bien = tb.id_tipo_bien   JOIN     funcionario f ON e.id_funcionario = f.id_funcionario   JOIN     persona p ON f.id_persona = p.id_persona   JOIN     tipo_identificacion_persona tip ON     p2.id_tipo_identificacion = tip.id_tipo_identificacion       WHERE c.id_coactivo = :idCoactivo and e.id_embargo = (  select max(ee.id_embargo) id_embargo from embargo ee   where ee.id_coactivo = c.id_coactivo )

--11/08/2024
SELECT   (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 438)                 AS cargo_delegado,          (SELECT Max(fp.numero_imagen)                FROM   firma_persona fp (nolock)                       INNER JOIN funcionario_financiacion f (nolock)                               ON fp.id_persona = f.id_persona                WHERE  fp.id_persona = F.id_persona                       AND f.fecha_final_vigencia IS NULL)  AS FIRMA_FUNCIONARIO_,             (SELECT TOP 1 Concat(f.titulo_obtenido, ' ', Upper(                                     Concat(per.nombre1, ' ', per.nombre2, ' ',                                     per.apellido1, ' ',  per.apellido2)))  FROM   funcionario f (nolock)  INNER JOIN persona per (nolock)  ON f.id_persona = per.id_persona  WHERE  f.id_cargo = 1  AND f.estado = 'VIGENTE')               AS nombre_abogado,                  e.fecha_registro,         ob.numero_oficio,         pro.numero_proceso + '-'         + Try_convert(Varchar(4), c.anio)               numero_proceso,         eb.nombre                                       entidad_bien,         CASE p2.id_tipo_identificacion           WHEN 2 THEN Upper(perj.nombre_comercial)           ELSE Upper(Concat(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ',                      p2.apellido2))         END                                             deudor,         tip.nombre                                      tipo_identificacion,         p2.numero_identificacion,         emb.monto_retenido,         emb.monto_retenido                              AS monto_letras,         tb.nombre                                       tipo_bien,         b.numero_referencia,         Concat(Isnull(f.titulo_obtenido, ' '), p.nombre1, ' ',         Isnull(p.nombre2, ''),         ' ', p.apellido1, ' ', Isnull(p.apellido2, '')) AS funcionario,         p.numero_identificacion         identificacion_funcionario    FROM   coactivo c         JOIN coactivo_oficio_bien cob           ON c.id_coactivo = cob.id_coactivo         JOIN oficio_bien ob           ON ob.id_oficio_bien = cob.id_oficio_bien         JOIN proceso pro           ON c.id_proceso = pro.id_proceso         JOIN bien b           ON cob.id_bien = b.id_bien         JOIN entidad_bien eb           ON b.id_entidad_bien = eb.id_entidad_bien         JOIN embargo e           ON c.id_coactivo = e.id_coactivo         JOIN persona p2           ON c.id_deudor = p2.id_persona         LEFT JOIN persona_juridica perj                ON perj.id_persona_juridica = c.id_deudor         JOIN embargo_bien emb           ON emb.id_embargo = e.id_embargo              AND emb.id_bien = b.id_bien         JOIN tipo_bien tb           ON b.id_tipo_bien = tb.id_tipo_bien         JOIN funcionario f           ON e.id_funcionario = f.id_funcionario         JOIN persona p           ON f.id_persona = p.id_persona         JOIN tipo_identificacion_persona tip           ON p2.id_tipo_identificacion = tip.id_tipo_identificacion  WHERE  c.id_coactivo = :idCoactivo         AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo                             FROM   embargo ee                             WHERE  ee.id_coactivo = c.id_coactivo)
-------------------------------------------------------------------------------------
--10/08/2024

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