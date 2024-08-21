--CONVENIO_MULTA  0930770789 id_persona=92906
--                
--Aparecen los datos quemados y hay que agregar dos variable
-- Generacion https://www.youtube.com/watch?v=SEfcS9BIK8A
--01/08/20224 https://www.youtube.com/watch?v=l7mAWR_Dpcg
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @DIAS_COBRO INT

SELECT TOP 1 @DIAS_COBRO = 8

SELECT f.id_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                          AS NombreInfractor,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1)        telefono,
       dbo.Correopersona(pe.id_persona)             correo,
       dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       @DIAS_COBRO                                  AS diasCobro,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)              AS TITULO_PLANTILLAS,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario_financiacion fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = ''Vigente'')          AS FIRMA,
       (SELECT TOP 1 Concat(fun.titulo_obtenido, '' '', pf.nombre1, '' '',
                     pf.nombre2, '' '',
                     pf.apellido1,
                                   '' '', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario_financiacion fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = ''Vigente'')          AS NOMBRE_DELEGADO,
       (SELECT TOP 1 Concat(ca.nombre, ''.  -'', f.memo_nombramiento, ''  '',
                                   RIGHT ( ''0'' + CONVERT ( VARCHAR (2), Day
                                   (f.fecha_nombramiento)),
                                   2)
                                                                          +
                                   '' de ''
                                                                          +
                                   Datename(
                                   month,
                     f.fecha_nombramiento)
                                                                          +
                                   '' del ''
                                                                          +
                                   CONVERT (
                                   VARCHAR (4),
                                   Year
                                   (f.fecha_nombramiento)), ''.'')
        FROM   funcionario_financiacion f
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN cargo ca (nolock)
                       ON f.id_cargo = ca.id_cargo
        WHERE  f.fecha_final_vigencia IS NULL)      AS cargo_delegado,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp
        WHERE  fp.id_persona = pe.id_persona)       AS IMAGEN_FIRMA_PERSONA

		,(SELECT Max(fp.numero_imagen)
        FROM   funcionario fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = ''Vigente'')                 AS FIRMA_2,


			   (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario_coactivo f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       firma_funcionario

FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       JOIN persona pe
         ON pe.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = f.id_deudor
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN proceso p
         ON p.id_proceso = f.id_proceso
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='ID_FINANCIACION,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,TASA_INTERES,VALOR_INT,VALOR_OBLIGACIONES,VALOR_TOTAL,TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,NUMERO_CUOTAS,NUMERO_PAGO,numero_consecutivo,DIAS_COBRO,TITULO_PLANTILLAS,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,IMAGEN_FIRMA_DOS,IMAGEN_FIRMA_CINCO,IMAGEN_FIRMA_CUATRO'
WHERE  id_plantilla_config=29

commit tran

---------------------------------------------------------------
--ID_FINANCIACION,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,
--N_DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,TASA_INTERES,VALOR_INT,VALOR_OBLIGACIONES,VALOR_TOTAL,
--TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,NUMERO_CUOTAS,NUMERO_PAGO,numero_consecutivo,DIAS_COBRO,TITULO_PLANTILLAS,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,IMAGEN_FIRMA_DOS



-------------------------------------------------------------------
--
--IMAGEN_FIRMA,NOMBRE_DELEGADO
--CARGO_DELEGADO

--

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3690--3692--3690--
--Impugnación de comparendo	Apertura impugnación sin tercero	APERT_IMPUG_SIN_TERC
																																	   *
select top 200 *from [documentos].[dbo].[documento] order by 1 desc																	   *
--**************************************************************************************************************************************


begin tran 
update documentos..plantilla set fecha_inicio='2024-08-05' where id_plantilla=4769
update documentos..plantilla set fecha_inicio='2024-08-06' where id_plantilla=4769
update documentos..plantilla set fecha_fin=null where id_plantilla=4762
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'CONVENIO_MULTA';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

--IMAGEN_FIRMA_DOS	1336
--IMAGEN_FIRMA	230
--FIRMA_AGENTE	1375
--CARGO_DELEGADO	285
--NOMBRE_DELEGADO	268
--FIRMA_FUNCIONARIO_	1376
--230 1376
--285 1448 268
--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
--where nombre_variable='IMAGEN_FIRMA'
where id_plantilla='4767'--'4749'--'2634'--2634

INSERT INTO documentos..variable_plantilla
SELECT 4749, 1336

--Modifcada
--ID_FINANCIACION,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,TASA_INTERES,VALOR_INT,VALOR_OBLIGACIONES,VALOR_TOTAL,TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,NUMERO_CUOTAS,NUMERO_PAGO,numero_consecutivo,DIAS_COBRO,TITULO_PLANTILLAS,IMAGEN_FIRMA,NOMBRE_DELEGADO,CARGO_DELEGADO,IMAGEN_FIRMA_DOS
-------------------------------------------------------------------------------------
--id_plantilla_config=29
DECLARE @DIAS_COBRO INT

SELECT TOP 1 @DIAS_COBRO = 8

SELECT f.id_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                          AS NombreInfractor,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1)        telefono,
       dbo.Correopersona(pe.id_persona)             correo,
       dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       @DIAS_COBRO                                  AS diasCobro,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)              AS TITULO_PLANTILLAS,

		(SELECT Max(fp.numero_imagen)
        FROM   funcionario_financiacion fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente')                 AS FIRMA,
			   (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario_financiacion fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente')                 AS NOMBRE_DELEGADO,


		(Select top 1 Concat(ca.nombre,'.  -',f.memo_nombramiento,'  ',
          RIGHT ( '0' + CONVERT ( varchar (2), day (f.fecha_nombramiento)), 2) + ' de ' + datename( month ,f.fecha_nombramiento) + ' del ' + CONVERT ( varchar (4),
         year (f.fecha_nombramiento)),'.')
         from funcionario_financiacion f
        INNER JOIN persona per (nolock)
    ON f.id_persona = per.id_persona
  inner join cargo ca (nolock)
    on f.id_cargo=ca.id_cargo
   where f.fecha_final_vigencia is null)                     AS cargo_delegado,

   (select max(fp.numero_imagen) from firma_persona fp
    where fp.id_persona=pe.id_persona) AS FIRMA_FUNCIONARIO_


FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       JOIN persona pe
         ON pe.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = f.id_deudor
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN proceso p
         ON p.id_proceso = f.id_proceso
WHERE  f.id_financiacion = :idFinanciacion 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
DECLARE @DIAS_COBRO INT    SELECT TOP 1 @DIAS_COBRO = 8    SELECT f.id_financiacion,         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper(pj.nombre_comercial)           ELSE  Upper(         Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))         END                                          AS NombreInfractor,         tip.codigo,         pe.numero_identificacion,         dbo.Telefonopersona(pe.id_persona, 1)        telefono,         dbo.Correopersona(pe.id_persona)             correo,         dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,         f.tasa_interes,         f.valor_total_intereses_moratorios,         f.valor_total_saldo_capital_obliga,         f.valor_total,         f.valor_total_financiar_interes,         dpc.porcentaje_cuota_inicial,         f.numero_cuotas,         f.id_tramite,         f.numero_financiacion,         @DIAS_COBRO                                  AS diasCobro,      (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS    FROM   financiacion f         JOIN configuracion_financiacion cf           ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion         JOIN detalle_porcentaje_cuota_inici dpc           ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion         JOIN persona pe           ON pe.id_persona = f.id_deudor         LEFT JOIN persona_juridica pj                ON pj.id_persona_juridica = f.id_deudor         JOIN tipo_identificacion_persona tip           ON tip.id_tipo_identificacion = pe.id_tipo_identificacion         LEFT JOIN direccion_persona dp                ON dp.id_persona = pe.id_persona         LEFT JOIN direccion d                ON d.id_direccion = dp.id_direccion         JOIN proceso p           ON p.id_proceso = f.id_proceso  WHERE  f.id_financiacion = :idFinanciacion 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--ID_PLANTILLA_CONFIG 30
SELECT CASE df.numero_cuota WHEN 0 THEN 'Cuota inicial' ELSE CAST(df.numero_cuota AS varchar) END, df.fecha_pago_oportuno, df.valor_capital, df.valor_intereses, df.valor_total, df.valor_saldo_obligacion FROM detalle_financiacion df WHERE df.id_financiacion = :idFinanciacion 
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Script Alexander
DECLARE @DIAS_COBRO INT    SELECT TOP 1 @DIAS_COBRO = 8    SELECT f.id_financiacion,         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper(pj.nombre_comercial)           ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',                      pe.apellido2))         END                                          AS NombreInfractor,         tip.codigo,         pe.numero_identificacion,         dbo.Telefonopersona(pe.id_persona, 1)        telefono,         dbo.Correopersona(pe.id_persona)             correo,         dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,         f.tasa_interes,         f.valor_total_intereses_moratorios,         f.valor_total_saldo_capital_obliga,         f.valor_total,         f.valor_total_financiar_interes,         dpc.porcentaje_cuota_inicial,         f.numero_cuotas,         f.id_tramite,         f.numero_financiacion,         @DIAS_COBRO                                  AS diasCobro,         (SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 439)              AS TITULO_PLANTILLAS,         (SELECT Max(fp.numero_imagen)          FROM   funcionario_financiacion fun (nolock)                 INNER JOIN firma_persona fp (nolock)                         ON fp.id_persona = fun.id_persona          WHERE  fun.id_cargo = 17                 AND fun.estado = 'Vigente')          AS FIRMA,         (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',                       pf.nombre2, ' ',                       pf.apellido1,                                     ' ', pf.apellido2)          FROM   persona pf                 INNER JOIN funcionario_financiacion fun                         ON pf.id_persona = fun.id_persona          WHERE  fun.id_cargo = 17                 AND fun.estado = 'Vigente')          AS NOMBRE_DELEGADO,         (SELECT TOP 1 Concat(ca.nombre, '.  -', f.memo_nombramiento, '  ',                                     RIGHT ( '0' + CONVERT ( VARCHAR (2), Day                                     (f.fecha_nombramiento)),                                     2)                                                                            +                                     ' de '                                                                            +                                     Datename(                                     month                       , f.fecha_nombramiento)                                                                            +                                     ' del '                                                                            +                                     CONVERT (                                     VARCHAR (4),                                     Year                                     (f.fecha_nombramiento)), '.')          FROM   funcionario_financiacion f                 INNER JOIN persona per (nolock)                         ON f.id_persona = per.id_persona                 INNER JOIN cargo ca (nolock)                         ON f.id_cargo = ca.id_cargo          WHERE  f.fecha_final_vigencia IS NULL)      AS cargo_delegado,           (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp          WHERE  fp.id_persona = pe.id_persona)       AS IMAGEN_FIRMA_PERSONA  FROM   financiacion f         JOIN configuracion_financiacion cf           ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion         JOIN detalle_porcentaje_cuota_inici dpc           ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion         JOIN persona pe           ON pe.id_persona = f.id_deudor         LEFT JOIN persona_juridica pj                ON pj.id_persona_juridica = f.id_deudor         JOIN tipo_identificacion_persona tip           ON tip.id_tipo_identificacion = pe.id_tipo_identificacion         LEFT JOIN direccion_persona dp                ON dp.id_persona = pe.id_persona         LEFT JOIN direccion d                ON d.id_direccion = dp.id_direccion         JOIN proceso p           ON p.id_proceso = f.id_proceso  WHERE  f.id_financiacion = :idFinanciacion 

