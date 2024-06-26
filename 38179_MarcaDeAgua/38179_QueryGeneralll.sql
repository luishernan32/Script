select *from [documentos].[dbo].[plantilla] where id_plantilla=2664--2663

select top 5 *from [documentos].[dbo].[documento] order by 1 desc


-----------------------------------------------------------------------------
select top 100 *from coactivo where id_tipo_coactivo=4  order by 1 desc

-----------------------------------------------------------------------------

--APELACION_REG_FALLO
--REGISTRO_FALLO

--N	C�digo Plantilla	id_plantilla_config	id_plantilla
--1	REGISTRO_FALLO	2	48
--1	APELACION_REG_FALLO	NO	
--1	ARCH_DESIST_COND	10181	1350  *****
--1	COA_JUNIO_2019	10182	1719 *****
--1	REG_FALL_CONS_PP	10183	1357
--1	COA_ACT_NV_FA	10184	10184
--1	COA_SV_ACT_FC	10185	1412

----------------------------------------

---------------------------------------------------------------------------------------------------------------
-----------------------------------------------Impugnaci�n fallo x 9-------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Revisado 31/12/2023

-- REGISTRO_FALLO  ok   id_plantilla=2619
--APELACION_REG_FALLO ok id_plantilla=2604
--ARCH_DESIST_COND ok id_plantilla=2602
--COA_JUNIO_2019 ok id_plantilla=2608
--REG_FALL_CONS_PP ok id_plantilla=2609
--COA_ACT_NV_FA id_plantilla=2610
--COA_SV_ACT_FC id_plantilla=2611
--COA_D_P_F_ABS id_plantilla=2622
--COA_IMCL_SN_DC_P id_plantilla=2623

--Orden en el que aparecen en excel
--REGISTRO_FALLO
--APELACION_REG_FALLO
--ARCH_DESIST_COND
--COA_JUNIO_2019
--REG_FALL_CONS_PP
--COA_SV_ACT_FC
--COA_D_P_F_ABS
--COA_IMCL_SN_DC_P
--COA_ACT_NV_FA

--(2619,2604,2602,2608,2609,2610,2611,2622,2623)





----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------Pilas con estos datos-----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
--APERTURA_IMPUGNACION (2592 *Crear una nueva version 2669) revisarrrr *
--ACTA_REC_FIR_RUB (2067 Crear new version) 2670 *
-----------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
--21/11/2023
--Impugnaci�n cierre de pruebas	COA - Cierre de pruebas	COA_CP	11777 id_plantilla=2617 2624
--Impugnaci�n con soluci�n inmediata	Actualizar_Ubicabilidad Juridica	ACT_PERSONA_JUR	934 id_plantilla=2422 2625
-------------------------------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------
--Incidencia Plantillas con variables desordenadas order_embargo
--ACTA_POSESION_DEP  	73	2524
--PROVIDENCIA_PAGO   	61	2148
--OFICIO_EMBARGO    	74	2483
--ORDEN_EMBARGO      	72	2485

----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
-- 23/11/2023
--MEMO_SOLICIT_PRUEBAS  2640 
--OFICIO_SOLIC_PRUEBAS  2641

--(2640,2641)

--MEMO_SOLICIT_PRUEBAS_y_OFICIO_SOLIC_PRUEBAS

-------------------------------------------------------



-------------------------------------------------------



--------------------------------------------------------------------------------------------------------------


--COA_ORDEN_PAGO_P ACTA_DE_POSESION_P AUTO_PAGO_PATIO_V2 AUTO_PAGO_PATIO
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------------------------------------------------------
--REGISTRO_FALLO 2619 *

--APELACION_REG_FALLO 2604 *
--ARCH_DESIST_COND 2602 *
--COA_JUNIO_2019 2608 *


--REG_FALL_CONS_PP 2609 *
--COA_SV_ACT_FC 2611 *
--COA_D_P_F_ABS 2622 *

--COA_IMCL_SN_DC_P 2623 *
--COA_ACT_NV_FA 2610 *
--MEMO_SOLICIT_PRUEBAS 2640 *
--OFICIO_SOLIC_PRUEBAS 2641 *
--COA_A_I_R_D 2631 *
--COA_FM_AI 2632 *
--COA_AUTO_INC_FDS 2633 *
--COA_AU_EV_PP 2634 *
--COA_FOT_PP_PP 2635 *
--COAMTVACT_DP_SPP 2636 *
--COA_MTV_MDCT_SPP 2637 *

--(2624,2618,2625,2620,2669,2670,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637) con las viejas
--------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Jasper------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------
--------------------Coactivo---------------------------
-------------------------------------------------------

--OFICIO_EMBARGO id_plantilla=2643
--AUTO_PAGO id_plantilla=2644
--PROVIDENCIA_PAGO id_plantilla=2645

--(2643,2644,2645)

--ACTA_POSESION_DEP 2646
--SENTAR_RAZON_PAGO 2647
--PROVIDENCIA_RETENCIO 2648
--OFICIO_BANCO_CARTA 2649

--OFIC_BAN_CARTA_SEPS 2650  --OFIC_BAN_CARTA_SEPS 2716 cambio su id 2685 por 2716
--PROVIDENCI_RET_SEPS 2651
--ACTA_DE_POSESION  id_plantilla=2652

--OFICIO_EMBARGO_SEPS 2653
--ORDEN_EMBARGO_SEPS 2654

--ORDEN_EMBARGO 2655

--COA_ORDEN_PAGO_P 2656
--ACTA_DE_POSESION_P 2657
--AUTO_PAGO_PATIO_V2 2658
--AUTO_PAGO_PATIO 2659

--DOC_DETER_DEUDA_COU 2660
--PROVIDENCIA_ANULAR 2661
--LEV_MEDIDA_RETENCION 2662

--NOTIFICACION_COAC 2663
--ACTA_EMBARGO_COACTIV 2664
--PROVIDENCIA_PAGO_EMB 2665
--COA_TITULO_CREDITO 2666
--LEV_MED_RET_PAGO_PAR 2667
--LEVANTAMIENT_EMBARGO 2668

--COA_DOC_DETER_DEUDA 2671

-----Adicional las plantillas jasper

----Jasper
--ORDEN_COBRO_COIP 2324
--ORDEN_COBRO_ORDENANZ 2325
--ORDEN_COBRO_COIP_ELE 2579
--ORDEN_COBRO_ORDE_ELE 2580
--ORDENANZA_REQ_PAGO 2229

--(2324,2325,2579,2580,2229)

--CERTI_CURSO_VIRTU  Gui para la soluci�n de las plantillas Jasper

--2650 por 2685 por 2716
--(2643,2644,2645,2646,2647,2648,2649,2716,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668,2671,
--   2324,2325,2579,2580,2229)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------
--Seguidad vial virtual
--------------------------------------------------------------------------------------------------------
--CARAT_CURSO_VIRTU jasper 2231
--RESOL_CULMI_VIRTU jasper 2232
--RESOL_INCUMP_VIRTU jasper 2233

--VOLANTE_PAGO_CURSOV jasper 2234  
--CERTI_CURSO_VIRTU jasper 2235
--RESOL_CULM_VIRTU_100 jasper 2466
--RESOL_INCU_VIRTU_100 jasper 2467
--Jasper
--(2231,2232,2233,2234,2235,2466,2467)

--ACTA_SEG_V_EVIRTUAL 2672
--ACTA_SEG_V_CUL 2673
--ACTA_SV_EVIRTUAL_100 2674
--Normales
--(2672,2673,2674)

--Todas las plantillas de seguridad vial virtula
--(2231,2232,2233,2234,2235,2466,2467,2672,2673,2674)
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
----------------------------------Financiaci�n comparendo----------------------------------------------------------------------

--CONVENIO_MULTA 2676
--VOLANTE_PAGO 2677
--ACUERDO_PAGO 2678
--AMORTIZACION 2679

--(2676,2677,2678,2679)
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
---------------------------Imposicion de comparendo X 12-----------Imposicion_de_comparendo----------------------------------------------------

------
--LEV_MED_CAUT  2258 *
--SENTAR_RAZON_EMBARGO 2259 *
--LEV_MED_CAUT_ANUL 2287 *
--COIP_REQ_PAGO 2228 * pendiente prueba
--LEV_MED_CAUT_COAC 2286 *
--LEV_MED_CAUT_CNV 2289 *
--SOLIC_IMPUGNACION 2237 * pendiente prueba
--SENTAR_RAZON_CUMPLE 2239 * pendiente prueba
--LEV_MED_CAUT_SAL 2284 *
--LEV_MED_CAUT_JUB 2285 *
--LEV_MED_CAUT_FLL 2288 *
--LEV_MED_CAUT_ALM 2290

--(2258,2259,2287,2228,2286,2289,2237,2239,2284,2285,2288,2290)--Imposicion de comparendo  ImposicionDeComparendo
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
----------------------Coactivo incidencia--------------------------------------------------------------------
--Revisar
--ACTA_POSESION_DEP � 2646
--ACTA_DE_POSESION_P  2657  (2646,2657)

--ACTA_POSESION_DEP y 
--ACTA_DE_POSESION_P
----------------------------------------------------------------------
------------------Calendarizaci�n-------------------------------------
----------------------------------------------------------------------
--2024/01/02

