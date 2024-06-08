--PROCESO: Devolucion Fallo	Devolucion fallo	REGISTRO_FALLO_DEV	4707	 10126



--REGISTRO_FALLO_DEV	4707	 10126     https://www.youtube.com/watch?v=4aCIxd8RC4I


--Devolucion Fallo	Devolucion fallo	REGISTRO_FALLO_DEV	39	




-- https://tomeko.net/online_tools/hex_to_file.php?lang=en
-- https://www.dpriver.com/pp/sqlformat.htm





--PROVIDENCIA_PAGO
--PROVIDENCIA_ANULAR
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO_DEV';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE COACTIVO
update documentos..plantilla set fecha_inicio='2024-06-06' where id_plantilla in(4707)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran


-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
--where id_plantilla in(2612,2611,2610,2609)
where id_plantilla in(4707)
commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=4707--2650--2648--2604  -    *
																																	   *
select top 200 *from [documentos].[dbo].[documento] order by 1 desc																	   *
--**************************************************************************************************************************************

select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2647' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 5 p.codigo_plantilla from documentos.dbo.documento d
inner join documentos.dbo.plantilla p on d.id_plantilla=p.id_plantilla
order by 1 desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DATOS PARA PRUEBA
--GLT0230
--gqh0010
--GNA0319
--RTB0950
--GPN0289
--GBL0616
--HZ370D
--GS09740
--GPJ0369
--GQH0870
--GLL0890 
--GIK0109 *
--GRW7830 x
------------------------------------------------------------------------------------

select *from interes

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10126***

commit tran

------------------------------------------------------------------------------------
--************************************************************************************
--Cambio para el titulo del delegado

