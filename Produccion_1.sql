--Impugnación sin solución inmediataX15

--x7 Certificados QA
--COA_A_I_R_D  id_plantilla=2631*
--COA_FM_AI id_plantilla=2632*
--COA_AUTO_INC_FDS id_plantilla=2633*
--COA_AU_EV_PP id_plantilla=2634 *
--COA_FOT_PP_PP id_plantilla=2635* 
--COAMTVACT_DP_SPP id_plantilla=2636*
--COA_MTV_MDCT_SPP id_plantilla=2637*

--(2631,2632,2633,2634,2635,2636,2637)

--------------------------------------------------------------------------------------------------------------------------------------
-----Impugnación cierre de pruebas-----------------------Proceso-----------------------------------------------------------------------

--COA - Cierre de pruebas	COA_CP 2738

--PRODUCCION 2546
--------------------------------------------------------------------------------------------------------------------------------------
---------------------Proceso Produccion------------Impugnación proceso de pruebas-----------------------------------------------------------------------------------------------------

--18/01/2024	
	--Memo solicitud de pruebas	MEMO_SOLICIT_PRUEBAS	 2100
	--Oficio de solicitud de pruebas	OFICIO_SOLIC_PRUEBAS	 2099

--------------------------------------------------------------------------------------------------------------------------------------


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'OFICIO_SOLIC_PRUEBAS';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)


select  * from documentos..firma_plantilla where id_plantilla = 2558