--PROCESO: Calendarizaci�n

--FALLO_CALEND_FIRMA 2697
--APERTURA_ANU_CAL 2698   *
--APERT_ANUCAL_SIN_TER 2699 *
--DOC_INCOMPLETA_CAL 2694
--RECH_FALTA_SOPOR_CAL 2695

--(2697,2698,2699,2694,2695)

--con incidencia

--APERT_ANUCAL_SIN_TER
--APERTURA_ANU_CAL
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----------------------------PROCESO: Calendarizacion fallo x1--------------------------
--2024/01/02
--PROCESO: Calendarizacion fallo x1
--	REGISTRO_FALLO_CAL 2700
--(2700)
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------



--------------------------------------Devolucion sin soluci�n inmediata----------------------------------------------------------------------
--AUTO_INICIAL_DEVO 2710
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
--------------------------------Devolucion Fallo----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--  PROCESO:Devolucion Fallo
--	REGISTRO_FALLO_DEV 2711


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--Fusi�n de los tres procesos de devoluci�n (2709,2708,2710,2711)
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------



--21/12/20223----------------------------------------------------------------------------------------------------------
----PROCESO-----------------------Recaudo---------------------------------------------------------------------------------

--REC_TRA_ATM 2712
------------------------------------------------------------------------------------------------------------
-------PROCESO-------------------------------Recurso apelacion	----------------------------------------------------------------------

--PRIMER_AUTO 2713
--PRIMER_AUTO_RESORTEO 2714



------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-------PROCESO------------------------Ubicabilidad-----------------------------------------------------------------------------

--ACT_UBICABILIDAD 2715

--FUSION Recaudo, Recaudo apelacion y Ubicabilidad (2712,2713,2714,2715)
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------


--26/12/223
--Generan la hoja en blanco 
--ACTA_POSESION_DEP  2646
--ACTA_DE_POSESION_P 2657
--OFIC_BAN_CARTA_SEPS 2685

--(2646,2657) ACTA_POSESION_DEP ACTA_DE_POSESION_P

------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------
select *from [documentos].[dbo].[plantilla] where id_plantilla=2685--2663

select top 5 *from [documentos].[dbo].[documento] order by 1 desc

-------------------------Plantilla coactivo pendiente-----------------------------------------------------------------

--OFIC_BAN_CARTA_SEPS 2716



--------------------------------------------------------------------------------------------------------
-----------------------------------Sentar Raz�n---------------------------------------------------------
--RAZON_NOTI_RES_ADMIN 2684
--RAZON_NOTI_CORREO 2681
--RAZON_NO_PRUEBAS 2680
--RAZON_NOTI_TRA_ADMIN 2682
--RAZON_SI_PRUEBAS 2683
--RAZON_CIER_SUBS_CAL

--(2680,2681,2682,2683,2684,2723)--Sentar Raz�n

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
-------------------------------Impugnaci�n de comparendo-------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Revisado 31/12/2023 --Salen hojas en blanco revisar con Nicolas
--Apertura impugnaci�n sin tercero	APERT_IMPUG_SIN_TERC	11924
--	Apertura de impugnaci�n	APERTURA_IMPUGNACION	3100


--APERT_IMPUG_SIN_TERC 2620
--APERTURA_IMPUGNACION 2669
--ACTA_REC_FIR_RUB 2670

--(2620,2669,2670)

--ACTA_REC_FIR_RUB (2067 Crear new version) 2670 *
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
--------------------------------------Impugnaci�n cierre de pruebasX2------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Impugnaci�n cierre de pruebas	COA - Cierre de pruebas	COA_CP	11777
--Impugnaci�n cierre de pruebas	Cierre de pruebas	CIERRE_PRUEBAS	3


--COA_CP 2624
--CIERRE_PRUEBAS 2618

--(2624,2618) Impugnaci�n cierre de pruebasX2
--------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
-----------------------------Impugnaci�n sin soluci�n inmediata----------------------------------------
--------------------------------------------------------------------------------------------------------
--22/11/2023
--02/01/2024

--COA_A_I_R_D  id_plantilla=2631
--COA_FM_AI id_plantilla=2632
--COA_AUTO_INC_FDS id_plantilla=2633
--COA_AU_EV_PP id_plantilla=2634
--COA_FOT_PP_PP id_plantilla=2635
--COAMTVACT_DP_SPP id_plantilla=2636
--COA_MTV_MDCT_SPP id_plantilla=2637

--COA_A_I_R_D
--COA_FM_AI
--COA_AUTO_INC_FDS
--COA_AU_EV_PP
--COA_FOT_PP_PP
--COAMTVACT_DP_SPP
--COA_MTV_MDCT_SPP

--(2631,2632,2633,2634,2635,2636,2637)

----21/12/2023------------26/12/2023--------------------------------------------------------------------------------------------
--PROCESO---------------------------Impugnaci�n sin soluci�n inmediata PAQUETE 2 PLANTILLAS SIN ENVIAR-----------------------------------------


--AI_EXV_SGPS_TP 2686
--MTV_SP_DCT_NO_MEMO 2687
--COA_A_EV_AU 2688
--COA_PPI_AU_PP 2689 
--AUTO_INICIAL_PRUEBA 2690
--COA_EXC_VEL_INF_ATD 2691
--COA_EXC_VEL_FDS 2692
--COA_VACT_PP_AI 2693

--(2686,2687,2688,2689,2690,2691,2692,2693) Impugnaci�n sin soluci�n inmediata


-- Total (2631,2632,2633,2634,2635,2636,2637,2686,2687,2688,2689,2690,2691,2692,2693)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------Coactivo----------------------------------------------

--Coactivo	Providencia por pago	PROVIDENCIA_PAGO 2645

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
------------------------------------Recurso apelacion------------------------------------------------------------------------

--Recurso apelacion	PRIMER AUTO	PRIMER_AUTO	740
--Recurso apelacion	PRIMER AUTO RESORTEO	PRIMER_AUTO_RESORTEO	38

--PRIMER_AUTO 2713
--PRIMER_AUTO_RESORTEO 2714
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---------------------------Paso a produccion------------------------------------
--------------------------------------------------------------------------------

--APERT_IMPUG_SIN_TERC 2620 2724
--APERTURA_IMPUGNACION 2669 2725


--------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------
--------20/12/20223----------------------------------------------------------------------------------------------------




--Impugnaci�n sin soluci�n inmediataX15

--x7 Certificados QA
--COA_A_I_R_D  id_plantilla=2631*
--COA_FM_AI id_plantilla=2632*
--COA_AUTO_INC_FDS id_plantilla=2633*
--COA_AU_EV_PP id_plantilla=2634*
--COA_FOT_PP_PP id_plantilla=2635*
--COAMTVACT_DP_SPP id_plantilla=2636*
--COA_MTV_MDCT_SPP id_plantilla=2637*

--(2631,2632,2633,2634,2635,2636,2637)

------------------------------------------------------------------------------------------------------------
------------------Calendarizaci�n-------------------------------------
----------------------------------------------------------------------
--2024/01/02
--2024/01/10
--PROCESO: Calendarizaci�n

--FALLO_CALEND_FIRMA 2697
--APERTURA_ANU_CAL 2698   *
--APERT_ANUCAL_SIN_TER 2699 *
--DOC_INCOMPLETA_CAL 2694
--RECH_FALTA_SOPOR_CAL 2695

--(2697,2698,2699,2694,2695)

--con incidencia

--APERT_ANUCAL_SIN_TER
--APERTURA_ANU_CAL

------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- REGISTRO_FALLO  ok   id_plantilla=2619
--APELACION_REG_FALLO ok id_plantilla=2604
--ARCH_DESIST_COND ok id_plantilla=2602
--COA_JUNIO_2019 ok id_plantilla=2608
--REG_FALL_CONS_PP ok id_plantilla=2609
--COA_SV_ACT_FC id_plantilla=2611

----------------------Proceso------------Impugnaci�n de comparendo------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
--17/01/2024

--	'Apertura impugnaci�n sin tercero'	APERT_IMPUG_SIN_TERC 2620  version creada por rafa 2724
--	'Apertura de impugnaci�n'	APERTURA_IMPUGNACION version 2669 creada por rafa 2725


-- Impugnaci�n de comparendo
--APERT_IMPUG_SIN_TERC 2620
--APERTURA_IMPUGNACION 2669
--ACTA_REC_FIR_RUB 2670
--(2724,2725,2670)


--------------------------------------------------------------------------------------------------------------------------------------
-----Impugnaci�n cierre de pruebas-----------------------Proceso produccion-----------------------------------------------------------------------
--18/01/2024
--COA - Cierre de pruebas	COA_CP 2738 2741 *******cambios en producci�n
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
---------------------Proceso Produccion------------Impugnaci�n proceso de pruebas-----------------------------------------------------------------------------------------------------

--18/01/2024	
	--Memo solicitud de pruebas	MEMO_SOLICIT_PRUEBAS	 2739
	--Oficio de solicitud de pruebas	OFICIO_SOLIC_PRUEBAS	2740   *******cambios en producci�n


	--(2738,2739,2740)

--------------------------------------------------------------------------------------------------------------------------------------
--APERT_DEV_SIN_TERC
--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
----------------------------------Devolucion de valores--------------------------------------------------------------------------
--Nota a dos plantillas con el mismo nombre en el modulo de documentos APERT_DEV_SIN_TERC