--------------------------------------------------------------------------
--Querys

select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2021
--and ci.id_ordenamiento_pais=1
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios0
--and oc.valor_costas_procesales0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
order by p.fecha_inicio desc





--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2024-08-01' ,'08:08:00.0000000',6767676812224, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,48.76, --total pago
NULL,NULL,1,535907, --factura finan --4007661 3087948
48.76, --total pago
0, --cuota
'03', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
48.76) ---total_tcr



select top 10 
*from financiacion
order by 1 desc


select *from persona
where id_persona='75150'


select top 1000 *from financiacion f
join proceso p on f.id_proceso=p.id_proceso
where 1=1
order by id_financiacion desc



--UPDATE ALEXANDER

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @DIAS_COBRO INT

SELECT TOP 1 @DIAS_COBRO = 8

SELECT f.id_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                          AS NombreInfractor,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1)        telefono,
       dbo.Correopersona(pe.id_persona)             correo,
       dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       @DIAS_COBRO                                  AS diasCobro,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)              AS TITULO_PLANTILLAS,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario_financiacion fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = ''Vigente'')          AS FIRMA,
       (SELECT TOP 1 Concat(fun.titulo_obtenido, '' '', pf.nombre1, '' '',
                     pf.nombre2, '' '',
                     pf.apellido1,
                                   '' '', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario_financiacion fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = ''Vigente'')          AS NOMBRE_DELEGADO,
       (SELECT TOP 1 Concat(ca.nombre, ''.  -'', f.memo_nombramiento, ''  '',
                                   RIGHT ( ''0'' + CONVERT ( VARCHAR (2), Day
                                   (f.fecha_nombramiento)),
                                   2)
                                                                          +
                                   '' de ''
                                                                          +
                                   Datename(
                                   month,
                     f.fecha_nombramiento)
                                                                          +
                                   '' del ''
                                                                          +
                                   CONVERT (
                                   VARCHAR (4),
                                   Year
                                   (f.fecha_nombramiento)), ''.'')
        FROM   funcionario_financiacion f
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN cargo ca (nolock)
                       ON f.id_cargo = ca.id_cargo
        WHERE  f.fecha_final_vigencia IS NULL)      AS cargo_delegado,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp
        WHERE  fp.id_persona = pe.id_persona)       AS IMAGEN_FIRMA_PERSONA
FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       JOIN persona pe
         ON pe.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = f.id_deudor
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN proceso p
         ON p.id_proceso = f.id_proceso
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='ID_FINANCIACION,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,TASA_INTERES,VALOR_INT,VALOR_OBLIGACIONES,VALOR_TOTAL,TOTAL_FINANCIADO,PORCENTAJE_CUOTA1,NUMERO_CUOTAS,NUMERO_PAGO,numero_consecutivo,DIAS_COBRO,TITULO_PLANTILLAS,IMAGEN_FIRMA_TRES,NOMBRE_DELEGADO,CARGO_DELEGADO,IMAGEN_FIRMA_CUATRO'
WHERE  id_plantilla_config=29

commit tran





