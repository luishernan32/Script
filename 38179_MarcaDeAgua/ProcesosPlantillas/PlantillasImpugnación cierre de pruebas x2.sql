--***********************************************************************************************************************                           
--*						   -- Impugnación cierre de pruebas         x2                       *
--***********************************************************************************************************************
--COA_CP	 3693 10177  
--CIERRE_PRUEBAS 3694 11  https://www.youtube.com/watch?v=lxrmT2PQHcA  
--(3693,3694)
--*************************************************************************************
--*************************************************************************************

--Impugnación cierre de pruebas	COA - Cierre de pruebas	COA_CP	11777	SI  https://www.youtube.com/watch?v=XedjZXZ5qz0  desde el min 4 hay información 
--Impugnación cierre de pruebas	Cierre de pruebas	CIERRE_PRUEBAS	3	SI


--*************************************************************************************
--*************************************************************************************
-- felipe.larreategui Admin123* con este usuario puedo aprobar fallos

--***********************************************************************************************************************

--Videos y descripcion
--Socialización: 
--Nico gene de plant: https://www.youtube.com/watch?v=XedjZXZ5qz0
--SENTAR_RAZON_PAGO PROVIDENCIA_RETENCIO OFICIO_BANCO_CARTA:
--https://www.youtube.com/watch?v=zc557WYlBn4
--https://www.youtube.com/watch?v=sp88MJyZHjI
--PROVIDENCIA_PAGO : https://www.youtube.com/watch?v=M-1sI2atJNM


--***********************************************************************************************************************
--Temporal

--Dato utilizado numero de obligacion: 12028982

--***********************************************************************************************************************
--OBSERVACIONES: Impugnación proceso de pruebas x2 y Impugnación cierre de pruebas x2 son procesos paralelos, pues siguendo
--               una trayectoria se pueden generar las plantillas con un solo dato de prueba
--***********************************************************************************************************************

--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='CIERRE_PRUEBAS'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-06' where id_plantilla in(3689,3690,3691,3692)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(3693,3694)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3694--3695 --3693--2383--2621--2259--2289--2287--2288--2287--2286--2639--2625--2258--2258--3692--3690--
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


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS

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
WHERE  id_plantilla_config=11xx

commit tran





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------
--fu.titulo_obtenido, ' ',

------------------------------------------------------------------------

------------------------------------------------------------------------













------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------












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

--ALEXIS 

--Cambio para que aparezca el titulo del funcionario
--fu.titulo_obtenido, ' ',  
------------------------------------------------------------------


select *from plantilla_configuracion
where id_plantilla


select *from plantilla_configuracion
order by id_plantilla  desc
where id_plantilla=1430
--------------------------------------

select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='FELIPE'

--------------------------------------------------------
select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='ALEXIS'

--------------------------------------------------------
--ABG.
select --titulo_obtenido
*from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='conny' 


begin tran
update funcionario 
set titulo_obtenido='ABG.'
where id_funcionario=182--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------





