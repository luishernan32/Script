--OFICIO_EMBARGO_SEPS 2638 10175

--Observaciones: Está plantilla presentaba un error ya que la variable venia desde el código por lo cual en el order variables no coincidia


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT e.fecha_registro,
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
       Concat(Isnull(f.titulo_obtenido, '' ''), p.nombre1, '' '',
       Isnull(p.nombre2, ''''),
       '' '', p.apellido1, '' '', Isnull(p.apellido2, '''')) AS funcionario,
       p.numero_identificacion
       identificacion_funcionario,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)                 AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )      AS
       cargo_delegado_mayusculas,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.estado = ''VIGENTE'')               AS nombre_abogado

		,(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS FIRMA


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
	   , orden_variables='FECHA_GENERACION,NO_OFICIO,NUMERAL,NOMBRE_BIEN,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO,PROFESION,NOMBRE_ABOGADO,IMAGEN_FIRMA'
WHERE  id_plantilla_config=10175

commit tran
                        --FECHA_GENERACION,NO_OFICIO,NUMERAL,NOMBRE_BIEN,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO,PROFESION

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'OFICIO_EMBARGO_SEPS';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)


--***********************************************************************************
--Variable por agregar  10/07/2024

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS


,(SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = 'VIGENTE')                   AS nombre_abogado



--Variables de plantillas

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2290'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2639, 230

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from variable
where nombre_variable='CARGO_DELEGADO'

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

--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='2638'

----------------------------------


--***********************************************************************************

--Modifcada 1
-------------------------------------------------------------------------------------
SELECT e.fecha_registro,
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
       Concat(Isnull(f.titulo_obtenido, ' '), p.nombre1, ' ',
       Isnull(p.nombre2, ''),
       ' ', p.apellido1, ' ', Isnull(p.apellido2, '')) AS funcionario,
       p.numero_identificacion
       identificacion_funcionario,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)                 AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )      AS
       cargo_delegado_mayusculas,
       (SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.estado = 'VIGENTE')               AS nombre_abogado

		,(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente')                 AS FIRMA


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









--***********************************************************************************

--Modifcada 2
-------------------------------------------------------------------------------------
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

		,(SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = 'VIGENTE')                   AS nombre_abogado

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
-------------------------------------------------------------------------------------
SELECT      e.fecha_registro,      ob.numero_oficio,      pro.numero_proceso+'-'+TRY_CONVERT(VARCHAR(4),c.anio) numero_proceso,     eb.nombre entidad_bien,   case p2.id_tipo_identificacion when 2 then UPPER(perj.nombre_comercial) else UPPER(CONCAT(p2.nombre1,' ',p2.nombre2,' ',p2.apellido1,' ', p2.apellido2))  END deudor,   tip.nombre tipo_identificacion,      p2.numero_identificacion,      emb.monto_retenido,       emb.monto_retenido AS monto_letras,      tb.nombre tipo_bien,      b.numero_referencia,      CONCAT(ISNULL(f.titulo_obtenido,' '), p.nombre1,' ',ISNULL(p.nombre2,''),' ',p.apellido1,' ',ISNULL(p.apellido2,'')) AS funcionario,       p.numero_identificacion identificacion_funcionario,   (SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 438) AS cargo_delegado,   (UPPER((SELECT valor_parametro_defecto FROM parametro(NOLOCK) WHERE codigo_parametro = 434))) AS cargo_delegado_mayusculas     FROM coactivo c   JOIN     coactivo_oficio_bien cob ON c.id_coactivo = cob.id_coactivo   JOIN     oficio_bien ob ON ob.id_oficio_bien = cob.id_oficio_bien   JOIN     proceso pro ON c.id_proceso = pro.id_proceso   JOIN     bien b ON cob.id_bien = b.id_bien   JOIN     entidad_bien eb ON b.id_entidad_bien = eb.id_entidad_bien   JOIN     embargo e ON c.id_coactivo = e.id_coactivo   JOIN persona p2 ON c.id_deudor = p2.id_persona  left join persona_juridica perj on perj.id_persona_juridica = c.id_deudor JOIN     embargo_bien emb ON emb.id_embargo = e.id_embargo   AND emb.id_bien = b.id_bien   JOIN     tipo_bien tb ON b.id_tipo_bien = tb.id_tipo_bien   JOIN     funcionario f ON e.id_funcionario = f.id_funcionario   JOIN     persona p ON f.id_persona = p.id_persona   JOIN     tipo_identificacion_persona tip ON     p2.id_tipo_identificacion = tip.id_tipo_identificacion       WHERE c.id_coactivo = :idCoactivo and e.id_embargo = (  select max(ee.id_embargo) id_embargo from embargo ee   where ee.id_coactivo = c.id_coactivo )
-------------------------------------------------------------------------------------
--14-07-2024
SELECT e.fecha_registro,         ob.numero_oficio,         pro.numero_proceso + '-'         + Try_convert(Varchar(4), c.anio)          numero_proceso,         eb.nombre                                  entidad_bien,         CASE p2.id_tipo_identificacion           WHEN 2 THEN Upper(perj.nombre_comercial)           ELSE Upper(Concat(p2.nombre1, ' ', p2.nombre2, ' ', p2.apellido1, ' ',                      p2.apellido2))         END                                        deudor,         tip.nombre                                 tipo_identificacion,         p2.numero_identificacion,         emb.monto_retenido,         emb.monto_retenido                         AS monto_letras,         tb.nombre                                  tipo_bien,         b.numero_referencia,         Concat(Isnull(f.titulo_obtenido, ' '),         p.nombre1, ' ', Isnull(p.nombre2, ''), ' ', p.apellido1, ' ',         Isnull(p.apellido2, ''))                   AS funcionario,         p.numero_identificacion                    identificacion_funcionario,         (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 438)            AS cargo_delegado,         ( Upper((SELECT valor_parametro_defecto                  FROM   parametro(nolock)                  WHERE  codigo_parametro = 434)) ) AS cargo_delegado_mayusculas      ,(SELECT Concat(f.titulo_obtenido, ' ', Upper(                 Concat(per.nombre1, ' ', per.nombre2, ' ',                         per.apellido1, ' ',                 per.apellido2)))          FROM   funcionario f (nolock)                 INNER JOIN persona per (nolock)                         ON f.id_persona = per.id_persona          WHERE  f.id_cargo = 11                 AND f.estado = 'VIGENTE')                   AS nombre_abogado    FROM   coactivo c         JOIN coactivo_oficio_bien cob           ON c.id_coactivo = cob.id_coactivo         JOIN oficio_bien ob           ON ob.id_oficio_bien = cob.id_oficio_bien         JOIN proceso pro           ON c.id_proceso = pro.id_proceso         JOIN bien b           ON cob.id_bien = b.id_bien         JOIN entidad_bien eb           ON b.id_entidad_bien = eb.id_entidad_bien         JOIN embargo e           ON c.id_coactivo = e.id_coactivo         JOIN persona p2           ON c.id_deudor = p2.id_persona         LEFT JOIN persona_juridica perj                ON perj.id_persona_juridica = c.id_deudor         JOIN embargo_bien emb           ON emb.id_embargo = e.id_embargo              AND emb.id_bien = b.id_bien         JOIN tipo_bien tb           ON b.id_tipo_bien = tb.id_tipo_bien         JOIN funcionario f           ON e.id_funcionario = f.id_funcionario         JOIN persona p           ON f.id_persona = p.id_persona         JOIN tipo_identificacion_persona tip           ON p2.id_tipo_identificacion = tip.id_tipo_identificacion  WHERE  c.id_coactivo = :idCoactivo         AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo                             FROM   embargo ee                             WHERE  ee.id_coactivo = c.id_coactivo)
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
SELECT 2290, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from variable
where nombre_variable='CARGO_DELEGADO'

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

