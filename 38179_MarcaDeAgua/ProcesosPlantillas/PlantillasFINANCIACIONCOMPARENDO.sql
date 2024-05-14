--***********************************************************************************************************************                           
--*						   --FINANCIACION COMPARENDO                                                      *
--***********************************************************************************************************************

--CONVENIO_MULTA lleva variable 3689 Falta con el id_plantilla_config==30 Variable ok  lanzar el job de replicar pago                                                            https://www.youtube.com/watch?v=SEfcS9BIK8A                               https://www.youtube.com/watch?v=mMJns0A5pCo
--VOLANTE_PAGO lleva variable 3690 RUTA: cartera-consultar convenios-imprimir recibo de pago  variable ok prueba ok                                                              https://www.youtube.com/watch?v=mMJns0A5pCo
--ACUERDO_PAGO 3691  RUTA: cartera-consultar convenios- seguimientos- solicitud                                                                                                  https://www.youtube.com/watch?v=mMJns0A5pCo
--+ AMORTIZACION lleva variable 3692   RUTA: cartera-consultar convenios-imprimir cuadro amortizacion prueba ok                                                                  https://www.youtube.com/watch?v=mMJns0A5pCo

--(3689,3690,3691,3692)



--********************************************************************************************

--Financiación comparendo	CONVENIO_MUTAS	CONVENIO_MULTA
--Financiación comparendo	Volante de pago	VOLANTE_PAGO
--Financiación comparendo	Acuerdo de pago	ACUERDO_PAGO
--Financiación comparendo	cuadroAmortizacion	AMORTIZACION

--***********************************************************************************************************************
--Temporal



--***********************************************************************************************************************
--OBSERVACIONES: 
--***********************************************************************************************************************

--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='AMORTIZACION'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-06' where id_plantilla in(3689,3690,3691,3692)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(3689,3690,3691,3692)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3690--3692--3690--
--Impugnación de comparendo	Apertura impugnación sin tercero	APERT_IMPUG_SIN_TERC
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
WHERE  id_plantilla_config=31xx

commit tran





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------
--Se intentarón obtener los titulos

SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437


			   SELECT Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ',
               p.apellido1, ' ',
                       p.apellido2)
        FROM   funcionario f (nolock)
               JOIN persona p (nolock)
                 ON f.id_persona = p.id_persona
        WHERE  id_cargo = 11
               AND fecha_final_vigencia IS NULL


--Ab. ERIKA JAQUELINE ZAMBRANO REYNA

------------------------------------------------------------------------

------------------------------------------------------------------------

select *from funcionario

Concat(fu.titulo_obtenido,' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,



SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente'

--Abg. Esp. FRANCISCO XAVIER ROJAS ESTEVES

----------------------------------------------------------

select --per.nombre1, per.nombre2
*from funcionario fu
inner join persona per on per.id_persona=fu.id_persona 
where id_funcionario=154
order by 1 desc


select per.nombre1, per.nombre2, fu.titulo_obtenido
from funcionario fu
inner join persona per on per.id_persona=fu.id_persona 
where id_funcionario=154
order by 1 desc


--CONNY YANINA ARREGUI MIRANDA
--DELEGADO DEL DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO
--DE INFRACCIONES Y SERVICIOS DE TRÁNSITO 136 cony



------------------------------------------------------------------


select *from plantilla_configuracion
where id_plantilla


select *from plantilla_configuracion
order by id_plantilla  desc
where id_plantilla=1430

-----------------------------------------------------------------------------

--GENERACION DE LA PLANTILLA CONVENIO_MULTA
select * from pago where id_pago=2278385
select * from detalle_pago where numero_obligacion='10610171'
Select top 10000 * from integracion_terceros..it_recaudo order by 1 desc  --Consultar despues de ejecutar los sps
update integracion_terceros..it_recaudo set estado_lectura=1 where id_recaudo=4032288
select top 100 * from pago order by 1 desc
select top 100 * from detalle_pago where numero_obligacion='5358' order by 1 desc
select * from estado_pago
select * from detalle_pago_conci_error order by 1 desc
select * from error_conciliacion_pago
Select top 100 * from integracion_terceros..it_recaudo_ncr order by fecha_creacion desc
Select top 30 * from recaudo_rechazo where numero_obligacion=535865 order by id_recaudo_rechazo desc
Select * from detalle_recaudo_rechazo where id_recaudo_rechazo=106916
select * from tipo_rechazo_recaudo


--SPS para replica de pagos
exec integracion_terceros.dbo.dba_axis_info_v_pagos_pre
exec integracion_terceros.dbo.dba_axis_info_v_detalles_pagos_pre
exec integracion_terceros.dbo.obtenerPagos '11001'

-----------------------------------------------------------------------------