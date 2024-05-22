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
set @codigoPlantilla ='CIERRE_PRUEBAS_DEVOL'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-16' where id_plantilla in(4695,4696)
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

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=11xx

commit tran





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