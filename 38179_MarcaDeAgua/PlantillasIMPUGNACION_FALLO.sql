--******************IMPUGNACION FALLO**********************

--REGISTRO_FALLO 2662 2 Tiene AUTORIDAD DE TR�NSISTO MUNICIPAL
--APELACION_REG_FALLO 2663 10095
--ARCH_DESIST_COND 2664 10194
--COA_JUNIO_2019 2665 10195
--REG_FALL_CONS_PP 2666 10196 Tiene AUTORIDAD DE TR�NSISTO MUNICIPAL
--COA_SV_ACT_FC 2667 10198 Tiene AUTORIDAD DE TR�NSISTO MUNICIPAL
--COA_D_P_F_ABS 2668  no tiene id_plantilla config Tiene AUTORIDAD DE TR�NSISTO MUNICIPAL
--COA_IMCL_SN_DC_P  2669  no tiene id_plantilla config Tiene AUTORIDAD DE TR�NSISTO MUNICIPAL

--(2662,2663,2664,2665,2666,2667,2668,2669)


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
update documentos..plantilla set fecha_inicio='2024-04-27' where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- C�digos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISI�N DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2602--2648--2604  -    *
--Impugnaci�n de comparendo	Apertura impugnaci�n sin tercero	APERT_IMPUG_SIN_TERC
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