--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='2638'

----------------------------------


--Dato quemado

SELECT e.fecha_registro,
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
       Concat(Isnull(f.titulo_obtenido, ' '), p.nombre1, ' ',
       Isnull(p.nombre2, ''),
       ' ', p.apellido1, ' ', Isnull(p.apellido2, '')) AS funcionario,
       p.numero_identificacion
       identificacion_funcionario,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)                 AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )      AS
       cargo_delegado_mayusculas,
       (SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = 'VIGENTE')               AS nombre_abogado
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
WHERE  c.id_coactivo = 1450814
       AND e.id_embargo = (SELECT Max(ee.id_embargo) id_embargo
                           FROM   embargo ee
                           WHERE  ee.id_coactivo = c.id_coactivo) 


------------------------------------------------
--************************************************************************************************************************************************************************
--************************************************************************************************************************************************************************
--Query datos
select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2022
--and ci.id_ordenamiento_pais=1
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and oc.valor_obligacion=425
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios>0
--and oc.valor_costas_procesales>0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
order by p.fecha_inicio asc
--************************************************************************************************************************************************************************
--************************************************************************************************************************************************************************


















--Update que sirvion

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT e.fecha_registro,
       ob.numero_oficio,
       pro.numero_proceso + ''-''
       + Try_convert(Varchar(4), c.anio)          numero_proceso,
       eb.nombre                                  entidad_bien,
       CASE p2.id_tipo_identificacion
         WHEN 2 THEN Upper(perj.nombre_comercial)
         ELSE Upper(Concat(p2.nombre1, '' '', p2.nombre2, '' '', p2.apellido1, '' '',
                    p2.apellido2))
       END                                        deudor,
       tip.nombre                                 tipo_identificacion,
       p2.numero_identificacion,
       emb.monto_retenido,
       emb.monto_retenido                         AS monto_letras,
       tb.nombre                                  tipo_bien,
       b.numero_referencia,
       Concat(Isnull(f.titulo_obtenido, '' ''),
       p.nombre1, '' '', Isnull(p.nombre2, ''''), '' '', p.apellido1, '' '',
       Isnull(p.apellido2, ''''))                   AS funcionario,
       p.numero_identificacion                    identificacion_funcionario,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 438)            AS cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) ) AS cargo_delegado_mayusculas

		,(SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.estado = ''VIGENTE'')                   AS nombre_abogado

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
                           WHERE  ee.id_coactivo = c.id_coactivo)'               
	   , orden_variables='FECHA_GENERACION,NO_OFICIO,NUMERAL,NOMBRE_BIEN,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,VALOR_SALDO,VALOR_TOTAL_LETRAS,TIPO_BIEN,OTROS,NOMBRE_DEPOSITARIO,DOCUMENTO_PARTICIPANTE,CARGO_DELEGADO,PROFESION,NOMBRE_ABOGADO'
WHERE  id_plantilla_config=10175

commit tran