Concat(f.titulo_obtenido, ' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,

--************************************************************************************
------------------------------------------------------------------------------------







select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=6--11 
and fecha_final_vigencia is null


select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

--Abg. FELIPE HIPOLITO LARREATEGUI AVILES

select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='FELIPE'





--[15:04] Nicolas Montañez Rozo
--Devolución de valores

select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion, c.* from comparendo c inner join

comparendo_persona cp on c.cicomparendo=cp.cicomparendo

where c.id_estado_comparendo in(3,17,19,20)

and fecha_infraccion>'2019-12-31'

order by c.fecha_infraccion asc



------------------------------------------------


--Devolución de valores

select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion, c.* from comparendo c inner join

comparendo_persona cp on c.cicomparendo=cp.cicomparendo

where c.id_estado_comparendo in(3,17,19,20)

and fecha_infraccion>'2019-12-31'

order by c.fecha_infraccion asc


------------------------------------------------------------

--update

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables='NOMBRE_INFRACTOR,numero_consecutivo,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,fecha_apertura_impug,anio_apertura_proceso,FECHA_IMPOSICION_COMPARENDO,HORA_IMPOSICION_COMPARENDO,ARTICULO,DESCRIPCION_INFRACCION,desc_motivacion,consi_juridica,REGISTRO_FALLO,ESTADO_CITACION,numero_citacion,FECHA_EVALUACION,DIRECCION_INFRACCION,PLACA_VEHICULO,VALOR_TOTAL,TOTAL_LETRAS,CARGO_DELEGADO,MEMO_DELEGADO,FECHA_DELEGADO,IMAGEN_FIRMA,NOMBRE_ABOGADO,ABOGADO_PROYECTADO,CORREO_ELECTRONICO_INFRACTOR,IMAGEN_FIRMA_DOS,NOMBRE_SECRETARIO,TITULO,NUMERO_COMPARENDO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10126***

commit tran




------------------------------------------------------------------------------------------------------------
--Query modificado
SELECT CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2)
              )
       END                                                      AS
       nombreCompleto,
       Concat (pr.numero_proceso, ' - ', Year(pr.fecha_inicio)) AS
       numero_proceso,
       tip.codigo,
       pe.numero_identificacion,
       pr.fecha_inicio,
       Year(pr.fecha_inicio)                                    AS anio_proceso,
       c.fecha_infraccion,
       c.hora_infraccion,
       CASE i.numeral_infraccion
         WHEN ' ' THEN Concat ('Artículo ', ci.articulo, ' - ', nm.nombre)
         ELSE Concat ('Artículo ', ci.articulo, ', numeral ',
              i.numeral_infraccion,
              ' - ',
                     nm.nombre)
       END                                                      AS infraccion,
       ci.descripcion,
       (SELECT mp.descripcion_hechos
        FROM   motivacion_impugnacion mp(nolock)
        WHERE  mp.id_trazabilidad_proceso = (SELECT tpdh.*
                                             FROM
               (SELECT
                       Max(tpmi.id_trazabilidad_proceso) AS idTraza
                                                     FROM
                       motivacion_impugnacion midh (nolock)
                       INNER JOIN trazabilidad_proceso tpmi
                               ON tpmi.id_trazabilidad_proceso =
                                  midh.id_trazabilidad_proceso
                       INNER JOIN proceso pdh
                               ON pdh.id_proceso = tpmi.id_proceso
                                                     WHERE
               pdh.id_proceso = :idProceso
               )
               tpdh))                                           AS
       descripcionHechos,
       (SELECT eimp.consideracion_juridica
        FROM   evaluar_impugnacion eimp(nolock)
               INNER JOIN trazabilidad_proceso trei
                       ON trei.id_trazabilidad_proceso =
                          eimp.id_trazabilidad_proceso
        WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                               FROM   (SELECT
                       Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                       FROM
                       evaluar_impugnacion eimp2 (nolock)
                       INNER JOIN trazabilidad_proceso tpei2
                               ON tpei2.id_trazabilidad_proceso =
                                  eimp2.id_trazabilidad_proceso
                       INNER JOIN proceso pei
                               ON pei.id_proceso = tpei2.id_proceso
                                                       WHERE  pei.id_proceso =
                                                              :idProceso) fiei
                                                      ))        AS
       consideracionJuridica,
       (SELECT fi.motivo
        FROM   fallo_impugnacion fi(nolock)
        WHERE  fi.id_trazabilidad_proceso = (SELECT fimp.*
                                             FROM
               (SELECT
                       Max(tpfi.id_trazabilidad_proceso) AS idTraza
                                                     FROM
               fallo_impugnacion fip(
               nolock)
                       INNER JOIN trazabilidad_proceso
                                  tpfi
                               ON tpfi.id_trazabilidad_proceso =
                                  fip.id_trazabilidad_proceso
                       INNER JOIN proceso pfi
                               ON pfi.id_proceso = tpfi.id_proceso
                                                     WHERE
               pfi.id_proceso = :idProceso
               )
               fimp))                                           AS motivo,
       ec.nombre,
       c.numero_citacion,
       (SELECT trei.fecha_inicio
        FROM   evaluar_impugnacion eimp(nolock)
               INNER JOIN trazabilidad_proceso trei
                       ON trei.id_trazabilidad_proceso =
                          eimp.id_trazabilidad_proceso
        WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                               FROM   (SELECT
                       Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                       FROM
                       evaluar_impugnacion eimp2 (nolock)
                       INNER JOIN trazabilidad_proceso tpei2
                               ON tpei2.id_trazabilidad_proceso =
                                  eimp2.id_trazabilidad_proceso
                       INNER JOIN proceso pei
                               ON pei.id_proceso = tpei2.id_proceso
                                                       WHERE  pei.id_proceso =
                                                              :idProceso) fiei
                                                      ))        AS
       fechaEvaluacion,
       dir.complemento,
       cv.placa_vehiculo                                        AS placa,
       ( car.saldo_capital + car.saldo_interes )                AS valorMulta,
       ( car.saldo_capital + car.saldo_interes )                AS valorletras,
       (SELECT TOP 1 Concat (ca.nombre, ' (E)')
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN cargo ca(nolock)
                 ON ca.id_cargo = fdv.id_cargo
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS cargo,
       (SELECT TOP 1 fdv.memo_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       memo_nombramiento,
       (SELECT TOP 1 fdv.fecha_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       fecha_nombramiento,
       (SELECT TOP 1 CASE
                       WHEN pr.id_estado_proceso IN ( 77, 84 ) THEN
                       Max(fp.numero_imagen)
                       ELSE NULL
                     END
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
               JOIN firma_persona fp
                 ON fp.id_persona = pab.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS numero_imagen
       ,
       (SELECT TOP 1 Upper(Concat (pab.nombre1, ' ', pab.nombre2, ' ',
                           pab.apellido1,
                           ' ',
                                         pab.apellido2))
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       nombreAprobador,
       (SELECT TOP 1 Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)                         AS
       nombreProyectado,
       (SELECT TOP 1 cp.correo_electronico
        FROM   correo_persona cp(nolock)
        WHERE  cp.estado = 1
               AND cp.id_persona = pe.id_persona
        ORDER  BY cp.fecha_registro DESC)                       AS correos,
       (SELECT Max(fp.numero_imagen)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso)               AS
       firmaSecretario,
       (SELECT TOP 1 Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)                         AS
       nombreSecretario,
       (SELECT TOP 1 Isnull(fdv.titulo_obtenido, '')
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       titulo_obtenido,
       (SELECT TOP 1 fdv.accion_personal
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       accion_personal,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                          AS
       TITULO_PLANTILLAS
FROM   proceso pr(nolock)
       JOIN comparendo_proceso cp(nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c(nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN estado_comparendo ec(nolock)
         ON ec.id_estado_comparendo = c.id_estado_comparendo
       JOIN infraccion i(nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci(nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm(nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp(nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe(nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip(nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN direccion dir(nolock)
         ON dir.id_direccion = c.id_direccion_comparendo
       LEFT JOIN comparendo_vehiculo cv(nolock)
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN comparendo_cartera cca(nolock)
         ON cca.cicomparendo = c.cicomparendo
       JOIN cartera car(nolock)
         ON car.id_cartera = cca.id_cartera
WHERE  ( tp.id_trazabilidad_proceso = (SELECT Max(tz1.id_trazabilidad_proceso)
                                       FROM   trazabilidad_proceso tz1(nolock)
                                       WHERE  tz1.id_proceso = pr.id_proceso) )
       AND pr.id_proceso = :idProceso
       AND c.id_estado_comparendo != 14 


------------------------------------------------------------------------------------------------------------
--Query original
SELECT CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2)
              )
       END                                                      AS
       nombreCompleto,
       Concat (pr.numero_proceso, ' - ', Year(pr.fecha_inicio)) AS
       numero_proceso,
       tip.codigo,
       pe.numero_identificacion,
       pr.fecha_inicio,
       Year(pr.fecha_inicio)                                    AS anio_proceso,
       c.fecha_infraccion,
       c.hora_infraccion,
       CASE i.numeral_infraccion
         WHEN ' ' THEN Concat ('Artículo ', ci.articulo, ' - ', nm.nombre)
         ELSE Concat ('Artículo ', ci.articulo, ', numeral ',
              i.numeral_infraccion,
              ' - ',
                     nm.nombre)
       END                                                      AS infraccion,
       ci.descripcion,
       (SELECT mp.descripcion_hechos
        FROM   motivacion_impugnacion mp(nolock)
        WHERE  mp.id_trazabilidad_proceso = (SELECT tpdh.*
                                             FROM
               (SELECT
                       Max(tpmi.id_trazabilidad_proceso) AS idTraza
                                                     FROM
                       motivacion_impugnacion midh (nolock)
                       INNER JOIN trazabilidad_proceso tpmi
                               ON tpmi.id_trazabilidad_proceso =
                                  midh.id_trazabilidad_proceso
                       INNER JOIN proceso pdh
                               ON pdh.id_proceso = tpmi.id_proceso
                                                     WHERE
               pdh.id_proceso = :idProceso
               )
               tpdh))                                           AS
       descripcionHechos,
       (SELECT eimp.consideracion_juridica
        FROM   evaluar_impugnacion eimp(nolock)
               INNER JOIN trazabilidad_proceso trei
                       ON trei.id_trazabilidad_proceso =
                          eimp.id_trazabilidad_proceso
        WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                               FROM   (SELECT
                       Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                       FROM
                       evaluar_impugnacion eimp2 (nolock)
                       INNER JOIN trazabilidad_proceso tpei2
                               ON tpei2.id_trazabilidad_proceso =
                                  eimp2.id_trazabilidad_proceso
                       INNER JOIN proceso pei
                               ON pei.id_proceso = tpei2.id_proceso
                                                       WHERE  pei.id_proceso =
                                                              :idProceso) fiei
                                                      ))        AS
       consideracionJuridica,
       (SELECT fi.motivo
        FROM   fallo_impugnacion fi(nolock)
        WHERE  fi.id_trazabilidad_proceso = (SELECT fimp.*
                                             FROM
               (SELECT
                       Max(tpfi.id_trazabilidad_proceso) AS idTraza
                                                     FROM
               fallo_impugnacion fip(
               nolock)
                       INNER JOIN trazabilidad_proceso
                                  tpfi
                               ON tpfi.id_trazabilidad_proceso =
                                  fip.id_trazabilidad_proceso
                       INNER JOIN proceso pfi
                               ON pfi.id_proceso = tpfi.id_proceso
                                                     WHERE
               pfi.id_proceso = :idProceso
               )
               fimp))                                           AS motivo,
       ec.nombre,
       c.numero_citacion,
       (SELECT trei.fecha_inicio
        FROM   evaluar_impugnacion eimp(nolock)
               INNER JOIN trazabilidad_proceso trei
                       ON trei.id_trazabilidad_proceso =
                          eimp.id_trazabilidad_proceso
        WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                               FROM   (SELECT
                       Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                       FROM
                       evaluar_impugnacion eimp2 (nolock)
                       INNER JOIN trazabilidad_proceso tpei2
                               ON tpei2.id_trazabilidad_proceso =
                                  eimp2.id_trazabilidad_proceso
                       INNER JOIN proceso pei
                               ON pei.id_proceso = tpei2.id_proceso
                                                       WHERE  pei.id_proceso =
                                                              :idProceso) fiei
                                                      ))        AS
       fechaEvaluacion,
       dir.complemento,
       cv.placa_vehiculo                                        AS placa,
       ( car.saldo_capital + car.saldo_interes )                AS valorMulta,
       ( car.saldo_capital + car.saldo_interes )                AS valorletras,
       (SELECT TOP 1 Concat (ca.nombre, ' (E)')
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN cargo ca(nolock)
                 ON ca.id_cargo = fdv.id_cargo
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS cargo,
       (SELECT TOP 1 fdv.memo_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       memo_nombramiento,
       (SELECT TOP 1 fdv.fecha_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       fecha_nombramiento,
       (SELECT TOP 1 CASE
                       WHEN pr.id_estado_proceso IN ( 77, 84 ) THEN
                       Max(fp.numero_imagen)
                       ELSE NULL
                     END
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
               JOIN firma_persona fp
                 ON fp.id_persona = pab.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS numero_imagen
       ,
       (SELECT TOP 1 Upper(Concat (pab.nombre1, ' ', pab.nombre2, ' ',
                           pab.apellido1,
                           ' ',
                                         pab.apellido2))
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       nombreAprobador,
       (SELECT TOP 1 Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)                         AS
       nombreProyectado,
       (SELECT TOP 1 cp.correo_electronico
        FROM   correo_persona cp(nolock)
        WHERE  cp.estado = 1
               AND cp.id_persona = pe.id_persona
        ORDER  BY cp.fecha_registro DESC)                       AS correos,
       (SELECT Max(fp.numero_imagen)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso)               AS
       firmaSecretario,
       (SELECT TOP 1 Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ',
                     p.apellido2)
        FROM   trazabilidad_proceso tp(nolock)
               INNER JOIN usuario_persona up(nolock)
                       ON up.id_usuario = tp.id_usuario
               LEFT JOIN persona p(nolock)
                      ON p.id_persona = up.id_persona
               LEFT JOIN firma_persona fp(nolock)
                      ON fp.id_persona = p.id_persona
        WHERE  tp.id_estado_proceso = 76
               AND tp.id_proceso = pr.id_proceso
        ORDER  BY tp.fecha_inicio DESC)                         AS
       nombreSecretario,
       (SELECT TOP 1 Isnull(fdv.titulo_obtenido, '')
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       titulo_obtenido,
       (SELECT TOP 1 fdv.accion_personal
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)                AS
       accion_personal,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)                          AS
       TITULO_PLANTILLAS
FROM   proceso pr(nolock)
       JOIN comparendo_proceso cp(nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c(nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN estado_comparendo ec(nolock)
         ON ec.id_estado_comparendo = c.id_estado_comparendo
       JOIN infraccion i(nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci(nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm(nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp(nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe(nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip(nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN direccion dir(nolock)
         ON dir.id_direccion = c.id_direccion_comparendo
       LEFT JOIN comparendo_vehiculo cv(nolock)
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN comparendo_cartera cca(nolock)
         ON cca.cicomparendo = c.cicomparendo
       JOIN cartera car(nolock)
         ON car.id_cartera = cca.id_cartera
WHERE  ( tp.id_trazabilidad_proceso = (SELECT Max(tz1.id_trazabilidad_proceso)
                                       FROM   trazabilidad_proceso tz1(nolock)
                                       WHERE  tz1.id_proceso = pr.id_proceso) )
       AND pr.id_proceso = :idProceso
       AND c.id_estado_comparendo != 14 

--------------------------------------------------------------------------------