--IMPUGNACION SIN SOLUCION INMEDIATA

--COA_A_I_R_D Presenta error en crear una nueva version
--COA_FM_AI
--COA_AUTO_INC_FDS
--COA_AU_EV_PP
--COA_FOT_PP_PP
--COAMTVACT_DP_SPP
--COA_MTV_MDCT_SPP

--TITULO_PLANTILLAS
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZ�N
update documentos..plantilla set fecha_inicio='2024-04-26' where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran



-- C�digos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISI�N DE LAS PLANTILLAS GENERADAS****************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2626--2659--2648--2604  -    *
--Impugnaci�n de comparendo	Apertura impugnaci�n sin tercero	APERT_IMPUG_SIN_TERC
																																	   --*
select top 20 *from [documentos].[dbo].[documento] order by 1 desc																	   
--****************************************************************************************************************************************

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
--Query para traer est� texto
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   
WHERE  id_plantilla_config=54


commit tran

-------------------------------------------------------------------------------




begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=10076xx

commit tran
