--PROVIDENCIA_ANULAR 4763 10061 las pruebas se tienen que hacer con el usuario FINANCIADOR
--"Va a la par con PROVIDENCIA_PAGO"
--La variable del delegado se presenta en código por ello fue mejor traerla en el Script para mejor manipulación

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437) AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS,
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
               AND fun.estado = ''Vigente'')                 AS NOMBRE_DELEGADO
FROM   proceso p
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,CARGO_DELEGADO,TITULO_PLANTILLAS,IMAGEN_FIRMA,NOMBRE_DELEGADO'
WHERE  id_plantilla_config=10061

commit tran
-------------------------------------------------------
-------------------------------------------------------
--Se tiene que hacer un insert

INSERT INTO documentos..variable_plantilla
SELECT 4763, 268

INSERT INTO documentos..variable_plantilla
SELECT 4763, 1376

--NOMBRE_DELEGADO	268
--FIRMA_FUNCIONARIO_	1376
--Ver las variables
select nombre_variable,va.id_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='4763'

---------------------------------------------------------
-------------------------------------------------------
begin tran 
update documentos..plantilla set fecha_inicio='2024-07-29' where id_plantilla=4764
update documentos..plantilla set fecha_inicio='2024-07-31' where id_plantilla=4764
update documentos..plantilla set fecha_fin=null where id_plantilla=4762
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_ANULAR';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS






--Modifcada
-------------------------------------------------------------------------------------
--Es antigua por lo gneral es de omitir
SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
WHERE  p.id_proceso = :idProceso 



-------------------------------------------------------------------
--30/07/2024
SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437) AS cargo_delegado,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS,
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
               AND fun.estado = 'Vigente')                 AS NOMBRE_DELEGADO
FROM   proceso p
WHERE  p.id_proceso = :idProceso 

--order variables: numero_consecutivo,anio_apertura_proceso,CARGO_DELEGADO,TITULO_PLANTILLAS
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT p.numero_proceso,         p.fecha_inicio,      (SELECT upper(valor_parametro_defecto)          FROM   parametro(nolock)          WHERE  codigo_parametro = 434) AS cargo_delegado  FROM   proceso p  WHERE  p.id_proceso = :idProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--30/07/2024
SELECT p.numero_proceso,         p.fecha_inicio,         (SELECT Upper(valor_parametro_defecto)          FROM   parametro(nolock)          WHERE  codigo_parametro = 437) AS cargo_delegado    ,(SELECT valor_parametro_defecto          FROM   parametro(nolock)          WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS  FROM   proceso p  WHERE  p.id_proceso = :idProceso 
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



--nombre_variable	id_variable
--T_DOCUMENTO_INFRACTOR	99
--N_DOCUMENTO_INFRACTOR	100
--NOMBRE_INFRACTOR	102
--PLACA_VEHICULO	113
--DESCRIPCION_INFRACCION	115
--numero_citacion	159
--fecha_actual	161
--FECHA_SOLICITUD	210
--VALOR_RECARGOS	219
--DIRECCION_INFRACCION	241
--NOMBRE_DELEGADO	268
--CARGO_DELEGADO	285
--HORA	299
--NOMBRE_AGENTE	1333
--CONSECUTIVO_ORDEN_COBRO	1369
--TITULO	1370
--VALOR_MULTA	1371
--CIUDAD_INFRACCION	1372
--FECHA_INFRACCION	1373
--PLACA_AGENTE	1374
--FIRMA_AGENTE	1375
--FIRMA_FUNCIONARIO_	1376
--LogoATM_variable	1392
--TITULO_PLANTILLAS	1448



UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10061

commit tran

----------------------------------------
--Query
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