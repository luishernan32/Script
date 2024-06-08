--***********************************************************************************************************************                           
--*						   -- PROCESO: Devolucion de valores x2                  *
--***********************************************************************************************************************
--APERT_DEV_SIN_TERC 4695 10123    "No hay que modificar la variable"  
--CIERRE_PRUEBAS_DEVOL 4696 10125  "No hay que modificar la variable"    https://www.youtube.com/watch?v=yDPctOPubuo min 2:30 exitoso

--(4695,4696)
--*************************************************************************************
--*************************************************************************************

--Devolucion de valores	Apertura Devolucion Valores	APERT_DEV_SIN_TERC    https://www.youtube.com/watch?v=m5uTEoA95bk
--Devolucion de valores	Cierre Pruebas Devolucion	CIERRE_PRUEBAS_DEVOL   7577134 con este dato se genero    1 hora :05 encuentro como se genera https://www.youtube.com/watch?v=GeFrrZh-yW8 Le falta

--*************************************************************************************
--*************************************************************************************
-- felipe.larreategui Admin123* con este usuario puedo aprobar y rechazar fallos 
--El fallo se puede aprobar con Felipe
--Andrea puede gestionar

--Los que aprueban los fallos son los delegados

--***********************************************************************************************************************

--Videos y descripcion
--Entrar con el rol del financiador: PROCESOS JURIDICOS ----- Gestionar devolucion de valores-----radicar expediente ----motivacion  


--min 50 inactiva usuario
--***********************************************************************************************************************
--Temporal

--Dato utilizado numero de obligacion: 12028982
--Recuperar la consulta de activar y inactiva usuarios

--***********************************************************************************************************************
--OBSERVACIONES: Hay que utilizar una query que se encuentra en la parte inferior de está hoja
--En la generacion de estás plantillas hay que utilizar el rol de financiador

--***********************************************************************************************************************

--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='APERT_DEV_SIN_TERC'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-06-06' where id_plantilla in(4695,4696)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(4695,4696)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2490--4695 3694--3695 --3693--2383--2621--2259--2289--2287--2288--2287--2286--2639--2625--2258--2258--3692--3690--
--Impugnación de comparendo	Apertura impugnación sin tercero	APERT_IMPUG_SIN_TERC
																																	   *
select top 20 *from [documentos].[dbo].[documento] order by 1 desc																	   *
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
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Devolución de valores
select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion
from comparendo c inner join comparendo_persona cp on c.cicomparendo=cp.cicomparendo
where c.id_estado_comparendo in(3,7,19,20)
and fecha_infraccion>'2019-12-31'
order by c.fecha_infraccion
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Para ejecutar el JOB hay que lanzar este query
--ejecutar job JobCierreSubsanacionDevolucionValores

SELECT sdv.* FROM subsanacion_devolucion_valores  sdv
LEFT JOIN trazabilidad_proceso tp ON sdv.id_trazabilidad_proceso= tp.id_trazabilidad_proceso
LEFT JOIN proceso p ON tp.id_proceso=p.id_proceso
WHERE tp.id_estado_proceso = 74
AND tp.fecha_fin is null AND p.id_tipo_proceso =13
--AND GETDATE() > sdv.fecha_fin
order by 1 desc
 
begin tran
update circulemos2.dbo.subsanacion_devolucion_valores
set fecha_fin = convert(date,'2023-12-29')
where id_subsanacion_devolucion_valores =3
commit tran

----------------------------------------------------------------------

update circulemos2.dbo.subsanacion_devolucion_valores
set fecha_fin = convert(date,'2024-05-17')
where id_subsanacion_devolucion_valores =9--8--7--3
commit tran


select *from devolucion_valores
where obligacion=7572282--7572081   ---La obligacion es el id_facttura axis

select *from trazabilidad_proceso
where id_proceso=2931748--2931747--2931746

begin tran
update trazabilidad_proceso
set fecha_inicio=convert(date,'2024-04-17')
where id_trazabilidad_proceso=18210184--18210181--18210178
commit tran
--7577076
select *from devolucion_valores
where obligacion=7577076   ---La obligacion es el id_facttura axis

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Devolución de valores
select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion
from comparendo c inner join comparendo_persona cp on c.cicomparendo=cp.cicomparendo
where c.id_estado_comparendo in(3,7,19,20)
and fecha_infraccion>'2019-12-31'
order by c.fecha_infraccion


-------------------------------------------------------------------------------