--04/01/2024
--23/01/2024

--PROCESO: Devolucion de valores
--APERT_DEV_SIN_TERC 2709  ****Presenta errores
--CIERRE_PRUEBAS_DEVOL 2708
--(2709,2708)

------------------------------------------------------------------------------------

--31/01/2024 creaci�n de la new Plantilla
--ACTA_RESORTEO   proceso:impugnacion cierre de pruebas
--RAZON_SI_PRUEBAS   proceso: Sentar raz�n
--COA_CP proceso:impugnacion cierre de pruebas 
--AUTO_PAGO_PATIO ejemplo Rafael 

--RAZON_NOTI_RES_ADMIN proceso:Sentar Raz�n
--MEMO_SOLICIT_PRUEBAS trae la firma de andrea

--IMPUGNACION_CIERRE_PRUEBAS("13", "/c2/Impugnacion_Cierre_Pruebas"), //
------------------------------------------------------------------------------------

select * from documentos..plantilla where codigo_plantilla='ACTA_RESORTEO'

--2739
select * from documentos..plantilla where id_plantilla=2739
---------------------------Consulta CODIGOS_PLANTILLAS-----------------------------------------------------------------------------

--numero_consecutivo,NOMBRE_COMPLETO,CORREO_ELECTRONICO_INFRACTOR,anio_apertura_proceso,NOMBRE_ABOGADO,PLACA_VEHICULO,NOMBRE_DELEGADO,  CARGO_DELEGADO,IMAGEN_FIRMA,MEMO_DELEGADO,FECHA_DELEGADO,TEXTO_NOMBRE_2
--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA
--CONSECUTIVO_PRUEBAS,numero_consecutivo,NOMBRE_INFRACTOR,anio_apertura_proceso,FECHA_SOLICITUD,DESCRIPCION_PRUEBA,PARA,CARACTERISTICA_PRUEBA,fecha_apertura_impug
--CIERRE_PRUEBAS_MANUA

select *from [documentos].[dbo].[plantilla] where id_plantilla=2574--2663
select top 5 *from [documentos].[dbo].[documento] order by 1 desc
select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2690' order by 1 desc

--12032705 
--Impugnacion cierre de pruebas
--CIERRE_PRUEBAS
--COA_CP
--CIERRE_PRUEBAS_MANUA FALLO_CALEND_FIRMA

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'COA_ORDEN_PAGO_P';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

------------------------------------------------------------------------------
--Ver los documentos generados

--ORDEN_COBRO_ORDE_ELE--La da�e
------------------------------------------------------------------------------------------

--Puedo revisar el codigo de la plantilla que se acabo de generar

select *from [documentos].[dbo].[plantilla] where id_plantilla=2254  --2413--2596--2597  --2324--2596--2413--2596--2597--2685--2663

select top 5 *from [documentos].[dbo].[documento] order by 1 desc


select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2739' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

-------------------------------------------------
(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436) 



--12032705
--ACTA_DE_POSESION_P   --RADICAR COBRO COACTIVO
--AUTO_PAGO_PATIO_V2    --RADICAR COBRO COACTIVO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA
--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA
--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA
--NUMERO_EXPEDIENTE,FECHA_ACTUAL,HORA_ACTUAL,NOMBRE_DELEGADO,IMAGEN_FIRMA
select * from documentos..plantilla_configuracion where id_plantilla_config='10202' --131
select * from documentos..plantilla where id_plantilla='2750'


begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla=2623
commit tran


-- C�digos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
--where id_plantilla in(2619,2604,2602,2608,2609,2610,2611,2622,2623)
--where id_plantilla in(2592,2620)
--COA_A_I_R_D, COA_FM_AI, COA_AUTO_INC_FDS, COA_AU_EV_PP,  COA_FOT_PP_PP, COAMTVACT_DP_SPP, COA_MTV_MDCT_SPP
--where id_plantilla in(2631,2632,2633,2634,2635,2636,2637) 2628
--where id_plantilla in(2638,2639) 
--where id_plantilla in(2640,2641) --MEMO_SOLICIT_PRUEBAS OFICIO_SOLIC_PRUEBAS --2626
--where id_plantilla in(2643,2644,2645,2646) --OFICIO_EMBARGO AUTO_PAGO PROVIDENCIA_PAGO 
--where id_plantilla in (2646,2647,2648,2649,2650,2651,2652,2653,2654,2655)  --ACTA_POSESION_DEP SENTAR_RAZON_PAGO PROVIDENCIA_RETENCIO OFICIO_BANCO_CARTA OFIC_BAN_CARTA_SEPS PROVIDENCI_RET_SEPS ACTA_DE_POSESION OFICIO_EMBARGO_SEPS ORDEN_EMBARGO_SEPS ORDEN_EMBARGO COA_ORDEN_PAGO_P ACTA_DE_POSESION_P AUTO_PAGO_PATIO_V2 AUTO_PAGO_PATIO
--where id_plantilla in(2646,2647,2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658,2659)
--where id_plantilla in(2643,2644,2645,2646,2647,2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668)
--where id_plantilla in(2624,2618,2625,2620,2592,2067,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637)
--where id_plantilla in(2624,2618,2625,2620,2669,2670,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637)--APERTURA_IMPUGNACION
--where id_plantilla in(2643,2644,2645,2646,2647,2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668,2671)
--where id_plantilla in(2324,2325,2579,2580,2229)--Plantillas Jasper
--where id_plantilla in (2231,2232,2233,2234,2235,2466,2467,2672,2673,2674)--10 Plantillas de seguridad virtual
--where id_plantilla in(2676,2677,2678,2679) --Financiaci�n comparendo
--where id_plantilla in(2680,2681,2682,2683,2684)--Sentar Raz�n
--where id_plantilla in(2686,2687,2688,2689,2690,2691,2692,2693) --Impugnaci�n sin soluci�n inmediata
--where id_plantilla in(2258,2259,2287,2228,2286,2289,2237,2239,2284,2285,2288,2290)--Imposicion de comparendo
--where id_plantilla in(2697,2698,2699,2694,2695)
--where id_plantilla in(2709,2708,2710,2711)
--where id_plantilla in(2712,2713,2714,2715) --FUSION Recaudo, Recaudo apelacion y Ubicabilidad (2712,2713,2714,2715)
where id_plantilla in(2680,2681,2682,2683,2684,2723,2750)--Sentar Raz�n



commit tran
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *from  documentos..plantilla where codigo_plantilla like '%Resol%'--=@codigoPlantilla

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin=null where id_plantilla=2636
--update documentos..plantilla set fecha_inicio='2023-11-17' where id_plantilla=2619  --2604 --2602 --2609 --2610 --2611 --2622 --2623
--update documentos..plantilla set fecha_inicio='2023-11-21' where id_plantilla in(2631,2632,2633,2634,2635,2636,2637) 
--update documentos..plantilla set fecha_inicio='2023-11-22' where id_plantilla in(2638,2639) 
--update documentos..plantilla set fecha_fin='2023-11-21' where id_plantilla=2485
--update documentos..plantilla set fecha_inicio='2023-11-22' where id_plantilla=2628
--update documentos..plantilla set fecha_inicio='2023-11-25' where id_plantilla in(2638,2639)
--update documentos..plantilla set fecha_fin=null where id_plantilla in(2621,2099)--2628
--update documentos..plantilla set fecha_inicio='2023-11-27' where id_plantilla in(2643,2644,2645,2646)
--update documentos..plantilla set fecha_inicio='2023-11-29' where id_plantilla in(2643,2644,2645,2646,2647,2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668)
--update documentos..plantilla set fecha_inicio='2023-12-02' where id_plantilla in(2624,2618,2625,2620,2592,2067,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637)
--update documentos..plantilla set fecha_inicio='2023-12-04' where id_plantilla in(2624,2618,2625,2620,2669,2670,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637) --*******APERTURA_IMPUGNACION
--update documentos..plantilla set fecha_inicio='2023-12-03' where id_plantilla in(2643,2644,2645,2646,2647,2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668,2671) --*******
--update documentos..plantilla set fecha_inicio='2023-12-11' where id_plantilla in(2643,2644,2645,2646,2647,2648,2649,2650,2651,2652,2653,
--2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664,2665,2666,2667,2668,2671,2624,2618,2625,2620,2669,2670,2619,2604,2602,2608,2609,2611,2622,2623,2610,2640,2641,2631,2632,2633,2634,2635,2636,2637) --*******--todasss
--update documentos..plantilla set fecha_inicio='2023-12-07' where id_plantilla in(2672,2673,2674)
--update documentos..plantilla set fecha_fin=null where id_plantilla=2526
--update documentos..plantilla set fecha_inicio='2023-12-13' where id_plantilla=2526 --New versi�n de la plantilla que est� molestando
--update documentos..plantilla set fecha_inicio='2023-12-13' where id_plantilla in(2676,2677,2678,2679) --Financiaci�n comparendo
--update documentos..plantilla set fecha_inicio='2023-12-12' where id_plantilla in(2680,2681,2682,2683,2684)--Sentar Raz�n
--update documentos..plantilla set fecha_inicio='2023-12-14' where id_plantilla in(2686,2687,2688,2689,2690,2691,2692,2693) --Impugnaci�n sin soluci�n inmediata
--update documentos..plantilla set fecha_inicio='2023-12-17' where id_plantilla in(2646,2657)--coactivo (2646,2657)
--update documentos..plantilla set fecha_inicio='2023-12-19' where id_plantilla in(2697,2698,2699,2694,2695,2700)
--update documentos..plantilla set fecha_inicio='2023-12-19' where id_plantilla in(2709,2708,2710,2711)
--update documentos..plantilla set fecha_inicio='2023-12-20' where id_plantilla in(2712,2713,2714,2715) --FUSION Recaudo, Recaudo apelacion y Ubicabilidad (2712,2713,2714,2715)
--update documentos..plantilla set fecha_inicio='2023-12-21' where id_plantilla in(2646,2657)-- proceso coactivo (2646,2657) ACTA_POSESION_DEP ACTA_DE_POSESION_P
--update documentos..plantilla set fecha_inicio='2023-12-25' where id_plantilla in(2646,2657) --ACTA_POSESION_DEP ACTA_DE_POSESION_P 
--update documentos..plantilla set fecha_inicio='2023-12-27' where id_plantilla in(2680,2681,2682,2683,2684,2723)--Sentar Raz�n
--update documentos..plantilla set fecha_inicio='2024-01-01' where id_plantilla in(2624,2618) --Impugnaci�n cierre de pruebasX2
--update documentos..plantilla set fecha_inicio='2024-01-11' where id_plantilla in(2697,2698,2699,2694,2695) --Calendarizacion
--update documentos..plantilla set fecha_inicio='2024-01-04' where id_plantilla in(2709,2708)
--update documentos..plantilla set fecha_inicio='2024-01-20' where id_plantilla=2738 in(2741,2739,2740)
update documentos..plantilla set fecha_inicio='2024-03-25' where id_plantilla=2610
commit tran

