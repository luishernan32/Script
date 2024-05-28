


--***********************************************************************************************************************                           
--*						   -- RECAUDO X 1

-- https://tomeko.net/online_tools/hex_to_file.php?lang=en
-- https://base64.guru/converter/decode/file

--Cambiando parametros  https://www.youtube.com/watch?v=miC4p-nUsK0

https://gacetamultas.atm.gob.ec/imagenes/img/background_certificado_virtual_v2.png


--Modulo de seguridad Virtual
-- http://10.6.30.176:8083/SeguridadVialWEB/protegido/main.xhtml

-- https://www.youtube.com/watch?v=iyUIiIkR_Sc ver el min 34

--karla.pantoja
--alexander.aguilar
--admin2017*
--Admin2017*
--***********************************************************************************************************************
--REC_TRA_ATM 4702 68  https://www.youtube.com/watch?v=eS2HGSUyVBI

--Sí, justamente. Solamente consultas el trámite y haces el pago, ahí se genera


--*************************************************************************************
--*************************************************************************************
--Generar documentos Seleccion

--Recaudo	RECAUDACION TRAMITES ATM	REC_TRA_ATM	6720


--esa se genera haciendo un pago con tarjeta de crédito
--Pago TDC 
--se llama la pantalla


--*************************************************************************************
--*************************************************************************************

--Seguidad vial virtual	CARATULA CURSO VIRTUAL	CARAT_CURSO_VIRTU	3843
--Seguidad vial virtual		ACTA_SEG_V_CUL	3628
--Seguidad vial virtual	CERTIFICADO CURSO VIRTUAL	CERTI_CURSO_VIRTU	3099
--Seguidad vial virtual	RESOLUCION CULMINACION VIRTUAL 100	RESOL_CULM_VIRTU_100	3013
--Seguidad vial virtual	ACTA DE COMPROMISO E-VIRTUAL 100	ACTA_SV_EVIRTUAL_100	2577
--Seguidad vial virtual	RESOLUCION INCUMPLE VIRTUAL 100	RESOL_INCU_VIRTU_100	607
--Seguidad vial virtual	RESOLUCION CULMINACION VIRTUAL	RESOL_CULMI_VIRTU	346
--Seguidad vial virtual	ACTA DE COMPROMISO E-VIRTUAL	ACTA_SEG_V_EVIRTUAL	322
--Seguidad vial virtual	VOLANTE PAGO CURSO VIRTUAL	VOLANTE_PAGO_CURSOV	277
--Seguidad vial virtual	RESOLUCION INCUMPLIMIENTO VIRTUAL	RESOL_INCUMP_VIRTU	77

--***********************************************************************************************************************

--***********************************************************************************************************************
--Temporal

--***********************************************************************************************************************
--OBSERVACIONES: 
--***********************************************************************************************************************

--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='REC_TRA_ATM'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-22' where id_plantilla in(4702)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(4702)--(2231,2235,2466,2467,2232,2234,2233) 

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=4702--1389--2324--2258--2258--2259--2289--2287--2288--2287--2286--2639--2625--2258--2258--3692--3690--
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
WHERE  id_plantilla_config=31xx

commit tran





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------INSERT----------------------------------------------------------------------------

--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2024-05-22' ,'08:08:00.0000000',67767776814906, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,35.57, --total pago
NULL,NULL,1,12148768, --factura finan --4007661 3087948
35.57, --total pago
0, --cuota
'02', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
35.57) ---total_tcr

------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------

------------------------------------------------------------------------



------------------------------------------------------------------



-----------------------------------------------------------------------------



-----------------------------------------------------------------------------














------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--Anexosss HEIDI

-- Documentos
--select * from plantilla where id_plantilla = 2231;
-- select * from plantilla_configuracion where id_plantilla =2750;
--select * from variable_plantilla WHERE id_plantilla = 2740;
--select * from jasper_plantilla  where id_plantilla = 2740;
--select * from xml_plantilla where id_xml_plantilla=2233;      
--select  * from firma_plantilla  where id_plantilla = 2740

--select * from documentos.dbo.variable where nombre_variable='LogoATMEncabezadoVariable'

----coactivo 2324,2325,2579,2580,2229
----Seguidad vial virtual 2231,2232,2233,2234,2235,2466,2467

---- gestor_docs
--select nombre, folder, extension, nombre_real, Registro_BD from data_documento
--WHERE  codigo_documento 
--IN (SELECT
--  jp.codigo_documento
--FROM documentos.dbo.jasper_plantilla jp
--WHERE  jp.id_plantilla = 2739)

--SELECT codigo_documento, contenido_binario, fecha, version FROM version_data_documento
--WHERE codigo_documento IN (SELECT
--  MAX(gdd.codigo_documento)
--FROM gestor_docs.dbo.data_documento gdd
--join documentos.dbo.jasper_plantilla jp on gdd.codigo_documento = jp.codigo_documento
--WHERE gdd.nombre = 'OFICIO_SOLIC_PRUEBAS.jasper'
--and jp.id_plantilla = 2738)
--ORDER BY version


--COA_CP
--COA_CP_IMAGEN_FIRMA



