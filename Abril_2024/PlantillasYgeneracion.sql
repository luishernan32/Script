
--COA_ORDEN_PAGO_P


--ACTA_DE_POSESION_P    Autopago coactivo autopago

--COA_ORDEN_PAGO_P  Radicar cobro coactivo interfaz
--ORDENANZA_REQ_PAGO

--COA_TITULO_CREDITO
--AUTO_PAGO_PATIO
--PROVIDENCIA_ANULAR
--PROVIDENCIA_ANULAR

--------------------------------------------------------------------------------------------------
--  Envio de notificacion AUTO_PAGO_PATIO oK sirvio con   id_plantilla_config=10115 Ok
-- autopago  <radio button> coactivo acta de posicion  ACTA_DE_POSESION_P OK  
--  Radicar cobro coactivo COA_ORDEN_PAGO_P                                 MOLESTANDO :(
-- autopago <radio button> coactivo autopago		AUTO_PAGO_PATIO_V2 ok

select top 100 *from coactivo order by 1 desc
--------------------------------------------------------------------------------------------------

SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434


--434 DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito   <ACTA_DE_POSESION_P, AUTO_PAGO_PATIO> 
--436 DELEGADO FUNCIONARIO EJECUTOR-COACTIVA DEL(LA) DIRECTOR(A) DE INFRACCIONES Y SERVICIOS DE TRÁNSITO DE LA AUTORIDAD DE TRÁNSITO MUNICIPAL
--437 Delegado Funcionario Ejecutor del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito de la Autoridad de Tránsito Municipal
--438 Delegado Funcionario Ejecutor-Coactiva Del(la) Director(a) de Infracciones y Servicios de Tránsito de la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil EP


------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'AUTO_PAGO_PATIO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611

update documentos..plantilla set fecha_inicio='2024-03-26' where id_plantilla=2612
commit tran

------------------------------------------------------------------------------
--Ver los documentos generados

--ORDEN_COBRO_ORDE_ELE--La dañe
------------------------------------------------------------------------------------------

--Puedo revisar el codigo de la plantilla que se acabo de generar

select *from [documentos].[dbo].[plantilla] where id_plantilla=2599  --2413--2596--2597  --2324--2596--2413--2596--2597--2685--2663

select top 5 *from [documentos].[dbo].[documento] order by 1 desc


select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2739' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=10148 --10115


commit tran

------------------------------------------------------------------------------------