------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--QUERY GENERAR  eliminar 2650
---------------------------------------------------------------
begin tran
delete from documentos..plantilla   where id_plantilla=2731
commit tran
---------------------------------------------------------------
begin tran
delete from documentos..jasper_plantilla   where id_plantilla=2731
commit tran

begin tran
delete from documentos..xml_plantilla   where id_xml_plantilla=2731
commit tran

begin tran
delete from documentos..variable_plantilla   where id_plantilla=2731
commit tran


begin tran
delete from documentos..firma_plantilla   where id_plantilla=2731
commit tran

-----------------------------------------------------------------
begin tran--Afecta varias rows
delete from documentos..documento   where id_plantilla=2731
commit tran

begin tran
delete from documentos.dbo.documento where id_documento =16241274

select *from documentos..documento where id_plantilla=2650
-----------------------------------------------------------------
begin tran
delete from documentos..xml_documento   where id_xml_documento in(16241004,16241274)


--dbo.jasper_plantilla
begin tran
delete from documentos..xml_documento   where id_xml_documento in(16241004,
16241274,16241276,16241278,16241280,16241282,16241285,16241287,16241288,16241290,16241292,16241295,16241297,16241298,16241301,16241303,16241305,16241307,16241308,16241310,16241312,16241314,
16241316,16241318,16241320,16241322,16241325,16241326,16241328,16241330,16241333,16241335,16241337,16241338,16241340,16241342,16241344,16241346,16241349,16241351,16241352,16241354,16241357,
16241358,16241360,16241362,16241365,16241366,16241369,16241370,16241372,16241374,16241376,16241378,16241381,16241382,16241385,16241386,16241389,16241391,16241392,16241394,16241396,16241399,
16241401,16241403,16241404,16241407,16241409,16241410,16241412,16241414,16241416,16241419,16241420,16241423,16241425,16241427,16241429,16241431,16241433,16241434,16241437,16241439,16241440,
16241442,16241444,16241446,16241448,16241451,16241452,16241455,16241457,16241459,16241461,16241462,16241465,16241466,16242219,16242221,16242223,16242225,16242228,16242229,16242232,16242233,
16242236,16242238,16242240,16242241,16242244,16242246,16242247,16242397,16242399,16242401,16242403,16242406,16242408,16242409,16242411,16242414,16242415,16242417,16242424,16242426,16242429,
16242430,16242433,16242438,16242441,16242443,16242445,16242447,16242450,16242452,16242454,16242456,16242458,16242459,16242462,16242464,16242465,16242467,16242472,16242473,16242476,16242477,
16242480,16242482,16242484,16242485,16242487,16242490,16242492,16242493,16242496,16242497,16242500,16242502,16242503,16242505,16242507,16242509,16242511,16242513,16242515,16242517,16242519,
16242522,16242523,16242525,16242528,16242529,16242531,16242533,16242535,16242536,16242540,16243245)
commit tran

--------------------------------------------------------------------------
begin tran
delete from documentos.dbo.documento where id_documento in(16242480,16242482,16242484,16242485,16242487,16242490,16242492,16242493,16242496,16242497,16242500,16242502,16242503,16242505,16242507,16242509,16242511,16242513,16242515,16242517,16242519,
16242522,16242523,16242525,16242528,16242529,16242531,16242533,16242535,16242536,16242540,16243245)

commit tran

------------------------------------------------------------------------------------------------------------

select *from documentos..xml_documento
where id_xml_documento=2650

select *from documentos..documento
where id_plantilla=2650
--dbo.xml_plantilla
------------------------------------------------------------------------------------------------------------
begin tran
delete from documentos..firma_plantilla where id_plantilla=2650
commit tran

select *from documentos..firma_plantilla
where id_plantilla=2639



 (SELECT SUBSTRING(valor, 1, CHARINDEX('DIRECTOR(A)', valor) + LEN('DIRECTOR(A)') - 1) AS valor_parametro_defecto
      FROM (
       SELECT valor_parametro_defecto AS valor
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436
       )) AS cargo_delegado






begin tran
--update documentos..plantilla set fecha_fin='2023-10-31' where id_plantilla=2542   --2532
update documentos..plantilla set fecha_inicio='2023-11-01' where id_plantilla=2602--2542--2601--2542--2601--2542--2601--2542
commit tran
--

--begin tran
--update documentos..plantilla set fecha_fin='2023-06-06' where id_plantilla=2505
--update documentos..plantilla set fecha_inicio='2023-06-07' where id_plantilla=2542
--commit tran

--begin tran
--update documentos..plantilla set fecha_fin='2023-06-08' where id_plantilla=2519
--update documentos..plantilla set fecha_inicio='2023-06-07' where id_plantilla=2519
--commit tran
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas 4
--1. RESOL_CULMI_VIRTU Seguidad vial virtual parecen que son Jasper id_plantilla=2232 id_plantilla_config=10107 *--
--2. RESOL_INCUMP_VIRTU Seguidad vial virtual parecen que son Jasper id_plantilla=2233 id_plantilla_config=10108 --OK
--3. RESOL_CULM_VIRTU_100 Seguidad vial virtual id_plantilla=2466 id_plantilla_config=10167 <Realizada por Oscar> FALTA****OK
--4. RESOL_INCU_VIRTU_100  Seguidad vial virtual id_plantilla=2467 id_plantilla_config=10168  No aparece el representante

--1. Resoluci�n culminaci�n virtual
--2. Resoluci�n incumplimiento virtual
--3. Resoluci�n culminaci�n virtual 100
--4. Resoluci�n incumple virtual 100

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *from xml_plantilla where id_xml_plantilla=2466

select *from estado_curso;
select top 10 *from curso where id_estado_curso !=1 order by fecha_registro desc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--POSTMAN
select *from estado_curso;
select top 10 *from curso order by fecha_registro desc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *from variable_plantilla vp
left join variable v on v.id_variable = vp.id_variable
where vp.id_plantilla = @idPlantilla

select *from jasper_plantilla jp where jp.id_plantilla = @idPlantilla
select *from xml_plantilla x where x.id_xml_plantilla=@idPlantilla
select *from firma_plantilla fp where fp.id_plantilla=@idPlantilla
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Plantillas
--http://sogit-app-pru.datatools.local:8080/DocumentosWEB/protected/inicio.xhtml
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--users: admin-docs
--Password: Admin123*  Admin1234*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Organizar consultas SQL
--https://www.dpriver.com/pp/sqlformat.htm  <SQL FORMATER>
--https://www.dpriver.com/pp/sqlformat.htmm

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas
--http://sogit-app-pru.datatools.local:8080/DocumentosWEB/protected/inicio.xhtml
--users: admin-docs
--Password: Admin123*  Admin1234*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Witch the query top they are modific plantillas "witch the id"
--Revisar COA - Si vino ACT - Fallo condenatorio
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas 3 +++++++
--COA - Cierre de pruebas    COA_CP -- No tiene query ni variables <impugnacion cierre de pruebas> id_plantilla=1439  id_plantilla_config=10196
--Cierre de pruebas    CIERRE_PRUEBAS   id_plantilla_config=11
--Cierre de pruebas manual    CIERRE_PRUEBAS_MANUA   - The query tiene pocas lineas id_plantilla_config=75
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PRODUCCI�N
--Plantillas 3 +++++++
--COA_CP -- No tiene query ni variables <impugnacion cierre de pruebas> id_plantilla=1439  id_plantilla_config=10196
--CIERRE_PRUEBAS   id_plantilla_config=11
--CIERRE_PRUEBAS_MANUA   - The query tiene pocas lineas id_plantilla_config=75
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas_2