--07/06/2024
--UPDATE APERT_DEV_SIN_TERC
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT DISTINCT pr.numero_proceso,
                c.numero_citacion,
                CASE pe.id_tipo_identificacion
                  WHEN ''2'' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2,
                             '' '', pe.apellido1,
                       '' '', pe.apellido2))
                END                                          AS nombreInfractor,
                pr.fecha_inicio                              AS anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)        fijo,
                dbo.Telefonopersona(pe.id_persona, 2)        celular,
                COALESCE(Stuff(devVal.correos_notificados,
                         Len(devVal.correos_notificados) -
                                  Charindex('','',
                Reverse(devVal.correos_notificados)) + 1, 1,
                '' ''), devVal.correos_notificados)            correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
                di.complemento                               AS
                direccionInfraccion,
                mp.descripcion_hechos,
                CASE i.numeral_infraccion
                  WHEN '' '' THEN Concat(''Artículo '', ci.articulo,
                                '' - '', nm.nombre)
                  ELSE Concat(''Artículo '', ci.articulo,
'', numeral '', i.numeral_infraccion, '' - '', nm.nombre)
END                                          AS infraccion,
ci.descripcion,
c.fecha_infraccion,
CASE pe.id_tipo_identificacion
WHEN ''2'' THEN pj.nombre_comercial
ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1,
'' '', pe.apellido2))
END                                          AS nombreCompleto,
cv.placa_vehiculo,
ecv.nombre_estado_civil,
pe.edad,
pro.nombre                                   AS profesion,
mp.pruebas_aportadas                         AS pruebasAportadas,
mp.otros,
Isnull(ivai.codigo_operador_agente, '''')      codigoAgente,
Upper(Concat (pas.nombre1, '' '', pas.nombre2, '' '',
pas.apellido1, '' '', pas.apellido2))    AS nombreAsesor,
tpf.fecha_inicio                             AS fechaSolicitud,
tpf.fecha_inicio                             AS horaSolicitud
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN devolucion_valores devVal (nolock)
         ON devVal.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN pruebas_aportadas pat (nolock)
              ON pat.id_pruebas_aportadas = mp.id_pruebas_aportadas
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       LEFT JOIN direccion di (nolock)
              ON di.id_direccion = c.id_direccion_comparendo
       LEFT JOIN integracion_terceros..v_all_infracciones ivai (nolock)
              ON c.id_factura_axis = ivai.numero_factura
                 AND c.numero_citacion = ivai.numero_citacion
                 AND c.codigo_medio_imposicion = 1
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,numero_citacion,NOMBRE_INFRACTOR,anio_apertura_proceso,fecha_apertura_impug,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,NUMERO_CELULAR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,DIRECCION_INFRACCION,desc_motivacion,ARTICULO,DESCRIPCION_INFRACCION,fecha_imposicion,NOMBRE_COMPLETO,PLACA_VEHICULO,ESTADO_CIVIL,EDAD,PROFESION,PRUEBAS_APORTADAS,OTROS_COA,CODIGO_AGENTE,NOMBRE_FUNCIONARIO,FECHA_SOLICITUD,HORA_SOLICITUD,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10123

commit tran






------------------------------------------------------------------------------------------------

--modificar APERT_DEV_SIN_TERC
SELECT DISTINCT pr.numero_proceso,
                c.numero_citacion,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2,
                             ' ', pe.apellido1,
                       ' ', pe.apellido2))
                END                                          AS nombreInfractor,
                pr.fecha_inicio                              AS anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)        fijo,
                dbo.Telefonopersona(pe.id_persona, 2)        celular,
                COALESCE(Stuff(devVal.correos_notificados,
                         Len(devVal.correos_notificados) -
                                  Charindex(',',
                Reverse(devVal.correos_notificados)) + 1, 1,
                ' '), devVal.correos_notificados)            correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
                di.complemento                               AS
                direccionInfraccion,
                mp.descripcion_hechos,
                CASE i.numeral_infraccion
                  WHEN ' ' THEN Concat('Artículo ', ci.articulo,
                                ' - ', nm.nombre)
                  ELSE Concat('Artículo ', ci.articulo,
', numeral ', i.numeral_infraccion, ' - ', nm.nombre)
END                                          AS infraccion,
ci.descripcion,
c.fecha_infraccion,
CASE pe.id_tipo_identificacion
WHEN '2' THEN pj.nombre_comercial
ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1,
' ', pe.apellido2))
END                                          AS nombreCompleto,
cv.placa_vehiculo,
ecv.nombre_estado_civil,
pe.edad,
pro.nombre                                   AS profesion,
mp.pruebas_aportadas                         AS pruebasAportadas,
mp.otros,
Isnull(ivai.codigo_operador_agente, '')      codigoAgente,
Upper(Concat (pas.nombre1, ' ', pas.nombre2, ' ',
pas.apellido1, ' ', pas.apellido2))    AS nombreAsesor,
tpf.fecha_inicio                             AS fechaSolicitud,
tpf.fecha_inicio                             AS horaSolicitud
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr (nolock)
       JOIN devolucion_valores devVal (nolock)
         ON devVal.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN pruebas_aportadas pat (nolock)
              ON pat.id_pruebas_aportadas = mp.id_pruebas_aportadas
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       LEFT JOIN direccion di (nolock)
              ON di.id_direccion = c.id_direccion_comparendo
       LEFT JOIN integracion_terceros..v_all_infracciones ivai (nolock)
              ON c.id_factura_axis = ivai.numero_factura
                 AND c.numero_citacion = ivai.numero_citacion
                 AND c.codigo_medio_imposicion = 1
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso 




--------------------------------------------------------------------
--Original APERT_DEV_SIN_TERC
--numero_consecutivo,numero_citacion,NOMBRE_INFRACTOR,anio_apertura_proceso,fecha_apertura_impug,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,TELEFONO_INFRACTOR,NUMERO_CELULAR,CORREO_ELECTRONICO_INFRACTOR,DIRECCION_INFRACTOR,DIRECCION_INFRACCION,desc_motivacion,ARTICULO,DESCRIPCION_INFRACCION,fecha_imposicion,NOMBRE_COMPLETO,PLACA_VEHICULO,ESTADO_CIVIL,EDAD,PROFESION,PRUEBAS_APORTADAS,OTROS_COA,CODIGO_AGENTE,NOMBRE_FUNCIONARIO,FECHA_SOLICITUD,HORA_SOLICITUD
SELECT DISTINCT pr.numero_proceso,
                c.numero_citacion,
                CASE pe.id_tipo_identificacion
                  WHEN '2' THEN pj.nombre_comercial
                  ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2,
                             ' ', pe.apellido1,
                       ' ', pe.apellido2))
                END                                          AS nombreInfractor,
                pr.fecha_inicio                              AS anio_apertura,
                pr.fecha_inicio,
                tip.codigo,
                pe.numero_identificacion,
                dbo.Telefonopersona(pe.id_persona, 1)        fijo,
                dbo.Telefonopersona(pe.id_persona, 2)        celular,
                COALESCE(Stuff(devVal.correos_notificados,
                         Len(devVal.correos_notificados) -
                                  Charindex(',',
                Reverse(devVal.correos_notificados)) + 1, 1,
                ' '), devVal.correos_notificados)            correo,
                dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
                di.complemento                               AS
                direccionInfraccion,
                mp.descripcion_hechos,
                CASE i.numeral_infraccion
                  WHEN ' ' THEN Concat('Artículo ', ci.articulo,
                                ' - ', nm.nombre)
                  ELSE Concat('Artículo ', ci.articulo,
', numeral ', i.numeral_infraccion, ' - ', nm.nombre)
END                                          AS infraccion,
ci.descripcion,
c.fecha_infraccion,
CASE pe.id_tipo_identificacion
WHEN '2' THEN pj.nombre_comercial
ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1,
' ', pe.apellido2))
END                                          AS nombreCompleto,
cv.placa_vehiculo,
ecv.nombre_estado_civil,
pe.edad,
pro.nombre                                   AS profesion,
mp.pruebas_aportadas                         AS pruebasAportadas,
mp.otros,
Isnull(ivai.codigo_operador_agente, '')      codigoAgente,
Upper(Concat (pas.nombre1, ' ', pas.nombre2, ' ',
pas.apellido1, ' ', pas.apellido2))    AS nombreAsesor,
tpf.fecha_inicio                             AS fechaSolicitud,
tpf.fecha_inicio                             AS horaSolicitud
FROM   proceso pr (nolock)
       JOIN devolucion_valores devVal (nolock)
         ON devVal.id_proceso = pr.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN motivacion_impugnacion mp (nolock)
         ON mp.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       LEFT JOIN pruebas_aportadas pat (nolock)
              ON pat.id_pruebas_aportadas = mp.id_pruebas_aportadas
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       LEFT JOIN comparendo_vehiculo cv
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN estado_civil ecv (nolock)
              ON ecv.id_estado_civil = pe.id_estado_civil
       LEFT JOIN profesion pro (nolock)
              ON pro.id_profesion = pe.id_profesion
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN direccion_persona dp (nolock)
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion dir (nolock)
              ON dir.id_direccion = dp.id_direccion
       LEFT JOIN direccion di (nolock)
              ON di.id_direccion = c.id_direccion_comparendo
       LEFT JOIN integracion_terceros..v_all_infracciones ivai (nolock)
              ON c.id_factura_axis = ivai.numero_factura
                 AND c.numero_citacion = ivai.numero_citacion
                 AND c.codigo_medio_imposicion = 1
       INNER JOIN usuario_persona up (nolock)
               ON tp.id_usuario = up.id_usuario
       INNER JOIN persona pas (nolock)
               ON up.id_persona = pas.id_persona
       LEFT JOIN trazabilidad_proceso tpf
              ON tpf.id_proceso = pr.id_proceso
                 AND tpf.id_trazabilidad_proceso =
                     (SELECT Max(tp1.id_trazabilidad_proceso)
                      FROM   trazabilidad_proceso tp1 (nolock)
                             INNER JOIN proceso p1 (nolock)
                                     ON tp1.id_proceso =
                                        p1.id_proceso
                                        AND p1.id_proceso =
                                            pr.id_proceso)
WHERE  pr.id_proceso = :idProceso 