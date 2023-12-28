-------------------------------------------------------------------------------------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'COA_A_I_R_D';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Witch the query top they are modific plantillas "witch the id"
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--REGISTRO_FALLO SI OKKKK * id_plantilla_config=2 id_plantilla=48 "Se utiliza para los insert"
--APELACION_REG_FALLO Noooo id_plantilla_config=  id_plantilla=
--ARCH_DESIST_COND si okkk * id_plantilla_config=10181 ** id_plantilla=1350

--COA_JUNIO_2019 si okkkk * id_plantilla_config=10182 ** id_plantilla=1719 
--REG_FALL_CONS_PP si okkk * id_plantilla_config=10183 ** id_plantilla=1357
--COA_ACT_NV_FA si okkk id_plantilla_config= 10184 ** id_plantilla=10184
--COA_SV_ACT_FC SI okkk ---id_plantilla_config=10185 ** id_plantilla=1412
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas_2
--COA - Auto inicial	COA_A_I_R_D	2020
--COA - FOTOMULTAS - Auto inicial	COA_FM_AI	1638
--COA AUTO INICIAL FDS	COA_AUTO_INC_FDS	689
--COA - Exc. Vel. / Pruebas pertinentes	COA_AU_EV_PP	682
--COA - FOTOMULTAS pruebas pertinentes - Período prueba	COA_FOT_PP_PP	241
--COA - MTV ACT dio paso - sin período de prueba	COAMTVACT_DP_SPP	42
--MTV SIN PERIODO DE PRUEBA NO MEMO DCT	MTV_SP_DCT_NO_MEMO	3
--COA - Pruebas pertinentes - Período prueba	COA_PPI_AU_PP	2
--Auto inicial	AUTO_INICIAL_PRUEBA	2
--Exceso de velocidad - sistema GPS - Transporte Público	AI_EXV_SGPS_TP	1
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COA_A_I_R_D
--COA_FM_AI
--COA_AUTO_INC_FDS
--COA_AU_EV_PP
--COA_FOT_PP_PP
--COAMTVACT_DP_SPP
--MTV_SP_DCT_NO_MEMO
--COA_PPI_AU_PP
--AUTO_INICIAL_PRUEBA
--AI_EXV_SGPS_TP


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin tran
update documentos..plantilla set fecha_fin='2023-06-14' where id_plantilla=2523
update documentos..plantilla set fecha_inicio='2023-06-15' where id_plantilla=2550
commit tran

--begin tran
--update documentos..plantilla set fecha_fin='2023-06-06' where id_plantilla=2505
--update documentos..plantilla set fecha_inicio='2023-06-07' where id_plantilla=2542
--commit tran

--



begin tran
update documentos..plantilla set fecha_fin='2023-06-08' where id_plantilla=2519
update documentos..plantilla set fecha_inicio='2023-06-07' where id_plantilla=2519
commit tran



select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

--select *from cargo  --id_cargo=11
--select *from funcionario where id_cargo=11 and fecha_final_vigencia is null