--1. COA - Auto inicial	COA_A_I_R_D	2020
--2. COA - FOTOMULTAS - Auto inicial	COA_FM_AI	1638  * 

--3. COA AUTO INICIAL FDS	COA_AUTO_INC_FDS	689 

--4. COA - Exc. Vel. / Pruebas pertinentes	COA_AU_EV_PP	682
--5. COA - FOTOMULTAS pruebas pertinentes - Per�odo prueba	COA_FOT_PP_PP	241
--6. COA - MTV ACT dio paso - sin per�odo de prueba	COAMTVACT_DP_SPP	42
--7. MTV SIN PERIODO DE PRUEBA NO MEMO DCT	MTV_SP_DCT_NO_MEMO	3
--8. COA - Pruebas pertinentes - Per�odo prueba	COA_PPI_AU_PP	2
--9. Auto inicial	AUTO_INICIAL_PRUEBA	2
--10. Exceso de velocidad - sistema GPS - Transporte P�blico	AI_EXV_SGPS_TP	1
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. COA_A_I_R_D revisar :(((( id_plantilla=1506  id_plantilla_config=10080
--7. MTV_SP_DCT_NO_MEMO  'Presenta error en el sistema' fail  id_plantilla=1612 id_plantilla_config=10192 revisar :(((( ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. COA_FM_AI   ....Quedo mal editada sirve para prueba  id_plantilla=1512 id_plantilla_config=10186* ok :)
--3. COA_AUTO_INC_FDS ok   <Insert> id_plantilla=1631  <update> id_plantilla_config=10187  ok :)
--4. COA_AU_EV_PP ok     id_plantilla=1487  id_plantilla_config=10188 ok :)
--5. COA_FOT_PP_PP ok    id_plantilla=1511  id_plantilla_config=10191 ok :)
--6. COAMTVACT_DP_SPP ok     id_plantilla=1428 id_plantilla_config=10190 * ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--8. COA_PPI_AU_PP ok       id_plantilla=1446 id_plantilla_config=10085  ok :)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--9. AUTO_INICIAL_PRUEBA ok  id_plantilla=37 <Tiene la consulta y las variables>  id_plantilla_config=12  ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--10. AI_EXV_SGPS_TP ok id_plantilla=1391 id_plantilla_config=10189 fecha ERROR AL GENERAR EL DOCUMENTO ok :)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------




select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

--select *from cargo  --id_cargo=11
--select *from funcionario where id_cargo=11 and fecha_final_vigencia is null




-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PRIMER PAQUETE DE PLANTILLAS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--REGISTRO_FALLO SI OKKKK * id_plantilla_config=2 id_plantilla=48 "Se utiliza para los insert"
--APELACION_REG_FALLO Noooo id_plantilla_config=  id_plantilla=
--ARCH_DESIST_COND si okkk * id_plantilla_config=10181 ** id_plantilla=1350

--COA_JUNIO_2019 si okkkk * id_plantilla_config=10182 ** id_plantilla=1719 
--REG_FALL_CONS_PP si okkk * id_plantilla_config=10183 ** id_plantilla=1357
--COA_ACT_NV_FA si okkk id_plantilla_config= 10184 ** id_plantilla=10184
--COA_SV_ACT_FC SI okkk ---id_plantilla_config=10185 ** id_plantilla=1412 mirar NICOLAS   impugnacion fallo
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--update documentos..xml_plantilla  
--set contenido_xml_plantilla=0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C6A61737065725265706F727420786D6C6E733D22687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F6A61737065727265706F7274732220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E636522207873693A736368656D614C6F636174696F6E3D22687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F6A61737065727265706F72747320687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F7873642F6A61737065727265706F72742E78736422206E616D653D225265736F6C7563696F6E43756C6D696E6163696F6E22207061676557696474683D223539352220706167654865696768743D2238343222207768656E4E6F44617461547970653D22416C6C53656374696F6E734E6F44657461696C2220636F6C756D6E57696474683D2235353522206C6566744D617267696E3D223230222072696768744D617267696E3D2232302220746F704D617267696E3D2232302220626F74746F6D4D617267696E3D2237322220697353756D6D6172794E6577506167653D227472756522207768656E5265736F757263654D697373696E67547970653D224572726F722220757569643D2237623935643831362D626231312D343062622D393161622D306433326434666631653061223E0A093C70726F7065727479206E616D653D22697265706F72742E7A6F6F6D222076616C75653D22312E31303030303030303030303030303038222F3E0A093C70726F7065727479206E616D653D22697265706F72742E78222076616C75653D2230222F3E0A093C70726F7065727479206E616D653D22697265706F72742E79222076616C75653D223936222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E70616765486569676874222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E706167655769647468222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E746F704D617267696E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E626F74746F6D4D617267696E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E6C6566744D617267696E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E72696768744D617267696E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E636F6C756D6E5769647468222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E636F6C756D6E53706163696E67222076616C75653D22706978656C222F3E0A093C706172616D65746572206E616D653D22434F4E534543555449564F5F5245532220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224E4F4D4252455F494E46524143544F522220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D22444553435249505F494E4652414343494F4E2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224C554741525F494E4652414343494F4E2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224E554D45524F5F4349544143494F4E2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D2246454348415F4349544143494F4E2220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224D454D4F52414E444F5F4E4F4D4252412220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D2246454348415F4E4F4D4252412220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224E554D45524F5F4944454E54494649434143494F4E2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224E554D45524F5F5245434155444F2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D2246454348415F5245434155444F2220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224E4F4D4252455F46554E43494F4E4152494F2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365222F3E0A093C706172616D65746572206E616D653D224C6F676F2220636C6173733D226A6176612E6C616E672E537472696E6722206973466F7250726F6D7074696E673D2266616C7365223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B222E222B46696C652E736570617261746F722B226C6F676F73222B46696C652E736570617261746F722B2261746D4C6F676F2E6A7067225D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D22436F6E736563757469766F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224E6F6D627265496E66726163746F722220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224E756D65726F4964656E74696669636163696F6E2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D2246656368614669726D61436F6D70726F6D69736F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224465736372697063696F6E4D756C74612220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D2246756E63696F6E6172696F41746D2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D22436172676F46756E63696F6E6172696F41746D2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D226665636861436172676F46756E63696F6E6172696F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224E726F4369746163696F6E2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224C756761724D756C74612220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D2246656368614D756C74612220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D224964446F635061676F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D2242616E636F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D2246656368615061676F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706172616D65746572206E616D653D22494D4147455F4449525F4B45592220636C6173733D226A6176612E6C616E672E537472696E67223E0A09093C706172616D657465724465736372697074696F6E3E3C215B43444154415B5D5D3E3C2F706172616D657465724465736372697074696F6E3E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B22225D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D225355425245504F52545F4449525F4B45592220636C6173733D226A6176612E6C616E672E537472696E67223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B22225D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D22505245564945575F4B45592220636C6173733D226A6176612E6C616E672E426F6F6C65616E223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B66616C73655D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C7175657279537472696E673E0A09093C215B43444154415B5D5D3E0A093C2F7175657279537472696E673E0A093C6669656C64206E616D653D224649524D415F46554E43494F4E4152494F5F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224C6F676F41544D5F7661726961626C652220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E5F444F43554D454E544F5F494E46524143544F522220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E4F4D4252455F494E46524143544F522220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D22465F494D504F534943494F4E5F434F4D504152454E444F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D226E756D65726F5F6369746163696F6E2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E4F4D4252455F5345435245544152494F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D22494D4147454E5F4649524D412220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D226E756D65726F5F636F6E736563757469766F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224D454D4F5F44454C454741444F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D2246454348415F44454C454741444F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D2246454348415F544558544F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E4F4D4252455F44454C454741444F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C706167654865616465723E0A09093C62616E64206865696768743D223833222073706C6974547970653D2253747265746368223E0A0909093C7072696E745768656E45787072657373696F6E3E3C215B43444154415B24567B504147455F4E554D4245527D203D3D315D5D3E3C2F7072696E745768656E45787072657373696F6E3E0A0909093C696D6167653E0A090909093C7265706F7274456C656D656E7420783D223139362220793D2233222077696474683D2231383122206865696768743D2238302220757569643D2235643837653866642D613262322D343337642D613566652D666539636464323431383937222F3E0A090909093C696D61676545787072657373696F6E3E3C215B43444154415B24467B4C6F676F41544D5F7661726961626C657D5D5D3E3C2F696D61676545787072657373696F6E3E0A0909093C2F696D6167653E0A09093C2F62616E643E0A093C2F706167654865616465723E0A093C636F6C756D6E4865616465723E0A09093C62616E64206865696768743D223730222073706C6974547970653D2253747265746368223E0A0909093C737461746963546578743E0A090909093C7265706F7274456C656D656E7420783D22302220793D2235222077696474683D2235373122206865696768743D2232322220757569643D2237616435343363382D313131392D343465612D616439332D646564383465336539646531223E0A09090909093C70726F7065727479206E616D653D226C6F63616C5F6D65737572655F756E6974686569676874222076616C75653D22706978656C222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E686569676874222076616C75653D227078222F3E0A09090909093C7072696E745768656E45787072657373696F6E3E3C215B43444154415B24567B504147455F4E554D4245527D203D3D20315D5D3E3C2F7072696E745768656E45787072657373696F6E3E0A090909093C2F7265706F7274456C656D656E743E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E74657222206D61726B75703D226E6F6E65223E0A09090909093C666F6E742073697A653D22313622206973426F6C643D2274727565222069734974616C69633D2266616C7365222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578743E3C215B43444154415B456D70726573612050C3BA626C696361204D756E69636970616C206465205472C3A16E7369746F2079205D5D3E3C2F746578743E0A0909093C2F737461746963546578743E0A0909093C737461746963546578743E0A090909093C7265706F7274456C656D656E7420783D222D312220793D223239222077696474683D2235373222206865696768743D2232322220757569643D2266333163306335302D633934662D346639342D386232632D373733343861316339616330223E0A09090909093C70726F7065727479206E616D653D226C6F63616C5F6D65737572655F756E6974686569676874222076616C75653D22706978656C222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E686569676874222076616C75653D227078222F3E0A09090909093C7072696E745768656E45787072657373696F6E3E3C215B43444154415B24567B504147455F4E554D4245527D203D3D20315D5D3E3C2F7072696E745768656E45787072657373696F6E3E0A090909093C2F7265706F7274456C656D656E743E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E74657222206D61726B75703D226E6F6E65223E0A09090909093C666F6E742073697A653D22313622206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578743E3C215B43444154415B4D6F76696C696461642064652047756179617175696C2C2045504D544D475D5D3E3C2F746578743E0A0909093C2F737461746963546578743E0A09093C2F62616E643E0A093C2F636F6C756D6E4865616465723E0A093C64657461696C3E0A09093C62616E64206865696768743D223631222073706C6974547970653D2253747265746368223E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D2234302220793D2230222077696474683D2233393022206865696768743D2232302220757569643D2264323861363432622D666565372D343164302D623961652D646662323066366262616238222F3E0A090909093C74657874456C656D656E74206D61726B75703D2268746D6C223E0A09090909093C666F6E74206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B225245534F4C554349C3934E204E6F2E203C623E222B24467B6E756D65726F5F636F6E736563757469766F7D2B223C2F623E225D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D2234312220793D223230222077696474683D2233303822206865696768743D2231382220757569643D2238303439376133342D626236342D346562362D393838302D363138303161643038316135222F3E0A090909093C74657874456C656D656E74206D61726B75703D227374796C6564223E0A09090909093C666F6E74206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B2247756179617175696C2C20222B24467B46454348415F544558544F7D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A09093C2F62616E643E0A09093C62616E64206865696768743D22323639223E0A0909093C746578744669656C6420697353747265746368576974684F766572666C6F773D2274727565223E0A090909093C7265706F7274456C656D656E742073747265746368547970653D2252656C6174697665546F54616C6C6573744F626A65637422206D6F64653D224F70617175652220783D2235302220793D223130222077696474683D2234373022206865696768743D223234382220697352656D6F76654C696E655768656E426C616E6B3D2274727565222069735072696E745768656E44657461696C4F766572666C6F77733D22747275652220757569643D2262643861626632612D366330322D343234342D396432662D333866353063623466393935222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D224A757374696669656422206D61726B75703D2268746D6C223E0A09090909093C666F6E742073697A653D22313222206973537472696B655468726F7567683D2266616C7365222F3E0A09090909093C706172616772617068206C696E6553706163696E673D22315F315F32222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B22456E206D692063616C696461642064652044454C454741444F2064656C204469726563746F72206465204765737469C3B36E20646520496E6672616363696F6E6573207920536572766963696F73206465205472C3A16E7369746F2C20222B24467B544558544F5F4E4F4D425245327D2B222C20736567C3BA6E20636F6E73746120656E20656C206D656D6F72616E646F204E6F2E20222B24467B4D454D4F5F44454C454741444F7D2B2220646520666563686120222B24467B46454348415F44454C454741444F7D2B222C2061766F636F20636F6E6F63696D69656E746F206465206C6120736F6C69636974756420646520737573746974756369C3B36E2064652076616C6F7265732070726573656E7461646120706F7220222B24467B4E4F4D4252455F494E46524143544F527D2B2220636F6E206EC3BA6D65726F206465206964656E7469666963616369C3B36E204E6F2E20222B24467B4E5F444F43554D454E544F5F494E46524143544F527D2B222C20717569656E20696E64696361206C6F207369677569656E74653A20E2809CE2809CE2809CE280A66D616E6966696573746F20717565206465206D616E657261206C69627265207920766F6C756E7461726961206D6520736F6D65746F2061206C61206F706369C3B36E20646520737573746974756369C3B36E2064652076616C6F726573206465206D756C7461732072656C6163696F6E6164617320636F6E206C612063697263756C616369C3B36E207665686963756C61722C20706F722065647563616369C3B36E207669616C207669727475616C2064697370756573746F20706F72204F7264656E616E7A61204D756E69636970616C2E2E2EE2809DE2809D2E205369656E646F20656C2065737461646F2061637475616C2064656C20657870656469656E746520656C206465207265736F6C7665722C20706172612068616365726C6F20736520636F6E7369646572613A205052494D45524F2E2D20456C20617274C3AD63756C6F203133302C20696E6369736F20736567756E646F2064656C2043C3B36469676F204F7267C3A16E69636F206465204F7267616E697A616369C3B36E205465727269746F7269616C2C204175746F6E6F6DC3AD6120792044657363656E7472616C697A616369C3B36E2065737461626C656365207175652061206C6F7320476F626965726E6F7320417574C3B36E6F6D6F732044657363656E7472616C697A61646F73204D756E69636970616C6573206C657320636F72726573706F6E646520646520666F726D61206578636C757369766120706C616E6966696361722C20726567756C6172207920636F6E74726F6C617220656C207472C3A16E7369746F2C20656C207472616E73706F7274652079206C6120736567757269646164207669616C2C2064656E74726F206465207375207465727269746F72696F2063616E746F6E616C2C207920656E2047756179617175696C207365206C6F20656A6572636520612074726176C3A973206465206C6120456D70726573612050C3BA626C696361204D756E69636970616C206465205472C3A16E7369746F202079204D6F76696C696461642064652047756179617175696C2C2045502E2C20636F6E666F726D6520636F6E7374612020656E2020656C2020617274C3AD63756C6F2020312020646520206C6120536567756E6461205265666F726D612061206C6120204F7264656E616E7A6120207175652020726567756C61202073752020437265616369C3B36E202079202046756E63696F6E616D69656E746F2C207075626C69636164612020656E20206C61202047616365746120204F66696369616C20204D756E69636970616C20204E6F2E202032392C202064656C20206A75657665732020313720206465202064696369656D627265202064652020323032302C2020717565207465787475616C6D656E74652020657870726573613A2020E2809C6D6F646966C3AD71756573652061206C6F206C6172676F20646520746F6461206C61206F7264656E616E7A6120766967656E746520646F6E6465207365206E6F6D6272652061206C61204F5244454E414E5A412051554520524547554C41204C4120435245414349C3934E20592046554E43494F4E414D49454E544F204445204C4120454D50524553412050C39A424C494341204D554E49434950414C204445205452414E5349544F2044452047554159415155494C2045502E2C207920646520737573207265666F726D6173206C612064656E6F6D696E616369C3B36E20706F72203C7374796C65206973426F6C643D2774727565273EE2809C20454D5052455341205055424C494341204D554E49434950414C204445205452414E5349544F2059204D4F56494C494441442044452047554159415155494C204550202EE2809D3C2F7374796C653E2C207469656E6520706F72206F626A65746F20656A6572636572206C6120636F6D706574656E63696120646520726563746F72C3AD61206C6F63616C2C20706C616E69666963616369C3B36E2C20726567756C616369C3B36E2C20636F6E74726F6C2079206765737469C3B36E2064656C207472C3A16E7369746F2C207472616E73706F72746520746572726573747265207920736567757269646164207669616C20656E20656C2063616E74C3B36E2047756179617175696C206465206163756572646F20636F6E206C6120436F6E73746974756369C3B36E206465206C6120526570C3BA626C696361207920656C2043C3B36469676F204F7267C3A16E69636F206465204F7267616E697A616369C3B36E205465727269746F7269616C2C204175746F6E6F6DC3AD6120792044657363656E7472616C697A616369C3B36E2C2066756E64616D656E74616C6D656E74652E20456C2063756D706C696D69656E746F2064656C206F626A65746F206465206C6120456D70726573612050C3BA626C69636120657320697272656E756E636961626C65E2809D2E3C62723E446520636F6E666F726D6964616420636F6E206C6F7320617274C3AD63756C6F7320343920792037312064656C2043C3B36469676F204F7267C3A16E69636F2041646D696E69737472617469766F20656C20696E66726173637269746F2064656C656761646F20657320636F6D706574656E7465207061726120636F6E6F6365722079207265736F6C766572206C612070726573656E746520736F6C69636974756420646520737573746974756369C3B36E2E20E2809320534547554E444F2E20E28093204E6F20657869737465206F6D697369C3B36E20646520736F6C656D6E696461642073757374616E6369616C20717565207669636965206465206E756C6964616420656C2070726F636564696D69656E746F2C206465206163756572646F20636F6E206C6F2064657465726D696E61646F20656E20656C203231372064656C2043C3B36469676F204F7267C3A16E69636F2041646D696E69737472617469766F2C207365206465636C617261206C612076616C6964657A20646520746F646F206C6F206163747561646F207920656E20746F64617320737573207061727465732E20E28093205445524345524F2E20E2809320456C20617274C3AD63756C6F2031206465206C61205265666F726D612061206C61204F7264656E616E7A612070617261206C6120537573746974756369C3B36E2064652056616C6F726573206465204D756C7461732072656C6163696F6E6164617320636F6E206C612063697263756C616369C3B36E207665686963756C61722C20706F722065647563616369C3B36E207669616C20792074726162616A6F20636F6D756E69746172696F20646973706F6E652071756520706F6472C3A120656C20636975646164616E6F2061636365646572206120737520656C65636369C3B36E20616C2062656E65666963696F20646520737573746974756369C3B36E2064652076616C6F72657320612074726176C3A9732064652065647563616369C3B36E207669616C207669727475616C2062616A6F206C6F7320706172C3A16D6574726F732065737461626C656369646F7320656E20656C207265737065637469766F20696E73747275637469766F2E20E280932043554152544F2E202D20436F6E737461206120666F6A6120312064656C20657870656469656E746520656C206163746120646520636F6D70726F6D69736F2064656C207365C3B16F7220222B24467B4E4F4D4252455F494E46524143544F527D2B2220656E206C612071756520696E64696361207175652073652073756A65746120766F6C756E74617269616D656E74652061206C61207265616C697A616369C3B36E2064656C20637572736F2064652065647563616369C3B36E207920736567757269646164207669616C207669727475616C20792071756520636F6E6F636520717565206465626520616C63616E7A6172206C612063616C69666963616369C3B36E206DC3AD6E696D6120656E206C61206576616C75616369C3B36E2070617261206C612061706C6963616369C3B36E2064656C2062656E65666963696F20646520737573746974756369C3B36E2E202D205155494E544F2E20E2809320436F6E666F726D65206C6F20696E6469636120656C20617274C3AD63756C6F207175696E746F206465206C61205265666F726D6120616C20496E73747275637469766F2070617261204F6274656E657220656C2042656E65666963696F206465206C6120537573746974756369C3B36E2064652056616C6F726573206465204D756C7461732052656C6163696F6E6164617320636F6E206C612043697263756C616369C3B36E205665686963756C61722C20706F722045647563616369C3B36E205669616C20792054726162616A6F20436F6D756E69746172696F2C20706172612071756520736520696E6963696520656C2070726F6365736F206465206C6120737573746974756369C3B36E2C20656C20696E66726163746F72206465626572C3A120706167617220656C207665696E746963696E636F20706F72206369656E746F2028323525292064656C2076616C6F72206465206C61206D756C746120636F72726573706F6E6469656E74652061206C6120696E667261636369C3B36E20636F6D65746964612C20657320706F722074616C206D6F7469766F2071756520636F6E737461206120666F6A61203320656C20636F6D70726F62616E7465206465207061676F2C206D656469616E746520656C206375616C207365206F6273657276612071756520656C20736F6C69636974616E74652068612070726F63656469646F20656C207061676F2064656C207665696E746963696E636F20706F72206369656E746F2028323525292064656C2076616C6F7220636F72726573706F6E6469656E74652061206C6120636974616369C3B36E206EC3BA6D65726F2020222B24467B6E756D65726F5F6369746163696F6E7D2B222C20656C20696E66726163746F722074656E6472C3A1206F706369C3B36E206163636564657220616C20637572736F207061726120656C2062656E65666963696F206465206C6120737573746974756369C3B36E2E202D20534558544F2E20E2809320436F6E666F726D65206C6F20696E6469636120656C20617274C3AD63756C6F206E6F76656E6F206465206C61205265666F726D6120616C20496E73747275637469766F2070617261204F6274656E657220656C2042656E65666963696F206465206C6120537573746974756369C3B36E2064652056616C6F726573206465204D756C7461732052656C6163696F6E6164617320636F6E206C612043697263756C616369C3B36E205665686963756C61722C20706F722045647563616369C3B36E205669616C20792054726162616A6F20436F6D756E69746172696F2C206170726F6261646F20656C206578616D656E2064656C20637572736F2064652045647563616369C3B36E207920436F6E6369656E74697A616369C3B36E205669616C207669727475616C2C207365207265616C697A6172C3A120756E206578616D656E20717565206465626572C3A120736572206170726F6261646F20706F7220656C207573756172696F2C20706F722074616C206D6F7469766F2C206120666F6A6120342064656C20657870656469656E746520636F6E73746120656C20636572746966696361646F206469676974616C206465206170726F62616369C3B36E2064656C20637572736F2064652065647563616369C3B36E207669616C207669727475616C2E202D20506F72206C617320636F6E73696465726163696F6E65732071756520616E7465636564656E2C2068616269656E646F20656C207365C3B16F7220222B24467B4E4F4D4252455F494E46524143544F527D2B2220636F6E206964656E7469666963616369C3B36E204E6F2E20222B24467B4E5F444F43554D454E544F5F494E46524143544F527D2B222C20736F6C6963697461646F20656C2062656E65666963696F206465206C6120737573746974756369C3B36E2064652076616C6F72657320726573706563746F206465206C6120636974616369C3B36E206465207472C3A16E7369746F206EC3BA6D65726F20222B24467B6E756D65726F5F6369746163696F6E7D2B222064656C20222B24467B465F494D504F534943494F4E5F434F4D504152454E444F7D2B22207365206861207665726966696361646F2071756520656C2061646D696E6973747261646F206861206461646F2063756D706C696D69656E746F20636F6E20656C2070726F636564696D69656E746F20696E64696361646F20656E206C61207265666F726D6120616C20696E73747275637469766F2070617261206C6120737573746974756369C3B36E2064652076616C6F7265732E20506F72206C6F2074616E746F2C20636F6E7374616E646F20656C207061676F2064656C207665696E746963696E636F20706F72206369656E746F2028323525292064656C2076616C6F72206465206C61206D756C746120636F72726573706F6E6469656E74652061206C6120696E667261636369C3B36E20636F6D6574696461207920656C20636572746966696361646F206465206170726F62616369C3B36E20646520637572736F20656E20656C20657870656469656E74652C2063756D706C69656E646F20636F6E206C612066696E616C696461642064652067656E6572617220636F6E6369656E63696120736F6369616C20736F627265206C6120696D706F7274616E6369612064656C207265737065746F207920636F6E6F63696D69656E746F206465206C6173206E6F726D6173206465207472C3A16E7369746F2C203C7374796C65206973426F6C643D2774727565273E52455355454C564F3A20535553544954554952204C4F532056414C4F52455320434F52524553504F4E4449454E5445532041204D554C5441532C205245434152474F53205920434F535441532050524F434553414C4553204445204C4120494E465241434349C3934E204EC39A4D45524F20222B24467B6E756D65726F5F6369746163696F6E7D2B2220646520666563686120222B24467B465F494D504F534943494F4E5F434F4D504152454E444F7D2B222067656E6572616461206120222B24467B4E4F4D4252455F494E46524143544F527D2B2220636F6E206964656E7469666963616369C3B36E204E6F2E20222B24467B4E5F444F43554D454E544F5F494E46524143544F527D2B223C2F7374796C653E2C2064656269656E646F2072657075746172736520706167616461206C6120696E667261636369C3B36E206465206C61207369677569656E7465206D616E6572612C20656C207665696E746963696E636F20706F72206369656E746F2028323525292064656C2076616C6F7220656E20656665637469766F207920656C20736574656E746120792063696E636F20706F72206369656E746F2028373525292070616761646F206D656469616E746520737573746974756369C3B36E2C20706F72206C6F20717565206465626572C3A1207265616C697A6172736520656C2063616D62696F2064652065737461646F20656E20656C2073697374656D612041584953206465206C61204175746F7269646164206465205472C3A16E7369746F204D756E69636970616C2064652070656E6469656E746520612070616761646F2E20456DC3AD74617365206F666963696F20646972696769646F2061206C612044697265636369C3B36E2046696E616E6369657261206465206C6120456D70726573612050C3BA626C696361204D756E69636970616C206465205472C3A16E7369746F2064652047756179617175696C2045502E2C20612066696E206465207175652074656E676120636F6E6F63696D69656E746F2064656C207061676F206465206C6120636974616369C3B36E20612074726176C3A973206465206C6120737573746974756369C3B36E2E20416374C3BA6520222B24467B4E4F4D4252455F5345435245544152494F7D2B2220636F6D6F207365637265746172696F286129206164202D20686F632E203C7374796C65206973426F6C643D2774727565273E2D204E4F544946C38D515545534520592043C39A4D504C4153452E202D3C2F7374796C653E20225D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A09093C2F62616E643E0A09093C62616E64206865696768743D22313533223E0A0909093C696D6167652068416C69676E3D2243656E746572223E0A090909093C7265706F7274456C656D656E742073747265746368547970653D2252656C6174697665546F54616C6C6573744F626A6563742220783D223138342220793D223331222077696474683D2231383022206865696768743D2238302220757569643D2236396365646466332D646436322D343761352D383462312D373635323135386533386363223E0A09090909093C70726F7065727479206E616D653D226C6F63616C5F6D65737572655F756E69747769647468222076616C75653D22706978656C222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E7769647468222076616C75653D227078222F3E0A09090909093C70726F7065727479206E616D653D226C6F63616C5F6D65737572655F756E6974686569676874222076616C75653D22706978656C222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E686569676874222076616C75653D227078222F3E0A090909093C2F7265706F7274456C656D656E743E0A090909093C696D61676545787072657373696F6E3E3C215B43444154415B24467B494D4147454E5F4649524D417D5D5D3E3C2F696D61676545787072657373696F6E3E0A0909093C2F696D6167653E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E742073747265746368547970653D2252656C6174697665546F42616E644865696768742220783D223138342220793D223935222077696474683D2232333022206865696768743D2235382220757569643D2266633564346464342D653939622D343634382D383266362D303032386533393533376164222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E746572222F3E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B24467B4E4F4D4252455F44454C454741444F7D2B222044454C454741444F2044454C204449524543544F52204745535449C3934E20444520494E4652414343494F4E4553205920534552564943494F53204445205452C3814E5349544F204155544F5249444144204445205452C3814E5349544F204D554E49434950414C225D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A09093C2F62616E643E0A093C2F64657461696C3E0A3C2F6A61737065725265706F72743E0A
--where id_xml_plantilla = 2232;	


-----------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'COA_ACT_NV_FA';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

select *from  documentos..plantilla where codigo_plantilla like '%Resol%'--=@codigoPlantilla

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas 4
--1. RESOL_CULMI_VIRTU Seguidad vial virtual parecen que son Jasper id_plantilla=2232 id_plantilla_config=10107 *--*+ No se inserto variable
--2. RESOL_INCUMP_VIRTU Seguidad vial virtual parecen que son Jasper id_plantilla=2233 id_plantilla_config=10108 --OK*+
--3. RESOL_CULM_VIRTU_100 Seguidad vial virtual id_plantilla=2466 id_plantilla_config=10167 <Realizada por Oscar> FALTA****OK* OJO EN POSTMAN
--4. RESOL_INCU_VIRTU_100  Seguidad vial virtual id_plantilla=2467 id_plantilla_config=10168  No aparece el representante

--1. Resoluci�n culminaci�n virtual
--2. Resoluci�n incumplimiento virtual
--3. Resoluci�n culminaci�n virtual 100
--4. Resoluci�n incumple virtual 100


select *from estado_curso;

select *from curso where id_estado_curso!=1 order by fecha_registro desc;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *from xml_plantilla where id_xml_plantilla=2466

select *from estado_curso;
select top 10 *from curso where id_estado_curso !=1 order by fecha_registro desc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--POSTMAN
select *from estado_curso;
select top 10 *from curso order by fecha_registro desc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *from variable_plantilla vp
left join variable v on v.id_variable = vp.id_variable
where vp.id_plantilla = @idPlantilla

select *from jasper_plantilla jp where jp.id_plantilla = @idPlantilla
select *from xml_plantilla x where x.id_xml_plantilla=@idPlantilla
select *from firma_plantilla fp where fp.id_plantilla=@idPlantilla
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Plantillas
--http://sogit-app-pru.datatools.local:8080/DocumentosWEB/protected/inicio.xhtml
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--users: admin-docs
--Password: Admin123*  Admin1234*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Organizar consultas SQL
--https://www.dpriver.com/pp/sqlformat.htm  <SQL FORMATER>
--https://www.dpriver.com/pp/sqlformat.htmm

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas
--http://sogit-app-pru.datatools.local:8080/DocumentosWEB/protected/inicio.xhtml
--users: admin-docs
--Password: Admin123*  Admin1234*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Witch the query top they are modific plantillas "witch the id"
--Revisar COA - Si vino ACT - Fallo condenatorio
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas 3 +++++++
--COA - Cierre de pruebas    COA_CP -- No tiene query ni variables <impugnacion cierre de pruebas> id_plantilla=1439  id_plantilla_config=10196
--Cierre de pruebas    CIERRE_PRUEBAS   id_plantilla_config=11
--Cierre de pruebas manual    CIERRE_PRUEBAS_MANUA   - The query tiene pocas lineas id_plantilla_config=75
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PRODUCCI�N
--Plantillas 3 +++++++
--COA_CP -- No tiene query ni variables <impugnacion cierre de pruebas> id_plantilla=1439  id_plantilla_config=10196
--CIERRE_PRUEBAS   id_plantilla_config=11
--CIERRE_PRUEBAS_MANUA   - The query tiene pocas lineas id_plantilla_config=75
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plantillas_2

--1. COA - Auto inicial	COA_A_I_R_D	2020
--2. COA - FOTOMULTAS - Auto inicial	COA_FM_AI	1638  * 

--3. COA AUTO INICIAL FDS	COA_AUTO_INC_FDS	689 

--4. COA - Exc. Vel. / Pruebas pertinentes	COA_AU_EV_PP	682
--5. COA - FOTOMULTAS pruebas pertinentes - Per�odo prueba	COA_FOT_PP_PP	241
--6. COA - MTV ACT dio paso - sin per�odo de prueba	COAMTVACT_DP_SPP	42
--7. MTV SIN PERIODO DE PRUEBA NO MEMO DCT	MTV_SP_DCT_NO_MEMO	3
--8. COA - Pruebas pertinentes - Per�odo prueba	COA_PPI_AU_PP	2
--9. Auto inicial	AUTO_INICIAL_PRUEBA	2
--10. Exceso de velocidad - sistema GPS - Transporte P�blico	AI_EXV_SGPS_TP	1
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. COA_A_I_R_D revisar :(((( id_plantilla=1506  id_plantilla_config=10080
--7. MTV_SP_DCT_NO_MEMO  'Presenta error en el sistema' fail  id_plantilla=1612 id_plantilla_config=10192 revisar :(((( ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2. COA_FM_AI   ....Quedo mal editada sirve para prueba  id_plantilla=1512 id_plantilla_config=10186* ok :)
--3. COA_AUTO_INC_FDS ok   <Insert> id_plantilla=1631  <update> id_plantilla_config=10187  ok :)
--4. COA_AU_EV_PP ok     id_plantilla=1487  id_plantilla_config=10188 ok :)
--5. COA_FOT_PP_PP ok    id_plantilla=1511  id_plantilla_config=10191 ok :)
--6. COAMTVACT_DP_SPP ok     id_plantilla=1428 id_plantilla_config=10190 * ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--8. COA_PPI_AU_PP ok       id_plantilla=1446 id_plantilla_config=10085  ok :)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--9. AUTO_INICIAL_PRUEBA ok  id_plantilla=37 <Tiene la consulta y las variables>  id_plantilla_config=12  ok :)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--10. AI_EXV_SGPS_TP ok id_plantilla=1391 id_plantilla_config=10189 fecha ERROR AL GENERAR EL DOCUMENTO ok :)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin tran
update documentos..plantilla set fecha_fin='2023-06-21' where id_plantilla=2532
update documentos..plantilla set fecha_inicio='2023-06-22' where id_plantilla=2550
commit tran

--begin tran
--update documentos..plantilla set fecha_fin='2023-06-06' where id_plantilla=2505
--update documentos..plantilla set fecha_inicio='2023-06-07' where id_plantilla=2542
--commit tran



select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

--select *from cargo  --id_cargo=11
--select *from funcionario where id_cargo=11 and fecha_final_vigencia is null




-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PRIMER PAQUETE DE PLANTILLAS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--REGISTRO_FALLO SI OKKKK * id_plantilla_config=2 id_plantilla=48 "Se utiliza para los insert"
--APELACION_REG_FALLO Noooo id_plantilla_config=  id_plantilla=
--ARCH_DESIST_COND si okkk * id_plantilla_config=10181 ** id_plantilla=1350

--COA_JUNIO_2019 si okkkk * id_plantilla_config=10182 ** id_plantilla=1719 
--REG_FALL_CONS_PP si okkk * id_plantilla_config=10183 ** id_plantilla=1357
--COA_ACT_NV_FA si okkk id_plantilla_config= 10184 ** id_plantilla=1475
--COA_SV_ACT_FC SI okkk ---id_plantilla_config=10185 ** id_plantilla=1412 mirar NICOLAS   impugnacion fallo
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

select v.* from documentos..variable_plantilla vp
join documentos..variable v on v.id_variable=vp.id_variable
where vp.id_plantilla=2740
-------------------------------------------------------------------------------------------------------------------------------------------------------------------



--Generando datos prueba

select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2022
--and ci.id_ordenamiento_pais=2
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and oc.valor_obligacion=425
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios>0
--and oc.valor_costas_procesales>0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
order by p.fecha_inicio desc
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Datos --APERT_DEV_SIN_TERC
select distinct top 10000 numero_identificacion,fecha_infraccion,fecha_notificacion, c.id_factura_axis,c.numero_citacion,c.* from comparendo c inner join
comparendo_persona cp on c.cicomparendo=cp.cicomparendo
where c.id_estado_comparendo in(3,17,19,20)
and fecha_infraccion>'2019-12-31'
order by c.fecha_infraccion asc

-------------------Revisar la generacion de las plantillas---------------------------------

------------------------------------------------------------------------------------------



