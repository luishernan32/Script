--***********************************************************************************************************************                           
--*						   --IMPUGNACION SIN SOLUCION INMEDIATA                                                         *
--***********************************************************************************************************************

--COA_A_I_R_D 3673 10080 tiene dos id_plantilla config
--COA_FM_AI 3674 10185  listo script
--COA_AUTO_INC_FDS 3675 10186 listo script
--COA_AU_EV_PP 3676 10179 listo script
--COA_FOT_PP_PP 3677 10180 listo script

--COAMTVACT_DP_SPP 3678 10181 listo script
--COA_MTV_MDCT_SPP 3680 no tiene id_plantilla_config
--AI_EXV_SGPS_TP 3681 10184 10085 listo script

--MTV_SP_DCT_NO_MEMO 3682 10182 listo script
--COA_A_EV_AU 3683 no tiene id_plantilla_config 
--COA_PPI_AU_PP 3684 10085 listo script
--AUTO_INICIAL_PRUEBA 3685 12 tiene dos id_plantilla_config
--COA_EXC_VEL_INF_ATD 3686 No tiene id_plantilla_config
--COA_EXC_VEL_FDS 3687 No tiene id_plantilla_config
--COA_VACT_PP_AI 3688 No tiene id_plantilla config

--(3673,3674,3675,3676,3677,3678,3680,3681,3682,3683,3684,3685,3686,3687,3688)

--***********************************************************************************************************************
--Temporal

--PLANTILLAS SENCILLAS

--COA_FM_AI 3674 10185  listo script
--COA_AUTO_INC_FDS 3675 10186 listo script
--COA_AU_EV_PP 3676 10179 listo script
--COA_FOT_PP_PP 3677 10180 listo script
--COAMTVACT_DP_SPP 3678 10181 listo script
--AI_EXV_SGPS_TP 3681 10184 10085 listo script
--MTV_SP_DCT_NO_MEMO 3682 10182 listo script 
--COA_PPI_AU_PP 3684 10085 listo script



--TIENES DOS ID_PLANTILLA_CONFIG
--COA_A_I_R_D 3673 10080 tiene dos id_plantilla config Ok con id_plantilla_config=10178
--AUTO_INICIAL_PRUEBA 3685 id_plantilla_config=12 tiene dos id_plantilla_config oK con el id_config==10183




--COA_MTV_MDCT_SPP 3680 no tiene id_plantilla_config
--COA_EXC_VEL_INF_ATD 3686 No tiene id_plantilla_config
--COA_EXC_VEL_FDS 3687 No tiene id_plantilla_config
--COA_VACT_PP_AI 3688 No tiene id_plantilla config
--COA_A_EV_AU 3683 no tiene id_plantilla_config




--***********************************************************************************************************************
--Impugnación sin solución inmediata	COA - Auto inicial	                                                                      COA_A_I_R_D Ok con id_plantilla_config=10178
--Impugnación sin solución inmediata	COA - FOTOMULTAS - Auto inicial	                                                          COA_FM_AI    ok
--Impugnación sin solución inmediata	COA AUTO INICIAL FDS	                                                                  COA_AUTO_INC_FDS ok
--Impugnación sin solución inmediata	COA - Exc. Vel. / Pruebas pertinentes	                                                  COA_AU_EV_PP Ok
--Impugnación sin solución inmediata	COA - FOTOMULTAS pruebas pertinentes - Período prueba	                                  COA_FOT_PP_PP  ok
--Impugnación sin solución inmediata	COA - MTV ACT dio paso - sin período de prueba	                                          COAMTVACT_DP_SPP * COAMTVACT_DP_SPP ok
--Impugnación sin solución inmediata	COA - MTV Memo DCT - sin período de prueba	                                              COA_MTV_MDCT_SPP

--Impugnación sin solución inmediata	Exceso de velocidad - sistema GPS - Transporte Público	                                  AI_EXV_SGPS_TP  ok 


--Impugnación sin solución inmediata	MTV SIN PERIODO DE PRUEBA NO MEMO DCT	                                                  MTV_SP_DCT_NO_MEMO ok
--Impugnación sin solución inmediata	COA - Exceso de velocidad	                                                              COA_A_EV_AU
--Impugnación sin solución inmediata	COA - Pruebas pertinentes - Período prueba	                                              COA_PPI_AU_PP  ok


--Impugnación sin solución inmediata	Auto inicial	                                                                          AUTO_INICIAL_PRUEBA  *     AUTO_INICIAL_PRUEBA_10183


--Impugnación sin solución inmediata	COA EXCESO DE VELOCIDAD INFORMÁTICA	                                                      COA_EXC_VEL_INF_ATD
--Impugnación sin solución inmediata	Coa exceso de velocidad FDS	                                                              COA_EXC_VEL_FDS
--Impugnación sin solución inmediata	COA - versión ACT - período de prueba	                                                  COA_VACT_PP_AI

--***********************************************************************************************************************
--OBSERVACIONES: APELACION_REG_FALLO presenta error y las plantillas COA_D_P_F_ABS y COA_IMCL_SN_DC_P no tienen id_config
--***********************************************************************************************************************

--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='AUTO_INICIAL_PRUEBA'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-01' where id_plantilla in(3673,3674,3675,3676,3677,3678,3680,3681,3682,3683,3684,3685,3686,3687,3688)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(3673,3674,3675,3676,3677,3678,3680,3681,3682,3683,3684,3685,3686,3687,3688)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3685--3673--3684--3682--3681--3678--3675--
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
WHERE  id_plantilla_config=10183XX

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


