----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--434 DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito   <ACTA_DE_POSESION_P, AUTO_PAGO_PATIO>    <COA_TITULO_CREDITO>
--436 DELEGADO FUNCIONARIO EJECUTOR-COACTIVA DEL(LA) DIRECTOR(A) DE INFRACCIONES Y SERVICIOS DE TRÁNSITO DE LA AUTORIDAD DE TRÁNSITO MUNICIPAL
--437 Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Autoridad de Tránsito Municipal
--438 Delegado Funcionario Ejecutor-Coactiva Del(la) Director(a) de Infracciones y Servicios de Tránsito de la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil EP
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--COA_TITULO_CREDITO falla la generacion por el rol ya está el update Preguntarle sobre ese usuario a Nicolas
--x AUTO_PAGO_PATIO ok
--PROVIDENCIA_PAGO  Se esta generando providencia_pago_em
--PROVIDENCIA_ANULAR  Preguntar porque no sale habilita el boton de anular :)  Ok
--x ACTA_DE_POSESION_P ok
--x AUTO_PAGO_PATIO_V2 ok
--COA_ORDEN_PAGO_P  fail ok
--ORDENANZA_REQ_PAGO Ya tiene update   Preguntar
--PROVIDENCIA_PAGO  Se esta generando providencia_pago_em "En la consulta de obtener los datos hay que hacer un cambio para no obtener providencia_pago_em" ok
--COA_TITULO_CREDITO falla la generacion por el rol ya está el update Preguntarle sobre ese usuario a Nicolas Hay que download 7-zip Ok

--Plantillas por preguntar
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Faltantes


--ORDENANZA_REQ_PAGO Ya tiene update   Preguntar



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SEGUIMIENTO DE LAS PLANTILLAS GENERADAS

--  Envio de notificacion AUTO_PAGO_PATIO oK sirvio con   id_plantilla_config=10115 Ok
-- * autopago  <radio button> coactivo acta de posicion  ACTA_DE_POSESION_P OK   parece que falta algo en la firma
--  Radicar cobro coactivo COA_ORDEN_PAGO_P                                 MOLESTANDO :(
-- autopago <radio button> coactivo autopago		AUTO_PAGO_PATIO_V2 ok
--(2612,2611,2610,2609)  id_planilla
--(AUTO_PAGO_PATIO,ACTA_DE_POSESION_P,COA_ORDEN_PAGO_P,AUTO_PAGO_PATIO_V2)

select top 100 *from coactivo order by 1 desc
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436

select *from parametro




--OFICIO_BANCO_CARTA 2616
------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'OFICIO_BANCO_CARTA';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611

update documentos..plantilla set fecha_inicio='2024-04-09' where id_plantilla=2616
commit tran




-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2612,2611,2610,2609)

commit tran
------------------------------------------------------------------------------
--Ver los documentos generados

--ORDEN_COBRO_ORDE_ELE--La dañe
------------------------------------------------------------------------------------------

--Puedo revisar el codigo de la plantilla que se acabo de generar

select *from [documentos].[dbo].[plantilla] where id_plantilla=2609  --2413--2596--2597  --2324--2596--2413--2596--2597--2685--2663

select top 5 *from [documentos].[dbo].[documento] order by 1 desc


select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2608' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 5 p.codigo_plantilla from documentos.dbo.documento d
inner join documentos.dbo.plantilla p on d.id_plantilla=p.id_plantilla
order by 1 desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=61


commit tran
----------------------------------------------
----------------------------------------------

----------------------------------------------
----------------------------------------------

--COA_ORDEN_PAGO_P


SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436

SELECT SUBSTRING(valor_parametro_defecto,1,58)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436


select *from parametro
----------------------------------------------------
--*

--PROVIDENCIA_PAGO
SELECT upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434

SELECT upper(concat(valor_parametro_defecto,' PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA'))
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434

--434 DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito   <ACTA_DE_POSESION_P, AUTO_PAGO_PATIO>    <COA_TITULO_CREDITO>
--------------------------------------------------------------
--------------------------------------------------------------
update documentos..xml_plantilla
set contenido_xml_plantilla=0x
where id_xml_plantilla=46464
--------------------------------------------------------------
--------------------------------------------------------------

select *from documentos.dbo.variable


-------------------------------------------

--COA_TITULO_CREDITO 10105
----------------------------------------------
--10105_COA_TITULO_CREDITO id_plantilla 2230
--10147_COA_TITULO_CREDITO id_plantilla 2436
--10150_COA_TITULO_CREDITO id_plantilla 2440
--434 DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito   <
--                    Director(a) de Gestión de Infracciones y Servicios de Tránsito
--AS cargo_delegado
--CARGO_DELEGADO

SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434

--Salio OKI
SELECT SUBSTRING(valor_parametro_defecto,18,62)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434

--AS cargo_delegado CARGO_DELEGADO
----------------------------------------------
----------------------------------------------
--ORDENANZA_REQ_PAGO

'DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO' AS CargoDelegado

SELECT upper(SUBSTRING(valor_parametro_defecto,18,62))
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=10202

commit tran
----------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=909090

commit tran
----------------------------------------------
----------------------------------------------
----------------------------------------------

--COA_TITULO_CREDITO
--AUTO_PAGO_PATIO 
--PROVIDENCIA_PAGO 
--PROVIDENCIA_ANULAR
--ACTA_DE_POSESION_P 
--AUTO_PAGO_PATIO_V2 
--COA_ORDEN_PAGO_P  
--ORDENANZA_REQ_PAGO
--PROVIDENCIA_PAGO  
--COA_TITULO_CREDITO 
