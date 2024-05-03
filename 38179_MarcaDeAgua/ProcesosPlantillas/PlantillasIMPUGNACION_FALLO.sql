--******************IMPUGNACION FALLO**********************

--REGISTRO_FALLO 2662 2 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada "Ver imagenes"
--APELACION_REG_FALLO 2663 10095  Presenta fallo
--ARCH_DESIST_COND 2664 10194 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada
--COA_JUNIO_2019 2665 10195 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query   Generada

--REG_FALL_CONS_PP 2666 10196 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada
--COA_SV_ACT_FC 2667 10198 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL Generada

--***********************************************************************************************
--COA_D_P_F_ABS 2668  no tiene id_plantilla config Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL
--COA_IMCL_SN_DC_P  2669  no tiene id_plantilla config Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL
--***********************************************************************************************
--COA_ACT_NV_FA 2672 10199 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada



--(2662,2663,2664,2665,2666,2667,2668,2669,2672)

--********************************************************/
--************************importante**********************/
--Ver los nombres ya que se generar en una sola pantalla
--*********************************************************


--Registro fallo	                                                           REGISTRO_FALLO
--Apelación -  Registro Fallo *                                                APELACION_REG_FALLO
--Desistimiento - Archivo - Fallo condenatorio	                               ARCH_DESIST_COND
--junio 2019 coa	                                                           COA_JUNIO_2019
--Registro fallo - Con período probatorio	                                   REG_FALL_CONS_PP
--COA - Sí vino ACT - Fallo condenatorio	                                   COA_SV_ACT_FC
--COA - Docs de prueba - Fallo absolutorio	                                   COA_D_P_F_ABS
--COA - Imagen clara sin docs de prueba - Fallo condenatorio	               COA_IMCL_SN_DC_P
--COA - ACT no vino - Fallo absolutorio	                                       COA_ACT_NV_FA


--***********************************************************************************************************************
--OBSERVACIONES: APELACION_REG_FALLO presenta error y las plantillas COA_D_P_F_ABS y COA_IMCL_SN_DC_P no tienen id_config
--***********************************************************************************************************************


--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'COA_ACT_NV_FA';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-04-30' where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669,2672)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran



-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669,2672)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2672--2667--2666--2664--2659--2633--2664--2659--2662--2659--2648--2604  -    *
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


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   
WHERE  id_plantilla_config=54


commit tran

-------------------------------------------------------------------------------


--COA_D_P_F_ABS 2668  no tiene id_plantilla config 
--COA_IMCL_SN_DC_P  2669  no tiene id_plantilla config 

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
WHERE  id_plantilla_config=10199xx

commit tran

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

